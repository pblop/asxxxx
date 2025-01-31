	.title	Intel 4040 Instruction Error Test

	.area	I4040	(ABS,OVR)

	sjmp = 0x78		; Short Jump Address
	ljmp = 0x0A98		; Long  Jump Address
	byt = 0x34		; Byte  Value
	nbl = 0x01		; Nible Value


	.sbttl	Condition Code Errors

	jcn	TZ	, sjmp	; 11 78
	jcn	CN	, sjmp	; 12 78
	jcn	AZ	, sjmp	; 14 78

	jcn	TZ|CZ	, sjmp	; 1B 78		;a
	jcn	TZ|AN	, sjmp	; 1D 78		;a
	jcn	CN|TN	, sjmp	; 1B 78		;a
	jcn	CN|AN	, sjmp	; 1E 78		;a
	jcn	AZ|TN	, sjmp	; 1D 78		;a
	jcn	AZ|CZ	, sjmp	; 1E 78		;a


	.sbttl	Condition Code Value Changes

	.byte	TZ		; 11
	.byte	CN		; 12
	.byte	AZ		; 14
	.byte	TN		; 29
	.byte	CZ		; 2A
	.byte	AN		; 2C

	TZ  = 1
	CN  = 2
	AZ  = 4

	TN = 9
	CZ = 10
	AN = 12


	.sbttl	Condition Code Link Time Errors

	.globl	xcc	;= 0x0E	; External Condition Code Value
	ccofst = 0x02		; Condition Code Offset Value

	jcn	ccofst + xcc,	sjmp	;u12 78	; 10 78   CC Overflow At Link Time


	.sbttl	Register Pair Link Time Errors

	.globl	xrp	;= 0x04	; External Register Pair Number
	rpofst = 0x04		; Register Pair Offset Value

	fim	rpofst + xrp,	#byt	;u28 34	; 20 34	  Register Pair Overflow At Link Time
	src	rpofst + xrp + 1	;u2B	; 23      Register Pair Overflow At Link Time
	fin	rpofst + xrp + 2	;u3C	; 34      Register Pair Overflow At Link Time
	jin	rpofst + xrp + 3	;u3F	; 37      Register Pair Overflow At Link Time


	.sbttl	Address Range Link Time Errors

	.globl	xljmp	;=0x800	; External ljmp Address
	nlofst = 0x800		; ljmp Offset Value

	jun	nlofst + xljmp		;v48u00	; 40 00	  Address Range Overflow At Link Time
	jms	nlofst + xljmp + 1	;v58u01	; 50 01	  Address Range Overflow At Link Time


	.sbttl	Register Link Time Errors

	.globl	xreg	;= 0x08	; External Register Number
	rofst = 0x08		; Register Offset Value

	inc	rofst + xreg		;u68	; 60      Register Overflow At Link Time
	isz	rofst + xreg + 1, ljmp	;u79 98	; 71 98   Register Overflow At Link Time
	add	rofst + xreg + 2	;u8A	; 82      Register Overflow At Link Time
	sub	rofst + xreg + 3	;u9B	; 93      Register Overflow At Link Time
	ld	rofst + xreg + 4	;uAC	; A4      Register Overflow At Link Time
	xch	rofst + xreg + 5	;uBD	; B5      Register Overflow At Link Time


	.sbttl	Page Address Tests

	.org	0

	xpg0 = 0x0000
	xpg1 = 0x0102
	xpg2 = 0x0204

	.globl	xpg	;= 0x00

pg0:	jcn	TZ, pg0			; 11*00
	jcn	TZ, pg1			; 11*02		; Paging Error At Link Time
	jcn	TZ, pg2			; 11*04		; Paging Error At Link Time
	jcn	TZ, xpg0 + xpg		; 11*00
	jcn	TZ, xpg1 + xpg		; 11*02		; Paging Error At Link Time
	jcn	TZ, xpg2 + xpg		; 11*04		; Paging Error At Link Time

	.org	0x0100

	jcn	TZ, pg0			; 11*00		; Paging Error At Link Time
pg1:	jcn	TZ, pg1			; 11*02
	jcn	TZ, pg2			; 11*04		; Paging Error At Link Time
	jcn	TZ, xpg0 + xpg		; 11*00		; Paging Error At Link Time
	jcn	TZ, xpg1 + xpg		; 11*02
	jcn	TZ, xpg2 + xpg		; 11*04		; Paging Error At Link Time

	.org	0x0200

	jcn	TZ, pg0			; 11*00		; Paging Error At Link Time
	jcn	TZ, pg1			; 11*02		; Paging Error At Link Time
pg2:	jcn	TZ, pg2			; 11*04
	jcn	TZ, xpg0 + xpg		; 11*00		; Paging Error At Link Time
	jcn	TZ, xpg1 + xpg		; 11*02		; Paging Error At Link Time
	jcn	TZ, xpg2 + xpg		; 11*04


	.sbttl	Page Address Tests With Relocation

	.area	PAG0	(REL,OVR)	;-b PAG0=0x0000

	jcn	TZ, pg0			; 11*00
	jcn	TZ, pg1			; 11*02		; Paging Error At Link Time
	jcn	TZ, pg2			; 11*04		; Paging Error At Link Time
	jcn	TZ, xpg0 + xpg		; 11*00
	jcn	TZ, xpg1 + xpg		; 11*02		; Paging Error At Link Time
	jcn	TZ, xpg2 + xpg		; 11*04		; Paging Error At Link Time


	.area	PAG1	(REL,OVR)	;-b PAG1=0x0100

	jcn	TZ, pg0			; 11*00		; Paging Error At Link Time
	jcn	TZ, pg1			; 11*02
	jcn	TZ, pg2			; 11*04		; Paging Error At Link Time
	jcn	TZ, xpg0 + xpg		; 11*00		; Paging Error At Link Time
	jcn	TZ, xpg1 + xpg		; 11*02
	jcn	TZ, xpg2 + xpg		; 11*04		; Paging Error At Link Time


	.area	PAG2	(REL,OVR)	;-b PAG2=0x0200

	jcn	TZ, pg0			; 11*00		; Paging Error At Link Time
	jcn	TZ, pg1			; 11*02		; Paging Error At Link Time
	jcn	TZ, pg2			; 11*04
	jcn	TZ, xpg0 + xpg		; 11*00		; Paging Error At Link Time
	jcn	TZ, xpg1 + xpg		; 11*02		; Paging Error At Link Time
	jcn	TZ, xpg2 + xpg		; 11*04


	.sbttl	Page Boundary Tests (Local Addresses)

	.area	I4040

	.org	0x000
	pgb0 = .
	pgb1 = . + 0x100

	.org	0x000
	jtz	pgb0 + 0xFF		; 11*FF		; No Paging Error - 2nd Byte Of Code In Page 0.

	.org	0x000
	jtz	pgb1			; 11*00		; Paging Error - Address Not In Page 0

	.org	0x0FF
	jtz	pgb1			; 11*00		; No Paging Error - 2nd Byte Of Code In Page 1.

	.org	0x0FE
	jtz	pgb1 + 0x0FF		; 11*FF		; Paging Error - 2nd Byte Of Code In Page 0

	.org	0x1FF
	jtz	pgb1			; 11*00		; Paging Error - 2nd Byte Of Code In Page 2

	.org	0x1FE
 	jtz	pgb1			; 11*00		; No Paging Error - 2nd Byte Of Code In Page 1.

	.org	0x200
	jtz	pgb1			; 11*00		; Paging Error - Address Not In Page 2


	.sbttl	Page Boundary Tests (Global Addresses)

	.area	I4040

	.org	0x000
	.globl	xpgb0
	.globl	xpgb1

	.org	0x000
	jtz	xpgb0 + 0xFF		; 11*FF		; No Paging Error - 2nd Byte Of Code In Page 0.

	.org	0x000
	jtz	xpgb1			; 11*00		; Paging Error - Address Not In Page 0

	.org	0x0FF
	jtz	xpgb1			; 11*00		; No Paging Error - 2nd Byte Of Code In Page 1.

	.org	0x0FE
	jtz	xpgb1 + 0x0FF		; 11*FF		; Paging Error - 2nd Byte Of Code In Page 0

	.org	0x1FF
	jtz	xpgb1			; 11*00		; Paging Error - 2nd Byte Of Code In Page 2

	.org	0x1FE
 	jtz	xpgb1			; 11*00		; No Paging Error - 2nd Byte Of Code In Page 1.

	.org	0x200
	jtz	xpgb1			; 11*00		; Paging Error - Address Not In Page 2


	.end
