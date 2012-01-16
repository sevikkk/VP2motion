#!/usr/local/bin/python
import sys
import time
import pty
import os
import sys

state = "init"

ignore = [
        "IO_D17", "IO_E17", # clocks
        "IO_G17", # led1
        "IO_AA10", # J2-15
        "IO_J16", # UART_TX

        "IO_AB7", # ?
        "IO_AD5", # ?

        "IO_Y6", #SD_CLK
        "IO_AC1", #SD_DO
        "IO_AA3", #SD_CS
        "IO_E1", #SD_DI
        "IO_Y7", #snd
        "",
        "",


        ###################
        "IOH5", # MAXII clock
        "IOA15", # led6
        "IOC13", # led7
        "IOB16",
        "IOD9",
        "IOR9",
        "IOD4",
        "IOP13",
        "IOP10",
        "IOT10",

    ]

ignore_data = [
        "IO_E13", # a01
        "IO_K14", # a02
        "IO_J14", # a03
        "IO_D9",  # a04
        "IO_C9",  # a05
        "IO_H13", # a06
        "IO_G13", # a07
        "IO_K12", # a08
        "IO_J12", # a09
        "IO_D5",  # a10
        "IO_D6",  # a11
        "IO_F9",  # a12
        "IO_E9",  # a13
        "IO_K11", # a14
        "IO_J11", # a15
        "IO_J10", # a16
        "IO_K16", # a17
        "IO_C13", # a18
        "IO_C14", # a19
        "IO_F14", # a20
        "IO_E14", # a21
        "IO_K15", # a22
        "IO_J15", # a23
        "IO_D11", # a24
        "IO_C11", # a25
        "IO_D13", # a26
        "IO_D12", # a27
        "IO_H14", # a28
        "IO_G14", # a29
        "IO_E10", # a30
        "IO_D10", # a31
        "IO_F13", # a32
        "IO_J8",  # b04
        "IO_J7",  # b05
        "IO_F5",  # b06
        "IO_F4",  # b07
        "IO_G4",  # b08
        "IO_G3",  # b09
        "IO_G6",  # b10
        "IO_G5",  # b11
        "IO_L3",  # b14
        "IO_M4",  # b15
        "IO_M3",  # b16
        "IO_P10", # b17
        "IO_P9",  # b18
        "IO_N6",  # b19
        "IO_N5",  # b20
        "IO_M1",  # b21
        "IO_N1",  # b23
        "IO_P8",  # b24
        "IO_P7",  # b25
        "IO_N4",  # b26
        "IO_N3",  # b27
        "IO_N2",  # b28
        "IO_P2",  # b29
        "IO_R10", # b30
        "IO_T5",  # c01
        "IO_T4",  # c02
        "IO_T3",  # c03
        "IO_U10", # c04
        "IO_U9",  # c05
        "IO_U6",  # c06
        "IO_U5",  # c07
        "IO_U2",  # c08
        "IO_V2",  # c09
        "IO_U8",  # c10
        "IO_U7",  # c11
        "IO_U4",  # c12
        "IO_U3",  # c13
        "IO_G9",  # c14
        "IO_H9",  # c15
        "IO_G10", # c16
        "IO_P3",  # c17
        "IO_T11", # c18
        "IO_U11", # c19
        "IO_R7",  # c20
        "IO_R6",  # c21
        "IO_P1",  # c22
        "IO_R1",  # c23
        "IO_T10", # c24
        "IO_T9",  # c25
        "IO_R4",  # c26
        "IO_R3",  # c27
        "IO_R2",  # c28
        "IO_T2",  # c29
        "IO_T8",  # c30
        "IO_T7",  # c31
        "IO_T6",  # c32
]

#ignore += ignore_data

def got1(fd):
    global state
    global ignore
    data = os.read(fd, 1000)
    #print state, `data`
    buf = ""
    if state == "init" and data.endswith("jtag> "):
        state = "banner"
        pty._writen(fd, """cable DLC5 parallel 0x378\nbsdl path .\ndetect\npart 0\n""")
        return ""
    elif state == "banner" and data.endswith(".bsdl\r\n"):
        state = "prompt"
        buf = ""
    elif state == "prompt":
        buf += data
        if data.endswith("jtag> "):
            buf = buf.split("\r\n")
            for s in buf:
                if s == "jtag> ":
                    continue
                pin = s.split(":")[0]
                if pin in ignore:
                    continue
                print s+"\r\n",
            #sys.stdout.write(`buf`)
            #sys.stdout.flush()
            pty._writen(fd, """scan\n""")
            buf = ""

    return ""

def got2(fd):
    d = os.read(fd, 1000)
    if d == "q":
        sys.exit(0)
    elif d in  ("\r","\n"):
        sys.stdout.write("\r\n")
        sys.stdout.flush()
    return ""

print pty.spawn(["/usr/bin/sudo", "sudo", "jtag"], got1, got2)

#print """
#cable DLC5 parallel 0x378
#bsdl path /usr/local/share/urjtag/bsdl/
#detect
#"""
while 1:
    #print "scan"
    #sys.stdout.flush()
    time.sleep(0.1)

