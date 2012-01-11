#!/usr/local/bin/python

import socket
import struct
import time
import sys

data = open(sys.argv[1],"rb").read()

port = 8081
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, True)
s.bind(("", 0))

print "Reseting"
dgram = struct.pack("HHH", 0xCEBA, 2, 0xE000)
s.sendto(dgram, ('192.168.0.255', 5000))

time.sleep(1)

print "Sending ",
addr = 0x1000
while data:
    chunk = data[:512]
    data = data[512:]
    dgram = struct.pack("HHHH", 0xCEBA, 1, addr, len(chunk)) + chunk
    #print `dgram`
    sys.stdout.write(".")
    sys.stdout.flush()
    s.sendto(dgram, ('192.168.0.255', 5000))
    time.sleep(0.2)
    #s.sendto(dgram, ('192.168.0.255', 5000))
    #time.sleep(0.2)
    #s.sendto(dgram, ('192.168.0.255', 5000))
    #time.sleep(0.2)
    addr += 512

print " Done"
dgram = struct.pack("HHH", 0xCEBA, 2, 0x1000)
s.sendto(dgram, ('192.168.0.255', 5000))
time.sleep(0.2)
#s.sendto(dgram, ('192.168.0.255', 5000))
#time.sleep(0.2)
#s.sendto(dgram, ('192.168.0.255', 5000))
#time.sleep(0.2)

