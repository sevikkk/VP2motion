#!/bin/sh
. /opt/Xilinx/10.1/ISE/settings64.sh
. /opt/Xilinx/10.1/EDK/settings64.sh
. /opt/Xilinx/10.1/ChipScope/settings64.sh
. /opt/Xilinx/10.1/PlanAhead/settings64.sh
export LD_PRELOAD=/home/seva/src/vp2/drivers/usb-driver/libusb-driver.so
export XIL_IMPACT_USE_LIBUSB=0

ise vp2.ise
