#!/usr/bin/env python
import math
import struct

AXES = ["X", "Y", "Z"]

class Segment:
    max_v = [15.0, 15.0, 5.0]
    max_v = [20.0, 20.0, 5.0]
    max_a = [50.0, 50.0, 10.0]
    max_delta = 0.5

    def __init__(self, prev_seg, next_point):
        self.prev_seg = prev_seg
        self.next_seg = None
        if self.prev_seg:
            self.prev_seg.next_seg = self

        self.pos, self.base_feed, self.base_espeed = next_point

        self.end_speed = None
        self.start_speed = None
        self.slowdown_k = 1.0

    def slowdown(self, k):
        self.slowdown_k *= k
        self.v = self.base_v[:]
        self.espeed = self.base_espeed

        for a in range(3):
            self.v[a] *= self.slowdown_k
        self.espeed *= self.slowdown_k

    def __repr__(self):
        return "<Segment([%.3f, %.3f, %.3f], %.3f, %.3f, %.3f)>" % (self.pos["X"], self.pos["Y"], self.pos["Z"], self.base_feed, self.base_espeed, self.slowdown_k)

class Head:

    def __init__(self, outfile):
        self.extruder_speed = 0
        self.extruder_state = 0

        self.last_extruder_state = None

        self.last_feed = None
        self.last_pos = {}
        self.thread = []
        self.segments = []
        self.outfile = outfile

    def extruder_start(self):
        self.stop()
        self.extruder_state = 1

    def extruder_stop(self):
        self.stop()
        self.extruder_state = 0

    def extruder_reverse(self):
        self.stop()
        self.extruder_state = -1

    def set_extruder_speed(self, speed):
        self.extruder_speed = speed

    def set_tool_temp(self, temp):
        self.outfile.write(struct.pack("<BBBBH", 136, 0, 3, 2, temp))

    def set_platform_temp(self, temp):
        self.outfile.write(struct.pack("<BBBBH", 136, 0, 31, 2, temp))
        if temp > 0:
            self.outfile.write(struct.pack("BBBBB", 136, 0, 10, 1, 3))
        else:
            self.outfile.write(struct.pack("BBBBB", 136, 0, 10, 1, 2))
        self.outfile.write(struct.pack("BBBBB", 136, 0, 4, 1, 255))

    def wait_tool(self):
        self.stop()
        self.outfile.write(struct.pack("<BB", 134, 0))
        self.outfile.write(struct.pack("<BBHh", 135, 0, 100, -1))
        self.outfile.write(struct.pack("<BBHh", 141, 0, 100, -1))

    def enable(self):
        self.stop()
        self.outfile.write(struct.pack("BB", 137, 0x9f))
        self.last_pos = {}

    def disable(self):
        self.stop()
        self.outfile.write(struct.pack("BB", 137, 0x1f))
        self.last_pos = {}

    def abp_on(self):
        self.stop()
        self.outfile.write(struct.pack("BBBBB", 136, 0, 27, 1, 1))

    def abp_off(self):
        self.stop()
        self.outfile.write(struct.pack("BBBBB", 136, 0, 27, 1, 0))

    def pause(self, pause):
        self.stop()
        self.outfile.write(struct.pack("<BI", 133, pause*1000))

    def home(self, axes, direction, feed):
        self.stop()
        if direction == "min":
            cmd = 131
        else:
            cmd = 132
        axes_code = 0
        if "X" in axes:
            axes_code |= 1
        if "Y" in axes:
            axes_code |= 2
        if "Z" in axes:
            axes_code |= 4
        self.outfile.write(struct.pack("<BBIH", cmd, axes_code, 1000000/(feed * 3200.0/60), 20))
        self.last_pos = {}
        self.last_feed = feed

    def recall(self, axes):
        self.stop()
        axes_code = 0
        if "X" in axes:
            axes_code |= 1
        if "Y" in axes:
            axes_code |= 2
        if "Z" in axes:
            axes_code |= 4
        self.outfile.write(struct.pack("<BB", 144, axes_code))
        self.last_pos = {}

    def set_pos(self, axes):
        self.stop()
        axes_vals = {}
        self.last_pos = {"X": 0, "Y": 0, "Z": 0}
        for k, v in axes:
            axes_vals[k] = v * 3200
            self.last_pos[k] = v
        self.outfile.write(struct.pack("<Biiiii", 140, axes_vals.get("X", 0), axes_vals.get("Y", 0), axes_vals.get("Z", 0), 0, 0))

    def split_thread(self):
        self.segments = []
        prev_seg = None
        prev_pos = None
        for t in self.thread:
            pos, feed, espeed = t
            feed *= 10
            espeed *= 10
            #print "splitting:", prev_pos, pos
            if not prev_seg:
                s = Segment(prev_seg, t)
                self.segments.append(s)
                s.de = 0
                prev_seg = s
            else:
                dx = pos["X"] - prev_seg.pos["X"]
                dy = pos["Y"] - prev_seg.pos["Y"]
                dz = pos["Z"] - prev_seg.pos["Z"]

                total = math.sqrt(dx*dx + dy*dy + dz*dz)

                seg_size = min(0.5, total/3)
                k = seg_size/total
                de = total / feed * espeed

                num_segs = min(5, int((total/seg_size)/2))
                #print k, seg_size, num_segs

                last_pos = prev_pos
                for i in range(num_segs):
                    npos = {}
                    npos["X"] = last_pos["X"] + dx * k * (i+1)
                    npos["Y"] = last_pos["Y"] + dy * k * (i+1)
                    npos["Z"] = last_pos["Z"] + dz * k * (i+1)
                    #print "  <", npos
                    s = Segment(prev_seg, (npos, feed, espeed))
                    s.de = de * k
                    self.segments.append(s)
                    prev_seg = s
                last_pos = pos
                for i in range(num_segs + 1):
                    npos = {}
                    npos["X"] = last_pos["X"] - dx * k * (num_segs - i)
                    npos["Y"] = last_pos["Y"] - dy * k * (num_segs - i)
                    npos["Z"] = last_pos["Z"] - dz * k * (num_segs - i)
                    #print "  >", npos
                    s = Segment(prev_seg, (npos, feed, espeed))
                    if i == 0:
                        s.de = de * (1.0 - num_segs * 2 * k)
                    else:
                        s.de = de * k

                    self.segments.append(s)
                    prev_seg = s
            prev_pos = pos

        self.segments.append(Segment(prev_seg, (pos, 0, 0)))
        self.segments[-1].de = 0

    def analyze_thread(self):
        #print self.segments
        self.speed_limit()
        i = 0
        while 1:
            self.reverse_step()
            self.forward_step()
            n = self.trapezoids()
            if n > 0:
                print "bad trapezoids", i, n
            else:
                break

            i += 1
            if i==30:
                print "bad trapezoids left", n
                break
        self.dump_trapezoids()

    def speed_limit(self):
        for s in self.segments:
            slowdown = 1.0
            if s.prev_seg:
                s.d = [
                    s.pos["X"] - s.prev_seg.pos["X"],
                    s.pos["Y"] - s.prev_seg.pos["Y"],
                    s.pos["Z"] - s.prev_seg.pos["Z"],
                ]
                total = math.sqrt(s.d[0]*s.d[0] + s.d[1]*s.d[1] + s.d[2]*s.d[2])
                if total > 0:
                    s.v = []
                    for a in range(3):
                        v = s.base_feed * s.d[a] / total / 60
                        s.v.append(v)
                        if v != 0:
                            slowdown = min(slowdown, abs(s.max_v[a]/v))
                else:
                    s.v = [0, 0, 0]
                    s.base_espeed = 0
            else:
                s.d = [0, 0, 0]
                s.v = [0, 0, 0]
                s.base_espeed = 0

            s.base_v = s.v[:]
            s.slowdown(slowdown)

    def reverse_step(self):
        n = len(self.segments) - 1
        for s in self.segments[-2:0:-1]:
            start_speed = s.v
            end_speed = s.next_seg.v

            delta1 = s.d
            delta2 = s.next_seg.d

            slowdown = 1.0
            n -= 1
            for a in range(3):
                ev = end_speed[a]
                sv = start_speed[a]
                max_a = s.max_a[a]

                d1 = abs(delta1[a])
                d2 = abs(delta2[a])

                d = (d1 + d2)/4

                if sv * ev < 0:
                    ev = 0 
                    d = d1/2

                if d > s.max_delta:
                    d = s.max_delta

                if abs(sv) <= abs(ev):
                    continue

                accel_dist = (sv*sv - ev*ev)/ (2.0*max_a)

                print "%d %s decel %.2f to %.2f in %.2f, need: %.2f" % (n, ["X", "Y", "Z"][a], sv, ev, d, accel_dist)
                if accel_dist > d:
                    print "need slowdown"
                    new_sv = math.sqrt(ev*ev + 2*max_a*d)
                    slowdown = min(slowdown, abs(new_sv/sv))
                    accel_dist = -(ev*ev - new_sv*new_sv)/ (2.0*max_a)
                    print n, "need slowdown dec, new speed:", new_sv, "new dist:", accel_dist, slowdown, abs(new_sv/sv)

            s.slowdown(slowdown)

            print s.pos, s.base_feed, s.espeed, slowdown

    def forward_step(self):
        n = 0
        for s in self.segments[1:-1]:
            start_speed = s.prev_seg.v
            end_speed = s.v

            delta1 = s.prev_seg.d
            delta2 = s.d

            slowdown = 1.0
            n += 1
            for a in range(3):
                sv = start_speed[a]
                ev = end_speed[a]
                max_a = s.max_a[a]

                d1 = abs(delta1[a])
                d2 = abs(delta2[a])

                d = (d1 + d2)/4

                if sv * ev < 0:
                    ev = 0 
                    d = d2/2

                if d > s.max_delta:
                    d = s.max_delta

                if abs(sv) >= abs(ev):
                    continue

                accel_dist = (ev*ev - sv*sv)/ (2.0*max_a)

                print "%d %s accel %.2f to %.2f in %.2f, need: %.2f" % (n, ["X", "Y", "Z"][a], sv, ev, d, accel_dist)
                if accel_dist > abs(s.d[a])/2:
                    print "need slowdown"
                    new_ev = math.sqrt(sv*sv + 2*max_a*d)
                    slowdown = min(slowdown, abs(new_ev/ev))
                    accel_dist = (new_ev*new_ev - sv*sv)/ (2.0*max_a)
                    print n, "need slowdown acc, new speed:", new_ev, "new dist:", accel_dist, slowdown, abs(new_ev/ev)

            s.slowdown(slowdown)

            print s.pos, s.base_feed, s.espeed, slowdown

    def trapezoids(self):
        bad = {}
        n = 0
        new_segments = []
        for s in self.segments[1:]:
            n += 1
            start_v = s.prev_seg.v
            end_v = s.v

            delta1 = s.prev_seg.d
            delta2 = s.d

            part = 0.0
            max_dt = 0.0

            for a in range(3):
                v1 = start_v[a]
                v2 = end_v[a]
                max_a = s.max_a[a]
                d1 = abs(delta1[a])
                d2 = abs(delta2[a])
                if d1 + d2 <0.01:
                    continue

                if v1 * v2 < 0:
                    dist = (v2*v2 + v1*v1)/(2.0*max_a)
                else:
                    dist = abs(v2*v2 - v1*v1)/(2.0*max_a)

                dt = abs(v1 - v2)/max_a

                part = max(part, dist /(d1 + d2))
                max_dt = max(max_dt, dt)
                #print n, a, dist /(d1 + d2), dt

            s.prev_seg.exit_part = part
            s.prev_seg.exit_dt = max_dt
            s.entry_part = part
            s.entry_dt = max_dt

        n = 1
        for s in self.segments[1:-1]:
            start_v = s.prev_seg.v
            target_v = s.v
            end_v = s.next_seg.v
            dt = 0
            s.entry_point = [0,0,0]
            s.exit_point = [0,0,0]
            for a in range(3):
                if abs(s.v[a]) > 0.01:
                    dt = max(dt, s.d[a]/s.v[a]*(1.0 - s.entry_part - s.exit_part))
                s.entry_point[a] = s.pos[["X", "Y", "Z"][a]] - s.d[a] * (1 - s.entry_part)
                s.exit_point[a] = s.pos[["X", "Y", "Z"][a]] - s.d[a] * s.exit_part
            s.dt = dt

            #print "%3d [%8.3f %8.3f %8.3f] [%8.3f %8.3f %8.3f] [%8.3f %8.3f %8.3f] %.3f %.3f %.3f" % tuple([n] + start_v + target_v + end_v + [ s.entry_part, 1 - s.entry_part - s.exit_part, s.exit_part ])
            d = math.sqrt( s.d[0] * s.d[0] + s.d[1] * s.d[1] + s.d[2] * s.d[2] )
            if (s.entry_part + s.exit_part > 1) or (d*s.entry_part > s.max_delta) or (d * s.exit_part > s.max_delta):
                bad[s] = 1
                bad[s.prev_seg] = 1
                bad[s.next_seg] = 1

            n+=1

        for s in [self.segments[0], self.segments[-1]]:
            s.dt = 0.05
            s.entry_part = 0
            s.exit_part = 0
            s.entry_point = [s.pos["X"],s.pos["Y"], s.pos["Z"]]
            s.exit_point = [s.pos["X"],s.pos["Y"], s.pos["Z"]]

        for s in bad.keys():
            s.slowdown(0.9)

        return len(bad)

    def dump_trapezoids(self):
        print "Trapezoids:"
        n = 1
        for s in self.segments[1:-1]:
            start_v = s.prev_seg.v
            target_v = s.v
            end_v = s.next_seg.v
            d = math.sqrt( s.d[0] * s.d[0] + s.d[1] * s.d[1] + s.d[2] * s.d[2] )
            print "%3d | [%8.3f %8.3f %8.3f] [%8.3f %8.3f %8.3f] [%8.3f %8.3f %8.3f] | %.3f %.3f %.3f | %8.3f %8.3f %8.3f | %.3f" % tuple([n] + start_v + target_v + end_v + [ s.entry_part, 1 - s.entry_part - s.exit_part, s.exit_part, d * s.entry_part, d * (1 - s.entry_part - s.exit_part), d * s.exit_part, s.slowdown_k])
            n+=1

    def out_segs(self):
        segs = []
        sub_seg_de = 0
        sub_seg_dt = 0
        n = 1
        for s in self.segments[1:]:
            de1 = s.prev_seg.de * s.prev_seg.exit_part + s.de * s.entry_part
            sub_seg_dt += s.entry_dt
            sub_seg_de += de1
            if sub_seg_dt > 0.020:
                espeed = sub_seg_de/sub_seg_dt
                segs.append((s.entry_point[0], s.entry_point[1], s.entry_point[2], sub_seg_de, espeed, sub_seg_dt))
                print "%3d | [%8.3f %8.3f %8.3f] %8.6f %8.6f" % tuple([n] + s.entry_point + [ sub_seg_de, sub_seg_dt])
                n += 1
                sub_seg_de -= int(sub_seg_de * 3200)/3200.0
                sub_seg_dt = 0
                prev_espeed = espeed

            de2 = s.de * (1 - s.exit_part - s.entry_part)
            sub_seg_dt += s.dt
            sub_seg_de += de2

            if sub_seg_dt > 0.020:
                espeed = sub_seg_de/sub_seg_dt
                segs.append((s.exit_point[0], s.exit_point[1], s.exit_point[2], sub_seg_de, espeed, sub_seg_dt))
                print "%3d | [%8.3f %8.3f %8.3f] %8.6f %8.6f" % tuple([n] + s.exit_point + [ sub_seg_de, sub_seg_dt])
                n += 1
                sub_seg_de -= int(sub_seg_de * 3200)/3200.0
                sub_seg_dt = 0
                prev_espeed = espeed

        prev_s = segs[0]
        for s in segs[1:]:
            x, y, z, de, ds, dt = prev_s
            _, _, _, _,  ns, _ = s
            de += (ns - ds) * 0.3
            self.outfile.write(struct.pack("<BiiiiiIB", 142, x*3200, y*3200, z*3200, -int(de * 3200), 0, dt * 1000000, 8))
            prev_s = s
        x, y, z, de, ds, dt = prev_s
        self.outfile.write(struct.pack("<BiiiiiIB", 142, x*3200, y*3200, z*3200, -int(de * 3200), 0, dt * 1000000, 8))
        return segs

    def stop(self):
        if self.thread:
            #print self.thread
            self.split_thread()
            self.analyze_thread()
            self.out_segs()

        self.thread = []

    def dda_move(self, pos, feed):
        axes_vals = {}
        self.last_pos = {"X": 0, "Y": 0, "Z": 0}
        for k, v in pos.items():
            axes_vals[k] = v * 3200
            self.last_pos[k] = v

        self.outfile.write(struct.pack("<BiiiiiI", 139, axes_vals.get("X", 0), axes_vals.get("Y", 0), axes_vals.get("Z", 0), 0, 0, 1000000/(feed * 3200.0/60)))
        print "DDA move to", pos, "at", feed

    def move_to(self, axes, feed):
        if self.extruder_state != self.last_extruder_state:
            self.stop()

        self.last_extruder_state = self.extruder_state

        if feed is None:
            feed = self.last_feed

        self.last_feed = feed

        ok = 1
        new = {}
        old = {}

        for a in AXES:
            old[a] = self.last_pos.get(a, None)
            if a in axes:
                new[a] = axes[a]
            else:
                new[a] = old[a]

            if old[a] is None or new[a] is None:
                ok = 0

        if not ok:
            if self.extruder_state != 0:
                print "undefined move with extruder on, ignoring extruder"
            self.dda_move(new, feed)
            self.stop()
            self.last_pos = new
            return

        if (new["Z"] != old["Z"]) and ((new["X"] != old["X"]) or (new["Y"] != old["Y"])):
            if self.extruder_state != 0:
                print "combined move with extruder on, ignoring extruder"
            if (new["Z"] > old["Z"]):
                print "combined move up, spliting"
                self.stop()
                self.move_to({"X": old["X"], "Y": old["Y"], "Z": new["Z"]}, 60)
                self.stop()
                self.move_to({"X": new["X"], "Y": new["Y"], "Z": new["Z"]}, feed)
                self.stop()
            else:
                print "combined move down, spliting"
                self.stop()
                self.move_to({"X": new["X"], "Y": new["Y"], "Z": old["Z"]}, feed)
                self.stop()
                self.move_to({"X": new["X"], "Y": new["Y"], "Z": new["Z"]}, 60)
                self.stop()
            return

        self.last_pos = new
        if not self.thread:
            self.thread = [(old, 0, 0)]

        espeed = self.extruder_speed
        if self.extruder_state == 0:
            espeed = 0
        elif self.extruder_state == -1:
            espeed = -espeed
        self.thread.append((new, feed, espeed))

def parse(f, head):
    for s in f:
        s = s.strip().split()
        if len(s) < 1:
            continue

        s1 = []
        for ss in s:
            if ss[0] in ["(", ';']:
                break
            s1.append(ss)

        if not s1:
            continue

        s = s1

        if s[0] in ("G21", "G90"):
            pass

        elif s[0] == "M108":
            if s[1][0] == "R":
                speed = float(s[1][1:])
                print "extruder speed:", speed
                head.set_extruder_speed(speed)
            else:
                print "bad command", " ".join(s)

        elif s[0] in ("M104", "M109"):
            if s[1][0] == "S":
                target_temp = int(s[1][1:])
                if s[0] == "M104":
                    target = "tool"
                    head.set_tool_temp(target_temp)
                else:
                    target = "platform"
                    head.set_platform_temp(target_temp)
                print target, "temp:", target_temp
            else:
                print "bad command", " ".join(s)

        elif s[0] == "M17":
            print "enable steppers"
            head.enable()

        elif s[0] == "M18":
            print "disable steppers"
            head.disable()

        elif s[0] == "M101":
            print "extruder start"
            head.extruder_start()

        elif s[0] == "M102":
            print "extruder reverse"
            head.extruder_reverse()

        elif s[0] == "M103":
            print "extruder stop"
            head.extruder_stop()

        elif s[0] == "M106":
            print "ABP on"
            head.abp_on()

        elif s[0] == "M107":
            print "ABP off"
            head.abp_off()

        elif s[0] == "G04":
            if s[1][0] == "P":
                pause = int(s[1][1:])
                print "pause", pause
                head.pause(pause)

        elif s[0] == "M6":
            print "wait tool"
            head.wait_tool()

        elif s[0] in ("G161", "G162"):
            axes = []
            feed = 0
            for ss in s[1:]:
                if ss[0] == "F":
                    feed = float(ss[1:])
                elif ss[0] in AXES:
                    axes.append(ss[0])
            if s[0] == "G161":
                direction = "min"
            else:
                direction = "max"

            print "home", direction, ",".join(axes), "at", feed
            head.home(axes, direction, feed)

        elif s[0] == "M132":
            axes = []
            for ss in s[1:]:
                if ss[0] in AXES:
                    axes.append(ss[0])

            print "recall home", ",".join(axes)
            head.recall(axes)

        elif s[0] == "G92":
            axes = []
            for ss in s[1:]:
                if ss[0] in AXES:
                    pos = float(ss[1:])
                    axes.append((ss[0], pos))
            print "set pos", axes
            head.set_pos(axes)

        elif s[0] == "G1":
            axes = {}
            feed = None
            for ss in s[1:]:
                if ss[0] == "F":
                    feed = float(ss[1:])
                if ss[0] in AXES:
                    axes[ss[0]] = float(ss[1:])

            print "move to", axes, "at", feed
            head.move_to(axes, feed)

        else:
            print "Unknown command:", " ".join(s)

if __name__ == "__main__":
    import sys
    of = open(sys.argv[2], "w")
    head = Head(of)
    f = open(sys.argv[1], "r")
    parse(f, head)
    f.close()
    of.close()
