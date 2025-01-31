	.title	Intel 4040 Instruction Test

	.area	I4040	(ABS,OVR)

	sjmp = 0x78		; Short Jump Address
	ljmp = 0x0A98		; Long  Jump Address
	byt = 0x34		; Byte  Value
	nbl = 0x01		; Nible Value


	.sbttl	Local Data and Addressing

	nop			; 00
	hlt			; 01
	bbs			; 02
	lcr			; 03
	or4			; 04
	or5			; 05
	an6			; 06
	an7			; 07
	db0			; 08
	db1			; 09
	sb0			; 0A
	sb1			; 0B
	ein			; 0C
	din			; 0D
	rpm			; 0E
				; 0F

	jcn	0	, sjmp	; 10 78
	jcn	TZ	, sjmp	; 11 78
	jcn	CN	, sjmp	; 12 78
	jcn	TZ|CN	, sjmp	; 13 78
	jcn	AZ	, sjmp	; 14 78
	jcn	TZ|AZ	, sjmp	; 15 78
	jcn	CN|AZ	, sjmp	; 16 78
	jcn	TZ|CN|AZ, sjmp	; 17 78
	jcn	8	, sjmp	; 18 78
	jcn	TN	, sjmp	; 19 78
	jcn	CZ	, sjmp	; 1A 78
	jcn	TN|CZ	, sjmp	; 1B 78
	jcn	AN	, sjmp	; 1C 78
	jcn	TN|AN	, sjmp	; 1D 78
	jcn	CZ|AN	, sjmp	; 1E 78
	jcn	TN|CZ|AN, sjmp	; 1F 78

	jcn	0	, sjmp	; 10 78
	jcn	1	, sjmp	; 11 78
	jcn	2	, sjmp	; 12 78
	jcn	3	, sjmp	; 13 78
	jcn	4	, sjmp	; 14 78
	jcn	5	, sjmp	; 15 78
	jcn	6	, sjmp	; 16 78
	jcn	7	, sjmp	; 17 78
	jcn	8	, sjmp	; 18 78
	jcn	9	, sjmp	; 19 78
	jcn	10	, sjmp	; 1A 78
	jcn	11	, sjmp	; 1B 78
	jcn	12	, sjmp	; 1C 78
	jcn	13	, sjmp	; 1D 78
	jcn	14	, sjmp	; 1E 78
	jcn	15	, sjmp	; 1F 78

	jtz	sjmp		; 11 78
	jcz	sjmp		; 12 78
	jaz	sjmp		; 14 78
	jtn	sjmp		; 19 78
	jnc	sjmp		; 1A 78
	jnz	sjmp		; 1C 78

	jto	sjmp		; 11 78
	joc	sjmp		; 12 78
	jco	sjmp		; 12 78
	jan	sjmp		; 1C 78

	fim	rp0, byt	; 20 34
	fim	rp1, byt	; 22 34
	fim	rp2, byt	; 24 34
	fim	rp3, byt	; 26 34
	fim	rp4, byt	; 28 34
	fim	rp5, byt	; 2A 34
	fim	rp6, byt	; 2C 34
	fim	rp7, byt	; 2E 34

	fim	r0, byt		; 20 34
	fim	r2, byt		; 22 34
	fim	r4, byt		; 24 34
	fim	r6, byt		; 26 34
	fim	r8, byt		; 28 34
	fim	r10, byt	; 2A 34
	fim	r12, byt	; 2C 34
	fim	r14, byt	; 2E 34

	fim	0, byt		; 20 34
	fim	1, byt		; 22 34
	fim	2, byt		; 24 34
	fim	3, byt		; 26 34
	fim	4, byt		; 28 34
	fim	5, byt		; 2A 34
	fim	6, byt		; 2C 34
	fim	7, byt		; 2E 34

	src	rp0		; 21
	src	rp1		; 23
	src	rp2		; 25
	src	rp3		; 27
	src	rp4		; 29
	src	rp5		; 2B
	src	rp6		; 2D
	src	rp7		; 2F

	src	r0		; 21
	src	r2		; 23
	src	r4		; 25
	src	r6		; 27
	src	r8		; 29
	src	r10		; 2B
	src	r12		; 2D
	src	r14		; 2F

	src	0		; 21
	src	1		; 23
	src	2		; 25
	src	3		; 27
	src	4		; 29
	src	5		; 2B
	src	6		; 2D
	src	7		; 2F

	fin	rp0		; 30
	fin	rp1		; 32
	fin	rp2		; 34
	fin	rp3		; 36
	fin	rp4		; 38
	fin	rp5		; 3A
	fin	rp6		; 3C
	fin	rp7		; 3E

	fin	r0		; 30
	fin	r2		; 32
	fin	r4		; 34
	fin	r6		; 36
	fin	r8		; 38
	fin	r10		; 3A
	fin	r12		; 3C
	fin	r14		; 3E

	fin	0		; 30
	fin	1		; 32
	fin	2		; 34
	fin	3		; 36
	fin	4		; 38
	fin	5		; 3A
	fin	6		; 3C
	fin	7		; 3E

	jin	rp0		; 31
	jin	rp1		; 33
	jin	rp2		; 35
	jin	rp3		; 37
	jin	rp4		; 39
	jin	rp5		; 3B
	jin	rp6		; 3D
	jin	rp7		; 3F

	jin	r0		; 31
	jin	r2		; 33
	jin	r4		; 35
	jin	r6		; 37
	jin	r8		; 39
	jin	r10		; 3B
	jin	r12		; 3D
	jin	r14		; 3F

	jin	0		; 31
	jin	1		; 33
	jin	2		; 35
	jin	3		; 37
	jin	4		; 39
	jin	5		; 3B
	jin	6		; 3D
	jin	7		; 3F

	jun	ljmp		; 4A 98
	jms	ljmp		; 5A 98

	jun	0x0A98		; 4A 98
	jms	0x0A98		; 5A 98

	inc	r0		; 60
	inc	r1		; 61
	inc	r2		; 62
	inc	r3		; 63
	inc	r4		; 64
	inc	r5		; 65
	inc	r6		; 66
	inc	r7		; 67
	inc	r8		; 68
	inc	r9		; 69
	inc	r10		; 6A
	inc	r11		; 6B
	inc	r12		; 6C
	inc	r13		; 6D
	inc	r14		; 6E
	inc	r15		; 6F

	inc	0		; 60
	inc	1		; 61
	inc	2		; 62
	inc	3		; 63
	inc	4		; 64
	inc	5		; 65
	inc	6		; 66
	inc	7		; 67
	inc	8		; 68
	inc	9		; 69
	inc	10		; 6A
	inc	11		; 6B
	inc	12		; 6C
	inc	13		; 6D
	inc	14		; 6E
	inc	15		; 6F

	isz	r0,sjmp+0x0100	; 70 78
	isz	r1,sjmp+0x0100	; 71 78
	isz	r2,sjmp+0x0100	; 72 78
	isz	r3,sjmp+0x0100	; 73 78
	isz	r4,sjmp+0x0100	; 74 78
	isz	r5,sjmp+0x0100	; 75 78
	isz	r6,sjmp+0x0100	; 76 78
	isz	r7,sjmp+0x0100	; 77 78
	isz	r8,sjmp+0x0100	; 78 78
	isz	r9,sjmp+0x0100	; 79 78
	isz	r10,sjmp+0x0100	; 7A 78
	isz	r11,sjmp+0x0100	; 7B 78
	isz	r12,sjmp+0x0100	; 7C 78
	isz	r13,sjmp+0x0100	; 7D 78
	isz	r14,sjmp+0x0100	; 7E 78
	isz	r15,sjmp+0x0100	; 7F 78

	isz	0,sjmp+0x0100	; 70 78
	isz	1,sjmp+0x0100	; 71 78
	isz	2,sjmp+0x0100	; 72 78
	isz	3,sjmp+0x0100	; 73 78
	isz	4,sjmp+0x0100	; 74 78
	isz	5,sjmp+0x0100	; 75 78
	isz	6,sjmp+0x0100	; 76 78
	isz	7,sjmp+0x0100	; 77 78
	isz	8,sjmp+0x0100	; 78 78
	isz	9,sjmp+0x0100	; 79 78
	isz	10,sjmp+0x0100	; 7A 78
	isz	11,sjmp+0x0100	; 7B 78
	isz	12,sjmp+0x0100	; 7C 78
	isz	13,sjmp+0x0100	; 7D 78
	isz	14,sjmp+0x0100	; 7E 78
	isz	15,sjmp+0x0100	; 7F 78

	add	r0		; 80
	add	r1		; 81
	add	r2		; 82
	add	r3		; 83
	add	r4		; 84
	add	r5		; 85
	add	r6		; 86
	add	r7		; 87
	add	r8		; 88
	add	r9		; 89
	add	r10		; 8A
	add	r11		; 8B
	add	r12		; 8C
	add	r13		; 8D
	add	r14		; 8E
	add	r15		; 8F

	add	0		; 80
	add	1		; 81
	add	2		; 82
	add	3		; 83
	add	4		; 84
	add	5		; 85
	add	6		; 86
	add	7		; 87
	add	8		; 88
	add	9		; 89
	add	10		; 8A
	add	11		; 8B
	add	12		; 8C
	add	13		; 8D
	add	14		; 8E
	add	15		; 8F

	sub	r0		; 90
	sub	r1		; 91
	sub	r2		; 92
	sub	r3		; 93
	sub	r4		; 94
	sub	r5		; 95
	sub	r6		; 96
	sub	r7		; 97
	sub	r8		; 98
	sub	r9		; 99
	sub	r10		; 9A
	sub	r11		; 9B
	sub	r12		; 9C
	sub	r13		; 9D
	sub	r14		; 9E
	sub	r15		; 9F

	sub	0		; 90
	sub	1		; 91
	sub	2		; 92
	sub	3		; 93
	sub	4		; 94
	sub	5		; 95
	sub	6		; 96
	sub	7		; 97
	sub	8		; 98
	sub	9		; 99
	sub	10		; 9A
	sub	11		; 9B
	sub	12		; 9C
	sub	13		; 9D
	sub	14		; 9E
	sub	15		; 9F

	ld	r0		; A0
	ld	r1		; A1
	ld	r2		; A2
	ld	r3		; A3
	ld	r4		; A4
	ld	r5		; A5
	ld	r6		; A6
	ld	r7		; A7
	ld	r8		; A8
	ld	r9		; A9
	ld	r10		; AA
	ld	r11		; AB
	ld	r12		; AC
	ld	r13		; AD
	ld	r14		; AE
	ld	r15		; AF

	ld	0		; A0
	ld	1		; A1
	ld	2		; A2
	ld	3		; A3
	ld	4		; A4
	ld	5		; A5
	ld	6		; A6
	ld	7		; A7
	ld	8		; A8
	ld	9		; A9
	ld	10		; AA
	ld	11		; AB
	ld	12		; AC
	ld	13		; AD
	ld	14		; AE
	ld	15		; AF

	xch	r0		; B0
	xch	r1		; B1
	xch	r2		; B2
	xch	r3		; B3
	xch	r4		; B4
	xch	r5		; B5
	xch	r6		; B6
	xch	r7		; B7
	xch	r8		; B8
	xch	r9		; B9
	xch	r10		; BA
	xch	r11		; BB
	xch	r12		; BC
	xch	r13		; BD
	xch	r14		; BE
	xch	r15		; BF

	xch	0		; B0
	xch	1		; B1
	xch	2		; B2
	xch	3		; B3
	xch	4		; B4
	xch	5		; B5
	xch	6		; B6
	xch	7		; B7
	xch	8		; B8
	xch	9		; B9
	xch	10		; BA
	xch	11		; BB
	xch	12		; BC
	xch	13		; BD
	xch	14		; BE
	xch	15		; BF

	bbl	#0		; C0
	bbl	#1		; C1
	bbl	#2		; C2
	bbl	#3		; C3
	bbl	#4		; C4
	bbl	#5		; C5
	bbl	#6		; C6
	bbl	#7		; C7
	bbl	#8		; C8
	bbl	#9		; C9
	bbl	#10		; CA
	bbl	#11		; CB
	bbl	#12		; CC
	bbl	#13		; CD
	bbl	#14		; CE
	bbl	#15		; CF

	bbl	0		; C0
	bbl	1		; C1
	bbl	2		; C2
	bbl	3		; C3
	bbl	4		; C4
	bbl	5		; C5
	bbl	6		; C6
	bbl	7		; C7
	bbl	8		; C8
	bbl	9		; C9
	bbl	10		; CA
	bbl	11		; CB
	bbl	12		; CC
	bbl	13		; CD
	bbl	14		; CE
	bbl	15		; CF

	ldm	#0		; D0
	ldm	#1		; D1
	ldm	#2		; D2
	ldm	#3		; D3
	ldm	#4		; D4
	ldm	#5		; D5
	ldm	#6		; D6
	ldm	#7		; D7
	ldm	#8		; D8
	ldm	#9		; D9
	ldm	#10		; DA
	ldm	#11		; DB
	ldm	#12		; DC
	ldm	#13		; DD
	ldm	#14		; DE
	ldm	#15		; DF

	ldm	0		; D0
	ldm	1		; D1
	ldm	2		; D2
	ldm	3		; D3
	ldm	4		; D4
	ldm	5		; D5
	ldm	6		; D6
	ldm	7		; D7
	ldm	8		; D8
	ldm	9		; D9
	ldm	10		; DA
	ldm	11		; DB
	ldm	12		; DC
	ldm	13		; DD
	ldm	14		; DE
	ldm	15		; DF

	wrm			; E0
	wmp			; E1
	wrr			; E2
	wpm			; E3
	wr0			; E4
	wr1			; E5
	wr2			; E6
	wr3			; E7
	sbm			; E8
	rdm			; E9
	rdr			; EA
	adm			; EB
	rd0			; EC
	rd1			; ED
	rd2			; EE
	rd3			; EF

	clb			; F0
	clc			; F1
	iac			; F2
	cmc			; F3
	cma			; F4
	ral			; F5
	rar			; F6
	tcc			; F7
	dac			; F8
	tcs			; F9
	stc			; FA
	daa			; FB
	kbp			; FC
	dcl			; FD
				; FE
				; FF


	.sbttl	External Data and Addresing

	sofst = 0x29A		; Short Jump Address Offset (Same Page)
	lofst = 0x0BA9		; Long  Jump Address Offset
	bofst = 0x56		; Byte  Offset Value
	nofst = 0x02		; Nible Offset Value

	.globl	xsjmp	; = 0	; External Short Jump Address
	.globl	xljmp	; = 0	; External Long  Jump Address
	.globl	xbyt	; = 0	; External Byte  Value
	.globl	xnbl	; = 0	; External Nible Value

	jcn	nofst + xnbl, 0x200 + sjmp	;u12 78
	jcn	nbl, sofst + xsjmp		; 11*9A
	jcn	nofst + xnbl, sofst + xsjmp	;u12*9A

	fim	nofst + xnbl, byt		;u24 34
	fim	nbl, bofst + xbyt		; 22r56
	fim	nofst + xnbl, bofst + xbyt	;u24r56

	src	nofst + xnbl			;u25

	fin	nofst + xnbl			;u34

	jin	nofst + xnbl			;u35

	jun	lofst + xljmp			;v4BuA9
	jms	lofst + xljmp			;v5BuA9

	inc	nofst + xnbl			;u62

	isz	nofst + xnbl, 0x200 + sjmp	;u72 78
	isz	nbl, 0x200 + bofst + xbyt	; 71*56
	isz	nofst + xnbl, 0x200+bofst+xbyt	;u72*56

	add	nofst + xnbl			;u82

	sub	nofst + xnbl			;u92

	ld	nofst + xnbl			;uA2

	xch	nofst + xnbl			;uB2

	bbl	nofst + xnbl			;rC2

	ldm	nofst + xnbl			;rD2


	.sbttl	Addressing Relative To The Program Counter

	.org	0x00

jcn:	.byte	2$		;r03
1$:	jcn	8, .+2		; 18*03
2$:	jcn	0, .-2		; 10*01
	.byte	1$		;r01

	.byte	4$		;r09
3$:	jcn	8, 4$		; 18*09
4$:	jcn	0, 3$		; 10*07
	.byte	3$		;r07

	.org	0x80

isz:	.byte	2$		;r83
1$:	isz	r0, .+2		; 70*83
2$:	isz	r1, .-2		; 71*81
	.byte	1$		;r81

	.byte	4$		;r89
3$:	isz	r2, 4$		; 72*89
4$:	isz	r3, 3$		; 73*87
	.byte	3$		;r87

	.org	0x940

jun:	.word	2$		;s09r44
1$:	jun	.+2		;v49u44
2$:	jun	.-2		;v49u42
	.word	1$		;s09r42

	.word	4$		;s09r4C
3$:	jms	4$		;v59u4C
4$:	jms	3$		;v59u4A
	.word	3$		;s09r4A

	.end
