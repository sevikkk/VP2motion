#!/usr/bin/python
import struct
import sys
import math

toolCommandTable = {
    3: ("<H", "Set target temperature to %i"),
    4: ("B", "Set motor 1 speed (pwm): %i"),
    10: ("B", "Toggle motor 1: %d"),
    12: ("B", "Turn fan on (1) or off (0): %d"),
    27: ("B", "Toggle ABP: %d"),
    31: ("<H", "Set build platform target temperature to %i"),
    129: ("<iiiI","Absolute move to (%i,%i,%i) at DDA %i"),
}

def parseToolAction():
    global s3gFile
    packetStr = s3gFile.read(3)
    if len(packetStr) != 3:
        raise "Incomplete s3g file during tool command parse"
    (index,command,payload) = struct.unpack("<BBB",packetStr)
    contents = s3gFile.read(payload)
    if len(contents) != payload:
        raise "Incomplete s3g file: tool packet truncated"
    return (index,command,contents)

def printToolAction(tuple):
    print "Tool %i: " % (tuple[0]),
    # command - tuple[1]
    # data - tuple[2]
    (parse, disp) = toolCommandTable[tuple[1]]
    if type(parse) == type(""):
        packetLen = struct.calcsize(parse)
        if len(tuple[2]) != packetLen:
            raise "Packet incomplete"
        parsed = struct.unpack(parse,tuple[2])
    else:
        parsed = parse()
    if type(disp) == type(""):
        print disp % parsed

# based on:
# https://github.com/grbl/grbl/blob/9713f9067dbc47c7622357736d0a55ad3cd8771d/planner.c
# https://github.com/chamnit/preGrbl

class Segment:
    def __init__(self, x, y, z, a, b, us, prev_block = None):
        self.target = [x, y, z, a, b]
        self.us = us

        self.direction_bits = [0, 0, 0, 0, 0]   # The direction bit set for this block (refers to *_DIRECTION_BIT in config.h)
        self.steps = [0, 0, 0, 0, 0]            # Step count along each axis
        self.step_event_count = 0               # The number of step events required to complete this block

        self.nominal_speed = 0.0                # The nominal speed for this block in mm/min
        self.entry_speed = 0.0                  # Entry speed at previous-current junction in mm/min
        self.max_entry_speed = 0.0              # Maximum allowable junction entry speed in mm/min
        self.millimeters = 0.0                  # The total travel of this block in mm

        self.recalculate_flag = False           # Planner flag to recalculate trapezoids on entry junction
        self.nominal_length_flag = False        # Planner flag for nominal speed always reached

        self.initial_rate = 0                   # The step rate at start of block  
        self.final_rate = 0                     # The step rate at end of block
        self.rate_delta = 0                     # The steps/minute to add or subtract when changing speed (must be positive)
        self.accelerate_until = 0               # The index of the step event on which to stop acceleration
        self.decelerate_after = 0               # The index of the step event on which to start decelerating
        self.nominal_rate = 0                   # The nominal step rate for this block in step_events/minute

        self.prev_block = prev_block
        self.next_block = None
        if prev_block:
            prev.next_block = self

    def __repr__(self):
        return "<Segment %.5f %.5f %.5f %.5f %.5f in %d us>" % tuple(self.target + [self.us or -1])

    def update_start(self, prev):
        if prev:
            self.dx = self.x - prev.x
            self.dy = self.y - prev.y
            self.dz = self.z - prev.z
            self.da = self.a - prev.a
            self.db = self.b - prev.b
        else:
            self.dx = 0
            self.dy = 0
            self.dz = 0
            self.da = 0
            self.db = 0

        if self.us:
            self.vx = self.dx * 1000000.0 / self.us / 400
            self.vy = self.dy * 1000000.0 / self.us / 400
            self.vz = self.dz * 1000000.0 / self.us / 400
            self.va = self.da * 1000000.0 / self.us / 400
            self.vb = self.db * 1000000.0 / self.us / 400
        else:
            self.vx = 0
            self.vy = 0
            self.vz = 0
            self.va = 0
            self.vb = 0

        self.stage = 1

class Emu:
    def __init__(self):
        self.state = "moving"
        self.last = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        self.path = []

    def Move(self, data):
        if self.state != "moving":
            return

        x, y, z, a, b, us, rel = data
        if rel & 1:
            x += self.last[0]
        if rel & 2:
            y += self.last[1]
        if rel & 4:
            z += self.last[2]
        if rel & 8:
            a += self.last[3]
        if rel & 16:
            b += self.last[4]

        dx = x - self.last[0]
        dy = y - self.last[1]
        dz = z - self.last[2]
        da = a - self.last[3]
        db = b - self.last[4]

        self.path.append(Segment(x, y, z, a, b, us))
        self.last = [x, y, z, a, b]

    def Move2(self, data):
        self.last = list(data[:5])
        self.path.append(Segment(data[0], data[1], data[2], data[3], data[4], None))
        if self.state == "init":
            self.state = "moving"

    def EOF(self):
        total = 0
        for s in self.path:
            total += s.us or 0
        print "Total:", total, total/1000000.0/3600

emu = Emu()

def parseMove():
    parse = "<iiiiiIB"
    packetLen = struct.calcsize(parse)
    packetData = s3gFile.read(packetLen)
    if len(packetData) != packetLen:
        raise "Packet incomplete"
    parsed = struct.unpack(parse,packetData)
    emu.Move(parsed)
    return parsed

def printMove(data):
    print "~Move to (%i,%i,%i,%i,%i) in %i us (relative: %X)" % data

def parseMove2():
    parse = "<iiiiiI"
    packetLen = struct.calcsize(parse)
    packetData = s3gFile.read(packetLen)
    if len(packetData) != packetLen:
        raise "Packet incomplete"
    parsed = struct.unpack(parse,packetData)
    emu.Move2(parsed)
    return parsed

def printMove2(data):
    print "~Absolute move to (%i,%i,%i,%i,%i) at DDA %i" % data

# Command table entries consist of:
# * The key: the integer command code
# * A tuple:
#   * idx 0: the python struct description of the rest of the data,
#            of a function that unpacks the remaining data from the
#            stream
#   * idx 1: either a format string that will take the tuple of unpacked
#            data, or a function that takes the tuple as input and returns
#            a string
# REMINDER: all values are little-endian. Struct strings with multibyte
# types should begin with "<".
# For a refresher on Python struct syntax, see here:
# http://docs.python.org/library/struct.html
commandTable = {    
    129: ("<iiiI","Absolute move to (%i,%i,%i) at DDA %i"),
    130: ("<iii","Machine position set as (%i,%i,%i)"),
    131: ("<BIH","Home minimum on %X, feedrate %i, timeout %i s"),
    132: ("<BIH","Home maximum on %X, feedrate %i, timeout %i s"),
    133: ("<I","Delay of %i us"),
    134: ("<B","Switch to tool %i"),
    135: ("<BHH","Wait for tool %i (%i ms between polls, %i s timeout"),
    136: (parseToolAction, printToolAction),
    137: ("<B", "Enable/disable axes %X"),
    138: ("<H", "User block on ID %i"),
    139: (parseMove2, printMove2),
    140: ("<iiiii","Extended Machine position set as (%i,%i,%i,%i,%i)"),
    141: ("<BHH","Wait for platform %i (%i ms between polls, %i s timeout)"),
    142: (parseMove, printMove),
    143: ("<b","Store home position for axes %d"),
    144: ("<b","Recall home position for axes %d"),
}

def parseNextCommand():
    """Parse and handle the next command.  Returns
    True for success, False on EOF, and raises an
    exception on corrupt data."""
    global s3gFile
    commandStr = s3gFile.read(1)
    if len(commandStr) == 0:
        emu.EOF()
        print "EOF"
        return False
    (command) = struct.unpack("B",commandStr)
    (parse, disp) = commandTable[command[0]]
    if type(parse) == type(""):
        packetLen = struct.calcsize(parse)
        packetData = s3gFile.read(packetLen)
        if len(packetData) != packetLen:
            raise "Packet incomplete"
        parsed = struct.unpack(parse,packetData)
    else:
        parsed = parse()
    if type(disp) == type(""):
        print disp % parsed
    else:
        disp(parsed)
    return True

s3gFile = open(sys.argv[1],'rb')
while parseNextCommand():
    pass
