	.title	Assembly and Object Code Examples

	.sbttl	Constant (Not Relocatable) Arguments

Part1:
	ADC	r5, r7			; 12 57
	ADC	r6, @r8			; 13 68
	ADC	0x34, 0x55		; 14 55 34
	ADC	0x35, @0xAA		; 15 AA 35
	ADC	0x36, #0x31		; 16 36 31
	ADC	@0x37, #0x32		; 17 37 32
	ADCX	0x351, 0x456		; 18 45 63 51
	ADCX	0x364, #0x35		; 19 35 03 64

	ADD	r5, r7			; 02 57
	ADD	r6, @r8			; 03 68
	ADD	0x34, 0x55		; 04 55 34
	ADD	0x35, @0xAA		; 05 AA 35
	ADD	0x36, #0x31		; 06 36 31
	ADD	@0x37, #0x32		; 07 37 32
	ADDX	0x351, 0x456		; 08 45 63 51
	ADDX	0x364, #0x35		; 09 35 03 64

	AND	r5, r7			; 52 57
	AND	r6, @r8			; 53 68
	AND	0x34, 0x55		; 54 55 34
	AND	0x35, @0xAA		; 55 AA 35
	AND	0x36, #0x31		; 56 36 31
	AND	@0x37, #0x32		; 57 37 32
	ANDX	0x351, 0x456		; 58 45 63 51
	ANDX	0x364, #0x35		; 59 35 03 64

	BCLR	3, r5			; E2 35

	BIT	0, 3, r5		; E2 35

	BIT	1, 3, r5		; E2 B5

	BRK				; 00

	BSET	3, r5			; E2 B5

	BSWAP	0x54			; D5 54

1$:
	BTJ	0, 2, r7, 1$		; F6 27 FD
	BTJ	1, 3, r6, 1$		; F6 B6 FA
	BTJ	0, 2, @r7, 1$		; F7 27 F7
	BTJ	1, 3, @r6, 1$		; F7 B6 F4

	BTJNZ	3, @r6, 1$		; F7 B6 F1
	BTJNZ	3, r6, 1$		; F6 B6 EE

	BTJZ	2, r7, 1$		; F6 27 EB
	BTJZ	2, @r7, 1$		; F7 27 E8

	CALL	@0x34			; D4 34
	CALL	0x3456			; D6 34 56

	CCF				; EF

	CLR	0x98			; B0 98
	CLR	@0x35			; B1 35

	COM	0x78			; 60 78
	COM	@0x54			; 61 54

	CP	r5, r7			; A2 57
	CP	r6, @r8			; A3 68
	CP	0x34, 0x55		; A4 55 34
	CP	0x35, @0xAA		; A5 AA 35
	CP	0x36, #0x31		; A6 36 31
	CP	@0x37, #0x32		; A7 37 32

	CPC	r5, r7			; 1F A2 57
	CPC	r6, @r8			; 1F A3 68
	CPC	0x34, 0x55		; 1F A4 55 34
	CPC	0x35, @0xAA		; 1F A5 AA 35
	CPC	0x36, #0x31		; 1F A6 36 31
	CPC	@0x37, #0x32		; 1F A7 37 32
	CPCX	0x351, 0x456		; 1F A8 45 63 51
	CPCX	0x364, #0x35		; 1F A9 35 03 64

	CPX	0x351, 0x456		; A8 45 63 51
	CPX	0x364, #0x35		; A9 35 03 64

	DA	0x34			; 40 34
	DA	@0x43			; 41 43

	DEC	0x56			; 30 56
	DEC	@0x41			; 31 41

	DECW	0x34			; 80 34
	DECW	@0x44			; 81 44

	DI				; 8F

2$:
	DJNZ	r0, 2$			; 0A FE
	DJNZ	r1, 2$			; 1A FC
	DJNZ	r2, 2$			; 2A FA
	DJNZ	r3, 2$			; 3A F8
	DJNZ	r4, 2$			; 4A F6
	DJNZ	r5, 2$			; 5A F4
	DJNZ	r6, 2$			; 6A F2
	DJNZ	r7, 2$			; 7A F0
	DJNZ	r8, 2$			; 8A EE
	DJNZ	r9, 2$			; 9A EC
	DJNZ	r10, 2$			; AA EA
	DJNZ	r11, 2$			; BA E8
	DJNZ	r12, 2$			; CA E6
	DJNZ	r13, 2$			; DA E4
	DJNZ	r14, 2$			; EA E2
	DJNZ	r15, 2$			; FA E0

	EI				; 9F

	HALT				; 7F

	INC	0x46			; 20 46
	INC	@0x34			; 21 34
	INC	r0			; 0E
	INC	r1			; 1E
	INC	r2			; 2E
	INC	r3			; 3E
	INC	r4			; 4E
	INC	r5			; 5E
	INC	r6			; 6E
	INC	r7			; 7E
	INC	r8			; 8E
	INC	r9			; 9E
	INC	r10			; AE
	INC	r11			; BE
	INC	r12			; CE
	INC	r13			; DE
	INC	r14			; EE
	INC	r15			; FE

	INCW	0x34			; A0 34
	INCW	@0x48			; A1 48

	IRET				; BF

	JP	@rr4			; C4 E4
	JP	0xF818			; 8D F8 18
	JP	F, 0xF010		; 0D F0 10
	JP	LT, 0xF111		; 1D F1 11
	JP	LE, 0xF212		; 2D F2 12
	JP	ULE, 0xF313		; 3D F3 13
	JP	OV, 0xF414		; 4D F4 14
	JP	MI, 0xF515		; 5D F5 15
	JP	Z, 0xF616		; 6D F6 16
	JP	C, 0xF717		; 7D F7 17
	JP	T, 0xF818		; 8D F8 18
	JP	GE, 0xF919		; 9D F9 19
	JP	GT, 0xFA1A		; AD FA 1A
	JP	UGT, 0xFB1B		; BD FB 1B
	JP	NOV, 0xFC1C		; CD FC 1C
	JP	PL, 0xFD1D		; DD FD 1D
	JP	NZ, 0xFE1E		; ED FE 1E
	JP	NC, 0xFF1F		; FD FF 1F

	JR	3$			; 8B 20
	JR	F, 3$			; 0B 1E
	JR	LT, 3$			; 1B 1C
	JR	LE, 3$			; 2B 1A
	JR	ULE, 3$			; 3B 18
	JR	OV, 3$			; 4B 16
	JR	MI, 3$			; 5B 14
	JR	Z, 3$			; 6B 12
	JR	C, 3$			; 7B 10
	JR	T, 3$			; 8B 0E
	JR	GE, 3$			; 9B 0C
	JR	GT, 3$			; AB 0A
	JR	UGT, 3$			; BB 08
	JR	NOV, 3$			; CB 06
	JR	PL, 3$			; DB 04
	JR	NZ, 3$			; EB 02
	JR	NC, 3$			; FB 00
3$:

	LD	r0, #0x30		; 0C 30
	LD	r1, #0x31		; 1C 31
	LD	r2, #0x32		; 2C 32
	LD	r3, #0x33		; 3C 33
	LD	r4, #0x34		; 4C 34
	LD	r5, #0x35		; 5C 35
	LD	r6, #0x36		; 6C 36
	LD	r7, #0x37		; 7C 37
	LD	r8, #0x38		; 8C 38
	LD	r9, #0x39		; 9C 39
	LD	r10, #0x3A		; AC 3A
	LD	r11, #0x3B		; BC 3B
	LD	r12, #0x3C		; CC 3C
	LD	r13, #0x3D		; DC 3D
	LD	r14, #0x3E		; EC 3E
	LD	r15, #0x3F		; FC 3F
	LD	r3, 0x3(r6)		; C7 36 03
	LD	0x5(r4), r7		; D7 74 05
	LD	r5, @r7			; E3 57
	LD	0x34, 0x55		; E4 55 34
	LD	0x35, @0xAA		; E5 AA 35
	LD	0x36, #0x31		; E6 36 31
	LD	@0x37, #0x32		; E7 37 32
	LD	@r7, r0			; F3 70
	LD	@0x25, 0x71		; F5 71 25

	LDC	r4, @rr6		; C2 46
	LDC	@r5, @rr6		; C5 56
	LDC	@rr6, r4		; D2 46

	LDCI	@r7, @rr8		; C3 78
	LDCI	@rr6, @r8		; D3 86

	LDE	r5, @rr8		; 82 58
	LDE	@rr2, r5		; 92 52

	LDEI	@r6, @rr10		; 83 6A
	LDEI	@rr14, @r3		; 93 3E

	LD	r1, 0xE3(r6)		; C7 16 E3
	LD	0x10(r8), r6		; D7 68 10

	LDWX	0x456,0x123		; 1F E8 12 34 56

	LDX	r3, 0x876		; 84 38 76
	LDX	@r4, 0x564		; 85 45 64
	LDX	0x34, @0x56		; 86 56 34
	LDX	@0x12, @.RR(0x09)	; 87 E8 12
	LDX	r4, 0x21(rr2)		; 88 42 21
	LDX	0x92(rr14), r0		; 89 E0 92
	LDX	0x345, r6		; 94 63 45
	LDX	0x347, @r6		; 95 63 47
	LDX	@rr10, r1		; 96 E1 EA
	LDX	@.RR(0x13), @0xB4	; 97 B4 E2
	LDX	0x351, 0x456		; E8 45 63 51
	LDX	0x364, #0x35		; E9 35 03 64

	LEA	r3, 0xF4(r4)		; 98 34 F4
	LEA	rr2, 0x10(rr4)		; 99 24 10

	MULT	0xCC			; F4 CC

	NOP				; 0F

	OR	r5, r7			; 42 57
	OR	r6, @r8			; 43 68
	OR	0x34, 0x55		; 44 55 34
	OR	0x35, @0xAA		; 45 AA 35
	OR	0x36, #0x31		; 46 36 31
	OR	@0x37, #0x32		; 47 37 32
	ORX	0x351, 0x456		; 48 45 63 51
	ORX	0x364, #0x35		; 49 35 03 64

	POP	0x46			; 50 46
	POP	@0x35			; 51 35
	POPX	0x543			; D8 54 30

	PUSH	0x54			; 70 54
	PUSH	@0x34			; 71 34
	PUSH	#0x14			; 1F 70 14
	PUSHX	0x345			; C8 34 50

	RCF				; CF

	RET				; AF

	RL	0x35			; 90 35
	RL	@0x44			; 91 44

	RLC	0x35			; 10 35
	RLC	@0x44			; 11 44

	RR	0x20			; E0 20
	RR	@0x46			; E1 46

	RRC	0x20			; C0 20
	RRC	@0x46			; C1 46

	SBC	r5, r7			; 32 57
	SBC	r6, @r8			; 33 68
	SBC	0x34, 0x55		; 34 55 34
	SBC	0x35, @0xAA		; 35 AA 35
	SBC	0x36, #0x31		; 36 36 31
	SBC	@0x37, #0x32		; 37 37 32
	SBCX	0x351, 0x456		; 38 45 63 51
	SBCX	0x364, #0x35		; 39 35 03 64

	SCF				; DF

	SRA	0x43			; D0 43
	SRA	@0x67			; D1 67

	SRL	0x41			; 1F C0 41
	SRL	@0x67			; 1F C1 67

	SRP	#0x35			; 01 35

	STOP				; 6F

	SUB	r5, r7			; 22 57
	SUB	r6, @r8			; 23 68
	SUB	0x34, 0x55		; 24 55 34
	SUB	0x35, @0xAA		; 25 AA 35
	SUB	0x36, #0x31		; 26 36 31
	SUB	@0x37, #0x32		; 27 37 32
	SUBX	0x351, 0x456		; 28 45 63 51
	SUBX	0x364, #0x35		; 29 35 03 64

	SWAP	0x56			; F0 56
	SWAP	@0x89			; F1 89

	TCM	r5, r7			; 62 57
	TCM	r6, @r8			; 63 68
	TCM	0x34, 0x55		; 64 55 34
	TCM	0x35, @0xAA		; 65 AA 35
	TCM	0x36, #0x31		; 66 36 31
	TCM	@0x37, #0x32		; 67 37 32
	TCMX	0x351, 0x456		; 68 45 63 51
	TCMX	0x364, #0x35		; 69 35 03 64

	TM	r5, r7			; 72 57
	TM	r6, @r8			; 73 68
	TM	0x34, 0x55		; 74 55 34
	TM	0x35, @0xAA		; 75 AA 35
	TM	0x36, #0x31		; 76 36 31
	TM	@0x37, #0x32		; 77 37 32
	TMX	0x351, 0x456		; 78 45 63 51
	TMX	0x364, #0x35		; 79 35 03 64

	TRAP	#0x35			; F2 35

	WDT				; 5F

	XOR	r5, r7			; B2 57
	XOR	r6, @r8			; B3 68
	XOR	0x34, 0x55		; B4 55 34
	XOR	0x35, @0xAA		; B5 AA 35
	XOR	0x36, #0x31		; B6 36 31
	XOR	@0x37, #0x32		; B7 37 32
	XORX	0x351, 0x456		; B8 45 63 51
	XORX	0x364, #0x35		; B9 35 03 64

	.page
	.sbttl	Relocatable Arguments

	.globl	X

Part2:
	ADC	r5, r7			; 12 57
	ADC	r6, @r8			; 13 68
	ADC	X+0x34, X+0x55		; 14 55 34
	ADC	X+0x35, @X+0xAA		; 15 AA 35
	ADC	X+0x36, #X+0x31		; 16 36 31
	ADC	@X+0x37, #X+0x32	; 17 37 32
	; **>**
;r	ADCX	X+0x351, X+0x456	; 18 45 63 51
	ADCX	X+0x351, 0x456		; 18 45 63 51
	ADCX	0x351, X+0x456		; 18 45 63 51
	; **<**
	ADCX	X+0x364, #X+0x35	; 19 35 03 64

	ADD	r5, r7			; 02 57
	ADD	r6, @r8			; 03 68
	ADD	X+0x34, X+0x55		; 04 55 34
	ADD	X+0x35, @X+0xAA		; 05 AA 35
	ADD	X+0x36, #X+0x31		; 06 36 31
	ADD	@X+0x37, #X+0x32	; 07 37 32
	;**>**
;r	ADDX	X+0x351, X+0x456	; 08 45 63 51
	ADDX	X+0x351, 0x456		; 08 45 63 51
	ADDX	0x351, X+0x456		; 08 45 63 51
	; **<**
	ADDX	X+0x364, #X+0x35	; 09 35 03 64

	AND	r5, r7			; 52 57
	AND	r6, @r8			; 53 68
	AND	X+0x34, X+0x55		; 54 55 34
	AND	X+0x35, @X+0xAA		; 55 AA 35
	AND	X+0x36, #X+0x31		; 56 36 31
	AND	@X+0x37, #X+0x32	; 57 37 32
	;**>**
;r	ANDX	X+0x351, X+0x456	; 58 45 63 51
	ANDX	X+0x351, 0x456		; 58 45 63 51
	ANDX	0x351, X+0x456		; 58 45 63 51
	; **<**
	ANDX	X+0x364, #X+0x35	; 59 35 03 64

	BCLR	3, r5			; E2 35

	BIT	0, 3, r5		; E2 35

	BIT	1, 3, r5		; E2 B5

	BRK				; 00

	BSET	3, r5			; E2 B5

	BSWAP	X+0x54			; D5 54

1$:
	BTJ	0, 2, r7, 1$		; F6 27 FD
	BTJ	1, 3, r6, 1$		; F6 B6 FA
	BTJ	0, 2, @r7, 1$		; F7 27 F7
	BTJ	1, 3, @r6, 1$		; F7 B6 F4

	BTJNZ	3, @r6, 1$		; F7 B6 F1
	BTJNZ	3, r6, 1$		; F6 B6 EE

	BTJZ	2, r7, 1$		; F6 27 EB
	BTJZ	2, @r7, 1$		; F7 27 E8

	CALL	@X+0x34			; D4 34
	CALL	X+0x3456		; D6 34 56

	CCF				; EF

	CLR	X+0x98			; B0 98
	CLR	@X+0x35			; B1 35

	COM	X+0x78			; 60 78
	COM	@X+0x54			; 61 54

	CP	r5, r7			; A2 57
	CP	r6, @r8			; A3 68
	CP	X+0x34, X+0x55		; A4 55 34
	CP	X+0x35, @X+0xAA		; A5 AA 35
	CP	X+0x36, #X+0x31		; A6 36 31
	CP	@X+0x37, #X+0x32	; A7 37 32

	CPC	r5, r7			; 1F A2 57
	CPC	r6, @r8			; 1F A3 68
	CPC	X+0x34, X+0x55		; 1F A4 55 34
	CPC	X+0x35, @X+0xAA		; 1F A5 AA 35
	CPC	X+0x36, #X+0x31		; 1F A6 36 31
	CPC	@X+0x37, #X+0x32	; 1F A7 37 32
	;**>**
;r	CPCX	X+0x351, X+0x456	; 1F A8 45 63 51
	CPCX	X+0x351, 0x456		; 1F A8 45 63 51
	CPCX	0x351, X+0x456		; 1F A8 45 63 51
	;**<**
	CPCX	X+0x364, #X+0x35	; 1F A9 35 03 64

	;**>**
;r	CPX	X+0x351, X+0x456	; A8 45 63 51
	CPX	X+0x351, 0x456		; A8 45 63 51
	CPX	0x351, X+0x456		; A8 45 63 51
	;**<**
	CPX	X+0x364, #X+0x35	; A9 35 03 64

	DA	X+0x34			; 40 34
	DA	@X+0x43			; 41 43

	DEC	X+0x56			; 30 56
	DEC	@X+0x41			; 31 41

	DECW	X+0x34			; 80 34
	DECW	@X+0x44			; 81 44

	DI				; 8F

2$:
	DJNZ	r0, 2$			; 0A FE
	DJNZ	r1, 2$			; 1A FC
	DJNZ	r2, 2$			; 2A FA
	DJNZ	r3, 2$			; 3A F8
	DJNZ	r4, 2$			; 4A F6
	DJNZ	r5, 2$			; 5A F4
	DJNZ	r6, 2$			; 6A F2
	DJNZ	r7, 2$			; 7A F0
	DJNZ	r8, 2$			; 8A EE
	DJNZ	r9, 2$			; 9A EC
	DJNZ	r10, 2$			; AA EA
	DJNZ	r11, 2$			; BA E8
	DJNZ	r12, 2$			; CA E6
	DJNZ	r13, 2$			; DA E4
	DJNZ	r14, 2$			; EA E2
	DJNZ	r15, 2$			; FA E0

	EI				; 9F

	HALT				; 7F

	INC	X+0x46			; 20 46
	INC	@X+0x34			; 21 34
	INC	r0			; 0E
	INC	r1			; 1E
	INC	r2			; 2E
	INC	r3			; 3E
	INC	r4			; 4E
	INC	r5			; 5E
	INC	r6			; 6E
	INC	r7			; 7E
	INC	r8			; 8E
	INC	r9			; 9E
	INC	r10			; AE
	INC	r11			; BE
	INC	r12			; CE
	INC	r13			; DE
	INC	r14			; EE
	INC	r15			; FE

	INCW	X+0x34			; A0 34
	INCW	@X+0x48			; A1 48

	IRET				; BF

	JP	@rr4			; C4 E4
	JP	X+0xF818			; 8D F8 18
	JP	F, X+0xF010		; 0D F0 10
	JP	LT, X+0xF111		; 1D F1 11
	JP	LE, X+0xF212		; 2D F2 12
	JP	ULE, X+0xF313		; 3D F3 13
	JP	OV, X+0xF414		; 4D F4 14
	JP	MI, X+0xF515		; 5D F5 15
	JP	Z, X+0xF616		; 6D F6 16
	JP	C, X+0xF717		; 7D F7 17
	JP	T, X+0xF818		; 8D F8 18
	JP	GE, X+0xF919		; 9D F9 19
	JP	GT, X+0xFA1A		; AD FA 1A
	JP	UGT, X+0xFB1B		; BD FB 1B
	JP	NOV, X+0xFC1C		; CD FC 1C
	JP	PL, X+0xFD1D		; DD FD 1D
	JP	NZ, X+0xFE1E		; ED FE 1E
	JP	NC, X+0xFF1F		; FD FF 1F

	JR	3$			; 8B 20
	JR	F, 3$			; 0B 1E
	JR	LT, 3$			; 1B 1C
	JR	LE, 3$			; 2B 1A
	JR	ULE, 3$			; 3B 18
	JR	OV, 3$			; 4B 16
	JR	MI, 3$			; 5B 14
	JR	Z, 3$			; 6B 12
	JR	C, 3$			; 7B 10
	JR	T, 3$			; 8B 0E
	JR	GE, 3$			; 9B 0C
	JR	GT, 3$			; AB 0A
	JR	UGT, 3$			; BB 08
	JR	NOV, 3$			; CB 06
	JR	PL, 3$			; DB 04
	JR	NZ, 3$			; EB 02
	JR	NC, 3$			; FB 00
3$:

	LD	r0, #X+0x30		; 0C 30
	LD	r1, #X+0x31		; 1C 31
	LD	r2, #X+0x32		; 2C 32
	LD	r3, #X+0x33		; 3C 33
	LD	r4, #X+0x34		; 4C 34
	LD	r5, #X+0x35		; 5C 35
	LD	r6, #X+0x36		; 6C 36
	LD	r7, #X+0x37		; 7C 37
	LD	r8, #X+0x38		; 8C 38
	LD	r9, #X+0x39		; 9C 39
	LD	r10, #X+0x3A		; AC 3A
	LD	r11, #X+0x3B		; BC 3B
	LD	r12, #X+0x3C		; CC 3C
	LD	r13, #X+0x3D		; DC 3D
	LD	r14, #X+0x3E		; EC 3E
	LD	r15, #X+0x3F		; FC 3F
	LD	r3, X+0x3(r6)		; C7 36 03
	LD	X+0x5(r4), r7		; D7 74 05
	LD	r5, @r7			; E3 57
	LD	X+0x34, X+0x55		; E4 55 34
	LD	X+0x35, @X+0xAA		; E5 AA 35
	LD	X+0x36, #X+0x31		; E6 36 31
	LD	@X+0x37, #X+0x32	; E7 37 32
	LD	@r7, r0			; F3 70
	LD	@X+0x25, X+0x71		; F5 71 25

	LDC	r4, @rr6		; C2 46
	LDC	@r5, @rr6		; C5 56
	LDC	@rr6, r4		; D2 46

	LDCI	@r7, @rr8		; C3 78
	LDCI	@rr6, @r8		; D3 86

	LDE	r5, @rr8		; 82 58
	LDE	@rr2, r5		; 92 52

	LDEI	@r6, @rr10		; 83 6A
	LDEI	@rr14, @r3		; 93 3E

	LD	r1, X+0xE3(r6)		; C7 16 E3
	LD	X+0x10(r8), r6		; D7 68 10

	; **>**
;r	LDWX	X+0x456,X+0x123		; 1F E8 12 34 56
	LDWX	X+0x456,0x123		; 1F E8 12 34 56
	LDWX	0x456,X+0x123		; 1F E8 12 34 56
	; **<**

	LDX	r3, X+0x876		; 84 38 76
	LDX	@r4, X+0x564		; 85 45 64
	LDX	X+0x34, @X+0x56		; 86 56 34
	LDX	@X+0x12, @.RR(X+0x09)	; 87 E8 12
	LDX	r4, X+0x21(rr2)		; 88 42 21
	LDX	X+0x92(rr14), r0	; 89 E0 92
	LDX	X+0x345, r6		; 94 63 45
	LDX	X+0x347, @r6		; 95 63 47
	LDX	@rr10, r1		; 96 E1 EA
	LDX	@.RR(X+0x13), @X+0xB4	; 97 B4 E2
	; **>**
;r	LDX	X+0x351, X+0x456	; E8 45 63 51
	LDX	X+0x351, 0x456		; E8 45 63 51
	LDX	0x351, X+0x456		; E8 45 63 51
	; **<**
	LDX	X+0x364, #X+0x35	; E9 35 03 64

	LEA	r3, X+0xF4(r4)		; 98 34 F4
	LEA	rr2, X+0x10(rr4)	; 99 24 10

	MULT	X+0xCC			; F4 CC

	NOP				; 0F

	OR	r5, r7			; 42 57
	OR	r6, @r8			; 43 68
	OR	X+0x34, X+0x55		; 44 55 34
	OR	X+0x35, @X+0xAA		; 45 AA 35
	OR	X+0x36, #X+0x31		; 46 36 31
	OR	@X+0x37, #X+0x32	; 47 37 32
	; **>**
;r	ORX	X+0x351, X+0x456	; 48 45 63 51
	ORX	X+0x351, 0x456		; 48 45 63 51
	ORX	0x351, X+0x456		; 48 45 63 51
	; **<**
	ORX	X+0x364, #X+0x35	; 49 35 03 64

	POP	X+0x46			; 50 46
	POP	@X+0x35			; 51 35
	POPX	X+0x543			; D8 54 30

	PUSH	X+0x54			; 70 54
	PUSH	@X+0x34			; 71 34
	PUSH	#X+0x14			; 1F 70 14
	PUSHX	X+0x345			; C8 34 50

	RCF				; CF

	RET				; AF

	RL	X+0x35			; 90 35
	RL	@X+0x44			; 91 44

	RLC	X+0x35			; 10 35
	RLC	@X+0x44			; 11 44

	RR	X+0x20			; E0 20
	RR	@X+0x46			; E1 46

	RRC	X+0x20			; C0 20
	RRC	@X+0x46			; C1 46

	SBC	r5, r7			; 32 57
	SBC	r6, @r8			; 33 68
	SBC	X+0x34, X+0x55		; 34 55 34
	SBC	X+0x35, @X+0xAA		; 35 AA 35
	SBC	X+0x36, #X+0x31		; 36 36 31
	SBC	@X+0x37, #X+0x32	; 37 37 32
	; **>**
;r	SBCX	X+0x351, X+0x456	; 38 45 63 51
	SBCX	X+0x351, 0x456		; 38 45 63 51
	SBCX	0x351, X+0x456		; 38 45 63 51
	; **<**
	SBCX	X+0x364, #X+0x35		; 39 35 03 64

	SCF				; DF

	SRA	X+0x43			; D0 43
	SRA	@X+0x67			; D1 67

	SRL	X+0x41			; 1F C0 41
	SRL	@X+0x67			; 1F C1 67

	SRP	#X+0x35			; 01 35

	STOP				; 6F

	SUB	r5, r7			; 22 57
	SUB	r6, @r8			; 23 68
	SUB	X+0x34, X+0x55		; 24 55 34
	SUB	X+0x35, @X+0xAA		; 25 AA 35
	SUB	X+0x36, #X+0x31		; 26 36 31
	SUB	@X+0x37, #X+0x32	; 27 37 32
	; **>**
;r	SUBX	X+0x351, X+0x456	; 28 45 63 51
	SUBX	X+0x351, 0x456		; 28 45 63 51
	SUBX	0x351, X+0x456		; 28 45 63 51
	; **<**
	SUBX	X+0x364, #X+0x35		; 29 35 03 64

	SWAP	X+0x56			; F0 56
	SWAP	@X+0x89			; F1 89

	TCM	r5, r7			; 62 57
	TCM	r6, @r8			; 63 68
	TCM	X+0x34, X+0x55		; 64 55 34
	TCM	X+0x35, @X+0xAA		; 65 AA 35
	TCM	X+0x36, #X+0x31		; 66 36 31
	TCM	@X+0x37, #X+0x32	; 67 37 32
	; **>**
;r	TCMX	X+0x351, X+0x456	; 68 45 63 51
	TCMX	X+0x351, 0x456		; 68 45 63 51
	TCMX	0x351, X+0x456		; 68 45 63 51
	; **<**
	TCMX	X+0x364, #X+0x35		; 69 35 03 64

	TM	r5, r7			; 72 57
	TM	r6, @r8			; 73 68
	TM	X+0x34, X+0x55		; 74 55 34
	TM	X+0x35, @X+0xAA		; 75 AA 35
	TM	X+0x36, #X+0x31		; 76 36 31
	TM	@X+0x37, #X+0x32	; 77 37 32
	; **>**
;r	TMX	X+0x351, X+0x456	; 78 45 63 51
	TMX	X+0x351, 0x456		; 78 45 63 51
	TMX	0x351, X+0x456		; 78 45 63 51
	; **<**
	TMX	X+0x364, #X+0x35	; 79 35 03 64

	TRAP	#X+0x35			; F2 35

	WDT				; 5F

	XOR	r5, r7			; B2 57
	XOR	r6, @r8			; B3 68
	XOR	X+0x34, X+0x55		; B4 55 34
	XOR	X+0x35, @X+0xAA		; B5 AA 35
	XOR	X+0x36, #X+0x31		; B6 36 31
	XOR	@X+0x37, #X+0x32	; B7 37 32
	; **>**
;r	XORX	X+0x351, X+0x456	; B8 45 63 51
	XORX	X+0x351, 0x456		; B8 45 63 51
	XORX	0x351, X+0x456		; B8 45 63 51
	; **<**
	XORX	X+0x364, #X+0x35	; B9 35 03 64



