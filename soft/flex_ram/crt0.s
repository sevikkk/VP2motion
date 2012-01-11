;
; Startup code for cc65 (NES version)
;
; by Groepaz/Hitmen <groepaz@gmx.net>
; based on code by Ullrich von Bassewitz <uz@cc65.org>
;
; This must be the *first* file on the linker command line
;

        .export         _exit
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

; stack pointer
        ldx     #$FF
        txs

; Clear the BSS data

        jsr	zerobss

; setup the stack

        lda     #<(__STCK_START__ + __STCK_SIZE__)
        sta	sp
        lda	#>(__STCK_START__ + __STCK_SIZE__)
       	sta	sp+1            ; Set argument stack ptr

; Push arguments and call main()

       	jsr    	callmain

; Reset the NES

_exit:
	jmp	_exit
