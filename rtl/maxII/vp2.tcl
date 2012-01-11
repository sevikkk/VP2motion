# Copyright (C) 1991-2011 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II: Generate Tcl File for Project
# File: vp2.tcl
# Generated on: Sat Jan  7 15:24:21 2012

# Load Quartus II Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "vp2"]} {
		puts "Project vp2 is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists vp2]} {
		project_open -revision vp2 vp2
	} else {
		project_new -revision vp2 vp2
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "MAX II"
	set_global_assignment -name DEVICE EPM1270F256C5
	set_global_assignment -name USE_GENERATED_PHYSICAL_CONSTRAINTS OFF -section_id eda_blast_fpga
	set_global_assignment -name MAXII_OPTIMIZATION_TECHNIQUE SPEED
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name POWER_EXT_SUPPLY_VOLTAGE_TO_REGULATOR 3.3V
	set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
	set_global_assignment -name USE_CONFIGURATION_DEVICE ON
	set_global_assignment -name GENERATE_SVF_FILE ON
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
	set_global_assignment -name ALWAYS_ENABLE_INPUT_BUFFERS ON
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS_NO_OUTPUT_GND "AS INPUT TRI-STATED"
	set_global_assignment -name LL_ROOT_REGION ON -section_id "Root Region"
	set_global_assignment -name LL_MEMBER_STATE LOCKED -section_id "Root Region"
	set_global_assignment -name VERILOG_FILE spi_slave.v
	set_global_assignment -name VERILOG_FILE spi_flash_ctrl.v
	set_global_assignment -name VHDL_FILE fjmem_pack.vhd
	set_global_assignment -name VHDL_FILE fjmem_config_pack.vhd
	set_global_assignment -name VHDL_FILE fjmem_cyclone.vhd
	set_global_assignment -name VHDL_FILE fjmem_core.vhd
	set_global_assignment -name QIP_FILE lpm_counter0.qip
	set_global_assignment -name CDF_FILE vp2.cdf
	set_global_assignment -name BDF_FILE vp2.bdf
	set_global_assignment -name VERILOG_FILE selectmap.v
	set_global_assignment -name QIP_FILE lpm_bustri0.qip
	set_global_assignment -name QIP_FILE lpm_bustri1.qip
	set_global_assignment -name SDC_FILE vp2.sdc
	set_global_assignment -name QIP_FILE ufm.qip
	set_location_assignment PIN_H5 -to clk
	set_location_assignment PIN_A15 -to led1
	set_location_assignment PIN_C13 -to led2
	set_location_assignment PIN_R7 -to flash_addr[21]
	set_location_assignment PIN_P6 -to flash_addr[20]
	set_location_assignment PIN_T6 -to flash_addr[19]
	set_location_assignment PIN_R5 -to flash_addr[18]
	set_location_assignment PIN_R6 -to flash_addr[17]
	set_location_assignment PIN_P5 -to flash_addr[16]
	set_location_assignment PIN_T5 -to flash_addr[15]
	set_location_assignment PIN_N5 -to flash_addr[14]
	set_location_assignment PIN_T4 -to flash_addr[13]
	set_location_assignment PIN_R4 -to flash_addr[12]
	set_location_assignment PIN_T2 -to flash_addr[11]
	set_location_assignment PIN_P4 -to flash_addr[10]
	set_location_assignment PIN_R1 -to flash_addr[9]
	set_location_assignment PIN_R3 -to flash_addr[8]
	set_location_assignment PIN_P2 -to flash_addr[7]
	set_location_assignment PIN_N3 -to flash_addr[6]
	set_location_assignment PIN_N1 -to flash_addr[5]
	set_location_assignment PIN_N2 -to flash_addr[4]
	set_location_assignment PIN_M1 -to flash_addr[3]
	set_location_assignment PIN_M4 -to flash_addr[2]
	set_location_assignment PIN_L2 -to flash_addr[1]
	set_location_assignment PIN_M3 -to flash_addr[0]
	set_location_assignment PIN_P7 -to flash_addr22
	set_location_assignment PIN_T7 -to flash_addr23
	set_location_assignment PIN_L1 -to flash_addr_24
	set_location_assignment PIN_L4 -to flash_byte
	set_location_assignment PIN_M15 -to flash_data[15]
	set_location_assignment PIN_N14 -to flash_data[14]
	set_location_assignment PIN_N13 -to flash_data[13]
	set_location_assignment PIN_N15 -to flash_data[12]
	set_location_assignment PIN_C3 -to flash_data[11]
	set_location_assignment PIN_C2 -to flash_data[10]
	set_location_assignment PIN_D3 -to flash_data[9]
	set_location_assignment PIN_D1 -to flash_data[8]
	set_location_assignment PIN_E1 -to flash_data[7]
	set_location_assignment PIN_E4 -to flash_data[6]
	set_location_assignment PIN_F2 -to flash_data[5]
	set_location_assignment PIN_E3 -to flash_data[4]
	set_location_assignment PIN_F1 -to flash_data[3]
	set_location_assignment PIN_E2 -to flash_data[2]
	set_location_assignment PIN_G2 -to flash_data[1]
	set_location_assignment PIN_F3 -to flash_data[0]
	set_location_assignment PIN_L3 -to flash_ce1
	set_location_assignment PIN_K1 -to flash_ce2
	set_location_assignment PIN_J2 -to flash_cs
	set_location_assignment PIN_J1 -to flash_oe
	set_location_assignment PIN_H1 -to flash_rp
	set_location_assignment PIN_J3 -to flash_vpen
	set_location_assignment PIN_K3 -to flash_we
	set_location_assignment PIN_D5 -to v_busy
	set_location_assignment PIN_A5 -to v_cclk
	set_location_assignment PIN_C6 -to v_cs
	set_location_assignment PIN_A8 -to v_d[0]
	set_location_assignment PIN_B9 -to v_d[1]
	set_location_assignment PIN_C8 -to v_d[2]
	set_location_assignment PIN_A10 -to v_d[3]
	set_location_assignment PIN_C5 -to v_d[4]
	set_location_assignment PIN_B7 -to v_d[5]
	set_location_assignment PIN_B1 -to v_d[6]
	set_location_assignment PIN_B3 -to v_d[7]
	set_location_assignment PIN_B5 -to v_done
	set_location_assignment PIN_A7 -to v_init
	set_location_assignment PIN_B12 -to v_m[2]
	set_location_assignment PIN_C12 -to v_m[1]
	set_location_assignment PIN_A13 -to v_m[0]
	set_location_assignment PIN_A12 -to v_prog
	set_location_assignment PIN_B8 -to v_rdwr
	set_location_assignment PIN_H3 -to flash_busy

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
