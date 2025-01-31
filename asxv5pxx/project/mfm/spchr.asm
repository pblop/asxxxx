.nlist
;****************************************************************************
;
; Compile The Assembly Code
;
;	AS89LP -loxff spchr.asm
;
; To Define The spchr.asm Globals Place The Following Lines In Your Code
;
;	.define _spchr
;	.list	(!)	; This Inhibits The Include File Pagination
;	.include "spchr.asm"
;	.list
;
;****************************************************************************
;
; SPCHR.ASM Globals In A Macro
;
	.macro	.spchr.globals	arg$
	  .iifne  arg$	.list	(!,src,me)
	  .globl	dec1by,	dec2by,	hex1by,	hex2by
  	  .globl	sp1chr,	sp2chr,	sp3chr,	sp4chr, sp5chr,	spcout
	  .nlist
	.endm
;
;****************************************************************************
;
.ifdef _spchr
	.list	(!,src)
;	spchr.asm       Globals                 Defined
	.nlist

	.spchr.globals	0
.else
	.list
	.title	Numerical Output Functions

	.module	SPCHR

	.spchr.globals	1

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
;  Externals By Inclusion
;
	.define	_sp0_x
	.define	_aiconv

	.list	(!)	; This Inhibits The Include File Pagination
	.include "sp0_x.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "aiconv.asm"
	.list
;
;****************************************************************************
;
	.area	EData

txtbuf:	.blkb	8	; Output Text Buffer

;
;****************************************************************************
;
	.area	Code
;
;****************************************************************************

	.page
	.sbttl	Integer To Ascii OutPut Functions

;****************************************************************************
;
; These functions are equivalent to the MONDEB-51
; 'out1by' and 'out2by' functions which converts
; input characters to a number.
;
;  display the number contained in [b] or [b,a]
;  in decimal radix with leading zeros suppressed
;
;  variables:
;  txtbuf - ascii output buffer
;
;****************************************************************************
;
	; output a 1 byte number

dec1by: setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$b$dz		; leading zero suppressed byte
	ljmp	SP0_MXT		; output string

	; output a 2 byte number

dec2by: setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$w$dz		; leading zero suppressed word
	ljmp	SP0_MXT		; output string

;
;****************************************************************************
;
; These functions are equivalent to the MONDEB-51
; 'out1by' and 'out2by' functions which converts
; input characters to a number.
;
;  display the number contained in [b] or [b,a]
;  in hex radix
;
;  variables:
;  txtbuf - ascii output buffer
;
;****************************************************************************
;
	; output a 1 byte number

hex1by: setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$b$h
	ljmp	SP0_MXT		; output string

	; output a 2 byte number

hex2by: setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$w$h
	ljmp	SP0_MXT		; output string
;
;****************************************************************************
;
; These functions are equivalent to the MONDEB-51
; 'out1by' and 'out2by' functions which converts
; input characters to a number.
;
;  display the number contained in [b] or [b,a]
;  in decimal radix with the equivalent of
;  %1s, %2s, %3s, %4s, or %5s formats.
;
;  variables:
;  txtbuf - ascii output buffer
;
;  Uses direct access to aiconv.asm and sp0_x.asm functions.
;
;****************************************************************************
;
	; output a 1 character number
	; with leading spaces (<b>)

sp1chr:	setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$b$d		; byte to decimal
	mov	b,#2		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#txtbuf+2	; output buffer
	ljmp	SP0_MXT		; output string

	; output a 2 character number
	; with leading spaces (<b>)

sp2chr:	setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$b$d		; byte to decimal
	mov	b,#2		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#txtbuf+1	; output buffer
	ljmp	SP0_MXT		; output string

	; output a 3 character number
	; with leading spaces (<b>)

sp3chr:	setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$b$d		; byte to decimal
	mov	b,#2		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#txtbuf	; output buffer
	ljmp	SP0_MXT		; output string

	; output a 4 character number
	; with leading spaces (<b:a>)

sp4chr:	setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$w$d		; word to decimal
	mov	b,#4		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#txtbuf+1	; output buffer
	ljmp	SP0_MXT		; output string

	; replace maximum of 'b'
	; leading zeros with spaces

sp5chr:	setb	i$xram
	mov	dptr,#txtbuf	; output buffer
	lcall	i$w$d		; word to decimal
	mov	b,#4		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#txtbuf	; output buffer
	ljmp	SP0_MXT		; output string

	; replace maximum of 'b'
	; leading zeros with spaces
spcout:	movx	a,@dptr
	cjne	a,#'0,1$
	mov	a,#spc			; replace leading 0's with space
	movx	@dptr,a
	inc	dptr			; on to next character
	djnz	b,spcout
1$:	ret

;
;****************************************************************************

.endif	; _spchr

	.end


