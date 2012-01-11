#!/usr/bin/python

import sys

data = open(sys.argv[1], "r").read()
addr = 0
for a in data:
    print "\t\t%d: dataOut <= 8'h%02X;" % (addr, ord(a))
    addr += 1
