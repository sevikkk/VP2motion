;
; Startup code for cc65 (NES version)
;
; by Groepaz/Hitmen <groepaz@gmx.net>
; based on code by Ullrich von Bassewitz <uz@cc65.org>
;
; This must be the *first* file on the linker command line
;

        .export         _exit
	.export         __STARTUP__ : absolute = 1      ; Mark as startup
	.import		callmain
	.import	        push0, _main, zerobss, copydata
        .import         ppubuf_flush

        ; Linker generated symbols
	.import		__RAM_START__, __RAM_SIZE__
	.import		__STCK_START__, __STCK_SIZE__

        .include        "zeropage.inc"

; ------------------------------------------------------------------------
; Place the startup code in a special segment.

.segment       	"INIT"

start:

; setup the CPU and System-IRQ
        ldx     #$FF
        txs

; Clear the BSS data

        jsr	zerobss

; initialize data
	jsr	copydata

; setup the stack

        lda     #<(__STCK_START__ + __STCK_SIZE__)
        sta	sp
        lda	#>(__STCK_START__ + __STCK_SIZE__)
       	sta	sp+1            ; Set argument stack ptr

; Push arguments and call main()

       	jsr    	callmain

; Reset the NES

_exit:
   	jmp start

; Interrupt exit

nmi:
irq2:
irq1:
timerirq:
irq:
        rti

; ------------------------------------------------------------------------
; hardware vectors
; ------------------------------------------------------------------------

.segment "VECTORS"

        .word   irq2        ; $fff4 ?
        .word   irq1        ; $fff6 ?
        .word   timerirq    ; $fff8 ?
        .word   nmi         ; $fffa vblank nmi
        .word   start	    ; $fffc reset
   	.word	irq         ; $fffe irq / brk


