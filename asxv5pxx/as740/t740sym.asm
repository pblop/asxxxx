	.title	t740sym.asm

	; Note:
	;	The external symbols are lower case and
	;	the internal symbols are upper case.
	;
	;	as740 -loxff t740sym

.ifne 0
	; Constants

	BIT0	=	0
	BIT1	=	1
	BIT2	=	2
	BIT3	=	3
	BIT4	=	4
	BIT5	=	5
	BIT6	=	6
	BIT7	=	7

	; Internal Symbols

	IMM	=	0x0001
	ZP	=	0x0023
	ABS	=	0x4567
	SPECIAL	=	0x89AB
.endif
	
	; External Symbols

	imm	==	0
	zp	==	0
	abs	==	0
	special	==	0

	bit0	==	0
	bit1	==	0
	bit2	==	0
	bit3	==	0
	bit4	==	0
	bit5	==	0
	bit6	==	0
	bit7	==	0






