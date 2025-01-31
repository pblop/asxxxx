	.title	Test PCR Boundaries

	.radix 8

	.bank	C	(base=0q1000)
	.area	B	(abs,ovr,bank=C)
	.org 0
	.area	A	(abs,ovr,bank=C)
	.org 0


	.globl	Y

	X = 2

	.word	0

A:	mov	A,A

1$:	mov	1$,1$

	mov	2(pc),2(pc)
	mov	A(pc),A(pc)
	mov	X(pc),X(pc)

	mov	@2(pc),@2(pc)
	mov	@A(pc),@A(pc)
	mov	@X(pc),@X(pc)

	mov	2,2
	mov	A,A
	mov	X,X

	mov	Y(pc),Y(pc)
	mov	@Y(pc),@Y(pc)
	mov	Y,Y


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	; The Macro Creates Labels Which Are Effectively External.
	; This Allows Testing Of The Program Counter Relative Modes
	; For External Symbols.
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	.macro	.xpc	a
		.list	(!,err,loc,bin,eqt,cyc,lin,src,mel)

		.globl	'a
		.nval	New_B_Org,.
		.area	B
		.org	New_B_Org
'a:
		.area	A

	.endm

B:

1$:	mov	1$,1$
	.xpc	a1
	mov	a1,a1


	;.define	^/0-./ ZMD
	.globl	a_T

	.area	T	(abs,con)
	.org 0

	.macro ZMD	; Zero Minus Dot
		.list (mel)
		.nval $_._$, .
	.word	0 - $_._$
	.endm

	.word

	ZMD

	.org	0x0010
A$:	br	$$2

	.org	0x7080
1$:	br	2$

	.org	0x7100
2$:	br	1$

;*****

	.org	0x7FF0
3$:	br	4$

	.org	0x8010
4$:	br	3$

;*****

	.org	0x9080
5$:	br	6$

	.org	0x9100
6$:	br	5$

;*****

	.org	0x8010
$$:	br	$$1

	.org	0x7FF0
$$1:	br	$$

;*****

	.org	0xFFF0
$$2:	br	A$


	.org	0x8000
	br	.

	.org	0x7FFE
	br	.+2


	.end

