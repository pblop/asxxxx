	.title	National Semiconductor COP4 Instruction Test

	.sbttl	Paging Errors

	.area	Page0	(ABS,OVR)
	.org	0x00		; Page 0

	.area	Page1	(ABS,OVR)
	.org	0x40		; Page 1

	.area	Page2	(ABS,OVR)
	.org	0x80		; Page 2

	.area	Page0

	jsrp	0x040		;*80	Paging Error
	jsrp	0x080		;*80
	jsrp	0x0BE		;*BE
	jsrp	0x0BF		;*BF	Address Error
	jsrp	0x0C0		;*80	Paging Error

	.area	Page2

	jp23	0x040		;*C0	Paging Error
	jp23	0x080		;*80
	jp23	0x0BE		;*BE
	jp23	0x0BF		;*BF	Address Error
	jp23	0x0C0		;*C0
	jp23	0x0FE		;*FE
	jp23	0x0FF		;*FF	Address Error
	jp23	0x100		;*80	Paging Error

 	.sbttl	Linking With Alternate Area

	.area	Page0

	jsrp	pg4A_1		;*80	Linking Paging Error
	jsrp	pg4A_2		;*80
	jsrp	pg4A_2+0x03E	;*BE
	jsrp	pg4A_2+0x03F	;*BF	Link Cannot Detect Address Error
	jsrp	pg4A_3		;*80	Linking Paging Error

	.area	Page2

	jp23	pg4A_1		;*C0	Linking Paging Error
	jp23	pg4A_2		;*80
	jp23	pg4A_2+0x03E	;*BE
	jp23	pg4A_2+0x03F	;*BF	Link Cannot Detect Address Error
	jp23	pg4A_3		;*C0
	jp23	pg4A_3+0x03E	;*FE
	jp23	pg4A_3+0x03F	;*FF	Link Cannot Detect Address Error
	jp23	pg4A_4		;*80	Linking Paging Error

	.area	Page1

	jsrp	pg4A_1		;*80	Linking Paging Error
	jsrp	pg4A_2		;*80
	jsrp	pg4A_2+0x03E	;*BE
	jsrp	pg4A_2+0x03F	;*BF	Link Cannot Detect Address Error
	jsrp	pg4A_3		;*80	Linking Paging Error

 	.sbttl	Linking With Relocated Alternate Area

	.area	Page0

	jsrp	pg4B_1		;*80	Linking Paging Error
	jsrp	pg4B_2		;*80
	jsrp	pg4B_2+0x03E	;*BE
	jsrp	pg4B_2+0x03F	;*BF	Link Cannot Detect Address Error
	jsrp	pg4B_3		;*80	Linking Paging Error

	.area	Page2

	jp23	pg4B_1		;*80	[C0] Linking Paging Error
	jp23	pg4B_2		;*C0	[80]
	jp23	pg4B_2+0x03E 	;*FE	[BE]
	jp23	pg4B_2+0x03F	;*FF	[BF] Link Cannot Detect Address Error
	jp23	pg4B_3		;*80	[C0]
	jp23	pg4B_3+0x03E	;*BE	[FE]
	jp23	pg4B_3+0x03F	;*BF	[FF] Link Cannot Detect Address Error
	jp23	pg4B_4		;*C0	[80] Linking Paging Error

	.area	Page1

	jsrp	pg4B_1		;*80	Linking Paging Error
	jsrp	pg4B_2		;*80
	jsrp	pg4B_2+0x03E	;*BE
	jsrp	pg4B_2+0x03F	;*BF	Link Cannot Detect Address Error
	jsrp	pg4B_3		;*80	Linking Paging Error


	.sbttl	Pages

	.area	COP4A	(ABS,OVR)

	.org	0x0000
pg4A_0:
	.org	0x0040
pg4A_1:
	.org	0x0080
pg4A_2:
	.org	0x00C0
pg4A_3:
	.org	0x0100
pg4A_4:


	.area	COP4B	(ABS,OVR)

	.org	0x0000
pg4B_1:
	.org	0x0040
pg4B_2:
	.org	0x0080
pg4B_3:
	.org	0x00C0
pg4B_4:
	.org	0x0100
pg4B_5:


	.end

