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
        .import         initlib, donelib

        ; Linker generated symbols
	.import		__RAM_START__, __RAM_SIZE__
	.import		__STCK_START__, __STCK_SIZE__

        .include        "zeropage.inc"

; ------------------------------------------------------------------------
; Place the startup code in a special segment.

.segment       	"INIT"

start:

; setup the CPU and System-IRQ

; Clear the BSS data

        jsr	zerobss

; setup the stack

        lda     sp
	sta	kernsp
        lda     sp+1
	sta	kernsp+1

        lda     #<(__STCK_START__ + __STCK_SIZE__)
        sta	sp
        lda	#>(__STCK_START__ + __STCK_SIZE__)
       	sta	sp+1            ; Set argument stack ptr

; Push arguments and call main()

       	jsr    	initlib
       	jsr    	callmain
       	jsr    	donelib

; Reset the NES

_exit:
	lda	kernsp
        sta     sp
	lda	kernsp+1
        sta     sp+1
   	rts

