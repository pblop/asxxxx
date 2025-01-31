.nlist
;****************************************************************************
;
; Compile The Assembly Code
;
;	AS89LP -loxff ideblk.asm
;
; To Define The ideblk.asm Globals Place The Following Lines In Your Code
;
;	.define _ideblk
;	.list	(!)	; This Inhibits The Include File Pagination
;	.include "ideblk.asm"
;	.list
;
;****************************************************************************
;

.ifdef _ideblk
	.list	(!,src)
;	ideblk.asm      Globals                 Defined
	.nlist

.else
	.list
	.title	IDE Drive Block Parameters

	.module	IDEBLK

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
	.list	(!)	; This Inhibits The Include File Pagination
	.include "ioreg.def"
	.list
;
;****************************************************************************
;
; Diagnostics Are Configured In 'debug.asm'
;
	.define	_debug

	.list	(!)	; This Inhibits The Include File Pagination
	.include "debug.asm"
	.list
;
;****************************************************************************
;
;  Externals By Inclusion
;
	.define	_macros
	.define	_mondeb51
	.define	_mfmide
	.define	_spchr
	.define	_sp0_x
	.define	_aiconv

	.list	(!)	; This Inhibits The Include File Pagination
	.include "macros.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mondeb51.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mfmide.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "spchr.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "sp0_x.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "aiconv.asm"
	.list
;
;****************************************************************************

	.page
	.sbttl	Identify Drive Table Entries

;****************************************************************************
;

	; Command Table Entries

	.area	CmdTbl

	ljmp	ide

	; Command List Entries 

	.area	CmdLst

	.ascii	/IDE/		; IDE
	.byte	cr

;
;****************************************************************************
;
	; Command Option List Entries

	.area	OptLst

	; Modifiers to "IDE"

idelst:	.ascii	/ID/
	.byte	cr
	.byte	lf		; end of list

	; Extended Help String Pointers

	.area	X_Ptrs

	.word	$ide

	; Extended Help Strings

	.area	X_Strs

$ide:	.ascii	" ID[E]  command"
	.byte	cr,lf
	.ascii	"   I[D] - Drive Identification Block"
	.byte	eot

;
;****************************************************************************
;
 	.area	MFMIDE
;
;****************************************************************************
;
; IDE Command Dispatcher
;

ide:	mov	dptr,#idelst	; look for option in list
	lcall	fndlnm		; returns with list number
	lcall	comand		; now go for a match
	jz	idehlp		; list help if just a cr was typed
	jb	a.7,1$		; bad command if negative
	ljmp	2$		; good command if positive
1$:	ljmp	badsyn

2$:	dec	a		; compute (a - 1) * 3
	mov	b,#3
	mul	ab		; a is product
	mov	dptr,#3$
	jmp	@a+dptr		; jump into jump table

	;1st level jump table

3$:	ljmp	i$id		; first level subcommands

idehlp:	mov	dptr,#$ide	; expanded help
	lcall	outstr		; string address in dptr
	ljmp	nomore

;
;****************************************************************************
;
; Show The 'Identify Drive' Block Parameters
;

i$id:	mov	dptr,#1$	; Command Description
	lcall	outstr

	lcall	i$mdln		; Model Number
	lcall	i$srln		; Serial Number
	lcall	i$fwrv		; Firmware Revision
	lcall	i$5458		; Disk Capacity
	lcall	i$6063		; Addressable Sectors [LBA]
	lcall	i$6470		; Cycle Times

	ljmp	nomore	

1$:	.ascii	" IDE Drive Indentification Block Parameters"
	.byte	cr,lf,cr,lf,eot
;
;****************************************************************************
;
i$mdln:	mov	b,#27			; [ 27], location in block
	lcall	i$lctn
	mov	dptr,#1$
	lcall	outstr
	mov	dptr,#ideblk+(2*27)	; Model Number
	mov	b,#40			; 40 characters
	lcall	dmpstr
	mov	dptr,#2$
	ljmp	outstr
	;	01234567890123456789012345
1$:	.ascii	"Model Number:      '"
	.byte	eot
2$:	.ascii	"'"
	.byte	cr,lf,eot
;
;****************************************************************************
;
i$srln: mov	b,#10
	lcall	i$lctn
	mov	dptr,#1$
	lcall	outstr
	mov	dptr,#ideblk+(2*10)	; Serial Number
	mov	b,#20			; 20 characters
	lcall	dmpstr
	mov	dptr,#2$
	ljmp	outstr
	;	01234567890123456789012345
1$:	.ascii	"Serial Number:     '"
	.byte	eot
2$:	.ascii	"'"
	.byte	cr,lf,eot
;
;****************************************************************************
;
i$fwrv: mov	b,#23
	lcall	i$lctn
	mov	dptr,#1$
	lcall	outstr
	mov	dptr,#ideblk+(2*23)	; Firmware Revision
	mov	b,#8			; 8 characters
	lcall	dmpstr
	mov	dptr,#2$
	ljmp	outstr
	;	01234567890123456789012345
1$:	.ascii	"Firmware Revision: '"
	.byte	eot
2$:	.ascii	"'"
	.byte	cr,lf,eot
;
;****************************************************************************
;
i$5458:	mov	dptr,#ideblk+(2*53 + 1)	; check if words 54-58 are valid
	movx	a,@dptr
	jb	a.0,1$
	ret				; no - exit

1$:	lcall	docrlf
	mov	b,#54			; [ 54], location in block
	lcall	i$lctn
	mov	dptr,#2$
	lcall	outstr
	.lb_x	b,ideblk+(2*54)		; cylinders
	inc	dptr
	movx	a,@dptr
	lcall	sp5chr			; output cylinders
	lcall	docrlf

	mov	b,#55			; [ 55], location in block
	lcall	i$lctn
	mov	dptr,#3$
	lcall	outstr
	.lb_x	b,ideblk+(2*55)		; heads
	inc	dptr
	movx	a,@dptr
	lcall	sp4chr			; output heads
	lcall	docrlf

	mov	b,#56			; [ 56], location in block
	lcall	i$lctn
	mov	dptr,#4$
	lcall	outstr
	.lb_x	b,ideblk+(2*56)		; sectors
	inc	dptr
	movx	a,@dptr
	lcall	sp4chr			; output sectors
	lcall	docrlf

	mov	b,#57			; [ 57], location in block
	lcall	i$lctn
	mov	dptr,#5$
	lcall	outstr
	.lb_x	b,ideblk+(2*58)		; capacity
	inc	dptr
	movx	a,@dptr
	lcall	hex2by			; output MSW capacity
	.lb_x	b,ideblk+(2*57)		; capacity
	inc	dptr
	movx	a,@dptr
	lcall	hex2by			; output LSW capacity
	ljmp	docrlf

2$:	.ascii	"Current Logical Cylinders:        "
	.byte	eot
3$:	.ascii	"Current Logical Heads:             "
	.byte	eot
4$:	.ascii	"Current Logical Sectors Per Track: "
	.byte	eot
5$:	.ascii	"Current Capacity in Sectors: 0x"
	.byte	eot
;
;****************************************************************************
;
i$6063:	lcall	docrlf
	mov	b,#60			; [ 60], location in block
	lcall	i$lctn
	mov	dptr,#5$
	lcall	outstr
	.lb_x	b,ideblk+(2*61)		; capacity
	inc	dptr
	movx	a,@dptr
	lcall	hex2by			; output MSW capacity
	.lb_x	b,ideblk+(2*60)		; capacity
	inc	dptr
	movx	a,@dptr
	lcall	hex2by			; output LSW capacity
	lcall	docrlf

	mov	b,#63			; [ 63], location in block
	lcall	i$lctn
	.lb_x	a,ideblk+(2*63+1)	; supported DMA modes
	lcall	i$bscn
	jc	1$
	mov	dptr,#6$
	lcall	outstr
	lcall	sp1chr
	sjmp	2$
1$:	mov	dptr,#7$
	lcall	outstr
2$:	lcall	docrlf

	mov	b,#63			; [ 63], location in block
	lcall	i$lctn
	.lb_x	b,ideblk+(2*63+0)	; selected DMA mode
	lcall	i$bscn
	jc	3$
	mov	dptr,#8$
	lcall	outstr
	lcall	sp1chr
	sjmp	4$
3$:	mov	dptr,#9$
	lcall	outstr
4$:	lcall	docrlf
	ret

5$:	.ascii	"Addressable Sectors [LBA]:   0x"
	.byte	eot
6$:	.ascii	"Supported Multiword DMA Modes Are <=  "
	.byte	eot
7$:	.ascii	"No Supported Multiword DMA Modes Listed"
	.byte	eot
8$:	.ascii	"Selected Multiword DMA Mode Is:       "
	.byte	eot
9$:	.ascii	"No Multiword DMA Mode Delected"
	.byte	eot

i$bscn:	clr	c
	mov	b,#0
	jnb	a.2,1$
	mov	b,#2
	sjmp	4$
1$:	jnb	a.1,2$
	mov	b,#1
	sjmp	4$
2$:	jnb	a.0,3$
	mov	b,#0
	sjmp	4$
3$:	setb	c			; nothing set
4$:	ret
;
;****************************************************************************
;
i$6470:	mov	dptr,#ideblk+(2*53 + 1)	; check if words 64-70 are valid
	movx	a,@dptr
	jb	a.1,1$
	ret				; no - exit

1$:	lcall	docrlf
	mov	b,#65			; [ 65], location in block
	lcall	i$lctn
	mov	dptr,#2$
	lcall	outstr
	.lb_x	b,ideblk+(2*65)		; minimum multiword DMA transfer time
	inc	dptr
	movx	a,@dptr
	lcall	sp4chr			; output in nanoseconds
	mov	dptr,#6$
	lcall	outstr
	lcall	docrlf

	mov	b,#66			; [ 66], location in block
	lcall	i$lctn
	mov	dptr,#3$
	lcall	outstr
	.lb_x	b,ideblk+(2*66)		; reecommended multiword DMA transfer time
	inc	dptr
	movx	a,@dptr
	lcall	sp4chr			; output in nanoseconds
	mov	dptr,#6$
	lcall	outstr
	lcall	docrlf

	mov	b,#67			; [ 67], location in block
	lcall	i$lctn
	mov	dptr,#4$
	lcall	outstr
	.lb_x	b,ideblk+(2*67)		; minimum PIO transfer cycle time with no flow control
	inc	dptr
	movx	a,@dptr
	lcall	sp4chr			; output in nanoseconds
	mov	dptr,#6$
	lcall	outstr
	lcall	docrlf

	mov	b,#68			; [ 68], location in block
	lcall	i$lctn
	mov	dptr,#5$
	lcall	outstr
	.lb_x	b,ideblk+(2*68)		; minimum PIO transfer cycle time with IORDY flow control
	inc	dptr
	movx	a,@dptr
	lcall	sp4chr			; output in nanoseconds
	mov	dptr,#6$
	lcall	outstr
	ljmp	docrlf

2$:	.ascii	"Minimum Multiword DMA Cycle Time:  "
	.byte	eot
3$:	.ascii	"Suggested Multiword DMA Cycle Time:"
	.byte	eot
4$:	.ascii	"Minimum PIO Cycle Time, No IORDY:  "
	.byte	eot
5$:	.ascii	"Minimum PIO Cycle Time With IORDY: "
	.byte	eot
6$:	.ascii	" ns."
	.byte	eot
;
;****************************************************************************
;
dmpstr:	sjmp	2$		; goto entry
1$:	dec	b
	inc	dptr
2$:	movx	a,@dptr
	add	a,#-spc		; strip leading spaces
	jz	1$

3$:	push	dph
	push	dpl
	dec	b		; address index
	mov	a,dpl
	add	a,b
	mov	dpl,a
	mov	a,dph
	addc	a,#0
	mov	dph,a
	movx	a,@dptr
	add	a,#-spc		; strip trailing spaces
	pop	dpl
	pop	dph
	jz	3$
	inc	b

4$:	movx	a,@dptr		; output string
	lcall	chrout
	inc	dptr
	djnz	b,4$
	ret
;
;****************************************************************************
;
i$lctn:	push	b
	mov	dptr,#iblk$1
	lcall	outstr
	pop	b
	lcall	sp3chr
	mov	dptr,#iblk$2
	lcall	outstr
	ret

iblk$1:	.ascii	"   ["
	.byte	eot
iblk$2:	.ascii	"] "
	.byte	eot
;
;****************************************************************************

.endif	; _ideblk

	.end


