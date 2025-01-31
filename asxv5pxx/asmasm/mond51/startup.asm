.nlist
;****************************************************************************
;
; Compile The Assembly Code
;
;	AS89LP -loxff startup.asm
;
; To Define The mfm.asm Globals Place The Following Lines In Your Code
;
;	.define _mfm
;	.list	(!)	; This Inhibits The Include File Pagination
;	_start		.include "start.asm"
;	.list
;
;****************************************************************************
;
;	  This file is the startup for the MONDEB-51 monitor.
;
;****************************************************************************
;
; START.ASM Globals In A Macro
;
	.macro	.startup.globals	arg$
	  .iifne  arg$	.list	(!,src,me)
	  .globl	wchdog  ; The Watch Dog Timer
	  .globl	coninp	; Console Input
	  .globl	conout	; Console Output
	  .globl	strout	; Console String Output
	  .globl	wt$brk	; Break Wait Flag
	  .globl	str$up	; In Startup Mode Flag
	  .nlist
	.endm
;
;****************************************************************************
;
.ifdef _startup
	.list	(!,src)
;	startup.asm     Globals                 Defined
	.nlist

	.startup.globals	0
.else
	.list
	.title	MONDEB-51 Startup

	.module	STARTUP

	.startup.globals	1
;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
;	The AREA Definition File Contains The Declarations Of
;	All Areas And Banks.  This File Determines All Code Locations
;
	.list	(!)	; This Inhibits The Include File Pagination
	.include "area.def"
	.list
;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Include SFR, Global, And System Definitions
;
	.list	(!)	; This Inhibits The Include File Pagination
	.include "lp3240.sfr"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "ascii.def"
	.list
;
;****************************************************************************
;
;  Externals By Inclusion
;
	.define	_macros
	.define	_sp0_x
	.define	_print
	.define	_mondeb51

	.list	(!)	; This Inhibits The Include File Pagination
	.include "macros.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "sp0_x.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "print.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mondeb51.asm"
	.list
;
; *****-----*****-----*****-----*****-----*****-----*****-----*****

	.page
	.sbttl	Interrupt Vector Table

; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
	.macro	.rst	addr,srvc
	  .list	(!,err,loc,bin,cyc,eqt,src,me,meb)
	  .org	addr
	  ljmp	srvc	; Normal Interrupt Processing
	  .nlist
	.endm

	.macro	.irq	addr,srvc
	  .list	(!,err,loc,bin,cyc,eqt,src,me,meb)
	  .org	addr
	  ljmp	srvc	; Normal Interrupt Processing
	  .nlist
	.endm

	.area	Stack

mstack:	.blkb	256		; System Stack Area


	.area	Vctr

	; Reset Vector
	.rst	0x00,Reset

	; AT89LP3240 Interrupt Vectors
	.irq	0x03,Ex0Int	; External Interrupt 0
	.irq	0x0B,TF0Int	; Timer 0 Overflow
	.irq	0x13,Ex1Int	; External Interrupt 1
	.irq	0x1B,TF1Int	; Timer 1 Overflow
	.irq	0x23,UrtInt	; Serial Port Interrupt
	.irq	0x2B,TF2Int	; Timer 2 Overflow
	.irq	0x33,AnlgInt	; Analog Comparator Interrupt
	.irq	0x3B,GpInt	; General Purpose Interrupt
	.irq	0x43,CcaInt	; Compare/Capture Array Interrupt
	.irq	0x4B,SpiInt	; Serial Peripheral Interface Interrupt
	.irq	0x53,AdcInt	; ADC Interrupt
	.irq	0x5B,TwiInt	; Two-Wire Interface Interrupt

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;

	.area	BrkPnts

brk01:	.blkb	1		; Console ^U Break Point Entry Flag
wt$brk:	.blkb	1		; Console ^B Break Wait Flag

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;

	.area	Bits

str$up:	.blkb	1		; Startup In Progress Flag

;
;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;

	.page
	.sbttl	Beginning Of Code Space

	.area	Code

	; Unused Interrupts Cause System Reset
.ifndef	Int$Ex0
Ex0Int:
.endif

.ifndef	Int$TF0
TF0Int:
.endif

.ifndef	Int$Ex1
Ex1Int:
.endif

.ifndef	Int$TF1
TF1Int:		; Allocated: Serial Port
.endif

.ifndef	Int$Urt
UrtInt:		; Allocated: Serial Port
.endif

.ifndef	Int$TF2
TF2Int:
.endif

.ifndef	Int$Anl
AnlgInt:
.endif

.ifndef	Int$GpI
GpInt:
.endif

.ifndef	Int$Cca
CcaInt:
.endif

.ifndef	Int$Spi
SpiInt:
.endif

.ifndef	Int$Adc
AdcInt:
.endif

.ifndef	Int$Twi
TwiInt:
.endif


;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
; Power on Reset or Trap
Reset:
	; Initialize target hardware
        mov	ie,#0			; disable all interrupts
	mov	psw,#0			; register bank 0

	mov	spx, #>mstack		; stack initialized to 0x0300
        mov     sp,  #<mstack		; with 256 bytes of XRam

	mov	page,#0			; MOVX a,@Rn and MOVX @Rn,a
					; use the first 256 bytes of EData
	mov	memcon,#0b00001000	; Flash Data mapped

	; Set XData Wait States And ALES = 1
	; The ALES Setting Is Contrary To The
	; Documentation For The AT89LP3240/6440
	; doc3706.pdf

	mov	auxr, #0b00011101	; auxr - Auxiliary Control Register
					;   1 => bit 4 - stack is in EData
					;   1 => bit 3 - Read/Write strobe width
					;   1 => bit 2 - set 4 * clock period
					;   0 => bit 1 - movx addresses EData
					;   1 => bit 0 - ALES set low (inactive)

	; zero DATA/IDATA (0x00 - 0xFF)
	mov	a,#0x00
	mov	r0,#0x00
loop1:	mov	@r0,a
	djnz	r0,loop1

	; zero XDATA (0x0000 - 0x02FF)
	mov	a,#0x00
	mov	b,#0x03
	mov	dptr,#0x0000
loop2:	movx	@dptr,a
	inc	dptr
	cjne	a,dpl,loop2
	djnz	b,loop2

	; zer0 XDATA (0x0300 - 0x03FF)
	; -- stack space --
	mov	a,#0x00
	mov	b,#0x01
	mov	dptr,#0x0300
loop3:	movx	@dptr,a
	inc	dptr
	cjne	a,dpl,loop3
	djnz	b,loop3

	; zero XDATA (0x0400 - 0x0FFF)
	mov	a,#0x00
	mov	b,#0x0C
	mov	dptr,#0x0400
loop4:	movx	@dptr,a
	inc	dptr
	cjne	a,dpl,loop4
	djnz	b,loop4

; Entering Startup Mode
	setb	str$up			; in startup mode

; Initialize Serial Port
.ifdef	Int$Urt
	mov	a,#7			; Select 9600 Baud
	lcall	SP0_INIT
.endif

; Initialize The Watch Dog Timer
; ~2*10^6 clocks is about .1 seconds
	mov	wdtcon,#0b11100000	; Prescaler
	lcall	wchdog			; Start The Watch Dog Timer

; Initialize The Timer(s)
.iifndef  tmr$tmr	tmr$tmr =: 0
.ifne	tmr$tmr
	lcall	timer_init		; timers.asm
.endif

; Interrupt Enable
	setb	ea			; Set Global Interrupt Enable

; Finished Startup Mode
	clr	str$up			; Finished Startup

; System Up
1$:	.cprint	prmt01			; Output System Prompt

; Echo Received Characters
2$:     lcall	coninp			; Wait For A Character
	jnc	2$

	cjne	a,#'V-64,3$		; ^V - Enter Monitor

; Enter Monitor With Serial Port Interrupts Enabled
	lcall	mond51
	sjmp	1$

3$:	cjne	a,#'U-64,4$		; ^U - Enter Monitor Via Break Point
	jnb	brk01,4$		; If Breakpoint Not Enabled - Skip

; Enter Monitor With Serial Port Interrupts Disabled
	setb	B_SP0DIR		; Enable Direct Access Mode (Disables Serial Interrupts)
	mov	brkpnd,#1		; Pending Break Point
	lcall	brkirq			; Enter Monitor Via Break Point
	clr	B_SP0DIR		; Disable Direct Access Mode (Enables Serial Interrupts)
	sjmp	1$

4$:	lcall	conout			; Echo The Character
	sjmp	2$

; Startup Prompt
prmt01:	.asciz	"Processor Initialized >"

	;===================================================
	; Routines Required By MONDEB

	; The Watch Dog Timer
wchdog:	jbc	ea,2$

1$:	mov	wdtrst,#0x1E		; Start Watch Dog Timer
	mov	wdtrst,#0xE1		; Times Out In 800 us.
	ret

2$:	lcall	1$
	setb	ea
	ret

	; The Console Input (Non Blocking)
coninp:	lcall	wchdog		; hit the watch dog timer
	lcall	SP0_INS		; check for character
	jc	1$
	ret			; character not returned

1$:	lcall	SP0_IN
	cjne	a,#'B-64,2$	; ^B - Break Out Of Wait
	setb	wt$brk		; set flag
	clr	c
	ret			; character not returned

2$:	setb	c
	ret			; character returned

	; The Console Output (Blocking)
conout:	lcall	wchdog		; hit the watch dog timer
	lcall	SP0_OUTS	; check if space
	jc	conout		; wait for space / ready
	ljmp	SP0_OUT		; output character
				; returns to caller of conout

	; The Console String Output (Blocking)
strout:	clr	a		; Make A = 0 So MOVC Works
	movc	a,@a+dptr	; Get Character
	inc	dptr		; Point To Next Character
	jnz	1$		; If Not Null, Output Character
	ret			; Return To Caller

1$:	lcall	conout 		; Output Character
	sjmp	strout		; And Loop
	;
	;===================================================

	.end

.endif	; .else of _startup

