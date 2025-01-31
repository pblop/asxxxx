.nlist
;****************************************************************************
;
; Compile The Assembly Code
;
;	AS89LP -loxff fpga.asm
;
; To Define The fpga.asm Globals Place The Following Lines In Your Code
;
;	.define _fpga
;	.list	(!)	; This Inhibits The Include File Pagination
;	.include "fpga.asm"
;	.list
;
;****************************************************************************
;
; This Definition Controls The Inclusion FPGA Code
;
	; fpga.asm
	mfm$fpg =:	1

;
;****************************************************************************
;
; FPGA.ASM Globals In A Macro
;
	.macro	.fpga.globals	arg$
	  .ifne	mfm$fpg
	    .iifne  arg$	.list	(!,src,me)
	  .globl	fpga
	  .globl	fpga_init
	    .nlist
	  .endif
	.endm
;
;****************************************************************************
;
.ifdef  _fpga
	.list	(!,src)
;	fpga.asm        Globals                 Defined
	.nlist

	.fpga.globals	0
.else
	.list
	.title	FPGA Reset And Loader

	.module	FPGA

	.fpga.globals	1

.ifne	mfm$fpg
;
;****************************************************************************
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
; Diagnostics Are Configured In 'debug.asm'
;
	.define	_debug

	.list	(!)	; This Inhibits The Include File Pagination
;	.include "debug.asm"
	.list
;
;****************************************************************************
;
;  Externals By Inclusion
;
	.define	_macros
	.define	_mfm
	.define	_mondeb51

	.list	(!)	; This Inhibits The Include File Pagination
	.include "macros.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mfm.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mondeb51.asm"
	.list
;
;****************************************************************************
;
	; Command Table Entries

	.area	CmdTbl

	ljmp	fpga

;
;****************************************************************************
;
	; Command List Entries 

	.area	CmdLst

	.ascii	/FPGA/
	.byte	cr

;
;****************************************************************************
;
	; Command Option List Entries

	.area	OptLst

	;  Question Answers

fpg$yn:	.ascii	/YES/
	.byte	cr
	.ascii	/NO/
	.byte	cr
	.byte	lf		; end of list

;
;****************************************************************************
;
	; Extended Help String Pointers

	.area	X_Ptrs

	.word	$fpga

;
;****************************************************************************
;
	; Extended Help Strings

	.area	X_Strs

$fpga:
	.ascii	" F[PGA]  Reset FPGA"
	.byte	cr,lf
	.byte	eot

;
;****************************************************************************

	.page
	.sbttl	Initialization Sequence

;****************************************************************************
;
	.area	Code

	; Step 1 - Reset FPGA (~1us)

fpga_init:			; P1 using default Quasi-Bidirectional Mode
				; PROG_B has a built in pullup resistor
				; Current State Of PROG_B = 1
	clr	p1.0		; 0 => p1.0
	mov	a,#4		; loop counter
	djnz	a,.		; inplace loop
	setb	p1.0		; 1 => p1.0

	; Step 2 - Wait Sufficient Time For FPGA To Configure

	mov	dptr,#5		; wait 5 ms.
	lcall	timdel

	; And Finished

	ret

;
;****************************************************************************

	.page
	.sbttl	Reset FPGA

;****************************************************************************
;

	; Step 1 - Reset FPGA (~1us)

fpga:	mov	dptr,#fpga$1	; ask for Y/N
	lcall	get$yn
	jc	fpga_y		; ^C abort
	jz	fpga_y		; no argument
	jb	a.7,fpga_x	; invalid argument
	cjne	a,#1,fpga_y	; not YES - abort

	lcall	fpga_init
	ljmp	nomore

fpga_x:	.ldptr	#fpga$x		; invalid/missing argument
	sjmp	fpga_z
fpga_y:	.ldptr  #fpga$y		; command aborted
;	sjmp	fpga_z

fpga_z:	lcall	outstr
	ljmp	nomore

fpga$1:	.ascii	" Reset FPGA ?  (Y/N) "
	.byte	eot
fpga$x:	.ascii	" Missing/Invalid Argument -"
fpga$y:	.ascii	" Reset Aborted"
	.byte	cr,lf,eot

	; YES/NO Query

get$yn:	lcall	get$ln
	jnc	1$
	ret

1$:	mov	dptr,#fpg$yn	; look for option in list
	lcall	fndlnm		; returns with list number
	lcall	comand
	clr	c
	ret

	; Query New Line

get$ln:	lcall	outstr
	lcall	getlin		; get line of input
	cjne	a,#3,1$		; abort line on a control-c
	lcall	docrlf
	setb	c
	ret

1$:	mov	a,#ttybuf-1
	.sb_rx	synptr,a	; reset pointer to beginning
	.sb_rx	linptr,a	; reset pointer to beginning
	setb	bolflg		; set 'beginning of line' flag
	clr	c
	ret

;
;****************************************************************************

	.end

.endif	; mfm$fpg
.endif	; .else of _fpga
