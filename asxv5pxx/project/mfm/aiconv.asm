.nlist
;****************************************************************************
;
; Compile The Assembly Code
;
;	AS89LP aiconv.asm
;
; To Define The aiconv.asm Globals Place The Following Lines In Your Code
;
;	.define _aiconv
;	.list	(!)	; This Inhibits The Include File Pagination
;	.include "aiconv.asm"
;	.list
;
;****************************************************************************
;
; MFM.ASM Globals In A Macro
;
	.macro	.aiconv.globals	arg$
	  .iifne  arg$	.list	(!,src,me)
	  .globl	a$o$i,	a$d$i,	a$h$i

	  .globl	i$b$b,	i$b$o,	i$b$d,	i$b$h
	  .globl	i$w$b,	i$w$o,	i$w$d,	i$w$h

	  .globl	i$b$bz,	i$b$oz,	i$b$dz,	i$b$hz
	  .globl	i$w$bz,	i$w$oz,	i$w$dz,	i$w$hz

	  .globl	i$sp,	i$xram,	i$err

	  .globl	i$dath,	i$datl
	  .nlist
	.endm
;
;****************************************************************************
;
.ifdef _aiconv
	.list	(!,src)
;	aiconv.asm      Globals                 Defined
	.nlist

	.aiconv.globals	0
.else
	.list
	.title	Ascii <--> Integer Conversion Routines

	.module	AICONV

	.aiconv.globals	1

;
;****************************************************************************
;
;  Includes
;
	.list	(!)	; This Inhibits The Include File Pagination
	.include "lp3240.sfr"
	.list
;
;****************************************************************************
;
	;	Summary of routines
	;
	;	a$o$i		Ascii in Octal to integer
	;	a$d$i		Ascii in Decimal to integer
	;	a$h$i		Ascii in Hexidecimal to integer
	;
	;	Integer Conversions with Leading Zeros
	;
	;	i$b$b		Integer byte to Binary Ascii
	;	i$w$b		Integer word to Binary Ascii
	;	i$b$o		Integer byte to Octal Ascii
	;	i$w$o		Integer word to Octal Ascii
	;	i$b$d		Integer byte to Decimal Ascii
	;	i$w$d		Integer word to Decimal Ascii
	;	i$b$h		Integer byte to Hexidecimal Ascii
	;	i$w$h		Integer word to Hexidecimal Ascii
	;
	;	Integer Conversion with Leading Zeros Suppressed
	;
	;	i$b$bz		Integer byte to Binary Ascii
	;	i$w$bz		Integer word to Binary Ascii
	;	i$b$oz		Integer byte to Octal Ascii
	;	i$w$oz		Integer word to Octal Ascii
	;	i$b$dz		Integer byte to Decimal Ascii
	;	i$w$dz		Integer word to Decimal Ascii
	;	i$b$hz		Integer byte to Hexidecimal Ascii
	;	i$w$hz		Integer word to Hexidecimal Ascii
	;
	;	All integer to Ascii conversion routines
	;	terminate the resulting string with a NULL byte
	;
	;	All Ascii to integer conversion routines
	;	expect the string to be terminated with a NULL byte
	;
	;	The input or output string is pointed to by dptr
	;		Set Bit i$xram = 0 for Internal Data Memory
	;		Set Bit i$xram = 1 for External XRam Memory
	;
	;	The input or output data is in [b,a]
	;


.ifne 0
	.area	Data	; Normal Data Space
.else
	.area	RData	; Alternate Uses Register Space
.endif

i$ndgt:	.blkb	1
i$dcnt:	.blkb	1
i$dath:	.blkb	1
i$datl:	.blkb	1

	.area	Bits

i$zero:	.blkb	1	; = 0, strip leading zeros / = 1 allow leading zeros
i$bw:	.blkb	1	; = 0, byte / = 1, word
i$sp:	.blkb	1	; = 0, [b,a],dptr / = 1, [b,a],dptr on stack
i$xram:	.blkb	1	; = 0, Data/IData Memory / = 1, XRam Memory
i$err:	.blkb	1	; = 1, Asciil Conversion Error

	.area	aiconv


	.page
	.sbttl	convert ascii in octal/decimal/hexadecimal to integer

a$o$i:
	mov	a,#0d8		; octal conversion
	sjmp	1$

a$d$i=.
	mov	a,#0d10		; decimal conversion
	sjmp	1$

a$h$i=.
	mov	a,#16		; hex conversion
;	sjmp	1$

1$:	push	dph		; save registers
	push	dpl
	push	r1
	push	r0
	mov	r0,a		; save conversion factor

	clr	i$err		; no error
	clr	a		; initialize result
	mov	i$dath,a
	mov	i$datl,a
	sjmp	5$

3$:	setb	i$err		; Note error then exit
	
4$:	pop	r0		; restore registers
	pop	r1
	pop	dpl
	pop	dph
	mov	a,i$datl	; load results
	mov	b,i$dath
	ret			; and exit

5$:	lcall	i$g$c		; get a character
	jz	4$		; check for end of string
	clr	c
	subb	a,#'0
	jc	3$		; result < 0

6$:	cjne	r0,#0d8,7$	; skip if not octal
	mov	b,#1+'7-'0
	sjmp	9$

7$:	cjne	r0,#0d10,8$	; skip if not decimal
	mov	b,#1+'9-'0
	sjmp	9$

8$:     cjne	r0,#0d16,3$	; error if not hexidecimal
	mov	b,#1+'9-'0
	subb	a,b		; 0-9
	jc	10$		; result < 0
	add	a,b		; restore
	clr	c
	subb	a,#'A-'0	; A-F
	jc	3$		; result < 0
	add	a,#0d10		; 0xA = 10
	mov	b,#0d16
	clr	c
9$:	subb	a,b
	jnc	3$		; result >= 0
10$:	add	a,b		; fixup result
	push	a		; save character value
	
	mov	a,r0		; load conversion factor
	mov	b,i$datl
	mul	ab		; multiply LSB of i$data by factor
	mov	i$datl,a	; save LSB of [factor * i$datl]
	push	b		; save MSB of [factor * i$datl]
	mov	a,r0		; restore conversion factor
	mov	b,i$dath
	mul	ab		; multiply MSB of i$data by factor
	pop	b		; pop MSB of [factor * i$datl]
	add	a,b		; add MSB of [factor * i$datl] to	
	mov	i$dath,a	; LSB of [factor * i$dath] and save 

	pop	a		; reecover last character value
	add	a,i$datl	; add to integer
	mov	i$datl,a
	mov	a,i$dath
	addc	a,#0
	mov	i$dath,a

	inc	dptr		; point to next character
	sjmp	5$		; and loop

	.page
	.sbttl	byte/word to Binary ascii conversion

i$b$b:
	setb	i$zero		; leading zeros enabled
	clr	i$bw		; byte operation
	sjmp	1$

i$b$bz=.
	clr	i$zero		; leading zeros disabled
	clr	i$bw		; byte operation
;	sjmp	1$

1$:	mov	i$ndgt,#8	; 8 bits
	sjmp	i$b$bw

i$w$b:
	setb	i$zero		; leading zeros enabled
	setb	i$bw		; word operation
	sjmp	1$

i$w$bz=.
	clr	i$zero
	setb	i$bw		; word operation
;	sjmp	1$

1$:	mov	i$ndgt,#16	; 16 bits
;	sjmp	i$b$bw

i$b$bw: jnb	i$sp,1$		; stacked parameters? no - skip
	pop	dph		; else unstack parameters
	pop	dpl
	pop	b
	pop	a
1$:	push	a		; save parameters
	push	b
	push	dpl
	push	dph
	push	r0
	push	r1

	jb	i$bw,2$
	clr	a		; byte configuration
2$:	mov	i$datl,a	; save data
	mov	i$dath,b

i$b:	mov	i$dcnt,#0	; initialize result
	lcall	i$shift		; shift 1 bit
	add	a,#'0		; convert to ascii

	lcall	i$char		; process character
	djnz	i$ndgt,i$b	; any more ? yes - loop

	ljmp	i$exit


	.page
	.sbttl	byte/word to Octal ascii conversion

i$b$o:
	setb	i$zero		; leading zeros enabled
	clr	i$bw		; byte operation
	sjmp	1$

i$b$oz=.
	clr	i$zero		; leading zeros suppressed
	clr	i$bw		; byte operation
;	sjmp	1$

1$:	mov	i$ndgt,#3	; 3 digits
	sjmp	i$o$bw

i$w$o:
	setb	i$zero		; leading zeros enabled
	setb	i$bw		; word operation
	sjmp	1$

i$w$oz=.
	clr	i$zero		; leading zeros suppressed
	setb	i$bw		; word operation
;	sjmp	1$

1$:	mov	i$ndgt,#6	; 6 digits
;	sjmp	i$d$bw

i$o$bw: jnb	i$sp,1$		; stacked parameters? no - skip
	pop	dph		; else unstack parameters
	pop	dpl
	pop	b
	pop	a
1$:	push	a		; save parameters
	push	b
	push	dpl
	push	dph
	push	r0
	push	r1

	jb	i$bw,2$
	clr	a		; byte configuration
2$:	mov	i$datl,a	; save data
	mov	i$dath,b
	clr	a
	mov	i$dcnt,a	; initialize result

	jb	i$bw,i$ow
	sjmp	i$ob

i$o:	mov	i$dcnt,#0	; initialize result
	lcall	i$shift		; shift 1 bit
i$ob=.
	lcall	i$shift		; shift 1 bit
i$ow=.
	lcall	i$shift		; shift 1 bit, i$dcnt left in a
	add	a,#'0		; convert to ascii

	lcall	i$char		; process character
	djnz	i$ndgt,i$o	; any more ? yes - loop
 	ljmp	i$exit


	.page
	.sbttl	byte/word to Decimal ascii conversion

i$b$d:
	setb	i$zero		; leading zeros enabled
	clr	i$bw		; byte operation
	sjmp	1$

i$b$dz=.
	clr	i$zero		; leading zeros suppressed
	clr	i$bw		; byte operation
;	sjmp	1$

1$:	mov	i$ndgt,#3	; 3 digits
	sjmp	i$d$bw

i$w$d:
	setb	i$zero		; leading zeros enabled
	setb	i$bw		; word operation
	sjmp	1$

i$w$dz=.
	clr	i$zero		; leading zeros suppressed
	setb	i$bw		; word operation
;	sjmp	1$

1$:	mov	i$ndgt,#5	; 5 digits
;	sjmp	i$d$bw

i$d$bw: jnb	i$sp,1$		; stacked parameters? no - skip
	pop	dph		; else unstack parameters
	pop	dpl
	pop	b
	pop	a
1$:	push	a		; save parameters
	push	b
	push	dpl
	push	dph
	push	r0
	push	r1

	jb	i$bw,2$
	clr	a		; byte configuration
	xch	a,b
2$:	mov	i$datl,a	; save data
	mov	i$dath,b

i$d:    push	dpl		; save
	push	dph
	mov	a,i$ndgt	; digit number
	mov	dptr,#3$
	sjmp	2$
1$:	inc	dptr
	inc	dptr
2$:	djnz	a,1$		; update pointer to proper digit
	movc	a,@a+dptr	; MSB of comparison value
	mov	r1,a
	mov	a,#1
	movc	a,@a+dptr	; LSB of comparison value
	mov	r0,a
	pop	dph		; restore
	pop	dpl
	mov	i$dcnt,#0	; initialize counter
	sjmp	4$

3$:	.word	0d1
	.word	0d10
	.word	0d100
	.word	0d1000
	.word	0d10000

4$:	mov	a,i$datl	; perform subtraction
	push	a		; save value for restore
	clr	c
	subb	a,r0
	mov	i$datl,a
	mov	a,i$dath
	push	a		; save value for restore
	subb	a,r1
	mov	i$dath,a
	jc	5$		; finish up on carry
	inc	i$dcnt		; else update count
	pop	a		; dump restore data
	pop	a
	sjmp	4$		; and loop

5$:	pop	a		; restore to before subtraction
	mov	i$dath,a
	pop	a
	mov	i$datl,a

	mov	a,i$dcnt
	add	a,#'0		; convert to ascii

	lcall	i$char		; process character
	djnz	i$ndgt,i$d	; any more ? yes - loop
	ljmp	i$exit

	.page
	.sbttl	byte/word to Hex ascii conversion

i$b$h:
	setb	i$zero		; leading zeros enabled
	clr	i$bw		; byte operation
	sjmp	1$

i$b$hz=.
	clr	i$zero		; leading zeros suppressed
	clr	i$bw		; byte operation
;	sjmp	1$

1$:	mov	i$ndgt,#2	; 2 digits
	sjmp	i$h$bw

i$w$h:
	setb	i$zero		; leading zeros enabled
	setb	i$bw		; word operation
	sjmp	1$

i$w$hz=.
	clr	i$zero		; leading zeros suppressed
	setb	i$bw		; word operation
;	sjmp	1$

1$:	mov	i$ndgt,#4	; 4 digits
;	sjmp	i$h$bw

i$h$bw: jnb	i$sp,1$		; stacked parameters? no - skip
	pop	dph		; else unstack parameters
	pop	dpl
	pop	b
	pop	a
1$:	push	a		; save parameters
	push	b
	push	dpl
	push	dph
	push	r0
	push	r1

	jb	i$bw,2$
	clr	a		; clear if byte option
2$:	mov	i$datl,a	; save data
	mov	i$dath,b

i$h:	mov	i$dcnt,#0	; initialize result
	lcall	i$shift		; shift 4 bits
	lcall	i$shift
	lcall	i$shift
	lcall	i$shift
	subb	a,#0d10		; convert to ascii
	jc	1$		; 0-9
	add	a,#7		; A-F
1$:	add	a,#'0+0d10

	lcall	i$char		; process character
	djnz	i$ndgt,i$h	; any more ? yes - loop
;	ljmp	i$exit
;
;****************************************************************************
;
i$exit:	clr	a
	lcall	i$p$c		; terminator
	pop	r1		; restore registers
	pop	r0
	pop	dph
	pop	dpl
	pop	b
	pop	a
	ret
;
;****************************************************************************
;
i$char:	djnz	i$ndgt,1$	; last digit ? no - test for '0
	sjmp	2$		; place last character in string

1$:	jb	i$zero,2$	; zeros ? yes - add to string
	cjne	a,#'0,2$	;  a '0 ?  no - add to string
	sjmp	3$	        ;	  yes - skip character

2$:	lcall	i$p$c		; save character
	inc	dptr
	setb	i$zero		; enable zeros
3$:     inc	i$ndgt		; restore count
	ret
;
;****************************************************************************
;
i$shift:clr	c		; left shift [i$dcnt, i$dath, i$datl] 1 bit
	mov	a,i$datl
	rlc	a
	mov	i$datl,a
	mov	a,i$dath
	rlc	a
	mov	i$dath,a
	mov	a,i$dcnt
	rlc	a
	mov	i$dcnt,a
	ret
;
;****************************************************************************
;
i$g$c:	jnb	i$xram,1$	; Internal Ram - skip

	movx	a,@dptr		; get character from Extended Memory
	ret

1$:     mov	r1,dpl		; just use LSB of address
	mov	a,@r1		; get character from Data/IData Memory
	ret
;
;****************************************************************************
;
i$p$c:	jnb	i$xram,1$	; Internal Ram - skip

	movx	@dptr,a		; place character in Extended Memory
	ret

1$:     mov	r1,dpl		; just use LSB as address
	mov	@r1,a		; place character in Data/IData Memory
	ret
;
;****************************************************************************
	
	.end

.endif	; .else of _aiconv

