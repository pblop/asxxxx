	.title	ASrs08 Instruction Test


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Macro Definitions With Constants
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	.macro	.def	name, radix, a1, a2, a3, a4, a5, a6, a7, a8
	  .irp	sym, a1, a2, a3, a4, a5, a6, a7, a8
	    .iifnb  ^/sym/  .define  name''sym  ^/radix''sym/
	  .endm
	.endm

	.macro	.udef 	name, radix, a1, a2, a3, a4, a5, a6, a7, a8
	  .irp	sym, a1, a2, a3, a4, a5, a6, a7, a8
	    .iifnb  ^/sym/  .undefine  name''sym
	  .endm
	.endm

	; Define B0 - B7	Bit Values
	.def	B, 0d, 0, 1, 2, 3, 4, 5, 6, 7

	; Define D0 - D15	Decimal Constants
	.def	D, 0d, 0, 1, 2, 3, 4, 5, 6, 7
	.def	D, 0d, 8, 9, 10, 11, 12, 13, 14, 15

	; Define A00 - A1F	Address Constants
	.def	A, 0x, 00, 01, 02, 03, 04, 05, 06, 07
        .def	A, 0x, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	.def	A, 0x, 10, 11, 12, 13, 14, 15, 16, 17
        .def	A, 0x, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F

	; Define A0000 - A00F0	Address Constants
	.def	A, 0x, 0000, 0010, 0020, 0030, 0040, 0050, 0060, 0070
	.def	A, 0x, 0080, 0090, 00A0, 00B0, 00C0, 00D0, 00E0, 00F0

	; Define Miscellaneous Address Constants
	.def	A, 0x, 22, 33, 3D, 44, 7E, FF, 1234, 2345

	; Define Miscellaneous Number Constants
	.def	N, 0x, 01, 03, 07, 10, 55
	.def	N, 0x, 00, 0B, 1C, 3D, 7E, FF


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Sequential Test With Constants
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	brset	B0,A00F0,.	; 00 F0 FD
	brclr	B0,A00E0,.	; 01 E0 FD
	brset	B1,A00D0,.	; 02 D0 FD
	brclr	B1,A00C0,.	; 03 C0 FD
	brset	B2,A00B0,.	; 04 B0 FD
	brclr	B2,A00A0,.	; 05 A0 FD
	brset	B3,A0090,.	; 06 90 FD
	brclr	B3,A0080,.	; 07 80 FD
	brset	B4,A0070,.	; 08 70 FD
	brclr	B4,A0060,.	; 09 60 FD
	brset	B5,A0050,.	; 0A 50 FD
	brclr	B5,A0040,.	; 0B 40 FD
	brset	B6,A0030,.	; 0C 30 FD
	brclr	B6,A0020,.	; 0D 20 FD
	brset	B7,A0010,.	; 0E 10 FD
	brclr	B7,A0000,.	; 0F 00 FD

	bset	B0,A00F0	; 10 F0
	bclr	B0,A00E0	; 11 E0
	bset	B1,A00D0	; 12 D0
	bclr	B1,A00C0	; 13 C0
	bset	B2,A00B0	; 14 B0
	bclr	B2,A00A0	; 15 A0
	bset	B3,A0090	; 16 90
	bclr	B3,A0080	; 17 80
	bset	B4,A0070	; 18 70
	bclr	B4,A0060	; 19 60
	bset	B5,A0050	; 1A 50
	bclr	B5,A0040	; 1B 40
	bset	B6,A0030	; 1C 30
	bclr	B6,A0020	; 1D 20
	bset	B7,A0010	; 1E 10
	bclr	B7,A0000	; 1F 00

	inc	A00		; 20
	inc 	A01		; 21
	inc	A02		; 22
	inc 	A03		; 23
	inc	A04		; 24
	inc 	A05		; 25
	inc	A06		; 26
	inc 	A07		; 27
	inc	A08		; 28
	inc 	A09		; 29
	inc	A0A		; 2A
	inc 	A0B		; 2B
	inc	A0C		; 2C
	inc 	A0D		; 2D
	inc	A0E		; 2E
	 inc	,x		; 2E
	 inc	D[X]		; 2E
	inc 	A0F		; 2F
	  inc	x		; 2F
	  incx			; 2F

	bra	.		; 30 FE
	  brn	.		; 30 00
	cbeq	#N55,.		; 41 55 FD
	  cbeq	a,#N55,.	; 41 55 FD
	cbeq	A44,.		; 31 44 FD
	  cbeq	,x,.		; 31 0E FD
	  cbeq	D[X],.		; 31 0E FD
	  cbeq	x,.		; 31 0F FD
	cbeq	a,A44,.		; 31 44 FD
	  cbeq	a,D[X],.	; 31 0E FD
	  cbeq	a,x,.		; 31 0F FD
				; 32
				; 33
	bcc	.		; 34 FE
	  bhs	.		; 34 FE
	bcs	.		; 35 FE
	  blo	.		; 35 FE
	bne	.		; 36 FE
	beq	.		; 37 FE
	clc			; 38
	sec			; 39
	dec	AFF		; 3A FF
	  dec	<*AFF		; 5F
	  dec	,x		; 5E
	  dec	D[X]		; 5E
	  dec	x		; 5F
	  decx			; 5F
	dbnz	A33,.		; 3B 33 FD
	  dbnz	,x,.		; 3B 0E FD
	  dbnz	D[X],.		; 3B 0E FD
	  dbnz	x,.		; 3B 0F FD
	  dbnzx	.		; 3B 0F FD
	inc	AFF		; 3C FF
	  inc	<*AFF		; 2F
	  inc	,x		; 2E
	  inc	D[X]		; 2E
	  inc	x		; 2F
	  incx			; 2F
				; 3D
				; 3E
	ldx	#N10		; 3E 10 0F
	  ldx	A33		; 4E 33 0F
	  ldx	,x		; 4E 0E 0F
	  ldx	D[X]		; 4E 0E 0F
	clr	AFF		; 3F FF
	  clr	<*AFF		; 9F
	  clr	,x		; 8E
	  clr	D[X]		; 8E
	  clr	x		; 8F
	  clrx			; 8F

				; 40
	cbeqa	#N55,.		; 41 55 FD
	  cbeqa	,x,.		; 31 0E FD
	  cbeqa	D[X],.		; 31 0E FD
	  cbeqa	x,.		; 31 0F FD
	sla			; 42
	  sl	a		; 42
	coma			; 43
	  com	a		; 43
	lsra			; 44
	  lsr	a		; 44
	sha			; 45
	  sh	a		; 45
	rora			; 46
	  ror	a		; 46
				; 47
	asla			; 48
	  asl	a		; 48
	  lsla			; 48
	  lsl	a		; 48
	rola			; 49
	  rol	a		; 49
	deca			; 4A
	  dec	a		; 4A
	dbnza	.		; 4B FE
	 dbnz	a,.		; 4B FE
	inca			; 4C
	  inc	a		; 4C
				; 4D
	mov	A22,A33		; 4E 22 33
	  mov	x,x		; 4E 0F 0F
	  mov	D[X],D[X]	; 4E 0E 0E
	  mov	,x,A44		; 4E 0E 44
	  mov	D[X],A44	; 4E 0E 44
	  mov	A44,D[X]	; 4E 44 0E
	  mov	x,A44		; 4E 0F 44
	  mov	A44,x		; 4E 44 0F
	  mov	#N55,A44	; 3E 55 44
	  mov	#N55,D[X]	; 3E 55 0E
	  mov	#N55,x		; 3E 55 0F
	stx	A44		; 4E 0F 44
	tst	A44		; 4E 44 44
	  tstx			; 4E 0F 0F
	  tst	,x		; 4E 0E 0E
	  tst	D[X]		; 4E 0E 0E
	  tst	x		; 4E 0F 0F
	  tstx			; 4E 0F 0F
	clra			; 4F
	  clr	a		; 4F

	dec	A00		; 50
	dec 	A01		; 51
	dec	A02		; 52
	dec 	A03		; 53
	dec	A04		; 54
	dec 	A05		; 55
	dec	A06		; 56
	dec 	A07		; 57
	dec	A08		; 58
	dec 	A09		; 59
	dec	A0A		; 5A
	dec 	A0B		; 5B
	dec	A0C		; 5C
	dec 	A0D		; 5D
	dec	A0E		; 5E
	  dec	,x		; 5E
	  dec	D[X]		; 5E
	dec 	A0F		; 5F
	  dec	x		; 5F
	  decx			; 5F

	add	A00		; 60
	add 	A01		; 61
	add	A02		; 62
	add 	A03		; 63
	add	A04		; 64
	add 	A05		; 65
	add	A06		; 66
	add 	A07		; 67
	add	A08		; 68
	add 	A09		; 69
	add	A0A		; 6A
	add 	A0B		; 6B
	add	A0C		; 6C
	add 	A0D		; 6D
	add	A0E		; 6E
	  add	,x		; 6E
	  add	D[X]		; 6E
	add 	A0F		; 6F
	  add	x		; 6F
	  addx			; 6F

	sub	A00		; 70
	sub 	A01		; 71
	sub	A02		; 72
	sub 	A03		; 73
	sub	A04		; 74
	sub 	A05		; 75
	sub	A06		; 76
	sub 	A07		; 77
	sub	A08		; 78
	sub 	A09		; 79
	sub	A0A		; 7A
	sub 	A0B		; 7B
	sub	A0C		; 7C
	sub 	A0D		; 7D
	sub	A0E		; 7E
	  sub	,x		; 7E
	  sub	D[X]		; 7E
	sub 	A0F		; 7F
	  sub	x		; 7F
	  subx			; 7F

	clr	A00		; 80
	clr 	A01		; 81
	clr	A02		; 82
	clr 	A03		; 83
	clr	A04		; 84
	clr 	A05		; 85
	clr	A06		; 86
	clr 	A07		; 87
	clr	A08		; 88
	clr 	A09		; 89
	clr	A0A		; 8A
	clr 	A0B		; 8B
	clr	A0C		; 8C
	clr 	A0D		; 8D
	clr	A0E		; 8E
	  clr	,x		; 8E
	  clr	D[X]		; 8E
	clr 	A0F		; 8F
	  clr	x		; 8F
	  clrx			; 8F

	clr	A10		; 90
	clr 	A11		; 91
	clr	A12		; 92
	clr 	A13		; 93
	clr	A14		; 94
	clr 	A15		; 95
	clr	A16		; 96
	clr 	A17		; 97
	clr	A18		; 98
	clr 	A19		; 99
	clr	A1A		; 9A
	clr 	A1B		; 9B
	clr	A1C		; 9C
	clr 	A1D		; 9D
	clr	A1E		; 9E
	clr 	A1F		; 9F

	sub	#N55		; A0 55
	cmp	#N55		; A1 55
	sbc	#N55		; A2 55
				; A3
	and	#N55		; A4 55
				; A5
	lda	#N55		; A6 55
				; A7
	eor	#N55		; A8 55
	adc	#N55		; A9 55
	ora	#N55		; AA 55
	  tst	a		; AA 00
	  tsta			; AA 00
	add	#N55		; AB 55
	nop			; AC
	bsr	.		; AD FE
	stop			; AE
	wait			; AF

	sub	A44		; B0 44
	cmp	A44		; B1 44
	  cmp	,x		; B1 0E
	  cmp	D[X]		; B1 0E
	  cmp	x		; B1 0F
	  cmpx			; B1 0F
	sbc	A44		; B2 44
	  sbc	,x		; B2 0E
	  sbc	D[X]		; B2 0E
	  sbc	x		; B2 0F
	  sbcx			; B2 0F
				; B3
	and	A44		; B4 44
	  and	,x		; B4 0E
	  and	D[X]		; B4 0E
	  and	x		; B4 0F
	  andx			; B4 0F
				; B5
	lda	A44		; B6 44
	  lda	<*A44		; C4
	sta	A44		; B7 44
	eor	A44		; B8 44
	  eor	,x		; B8 0E
	  eor	D[X]		; B8 0E
	  eor	x		; B8 0F
	  eorx			; B8 0F
	adc	A44		; B9 44
	  adc	,x		; B9 0E
	  adc	D[X]		; B9 0E
	  adc	x		; B9 0F
	  adcx			; B9 0F
	ora	A44		; BA 44
	  ora	,x		; BA 0E
	  ora	D[X]		; BA 0E
	  ora	x		; BA 0F
	  orax			; BA 0F
	add	A44		; BB 44
	  add	<*A44		; 64
	  add	,x		; 6E
	  add	D[X]		; 6E
	  add	x		; 6F
	  addx			; 6F
	jmp	A1234		; BC 12 34
	jsr	A2345		; BD 23 45
	rts			; BE
	bgnd			; BF

	lda	A00		; C0
	lda 	A01		; C1
	lda	A02		; C2
	lda 	A03		; C3
	lda	A04		; C4
	lda 	A05		; C5
	lda	A06		; C6
	lda 	A07		; C7
	lda	A08		; C8
	lda 	A09		; C9
	lda	A0A		; CA
	lda 	A0B		; CB
	lda	A0C		; CC
	lda 	A0D		; CD
	lda	A0E		; CE
	  lda	,x		; CE
	  lda	D[X]		; CE
	lda 	A0F		; CF
	  lda	x		; CF
	  ldax			; CF
	  txa			; CF

	lda	A10		; D0
	lda 	A11		; D1
	lda	A12		; D2
	lda 	A13		; D3
	lda	A14		; D4
	lda 	A15		; D5
	lda	A16		; D6
	lda 	A17		; D7
	lda	A18		; D8
	lda 	A19		; D9
	lda	A1A		; DA
	lda 	A1B		; DB
	lda	A1C		; DC
	lda 	A1D		; DD
	lda	A1E		; DE
	lda 	A1F		; DF

	sta	A00		; E0
	sta 	A01		; E1
	sta	A02		; E2
	sta 	A03		; E3
	sta	A04		; E4
	sta 	A05		; E5
	sta	A06		; E6
	sta 	A07		; E7
	sta	A08		; E8
	sta 	A09		; E9
	sta	A0A		; EA
	sta 	A0B		; EB
	sta	A0C		; EC
	sta 	A0D		; ED
	sta	A0E		; EE
	  sta	,x		; EE
	  sta	D[X]		; EE
	sta 	A0F		; EF
	  sta	x		; EF
	  stax			; EF
	  tax			; EF

	sta	A10		; F0
	sta 	A11		; F1
	sta	A12		; F2
	sta 	A13		; F3
	sta	A14		; F4
	sta 	A15		; F5
	sta	A16		; F6
	sta 	A17		; F7
	sta	A18		; F8
	sta 	A19		; F9
	sta	A1A		; FA
	sta 	A1B		; FB
	sta	A1C		; FC
	sta 	A1D		; FD
	sta	A1E		; FE
	sta 	A1F		; FF

	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Test Of Special Modes With Constants
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	; Assembler S_TYP1 - ADD, DEC, INC, and SUB
	; TNY Mode

	add	A00		; 60
	add	A0B		; 6B
	add	A1C		; BB 1C
	add	A3D		; BB 3D
	add	A7E		; BB 7E
	add	AFF		; BB FF

	add	*A00		; BB 00
	add	*A0B		; BB 0B
	add	*A1C		; BB 1C
	add	*A3D		; BB 3D
	add	*A7E		; BB 7E
	add	*AFF		; BB FF

	add	<*A00		; 60
	add	<*A0B		; 6B
	add	<*A1C		; 6C
	add	<*A3D		; 6D
	add	<*A7E		; 6E
	add	<*AFF		; 6F

	; Assembler S_TYP2 - CLR
	; SRT Mode

	clr	A00		; 80
	clr	A0B		; 8B
	clr	A1C		; 9C
	clr	A3D		; 3F 3D
	clr	A7E		; 3F 7E
	clr	AFF		; 3F FF

	clr	*A00		; 3F 00
	clr	*A0B		; 3F 0B
	clr	*A1C		; 3F 1C
	clr	*A3D		; 3F 3D
	clr	*A7E		; 3F 7E
	clr	*AFF		; 3F FF

	clr	<*A00		; 80
	clr	<*A0B		; 8B
	clr	<*A1C		; 9C
	clr	<*A3D		; 9D
	clr	<*A7E		; 9E
	clr	<*AFF		; 9F

	; Assembler S_TYP3 - LDA and STA
	; SRT Mode

	lda	A00		; C0
	lda	A0B		; CB
	lda	A1C		; DC
	lda	A3D		; B6 3D
	lda	A7E		; B6 7E
	lda	AFF		; B6 FF

	lda	*A00		; B6 00
	lda	*A0B		; B6 0B
	lda	*A1C		; B6 1C
	lda	*A3D		; B6 3D
	lda	*A7E		; B6 7E
	lda	*AFF		; B6 FF

	lda	<*A00		; C0
	lda	<*A0B		; CB
	lda	<*A1C		; DC
	lda	<*A3D		; DD
	lda	<*A7E		; DE
	lda	<*AFF		; DF

	; Assembler S_BIT - BCLR and BSET
	; R_3BIT Mode (And S_FRC)

	bclr	N00,A44		; 11 44
	bclr	N01,A44		; 13 44
	bclr	N03,A44		; 17 44
	bclr	N07,A44		; 1F 44
	bclr	*N00,A44	; 11 44
	bclr	*N01,A44	; 13 44
	bclr	*N03,A44	; 17 44
	bclr	*N07,A44	; 1F 44
	bclr	<*N0B,A44	; 17 44
	bclr	<*N1C,A44	; 19 44
	bclr	<*N3D,A44	; 1B 44
	bclr	<*N7E,A44	; 1D 44
	bclr	<*NFF,A44	; 1F 44

	bclr	#N00,A44	; 11 44
	bclr	#N01,A44	; 13 44
	bclr	#N03,A44	; 17 44
	bclr	#N07,A44	; 1F 44
	bclr	<*#N0B,A44	; 17 44
	bclr	<*#N1C,A44	; 19 44
	bclr	<*#N3D,A44	; 1B 44
	bclr	<*#N7E,A44	; 1D 44
	bclr	<*#NFF,A44	; 1F 44

	; Assembler S_BBIT - BRCLR and BRSET
	; R_3BIT Mode (And S_FRC)

	brclr	N00,A44,.	; 01 44 FD
	brclr	N01,A44,.	; 03 44 FD
	brclr	N03,A44,.	; 07 44 FD
	brclr	N07,A44,.	; 0F 44 FD
	brclr	*N00,A44,.	; 01 44 FD
	brclr	*N01,A44,.	; 03 44 FD
	brclr	*N03,A44,.	; 07 44 FD
	brclr	*N07,A44,.	; 0F 44 FD
	brclr	<*N0B,A44,.	; 07 44 FD
	brclr	<*N1C,A44,.	; 09 44 FD
	brclr	<*N3D,A44,.	; 0B 44 FD
	brclr	<*N7E,A44,.	; 0D 44 FD
	brclr	<*NFF,A44,.	; 0F 44 FD

	brclr	#N00,A44,.	; 01 44 FD
	brclr	#N01,A44,.	; 03 44 FD
	brclr	#N03,A44,.	; 07 44 FD
	brclr	#N07,A44,.	; 0F 44 FD
	brclr	<*#N0B,A44,.	; 07 44 FD
	brclr	<*#N1C,A44,.	; 09 44 FD
	brclr	<*#N3D,A44,.	; 0B 44 FD
	brclr	<*#N7E,A44,.	; 0D 44 FD
	brclr	<*#NFF,A44,.	; 0F 44 FD


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Remove Macro Definitions With Constants
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	; UnDefine B0 - B7	Bit Values
	.udef	B, 0d, 0, 1, 2, 3, 4, 5, 6, 7

	; UnDefine D0 - D15	Decimal Constants
	.udef	D, 0d, 0, 1, 2, 3, 4, 5, 6, 7
	.udef	D, 0d, 8, 9, 10, 11, 12, 13, 14, 15

	; UnDefine A00 - A1F	Address Constants
	.udef	A, 0x, 00, 01, 02, 03, 04, 05, 06, 07
        .udef	A, 0x, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	.udef	A, 0x, 10, 11, 12, 13, 14, 15, 16, 17
        .udef	A, 0x, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F

	; UnDefine A0000 - A00F0	Address Constants
	.udef	A, 0x, 0000, 0010, 0020, 0030, 0040, 0050, 0060, 0070
	.udef	A, 0x, 0080, 0090, 00A0, 00B0, 00C0, 00D0, 00E0, 00F0

	; UnDefine Miscellaneous Address Constants
	.udef	A, 0x, 22, 33, 3D, 44, 7E, FF, 1234, 2345

	; UnDefine Miscellaneous Number Constants
	.udef	N, 0x, 01, 03, 07, 10, 55
	.udef	N, 0x, 00, 0B, 1C, 3D, 7E, FF

	; UnDefine Argument Macros

 	.mdelete  .def,  .udef


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Macro Definitions With Externals
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	.macro	.def	name, radix, a1, a2, a3, a4, a5, a6, a7, a8
	  .irp	sym, a1, a2, a3, a4, a5, a6, a7, a8
	    .iifnb  ^/sym/  .define  name''sym  ^/radix''sym + Ext/
	  .endm
	  .globl  Ext
	.endm

	.macro	.udef 	name, radix, a1, a2, a3, a4, a5, a6, a7, a8
	  .irp	sym, a1, a2, a3, a4, a5, a6, a7, a8
	    .iifnb  ^/sym/  .undefine  name''sym
	  .endm
	.endm

	; Define B0 - B7	Bit Values
	.def	B, 0d, 0, 1, 2, 3, 4, 5, 6, 7

	; Define D0 - D15	Decimal Constants
	.def	D, 0d, 0, 1, 2, 3, 4, 5, 6, 7
	.def	D, 0d, 8, 9, 10, 11, 12, 13, 14, 15

	; Define A00 - A1F	Address Constants
	.def	A, 0x, 00, 01, 02, 03, 04, 05, 06, 07
        .def	A, 0x, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	.def	A, 0x, 10, 11, 12, 13, 14, 15, 16, 17
        .def	A, 0x, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F

	; Define A0000 - A00F0	Address Constants
	.def	A, 0x, 0000, 0010, 0020, 0030, 0040, 0050, 0060, 0070
	.def	A, 0x, 0080, 0090, 00A0, 00B0, 00C0, 00D0, 00E0, 00F0

	; Define Miscellaneous Address Constants
	.def	A, 0x, 22, 33, 3D, 44, 7E, FF, 1234, 2345

	; Define Miscellaneous Number Constants
	.def	N, 0x, 01, 03, 07, 10, 55
	.def	N, 0x, 00, 0B, 1C, 3D, 7E, FF


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Sequential Test With Externals
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	brset	B0,A00F0,.	;u00*F0 FD
	brclr	B0,A00E0,.	;u01*E0 FD
	brset	B1,A00D0,.	;u02*D0 FD
	brclr	B1,A00C0,.	;u03*C0 FD
	brset	B2,A00B0,.	;u04*B0 FD
	brclr	B2,A00A0,.	;u05*A0 FD
	brset	B3,A0090,.	;u06*90 FD
	brclr	B3,A0080,.	;u07*80 FD
	brset	B4,A0070,.	;u08*70 FD
	brclr	B4,A0060,.	;u09*60 FD
	brset	B5,A0050,.	;u0A*50 FD
	brclr	B5,A0040,.	;u0B*40 FD
	brset	B6,A0030,.	;u0C*30 FD
	brclr	B6,A0020,.	;u0D*20 FD
	brset	B7,A0010,.	;u0E*10 FD
	brclr	B7,A0000,.	;u0F*00 FD

	bset	B0,A00F0	;u10*F0
	bclr	B0,A00E0	;u11*E0
	bset	B1,A00D0	;u12*D0
	bclr	B1,A00C0	;u13*C0
	bset	B2,A00B0	;u14*B0
	bclr	B2,A00A0	;u15*A0
	bset	B3,A0090	;u16*90
	bclr	B3,A0080	;u17*80
	bset	B4,A0070	;u18*70
	bclr	B4,A0060	;u19*60
	bset	B5,A0050	;u1A*50
	bclr	B5,A0040	;u1B*40
	bset	B6,A0030	;u1C*30
	bclr	B6,A0020	;u1D*20
	bset	B7,A0010	;u1E*10
	bclr	B7,A0000	;u1F*00

	inc	A00		; 3C*00
	inc 	A01		; 3C*01
	inc	A02		; 3C*02
	inc 	A03		; 3C*03
	inc	A04		; 3C*04
	inc 	A05		; 3C*05
	inc	A06		; 3C*06
	inc 	A07		; 3C*07
	inc	A08		; 3C*08
	inc 	A09		; 3C*09
	inc	A0A		; 3C*0A
	inc 	A0B		; 3C*0B
	inc	A0C		; 3C*0C
	inc 	A0D		; 3C*0D
	inc	A0E		; 3C*0E
	  inc	,x		; 2E
	  inc	D[X]		; 2E
	inc 	A0F		; 3C*0F
	  inc	x		; 2F
	  incx			; 2F

	bra	.		; 30 FE
	  brn	.		; 30 00
	cbeq	#N55,.		; 41r55 FD
	  cbeq	a,#N55,.	; 41r55 FD
	cbeq	A44,.		; 31*44 FD
	  cbeq	,x,.		; 31 0E FD
	  cbeq	D[X],.		; 31 0E FD
	  cbeq	x,.		; 31 0F FD
	cbeq	a,A44,.		; 31*44 FD
	  cbeq	a,D[X],.	; 31 0E FD
	  cbeq	a,x,.		; 31 0F FD
				; 32
				; 33
	bcc	.		; 34 FE
	  bhs	.		; 34 FE
	bcs	.		; 35 FE
	  blo	.		; 35 FE
	bne	.		; 36 FE
	beq	.		; 37 FE
	clc			; 38
	sec			; 39
	dec	AFF		; 3A*FF
	  dec	<*AFF		;r5F
	  dec	,x		; 5E
	  dec	D[X]		; 5E
	  dec	x		; 5F
	  decx			; 5F
	dbnz	A33,.		; 3B*33 FD
	  dbnz	,x,.		; 3B 0E FD
	  dbnz	D[X],.		; 3B 0E FD
	  dbnz	x,.		; 3B 0F FD
	  dbnzx	.		; 3B 0F FD
	inc	AFF		; 3C*FF
	  inc	<*AFF		;r2F
	  inc	,x		; 2E
	  inc	D[X]		; 2E
	  inc	x		; 2F
	  incx			; 2F
				; 3D
				; 3E
	ldx	#N10		; 3Er10 0F
	  ldx	A33		; 4E*33 0F
	  ldx	,x		; 4E 0E 0F
	  ldx	D[X]		; 4E 0E 0F
	clr	AFF		; 3F*FF
	  clr	<*AFF		;r9F
	  clr	,x		; 8E
	  clr	D[X]		; 8E
	  clr	x		; 8F
	  clrx			; 8F

				; 40
	cbeqa	#N55,.		; 41r55 FD
	  cbeqa	,x,.		; 31 0E FD
	  cbeqa	D[X],.		; 31 0E FD
	  cbeqa	x,.		; 31 0F FD
	sla			; 42
	  sl	a		; 42
	coma			; 43
	  com	a		; 43
	lsra			; 44
	  lsr	a		; 44
	sha			; 45
	  sh	a		; 45
	rora			; 46
	  ror	a		; 46
				; 47
	asla			; 48
	  asl	a		; 48
	  lsla			; 48
	  lsl	a		; 48
	rola			; 49
	  rol	a		; 49
	deca			; 4A
	  dec	a		; 4A
	dbnza	.		; 4B FE
	 dbnz	a,.		; 4B FE
	inca			; 4C
	  inc	a		; 4C
				; 4D
	mov	A22,A33		; 4E*22*33
	  mov	x,x		; 4E 0F 0F
	  mov	D[X],D[X]	; 4E 0E 0E
	  mov	,x,A44		; 4E 0E*44
	  mov	D[X],A44	; 4E 0E*44
	  mov	A44,D[X]	; 4E*44 0E
	  mov	x,A44		; 4E 0F*44
	  mov	A44,x		; 4E*44 0F
	  mov	#N55,A44	; 3Er55*44
	  mov	#N55,D[X]	; 3Er55 0E
	  mov	#N55,x		; 3Er55 0F
	stx	A44		; 4E 0F*44
	tst	A44		; 4E*44*44
	  tstx			; 4E 0F 0F
	  tst	,x		; 4E 0E 0E
	  tst	D[X]		; 4E 0E 0E
	  tst	x		; 4E 0F 0F
	  tstx			; 4E 0F 0F
	clra			; 4F
	  clr	a		; 4F
	  clra			; 4F

	dec	A00		; 3A*00
	dec 	A01		; 3A*01
	dec	A02		; 3A*02
	dec 	A03		; 3A*03
	dec	A04		; 3A*04
	dec 	A05		; 3A*05
	dec	A06		; 3A*06
	dec 	A07		; 3A*07
	dec	A08		; 3A*08
	dec 	A09		; 3A*09
	dec	A0A		; 3A*0A
	dec 	A0B		; 3A*0B
	dec	A0C		; 3A*0C
	dec 	A0D		; 3A*0D
	dec	A0E		; 3A*0E
	  dec	,x		; 5E
	  dec	D[X]		; 5E
	dec 	A0F		; 3A*0F
	  dec	x		; 5F
	  decx			; 5F

	add	A00		; BB*00
	add 	A01		; BB*01
	add	A02		; BB*02
	add 	A03		; BB*03
	add	A04		; BB*04
	add 	A05		; BB*05
	add	A06		; BB*06
	add 	A07		; BB*07
	add	A08		; BB*08
	add 	A09		; BB*09
	add	A0A		; BB*0A
	add 	A0B		; BB*0B
	add	A0C		; BB*0C
	add 	A0D		; BB*0D
	add	A0E		; BB*0E
	  add	,x		; 6E
	  add	D[X]		; 6E
	add 	A0F		; BB*0F
	  add	x		; 6F
	  addx			; 6F

	sub	A00		; B0*00
	sub 	A01		; B0*01
	sub	A02		; B0*02
	sub 	A03		; B0*03
	sub	A04		; B0*04
	sub 	A05		; B0*05
	sub	A06		; B0*06
	sub 	A07		; B0*07
	sub	A08		; B0*08
	sub 	A09		; B0*09
	sub	A0A		; B0*0A
	sub 	A0B		; B0*0B
	sub	A0C		; B0*0C
	sub 	A0D		; B0*0D
	sub	A0E		; B0*0E
	  sub	,x		; 7E
	  sub	D[X]		; 7E
	sub 	A0F		; B0*0F
	  sub	x		; 7F
	  subx			; 7F

	clr	A00		; 3F*00
	clr 	A01		; 3F*01
	clr	A02		; 3F*02
	clr 	A03		; 3F*03
	clr	A04		; 3F*04
	clr 	A05		; 3F*05
	clr	A06		; 3F*06
	clr 	A07		; 3F*07
	clr	A08		; 3F*08
	clr 	A09		; 3F*09
	clr	A0A		; 3F*0A
	clr 	A0B		; 3F*0B
	clr	A0C		; 3F*0C
	clr 	A0D		; 3F*0D
	clr	A0E		; 3F*0E
	  clr	,x		; 8E
	  clr	D[X]		; 8E
	clr 	A0F		; 3F*0F
	  clr	x		; 8F
	  clrx			; 8F

	clr	A10		; 3F*10
	clr 	A11		; 3F*11
	clr	A12		; 3F*12
	clr 	A13		; 3F*13
	clr	A14		; 3F*14
	clr 	A15		; 3F*15
	clr	A16		; 3F*16
	clr 	A17		; 3F*17
	clr	A18		; 3F*18
	clr 	A19		; 3F*19
	clr	A1A		; 3F*1A
	clr 	A1B		; 3F*1B
	clr	A1C		; 3F*1C
	clr 	A1D		; 3F*1D
	clr	A1E		; 3F*1E
	clr 	A1F		; 3F*1F

	sub	#N55		; A0r55
	cmp	#N55		; A1r55
	sbc	#N55		; A2r55
				; A3
	and	#N55		; A4r55
				; A5
	lda	#N55		; A6r55
				; A7
	eor	#N55		; A8r55
	adc	#N55		; A9r55
	ora	#N55		; AAr55
	  tst	a		; AA 00
	  tsta			; AA 00
	add	#N55		; ABr55
	nop			; AC
				; AD
	stop			; AE
	wait			; AF

	sub	A44		; B0*44
	cmp	A44		; B1*44
	  cmp	,x		; B1 0E
	  cmp	D[X]		; B1 0E
	  cmp	x		; B1 0F
	sbc	A44		; B2*44
	  sbc	,x		; B2 0E
	  sbc	D[X]		; B2 0E
	  sbc	x		; B2 0F
	  sbcx			; B2 0F
				; B3
	and	A44		; B4*44
	  and	,x		; B4 0E
	  and	D[X]		; B4 0E
	  and	x		; B4 0F
	  andx			; B4 0F
				; B5
	lda	A44		; B6*44
	  lda	<*A44		;rC4
	sta	A44		; B7*44
	eor	A44		; B8*44
	  eor	,x		; B8 0E
	  eor	D[X]		; B8 0E
	  eor	x		; B8 0F
	  eorx			; B8 0F
	adc	A44		; B9*44
	  adc	,x		; B9 0E
	  adc	D[X]		; B9 0E
	  adc	x		; B9 0F
	  adcx			; B9 0F
	ora	A44		; BA*44
	  ora	,x		; BA 0E
	  ora	D[X]		; BA 0E
	  ora	x		; BA 0F
	  orax			; BA 0F
	add	A44		; BB*44
	  add	<*A44		;r64
	  add	,x		; 6E
	  add	D[X]		; 6E
	  add	x		; 6F
	  addx			; 6F
	jmp	A1234		; BCs12r34
	jsr	A2345		; BDs23r45
	rts			; BE
	bgnd			; BF

	lda	A00		; B6*00
	lda 	A01		; B6*01
	lda	A02		; B6*02
	lda 	A03		; B6*03
	lda	A04		; B6*04
	lda 	A05		; B6*05
	lda	A06		; B6*06
	lda 	A07		; B6*07
	lda	A08		; B6*08
	lda 	A09		; B6*09
	lda	A0A		; B6*0A
	lda 	A0B		; B6*0B
	lda	A0C		; B6*0C
	lda 	A0D		; B6*0D
	lda	A0E		; B6*0E
	  lda	,x		; CE
	  lda	D[X]		; CE
	lda 	A0F		; B6*0F
	  lda	x		; CF
	  ldax			; CF
	  txa			; CF
	lda	A10		; B6*10
	lda 	A11		; B6*11
	lda	A12		; B6*12
	lda 	A13		; B6*13
	lda	A14		; B6*14
	lda 	A15		; B6*15
	lda	A16		; B6*16
	lda 	A17		; B6*17
	lda	A18		; B6*18
	lda 	A19		; B6*19
	lda	A1A		; B6*1A
	lda 	A1B		; B6*1B
	lda	A1C		; B6*1C
	lda 	A1D		; B6*1D
	lda	A1E		; B6*1E
	lda 	A1F		; B6*1F

	sta	A00		; B7*00
	sta 	A01		; B7*01
	sta	A02		; B7*02
	sta 	A03		; B7*03
	sta	A04		; B7*04
	sta 	A05		; B7*05
	sta	A06		; B7*06
	sta 	A07		; B7*07
	sta	A08		; B7*08
	sta 	A09		; B7*09
	sta	A0A		; B7*0A
	sta 	A0B		; B7*0B
	sta	A0C		; B7*0C
	sta 	A0D		; B7*0D
	sta	A0E		; B7*0E
	  sta	,x		; EE
	  sta	D[X]		; EE
	sta 	A0F		; B7*0F
	  sta	x		; EF
	  stax			; EF
	  tax			; EF

	sta	A10		; B7*10
	sta 	A11		; B7*11
	sta	A12		; B7*12
	sta 	A13		; B7*13
	sta	A14		; B7*14
	sta 	A15		; B7*15
	sta	A16		; B7*16
	sta 	A17		; B7*17
	sta	A18		; B7*18
	sta 	A19		; B7*19
	sta	A1A		; B7*1A
	sta 	A1B		; B7*1B
	sta	A1C		; B7*1C
	sta 	A1D		; B7*1D
	sta	A1E		; B7*1E
	sta 	A1F		; B7*1F


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Test Of Special Modes With Externals
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	; Assembler S_TYP1 - ADD, DEC, INC, and SUB
	; TNY Mode

	add	A00		; BB*00
	add	A0B		; BB*0B
	add	A1C		; BB*1C
	add	A3D		; BB*3D
	add	A7E		; BB*7E
	add	AFF		; BB*FF

	add	*A00		; BB*00
	add	*A0B		; BB*0B
	add	*A1C		; BB*1C
	add	*A3D		; BB*3D
	add	*A7E		; BB*7E
	add	*AFF		; BB*FF

	add	<*A00		;r60
	add	<*A0B		;r6B
	add	<*A1C		;r6C
	add	<*A3D		;r6D
	add	<*A7E		;r6E
	add	<*AFF		;r6F

	; Assembler S_TYP2 - CLR
	; SRT Mode

	clr	A00		; 3F*00
	clr	A0B		; 3F*0B
	clr	A1C		; 3F*1C
	clr	A3D		; 3F*3D
	clr	A7E		; 3F*7E
	clr	AFF		; 3F*FF

	clr	*A00		; 3F*00
	clr	*A0B		; 3F*0B
	clr	*A1C		; 3F*1C
	clr	*A3D		; 3F*3D
	clr	*A7E		; 3F*7E
	clr	*AFF		; 3F*FF

	clr	<*A00		;r80
	clr	<*A0B		;r8B
	clr	<*A1C		;r9C
	clr	<*A3D		;r9D
	clr	<*A7E		;r9E
	clr	<*AFF		;r9F

	; Assembler S_TYP3 - LDA and STA
	; SRT Mode

	lda	A00		; B6*00
	lda	A0B		; B6*0B
	lda	A1C		; B6*1C
	lda	A3D		; B6*3D
	lda	A7E		; B6*7E
	lda	AFF		; B6*FF

	lda	*A00		; B6*00
	lda	*A0B		; B6*0B
	lda	*A1C		; B6*1C
	lda	*A3D		; B6*3D
	lda	*A7E		; B6*7E
	lda	*AFF		; B6*FF

	lda	<*A00		;rC0
	lda	<*A0B		;rCB
	lda	<*A1C		;rDC
	lda	<*A3D		;rDD
	lda	<*A7E		;rDE
	lda	<*AFF		;rDF

	; Assembler S_BIT - BCLR and BSET
	; R_3BIT Mode (And S_FRC)

	bclr	N00,A44		;u11*44
	bclr	N01,A44		;u13*44
	bclr	N03,A44		;u17*44
	bclr	N07,A44		;u1F*44
	bclr	*N00,A44	;u11*44
	bclr	*N01,A44	;u13*44
	bclr	*N03,A44	;u17*44
	bclr	*N07,A44	;u1F*44
	bclr	<*N0B,A44	;r17*44
	bclr	<*N1C,A44	;r19*44
	bclr	<*N3D,A44	;r1B*44
	bclr	<*N7E,A44	;r1D*44
	bclr	<*NFF,A44	;r1F*44

	bclr	#N00,A44	;u11*44
	bclr	#N01,A44	;u13*44
	bclr	#N03,A44	;u17*44
	bclr	#N07,A44	;u1F*44
	bclr	<*#N0B,A44	;r17*44
	bclr	<*#N1C,A44	;r19*44
	bclr	<*#N3D,A44	;r1B*44
	bclr	<*#N7E,A44	;r1D*44
	bclr	<*#NFF,A44	;r1F*44

	; Assembler S_BBIT - BRCLR and BRSET
	; R_3BIT Mode (And S_FRC)

	brclr	N00,A44,.	;u01*44 FD
	brclr	N01,A44,.	;u03*44 FD
	brclr	N03,A44,.	;u07*44 FD
	brclr	N07,A44,.	;u0F*44 FD
	brclr	*N00,A44,.	;u01*44 FD
	brclr	*N01,A44,.	;u03*44 FD
	brclr	*N03,A44,.	;u07*44 FD
	brclr	*N07,A44,.	;u0F*44 FD
	brclr	<*N0B,A44,.	;r07*44 FD
	brclr	<*N1C,A44,.	;r09*44 FD
	brclr	<*N3D,A44,.	;r0B*44 FD
	brclr	<*N7E,A44,.	;r0D*44 FD
	brclr	<*NFF,A44,.	;r0F*44 FD

	brclr	#N00,A44,.	;u01*44 FD
	brclr	#N01,A44,.	;u03*44 FD
	brclr	#N03,A44,.	;u07*44 FD
	brclr	#N07,A44,.	;u0F*44 FD
	brclr	<*#N0B,A44,.	;r07*44 FD
	brclr	<*#N1C,A44,.	;r09*44 FD
	brclr	<*#N3D,A44,.	;r0B*44 FD
	brclr	<*#N7E,A44,.	;r0D*44 FD
	brclr	<*#NFF,A44,.	;r0F*44 FD


	; *****-----*****-----*****-----*****-----*****-----*****-----*****
	;
	; Remove Macro Definitions With Constants
	;
	; *****-----*****-----*****-----*****-----*****-----*****-----*****

	; UnDefine B0 - B7	Bit Values
	.udef	B, 0d, 0, 1, 2, 3, 4, 5, 6, 7

	; UnDefine D0 - D15	Decimal Constants
	.udef	D, 0d, 0, 1, 2, 3, 4, 5, 6, 7
	.udef	D, 0d, 8, 9, 10, 11, 12, 13, 14, 15

	; UnDefine A00 - A1F	Address Constants
	.udef	A, 0x, 00, 01, 02, 03, 04, 05, 06, 07
        .udef	A, 0x, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	.udef	A, 0x, 10, 11, 12, 13, 14, 15, 16, 17
        .udef	A, 0x, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F

	; UnDefine A0000 - A00F0	Address Constants
	.udef	A, 0x, 0000, 0010, 0020, 0030, 0040, 0050, 0060, 0070
	.udef	A, 0x, 0080, 0090, 00A0, 00B0, 00C0, 00D0, 00E0, 00F0

	; UnDefine Miscellaneous Address Constants
	.udef	A, 0x, 22, 33, 3D, 44, 7E, FF, 1234, 2345

	; UnDefine Miscellaneous Number Constants
	.udef	N, 0x, 01, 03, 07, 10, 55
	.udef	N, 0x, 00, 0B, 1C, 3D, 7E, FF

	; UnDefine Argument Macros

 	.mdelete  .def,  .udef


	.end
