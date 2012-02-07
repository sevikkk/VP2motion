# version: 10.1.03
# 
# ProjectNavigator SourceControl export script
#
# This script is generated and executed by ProjectNavigator
# to copy files related to the current project to a
# destination staging area.
#
# The list of files being exported, as controled by
# GUI settings, is placed in the variable export_files.
# Each file will be passed to the procedure CopyOut.  This
# procedure will determine the exact destination, and will
# attempt the file copy if the source and destination are different.
#
# This script is not indended for direct customer editing.
#
# Copyright 2006, Xilinx, Inc.
#
#
# CopyOut -- copy a source file to the staging area, with
#            extra options for files remote (outside of) the
#            project directory.
proc CopyOut { srcfile staging_area copy_option } {
   set report_errors true
   if { $copy_option == "flatten" } {
       set dest [ file join $staging_area [ file tail $srcfile ] ]
   } elseif { $copy_option == "nop" } {
       set dest  $staging_area
       set report_errors false
   } elseif { [ file pathtype $srcfile ] != "relative" } {
       set srcfile2 [ string map {: _} $srcfile ]
       set dest [ file join $staging_area absolute $srcfile2 ]
   } elseif { [ expr { $copy_option == "absremote" } && { [string equal -length 2 $srcfile ".." ] } ] } {
       set dest [ file join $staging_area outside_relative [ string map {.. up} $srcfile ] ]
   } else {
       set srcfile2 [ string map {: _} $srcfile ]
       set dest [ file join $staging_area $srcfile2 ]
   }

   set dest [ file normalize $dest ]
   set src [ file normalize $srcfile ]

   if { [ expr { [ string equal $dest $src ] == 0 } && { [ file exists $src ] } ] } {
      file mkdir [ file dirname $dest ]
      if { [catch { file copy -force $src $dest } ] } {
         if { $report_errors } { puts "Could not copy $src to $dest." }
      }
   }
}

# change to the working directory
set old_working_dir [pwd]
cd [file normalize {/home/seva/src/vp2/rtl/vp2} ]
set copy_option relative
set staging_area "/home/seva/src/vp2/rtl/vp2"
set export_files { 
          "6502_sync.vhd" 
          "ClkUnit.sym" 
          "ClkUnit38400.sym" 
          "RxFifo.v" 
          "RxFifoBI.v" 
          "RxUnit.sym" 
          "RxUnit.vhd" 
          "TxFifo.v" 
          "TxFifoBI.v" 
          "TxUnit.sym" 
          "TxUnit.vhd" 
          "clkUnit.vhd" 
          "clkUnit38400.vhd" 
          "clockgen.sym" 
          "clockgen.xaw" 
          "clockgen_arwz.ucf" 
          "cpu6502_sync.sym" 
          "cpu_ram.sym" 
          "cpu_ram.v" 
          "cpu_rom.sym" 
          "cpu_rom.v" 
          "ctrlStsRegBI.v" 
          "datamux.sym" 
          "datamux.v" 
          "dda.sym" 
          "dda.v" 
          "dda_bus_if.sym" 
          "dda_bus_if.v" 
          "debounce.sym" 
          "debounce.v" 
          "div_steps.sym" 
          "div_steps.v" 
          "dpMem_dc.v" 
          "eth_rx.sym" 
          "eth_tx.sym" 
          "fifo32.sym" 
          "fifo32.v" 
          "fifoRTL.v" 
          "gpin_buf.sym" 
          "gpin_buf.v" 
          "gpio_buf.sym" 
          "gpio_buf.v" 
          "gpio_ctrl.sym" 
          "gpio_ctrl.v" 
          "gpout_buf.sym" 
          "gpout_buf.v" 
          "initSD.v" 
          "loader.v" 
          "memory_maped_if.sym" 
          "memory_maped_if.v" 
          "mmu.sym" 
          "mmu.v" 
          "pio.sym" 
          "readWriteSDBlock.v" 
          "readWriteSPIWireData.sym" 
          "readWriteSPIWireData.v" 
          "sdram.sym" 
          "sendCmd.v" 
          "spiCtrl.v" 
          "spiMaster.sym" 
          "spiMaster.v" 
          "spiMaster_defines.v" 
          "spiTxRxData.v" 
          "spi_buf_ctrl.v" 
          "spi_master_ctrl.sym" 
          "spi_master_ctrl.v" 
          "spi_slave.sym" 
          "spi_slave.v" 
          "step_gen.sym" 
          "step_gen.v" 
          "stepper_ctrl.sch" 
          "steppers_module.sch" 
          "steppers_module.sym" 
          "test_debounce.v" 
          "test_div_steps.v" 
          "test_mmi.v" 
          "test_spi_wire.v" 
          "test_step_gen.v" 
          "test_stepper_ctrl.v" 
          "test_steppers_module.v" 
          "test_top.v" 
          "test_uart.v" 
          "timescale.v" 
          "top.sch" 
          "top.sym" 
          "top.ucf" 
          "top_guide.ncd" 
          "uart.sch" 
          "uart_cpu_if.sym" 
          "uart_cpu_if.v" 
          "uart_lib.vhd" 
          "uarts_module.sch" 
          "uarts_module.sym" 
          "wishBoneBI.v" 
                 }
foreach file $export_files {
   CopyOut $file $staging_area $copy_option
}
# copy export file to staging area
CopyOut "/home/seva/src/vp2/rtl/vp2/vp2_import.tcl" "$staging_area" nop
# return back
cd $old_working_dir

