#!/usr/bin/env python
import math

AXES = ["X", "Y", "Z", "E", "F"]
def main(fname):
    f = open(fname, "r")
    last = {}
    for a in AXES:
        last[a] = 0.0

    for s in f:
        s = s.strip().split()
        if len(s) < 1:
            continue

        if s[0] != "G1":
            continue

        new = {}
        for ss in s[1:]:
            new[ss[0]] = float(ss[1:])

        dsts = []
        deltas = []
        for a in AXES:
            if a not in new:
                new[a] = last[a]

            deltas.append(last[a] - new[a])
            dsts.append(new[a])

        dxyz = math.sqrt(
                deltas[0] * deltas[0] +
                deltas[1] * deltas[1] +
                deltas[2] * deltas[2]
            )
        de = abs(deltas[3])
        feed = dsts[3] * 60
        if dxyz + de > 0: 
            print "%10.5f %10.5f %10.5f %10.5f %10.5f | %10.5f %10.5f" % tuple( dsts[:4] + [dsts[4]/60, dxyz, de])
            last = new

if __name__ == "__main__":
    import sys
    main(sys.argv[1])

