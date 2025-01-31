	.title	6500 Assembler Test

;
; All documented 650X, 651X, 65F11, 65F12, 65C00/21, 65C29,
; 65C02, 65C102, and 65C112 instructions with proper AS6500 syntax.
;

	; Enable Automatic Direct Page For Constants
	.enabl	(autodpcnst)

 	; Set Default Radix
	.radix x

	r6500	= 0
	r65f11	= 0
	r65c00	= 0
	r65c02	= 1

;	Enable 6500 Core Instructions Only
.if r6500
	.r6500
.endif

;	Enable 6500 Core Plus 65F11 / 65F12 Instructions
.if r65f11
	.r65f11
.endif

;	Enable 6500 Core Plus 65C00/21 and 65C29 Instructions
.if r65c00
	.r65c00
.endif

;	Enable 6500 Core Plus 65C02, 65C102, and 65C112 Instructions
.if r65c02
	.r65c02
.endif

;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Instruction Test With Brackets - [ ]
;
;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Local Parameters
;
	.define		dir	"0x0083"
	.define		ext	"0x8122"

LB_E:
	adc	#12		; 69 12
				; ---
	adc	12		; 65 12
	adc	dir		; 65 83
	adc	1234		; 6D 34 12
	adc	ext		; 6D 22 81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65 83
				; ---
	adc	,x		; 75 00
	adc	12,x		; 75 12
	adc	dir,x		; 75 83
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7D 22 81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75 83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79 83 00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79 22 81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79 83 00
				; ---
	adc	[,x]		; 61 00
	adc	[12,x]		; 61 12
	adc	[dir,x]		; 61 83
				; ---
	adc	[*,x]		; 61 00
	adc	[*12,x]		; 61 12
	adc	[*dir,x]	; 61 83
				; ---
	adc	[12],y		; 71 12
	adc	[dir],y		; 71 83
				; ---
	adc	[*12],y		; 71 12
	adc	[*dir],y	; 71 83
				; ---
.if r65c02
	adc	[12]		; 72 12
	adc	[dir]		; 72 83
				; ---
	adc	[*12]		; 72 12
	adc	[*dir]		; 72 83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 25 12
	and	dir		; 25 83
	and	1234		; 2D 34 12
	and	ext		; 2D 22 81
				; ---
	and	*12		; 25 12
	and	*dir		; 25 83
				; ---
	and	,x		; 35 00
	and	12,x		; 35 12
	and	dir,x		; 35 83
	and	1234,x		; 3D 34 12
	and	ext,x		; 3D 22 81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35 83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39 83 00
	and	1234,y		; 39 34 12
	and	ext,y		; 39 22 81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39 83 00
				; ---
	and	[,x]		; 21 00
	and	[12,x]		; 21 12
	and	[dir,x]		; 21 83
				; ---
	and	[*,x]		; 21 00
	and	[*12,x]		; 21 12
	and	[*dir,x]	; 21 83
				; ---
	and	[12],y		; 31 12
	and	[dir],y		; 31 83
				; ---
	and	[*12],y		; 31 12
	and	[*dir],y	; 31 83
				; ---
.if	r65c02
	and	[12]		; 32 12
	and	[dir]		; 32 83
				; ---
	and	[*12]		; 32 12
	and	[*dir]		; 32 83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 06 12
	asl	dir		; 06 83
	asl	1234		; 0E 34 12
	asl	ext		; 0E 22 81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06 83
				; ---
	asl	,x		; 16 00
	asl	12,x		; 16 12
	asl	dir,x		; 16 83
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16 83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1E 22 81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F 83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F 83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 24 12
	bit	dir		; 24 83
	bit	1234		; 2C 34 12
	bit	ext		; 2C 22 81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24 83
				; ---
.if	r65c02
	bit	,x		; 34 00
	bit	12,x		; 34 12
	bit	dir,x		; 34 83
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3C 22 81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34 83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; C5 12
	cmp	dir		; C5 83
	cmp	1234		; CD 34 12
	cmp	ext		; CD 22 81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5 83
				; ---
	cmp	,x		; D5 00
	cmp	12,x		; D5 12
	cmp	dir,x		; D5 83
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DD 22 81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5 83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9 83 00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9 22 81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9 83 00
				; ---
	cmp	[,x]		; C1 00
	cmp	[12,x]		; C1 12
	cmp	[dir,x]		; C1 83
				; ---
	cmp	[*,x]		; C1 00
	cmp	[*12,x]		; C1 12
	cmp	[*dir,x]	; C1 83
				; ---
	cmp	[12],y		; D1 12
	cmp	[dir],y		; D1 83
				; ---
	cmp	[*12],y		; D1 12
	cmp	[*dir],y	; D1 83
				; ---
.if	r65c02
	cmp	[12]		; D2 12
	cmp	[dir]		; D2 83
				; ---
	cmp	[*12]		; D2 12
	cmp	[*dir]		; D2 83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; E4 12
	cpx	dir		; E4 83
	cpx	1234		; EC 34 12
	cpx	ext		; EC 22 81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4 83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; C4 12
	cpy	dir		; C4 83
	cpy	1234		; CC 34 12
	cpy	ext		; CC 22 81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4 83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; C6 12
	dec	dir		; C6 83
	dec	1234		; CE 34 12
	dec	ext		; CE 22 81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6 83
				; ---
	dec	12,x		; D6 12
	dec	dir,x		; D6 83
	dec	1234,x		; DE 34 12
	dec	ext,x		; DE 22 81
				; ---
	dec	*12,x		; D6 12
	dec	*dir,x		; D6 83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 45 12
	eor	dir		; 45 83
	eor	1234		; 4D 34 12
	eor	ext		; 4D 22 81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45 83
				; ---
	eor	,x		; 55 00
	eor	12,x		; 55 12
	eor	dir,x		; 55 83
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5D 22 81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55 83
		; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59 83 00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59 22 81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59 83 00
				; ---
	eor	[12],y		; 51 12
	eor	[dir],y		; 51 83
				; ---
	eor	[*12],y		; 51 12
	eor	[*dir],y	; 51 83
				; ---
	eor	[,x]		; 41 00
	eor	[12,x]		; 41 12
	eor	[dir,x]		; 41 83
				; ---
	eor	[*,x]		; 41 00
	eor	[*12,x]		; 41 12
	eor	[*dir,x]	; 41 83
				; ---
.if	r65c02
	eor	[12]		; 52 12
	eor	[dir]		; 52 83
				; ---
	eor	[*12]		; 52 12
	eor	[*dir]		; 52 83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; E6 12
	inc	dir		; E6 83
	inc	1234		; EE 34 12
	inc	ext		; EE 22 81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6 83
				; ---
	inc	,x		; F6 00
	inc	12,x		; F6 12
	inc	dir,x		; F6 83
	inc	1234,x		; FE 34 12
	inc	ext,x		; FE 22 81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6 83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4C 83 00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4C 22 81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4C 83 00
				; ---
	jmp	[12]		; 6C 12 00
	jmp	[dir]		; 6C 83 00
	jmp	[1234]		; 6C 34 12
	jmp	[ext]		; 6C 22 81
				; ---
	jmp	[*12]		; 6C 12 00
	jmp	[*dir]		; 6C 83 00
				; ---
.if	r65c02
	jmp	[1234,x]	; 7C 34 12
	jmp	[ext,x]		; 7C 22 81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20 83 00
	jsr	1234		; 20 34 12
	jsr	ext		; 20 22 81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20 83 00

	lda	#12		; A9 12
				; ---
	lda	12		; A5 12
	lda	dir		; A5 83
	lda	1234		; AD 34 12
	lda	ext		; AD 22 81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5 83
				; ---
	lda	,x		; B5 00
	lda	12,x		; B5 12
	lda	dir,x		; B5 83
	lda	1234,x		; BD 34 12
	lda	ext,x		; BD 22 81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5 83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9 83 00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9 22 81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9 83 00
				; ---
	lda	[,x]		; A1 00
	lda	[12,x]		; A1 12
	lda	[dir,x]		; A1 83
				; ---
	lda	[*,x]		; A1 00
	lda	[*12,x]		; A1 12
	lda	[*dir,x]	; A1 83
				; ---
	lda	[12],y		; B1 12
	lda	[dir],y		; B1 83
				; ---
	lda	[*12],y		; B1 12
	lda	[*dir],y	; B1 83
				; ---
.if	r65c02
	lda	[12]		; B2 12
	lda	[dir]		; B2 83
				; ---
	lda	[*12]		; B2 12
	lda	[*dir]		; B2 83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; A6 12
	ldx	dir		; A6 83
	ldx	1234		; AE 34 12
	ldx	ext		; AE 22 81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6 83
				; ---
	ldx	,y		; B6 00
	ldx	12,y		; B6 12
	ldx	dir,y		; B6 83
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BE 22 81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6 83

	ldy	#12		; A0 12
				; ---
	ldy	12		; A4 12
	ldy	dir		; A4 83
	ldy	1234		; AC 34 12
	ldy	ext		; AC 22 81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4 83
				; ---
	ldy	,x		; B4 00
	ldy	12,x		; B4 12
	ldy	dir,x		; B4 83
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BC 22 81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4 83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 46 12
	lsr	dir		; 46 83
	lsr	1234		; 4E 34 12
	lsr	ext		; 4E 22 81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46 83
				; ---
	lsr	,x		; 56 00
	lsr	12,x		; 56 12
	lsr	dir,x		; 56 83
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5E 22 81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56 83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 05 12
	ora	dir		; 05 83
	ora	1234		; 0D 34 12
	ora	ext		; 0D 22 81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05 83
				; ---
	ora	,x		; 15 00
	ora	12,x		; 15 12
	ora	dir,x		; 15 83
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1D 22 81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15 83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19 83 00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19 22 81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19 83 00
				; ---
	ora	[,x]		; 01 00
	ora	[12,x]		; 01 12
	ora	[dir,x]		; 01 83
				; ---
	ora	[*,x]		; 01 00
	ora	[*12,x]		; 01 12
	ora	[*dir,x]	; 01 83
				; ---
	ora	[12],y		; 11 12
	ora	[dir],y		; 11 83
				; ---
	ora	[*12],y		; 11 12
	ora	[*dir],y	; 11 83
				; ---
.if	r65c02
	ora	[12]		; 12 12
	ora	[dir]		; 12 83
				; ---
	ora	[*12]		; 12 12
	ora	[*dir]		; 12 83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07 83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 26 12
	rol	dir		; 26 83
	rol	1234		; 2E 34 12
	rol	ext		; 2E 22 81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26 83
				; ---
	rol	,x		; 36 00
	rol	12,x		; 36 12
	rol	dir,x		; 36 83
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3E 22 81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36 83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 66 12
	ror	dir		; 66 83
	ror	1234		; 6E 34 12
	ror	ext		; 6E 22 81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66 83
				; ---
	ror	,x		; 76 00
	ror	12,x		; 76 12
	ror	dir,x		; 76 83
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7E 22 81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76 83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; E5 12
	sbc	dir		; E5 83
	sbc	1234		; ED 34 12
	sbc	ext		; ED 22 81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5 83
				; ---
	sbc	,x		; F5 00
	sbc	12,x		; F5 12
	sbc	dir,x		; F5 83
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FD 22 81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5 83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9 83 00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9 22 81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9 83 00
				; ---
	sbc	[12,x]		; E1 12
	sbc	[dir,x]		; E1 83
				; ---
	sbc	[*,x]		; E1 00
	sbc	[*12,x]		; E1 12
	sbc	[*dir,x]	; E1 83
				; ---
	sbc	[12],y		; F1 12
	sbc	[dir],y		; F1 83
				; ---
	sbc	[*12],y		; F1 12
	sbc	[*dir],y	; F1 83
				; ---
.if	r65c02
	sbc	[12]		; F2 12
	sbc	[dir]		; F2 83
				; ---
	sbc	[*12]		; F2 12
	sbc	[*dir]		; F2 83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87 83
.endif

; 	sta	#12		; Illegal
				; ---
	sta	12		; 85 12
	sta	dir		; 85 83
	sta	1234		; 8D 34 12
	sta	ext		; 8D 22 81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85 83
				; ---
	sta	,x		; 95 00
	sta	12,x		; 95 12
	sta	dir,x		; 95 83
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9D 22 81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95 83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99 83 00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99 22 81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99 83 00
				; ---
	sta	[,x]		; 81 00
	sta	[12,x]		; 81 12
	sta	[dir,x]		; 81 83
				; ---
	sta	[*,x]		; 81 00
	sta	[*12,x]		; 81 12
	sta	[*dir,x]	; 81 83
				; ---
	sta	[12],y		; 91 12
	sta	[dir],y		; 91 83
				; ---
	sta	[*12],y		; 91 12
	sta	[*dir],y	; 91 83
				; ---
.if	r65c02
	sta	[12]		; 92 12
	sta	[dir]		; 92 83
				; ---
	sta	[*12]		; 92 12
	sta	[*dir]		; 92 83
.endif

	stx	12		; 86 12
	stx	dir		; 86 83
	stx	1234		; 8E 34 12
	stx	ext		; 8E 22 81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86 83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96 83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96 83

	sty	12		; 84 12
	sty	dir		; 84 83
	sty	1234		; 8C 34 12
	sty	ext		; 8C 22 81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84 83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94 83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94 83

.if	r65c02
	stz	12		; 64 12
	stz	dir		; 64 83
	stz	1234		; 9C 34 12
	stz	ext		; 9C 22 81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64 83
				; ---
	stz	,x		; 74 00
	stz	12,x		; 74 12
	stz	dir,x		; 74 83
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9E 22 81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74 83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 14 12
	trb	dir		; 14 83
	trb	1234		; 1C 34 12
	trb	ext		; 1C 22 81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14 83

	tsb	12		; 04 12
	tsb	dir		; 04 83
	tsb	1234		; 0C 34 12
	tsb	ext		; 0C 22 81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04 83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

;
; External Parameters
;
	.define		dir	"0x0083 + dirx"
	.define		ext	"0x8122 + extx"

XB_E:
	adc	#12		; 69 12
				; ---
	adc	12		; 65 12
	adc	dir		; 6Dr83s00
	adc	1234		; 6D 34 12
	adc	ext		; 6Dr22s81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65*83
				; ---
	adc	,x		; 75 00
	adc	12,x		; 75 12
	adc	dir,x		; 7Dr83s00
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7Dr22s81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75*83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79r83s00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79r22s81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79r83s00
				; ---
	adc	[,x]		; 61 00
	adc	[12,x]		; 61 12
	adc	[dir,x]		; 61*83
				; ---
	adc	[*,x]		; 61 00
	adc	[*12,x]		; 61 12
	adc	[*dir,x]	; 61*83
				; ---
	adc	[12],y		; 71 12
	adc	[dir],y		; 71*83
				; ---
	adc	[*12],y		; 71 12
	adc	[*dir],y	; 71*83
				; ---
.if r65c02
	adc	[12]		; 72 12
	adc	[dir]		; 72*83
				; ---
	adc	[*12]		; 72 12
	adc	[*dir]		; 72*83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 25 12
	and	dir		; 2Dr83s00
	and	1234		; 2D 34 12
	and	ext		; 2Dr22s81
				; ---
	and	*12		; 25 12
	and	*dir		; 25*83
				; ---
	and	12,x		; 35 12
	and	dir,x		; 3Dr83s00
	and	1234,x		; 3D 34 12
	and	ext,x		; 3Dr22s81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35*83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39r83s00
	and	1234,y		; 39 34 12
	and	ext,y		; 39r22s81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39r83s00
				; ---
	and	[,x]		; 21 00
	and	[12,x]		; 21 12
	and	[dir,x]		; 21*83
				; ---
	and	[*,x]		; 21 00
	and	[*12,x]		; 21 12
	and	[*dir,x]	; 21*83
				; ---
	and	[12],y		; 31 12
	and	[dir],y		; 31*83
				; ---
	and	[*12],y		; 31 12
	and	[*dir],y	; 31*83
				; ---
.if	r65c02
	and	[12]		; 32 12
	and	[dir]		; 32*83
				; ---
	and	[*12]		; 32 12
	and	[*dir]		; 32*83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 06 12
	asl	dir		; 0Er83s00
	asl	1234		; 0E 34 12
	asl	ext		; 0Er22s81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06*83
				; ---
	asl	,x		; 16 00
	asl	12,x		; 16 12
	asl	dir,x		; 1Er83s00
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16*83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1Er22s81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F*83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F*83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 24 12
	bit	dir		; 2Cr83s00
	bit	1234		; 2C 34 12
	bit	ext		; 2Cr22s81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24*83
				; ---
.if	r65c02
	bit	,x		; 34 00
	bit	12,x		; 34 12
	bit	dir,x		; 3Cr83s00
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3Cr22s81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34*83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; C5 12
	cmp	dir		; CDr83s00
	cmp	1234		; CD 34 12
	cmp	ext		; CDr22s81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5*83
				; ---
	cmp	,x		; D5 00
	cmp	12,x		; D5 12
	cmp	dir,x		; DDr83s00
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DDr22s81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5*83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9r83s00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9r22s81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9r83s00
				; ---
	cmp	[,x]		; C1 00
	cmp	[12,x]		; C1 12
	cmp	[dir,x]		; C1*83
				; ---
	cmp	[*12,x]		; C1 12
	cmp	[*dir,x]	; C1*83
				; ---
	cmp	[12],y		; D1 12
	cmp	[dir],y		; D1*83
				; ---
	cmp	[*12],y		; D1 12
	cmp	[*dir],y	; D1*83
				; ---
.if	r65c02
	cmp	[12]		; D2 12
	cmp	[dir]		; D2*83
				; ---
	cmp	[*12]		; D2 12
	cmp	[*dir]		; D2*83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; E4 12
	cpx	dir		; ECr83s00
	cpx	1234		; EC 34 12
	cpx	ext		; ECr22s81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4*83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; C4 12
	cpy	dir		; CCr83s00
	cpy	1234		; CC 34 12
	cpy	ext		; CCr22s81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4*83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; C6 12
	dec	dir		; CEr83s00
	dec	1234		; CE 34 12
	dec	ext		; CEr22s81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6*83
				; ---
	dec	,x		; D6 00
	dec	12,x		; D6 12
	dec	dir,x		; DEr83s00
	dec	1234,x		; DE 34 12
	dec	ext,x		; DEr22s81
				; ---
	dec	*,x		; D6 00
	dec	*12,x		; D6 12
	dec	*dir,x		; D6*83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 45 12
	eor	dir		; 4Dr83s00
	eor	1234		; 4D 34 12
	eor	ext		; 4Dr22s81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45*83
				; ---
	eor	,x		; 55 00
	eor	12,x		; 55 12
	eor	dir,x		; 5Dr83s00
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5Dr22s81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55*83
				; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59r83s00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59r22s81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59r83s00
				; ---
	eor	[12],y		; 51 12
	eor	[dir],y		; 51*83
				; ---
	eor	[*12],y		; 51 12
	eor	[*dir],y	; 51*83
				; ---
	eor	[,x]		; 41 00
	eor	[12,x]		; 41 12
	eor	[dir,x]		; 41*83
				; ---
	eor	[*,x]		; 41 00
	eor	[*12,x]		; 41 12
	eor	[*dir,x]	; 41*83
				; ---
.if	r65c02
	eor	[12]		; 52 12
	eor	[dir]		; 52*83
				; ---
	eor	[*12]		; 52 12
	eor	[*dir]		; 52*83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; E6 12
	inc	dir		; EEr83s00
	inc	1234		; EE 34 12
	inc	ext		; EEr22s81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6*83
				; ---
	inc	,x		; F6 00
	inc	12,x		; F6 12
	inc	dir,x		; FEr83s00
	inc	1234,x		; FE 34 12
	inc	ext,x		; FEr22s81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6*83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4Cr83s00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4Cr22s81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4Cr83s00
				; ---
	jmp	[12]		; 6C 12 00
	jmp	[dir]		; 6Cr83s00
	jmp	[1234]		; 6C 34 12
	jmp	[ext]		; 6Cr22s81
				; ---
	jmp	[*12]		; 6C 12 00
	jmp	[*dir]		; 6Cr83s00
				; ---
.if	r65c02
	jmp	[1234,x]	; 7C 34 12
	jmp	[ext,x]		; 7Cr22s81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20r83s00
	jsr	1234		; 20 34 12
	jsr	ext		; 20r22s81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20r83s00

	lda	#12		; A9 12
				; ---
	lda	12		; A5 12
	lda	dir		; ADr83s00
	lda	1234		; AD 34 12
	lda	ext		; ADr22s81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5*83
				; ---
	lda	,x		; B5 00
	lda	12,x		; B5 12
	lda	dir,x		; BDr83s00
	lda	1234,x		; BD 34 12
	lda	ext,x		; BDr22s81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5*83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9r83s00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9r22s81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9r83s00
				; ---
	lda	[,x]		; A1 00
	lda	[12,x]		; A1 12
	lda	[dir,x]		; A1*83
				; ---
	lda	[*,x]		; A1 00
	lda	[*12,x]		; A1 12
	lda	[*dir,x]	; A1*83
				; ---
	lda	[12],y		; B1 12
	lda	[dir],y		; B1*83
				; ---
	lda	[*12],y		; B1 12
	lda	[*dir],y	; B1*83
				; ---
.if	r65c02
	lda	[12]		; B2 12
	lda	[dir]		; B2*83
				; ---
	lda	[*12]		; B2 12
	lda	[*dir]		; B2*83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; A6 12
	ldx	dir		; AEr83s00
	ldx	1234		; AE 34 12
	ldx	ext		; AEr22s81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6*83
				; ---
	ldx	,y		; B6 00
	ldx	12,y		; B6 12
	ldx	dir,y		; BEr83s00
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BEr22s81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6*83

	ldy	#12		; A0 12
				; ---
	ldy	12		; A4 12
	ldy	dir		; ACr83s00
	ldy	1234		; AC 34 12
	ldy	ext		; ACr22s81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4*83
				; ---
	ldy	,x		; B4 00
	ldy	12,x		; B4 12
	ldy	dir,x		; BCr83s00
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BCr22s81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4*83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 46 12
	lsr	dir		; 4Er83s00
	lsr	1234		; 4E 34 12
	lsr	ext		; 4Er22s81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46*83
				; ---
	lsr	,x		; 56 00
	lsr	12,x		; 56 12
	lsr	dir,x		; 5Er83s00
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5Er22s81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56*83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 05 12
	ora	dir		; 0Dr83s00
	ora	1234		; 0D 34 12
	ora	ext		; 0Dr22s81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05*83
				; ---
	ora	,x		; 15 00
	ora	12,x		; 15 12
	ora	dir,x		; 1Dr83s00
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1Dr22s81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15*83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19r83s00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19r22s81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19r83s00
				; ---
	ora	[,x]		; 01 00
	ora	[12,x]		; 01 12
	ora	[dir,x]		; 01*83
				; ---
	ora	[*,x]		; 01 00
	ora	[*12,x]		; 01 12
	ora	[*dir,x]	; 01*83
				; ---
	ora	[12],y		; 11 12
	ora	[dir],y		; 11*83
				; ---
	ora	[*12],y		; 11 12
	ora	[*dir],y	; 11*83
				; ---
.if	r65c02
	ora	[12]		; 12 12
	ora	[dir]		; 12*83
				; ---
	ora	[*12]		; 12 12
	ora	[*dir]		; 12*83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07*83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 26 12
	rol	dir		; 2Er83s00
	rol	1234		; 2E 34 12
	rol	ext		; 2Er22s81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26*83
				; ---
	rol	,x		; 36 00
	rol	12,x		; 36 12
	rol	dir,x		; 3Er83s00
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3Er22s81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36*83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 66 12
	ror	dir		; 6Er83s00
	ror	1234		; 6E 34 12
	ror	ext		; 6Er22s81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66*83
				; ---
	ror	,x		; 76 00
	ror	12,x		; 76 12
	ror	dir,x		; 7Er83s00
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7Er22s81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76*83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; E5 12
	sbc	dir		; EDr83s00
	sbc	1234		; ED 34 12
	sbc	ext		; EDr22s81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5*83
				; ---
	sbc	,x		; F5 00
	sbc	12,x		; F5 12
	sbc	dir,x		; FDr83s00
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FDr22s81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5*83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9r83s00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9r22s81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9r83s00
				; ---
	sbc	[,x]		; E1 00
	sbc	[12,x]		; E1 12
	sbc	[dir,x]		; E1*83
				; ---
	sbc	[*,x]		; E1 00
	sbc	[*12,x]		; E1 12
	sbc	[*dir,x]	; E1*83
				; ---
	sbc	[12],y		; F1 12
	sbc	[dir],y		; F1*83
				; ---
	sbc	[*12],y		; F1 12
	sbc	[*dir],y	; F1*83
				; ---
.if	r65c02
	sbc	[12]		; F2 12
	sbc	[dir]		; F2*83
				; ---
	sbc	[*12]		; F2 12
	sbc	[*dir]		; F2*83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87*83
.endif

; 	sta	#12
				; ---
	sta	12		; 85 12
	sta	dir		; 8Dr83s00
	sta	1234		; 8D 34 12
	sta	ext		; 8Dr22s81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85*83
				; ---
	sta	,x		; 95 00
	sta	12,x		; 95 12
	sta	dir,x		; 9Dr83s00
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9Dr22s81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95*83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99r83s00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99r22s81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99r83s00
				; ---
	sta	[,x]		; 81 00
	sta	[12,x]		; 81 12
	sta	[dir,x]		; 81*83
				; ---
	sta	[*,x]		; 81 00
	sta	[*12,x]		; 81 12
	sta	[*dir,x]	; 81*83
				; ---
	sta	[12],y		; 91 12
	sta	[dir],y		; 91*83
				; ---
	sta	[*12],y		; 91 12
	sta	[*dir],y	; 91*83
				; ---
.if	r65c02
	sta	[12]		; 92 12
	sta	[dir]		; 92*83
				; ---
	sta	[*12]		; 92 12
	sta	[*dir]		; 92*83
.endif

	stx	12		; 86 12
	stx	dir		; 8Er83s00
	stx	1234		; 8E 34 12
	stx	ext		; 8Er22s81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86*83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96*83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96*83

	sty	12		; 84 12
	sty	dir		; 8Cr83s00
	sty	1234		; 8C 34 12
	sty	ext		; 8Cr22s81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84*83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94*83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94*83

.if	r65c02
	stz	12		; 64 12
	stz	dir		; 9Cr83s00
	stz	1234		; 9C 34 12
	stz	ext		; 9Cr22s81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64*83
				; ---
	stz	,x		; 74 00
	stz	12,x		; 74 12
	stz	dir,x		; 9Er83s00
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9Er22s81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74*83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 14 12
	trb	dir		; 1Cr83s00
	trb	1234		; 1C 34 12
	trb	ext		; 1Cr22s81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14*83

	tsb	12		; 04 12
	tsb	dir		; 0Cr83s00
	tsb	1234		; 0C 34 12
	tsb	ext		; 0Cr22s81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04*83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Instruction Test With Parenthesis - ( )
;
;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Local Parameters
;
	.define		dir	"0x0083"
	.define		ext	"0x8122"

LP_E:	adc	#12		; 69 12
				; ---
	adc	12		; 65 12
	adc	dir		; 65 83
	adc	1234		; 6D 34 12
	adc	ext		; 6D 22 81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65 83
				; ---
	adc	,x		; 75 00
	adc	12,x		; 75 12
	adc	dir,x		; 75 83
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7D 22 81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75 83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79 83 00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79 22 81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79 83 00
				; ---
	adc	(,x)		; 61 00
	adc	(12,x)		; 61 12
	adc	(dir,x)		; 61 83
				; ---
	adc	(*,x)		; 61 00
	adc	(*12,x)		; 61 12
	adc	(*dir,x)	; 61 83
				; ---
	adc	(12),y		; 71 12
	adc	(dir),y		; 71 83
				; ---
	adc	(*12),y		; 71 12
	adc	(*dir),y	; 71 83
				; ---
.if r65c02
	adc	(12)		; 72 12
	adc	(dir)		; 72 83
				; ---
	adc	(*12)		; 72 12
	adc	(*dir)		; 72 83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 25 12
	and	dir		; 25 83
	and	1234		; 2D 34 12
	and	ext		; 2D 22 81
				; ---
	and	*12		; 25 12
	and	*dir		; 25 83
				; ---
	and	,x		; 35 00
	and	12,x		; 35 12
	and	dir,x		; 35 83
	and	1234,x		; 3D 34 12
	and	ext,x		; 3D 22 81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35 83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39 83 00
	and	1234,y		; 39 34 12
	and	ext,y		; 39 22 81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39 83 00
				; ---
	and	(,x)		; 21 00
	and	(12,x)		; 21 12
	and	(dir,x)		; 21 83
				; ---
	and	(*,x)		; 21 00
	and	(*12,x)		; 21 12
	and	(*dir,x)	; 21 83
				; ---
	and	(12),y		; 31 12
	and	(dir),y		; 31 83
				; ---
	and	(*12),y		; 31 12
	and	(*dir),y	; 31 83
				; ---
.if	r65c02
	and	(12)		; 32 12
	and	(dir)		; 32 83
				; ---
	and	(*12)		; 32 12
	and	(*dir)		; 32 83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 06 12
	asl	dir		; 06 83
	asl	1234		; 0E 34 12
	asl	ext		; 0E 22 81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06 83
				; ---
	asl	,x		; 16 00
	asl	12,x		; 16 12
	asl	dir,x		; 16 83
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16 83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1E 22 81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F 83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F 83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 24 12
	bit	dir		; 24 83
	bit	1234		; 2C 34 12
	bit	ext		; 2C 22 81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24 83
				; ---
.if	r65c02
	bit	,x		; 34 00
	bit	12,x		; 34 12
	bit	dir,x		; 34 83
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3C 22 81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34 83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; C5 12
	cmp	dir		; C5 83
	cmp	1234		; CD 34 12
	cmp	ext		; CD 22 81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5 83
				; ---
	cmp	,x		; D5 00
	cmp	12,x		; D5 12
	cmp	dir,x		; D5 83
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DD 22 81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5 83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9 83 00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9 22 81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9 83 00
				; ---
	cmp	(,x)		; C1 00
	cmp	(12,x)		; C1 12
	cmp	(dir,x)		; C1 83
				; ---
	cmp	(*,x)		; C1 00
	cmp	(*12,x)		; C1 12
	cmp	(*dir,x)	; C1 83
				; ---
	cmp	(12),y		; D1 12
	cmp	(dir),y		; D1 83
				; ---
	cmp	(*12),y		; D1 12
	cmp	(*dir),y	; D1 83
				; ---
.if	r65c02
	cmp	(12)		; D2 12
	cmp	(dir)		; D2 83
				; ---
	cmp	(*12)		; D2 12
	cmp	(*dir)		; D2 83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; E4 12
	cpx	dir		; E4 83
	cpx	1234		; EC 34 12
	cpx	ext		; EC 22 81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4 83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; C4 12
	cpy	dir		; C4 83
	cpy	1234		; CC 34 12
	cpy	ext		; CC 22 81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4 83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; C6 12
	dec	dir		; C6 83
	dec	1234		; CE 34 12
	dec	ext		; CE 22 81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6 83
				; ---
	dec	12,x		; D6 12
	dec	dir,x		; D6 83
	dec	1234,x		; DE 34 12
	dec	ext,x		; DE 22 81
				; ---
	dec	*12,x		; D6 12
	dec	*dir,x		; D6 83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 45 12
	eor	dir		; 45 83
	eor	1234		; 4D 34 12
	eor	ext		; 4D 22 81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45 83
				; ---
	eor	,x		; 55 00
	eor	12,x		; 55 12
	eor	dir,x		; 55 83
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5D 22 81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55 83
		; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59 83 00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59 22 81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59 83 00
				; ---
	eor	(12),y		; 51 12
	eor	(dir),y		; 51 83
				; ---
	eor	(*12),y		; 51 12
	eor	(*dir),y	; 51 83
				; ---
	eor	(,x)		; 41 00
	eor	(12,x)		; 41 12
	eor	(dir,x)		; 41 83
				; ---
	eor	(*,x)		; 41 00
	eor	(*12,x)		; 41 12
	eor	(*dir,x)	; 41 83
				; ---
.if	r65c02
	eor	(12)		; 52 12
	eor	(dir)		; 52 83
				; ---
	eor	(*12)		; 52 12
	eor	(*dir)		; 52 83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; E6 12
	inc	dir		; E6 83
	inc	1234		; EE 34 12
	inc	ext		; EE 22 81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6 83
				; ---
	inc	,x		; F6 00
	inc	12,x		; F6 12
	inc	dir,x		; F6 83
	inc	1234,x		; FE 34 12
	inc	ext,x		; FE 22 81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6 83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4C 83 00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4C 22 81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4C 83 00
				; ---
	jmp	(12)		; 6C 12 00
	jmp	(dir)		; 6C 83 00
	jmp	(1234)		; 6C 34 12
	jmp	(ext)		; 6C 22 81
				; ---
	jmp	(*12)		; 6C 12 00
	jmp	(*dir)		; 6C 83 00
				; ---
.if	r65c02
	jmp	(1234,x)	; 7C 34 12
	jmp	(ext,x)		; 7C 22 81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20 83 00
	jsr	1234		; 20 34 12
	jsr	ext		; 20 22 81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20 83 00

	lda	#12		; A9 12
				; ---
	lda	12		; A5 12
	lda	dir		; A5 83
	lda	1234		; AD 34 12
	lda	ext		; AD 22 81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5 83
				; ---
	lda	,x		; B5 00
	lda	12,x		; B5 12
	lda	dir,x		; B5 83
	lda	1234,x		; BD 34 12
	lda	ext,x		; BD 22 81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5 83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9 83 00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9 22 81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9 83 00
				; ---
	lda	(,x)		; A1 00
	lda	(12,x)		; A1 12
	lda	(dir,x)		; A1 83
				; ---
	lda	(*,x)		; A1 00
	lda	(*12,x)		; A1 12
	lda	(*dir,x)	; A1 83
				; ---
	lda	(12),y		; B1 12
	lda	(dir),y		; B1 83
				; ---
	lda	(*12),y		; B1 12
	lda	(*dir),y	; B1 83
				; ---
.if	r65c02
	lda	(12)		; B2 12
	lda	(dir)		; B2 83
				; ---
	lda	(*12)		; B2 12
	lda	(*dir)		; B2 83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; A6 12
	ldx	dir		; A6 83
	ldx	1234		; AE 34 12
	ldx	ext		; AE 22 81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6 83
				; ---
	ldx	,y		; B6 00
	ldx	12,y		; B6 12
	ldx	dir,y		; B6 83
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BE 22 81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6 83

	ldy	#12		; A0 12
				; ---
	ldy	12		; A4 12
	ldy	dir		; A4 83
	ldy	1234		; AC 34 12
	ldy	ext		; AC 22 81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4 83
				; ---
	ldy	,x		; B4 00
	ldy	12,x		; B4 12
	ldy	dir,x		; B4 83
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BC 22 81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4 83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 46 12
	lsr	dir		; 46 83
	lsr	1234		; 4E 34 12
	lsr	ext		; 4E 22 81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46 83
				; ---
	lsr	,x		; 56 00
	lsr	12,x		; 56 12
	lsr	dir,x		; 56 83
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5E 22 81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56 83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 05 12
	ora	dir		; 05 83
	ora	1234		; 0D 34 12
	ora	ext		; 0D 22 81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05 83
				; ---
	ora	,x		; 15 00
	ora	12,x		; 15 12
	ora	dir,x		; 15 83
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1D 22 81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15 83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19 83 00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19 22 81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19 83 00
				; ---
	ora	(,x)		; 01 00
	ora	(12,x)		; 01 12
	ora	(dir,x)		; 01 83
				; ---
	ora	(*,x)		; 01 00
	ora	(*12,x)		; 01 12
	ora	(*dir,x)	; 01 83
				; ---
	ora	(12),y		; 11 12
	ora	(dir),y		; 11 83
				; ---
	ora	(*12),y		; 11 12
	ora	(*dir),y	; 11 83
				; ---
.if	r65c02
	ora	(12)		; 12 12
	ora	(dir)		; 12 83
				; ---
	ora	(*12)		; 12 12
	ora	(*dir)		; 12 83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07 83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 26 12
	rol	dir		; 26 83
	rol	1234		; 2E 34 12
	rol	ext		; 2E 22 81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26 83
				; ---
	rol	,x		; 36 00
	rol	12,x		; 36 12
	rol	dir,x		; 36 83
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3E 22 81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36 83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 66 12
	ror	dir		; 66 83
	ror	1234		; 6E 34 12
	ror	ext		; 6E 22 81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66 83
				; ---
	ror	,x		; 76 00
	ror	12,x		; 76 12
	ror	dir,x		; 76 83
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7E 22 81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76 83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; E5 12
	sbc	dir		; E5 83
	sbc	1234		; ED 34 12
	sbc	ext		; ED 22 81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5 83
				; ---
	sbc	,x		; F5 00
	sbc	12,x		; F5 12
	sbc	dir,x		; F5 83
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FD 22 81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5 83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9 83 00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9 22 81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9 83 00
				; ---
	sbc	(12,x)		; E1 12
	sbc	(dir,x)		; E1 83
				; ---
	sbc	(*,x)		; E1 00
	sbc	(*12,x)		; E1 12
	sbc	(*dir,x)	; E1 83
				; ---
	sbc	(12),y		; F1 12
	sbc	(dir),y		; F1 83
				; ---
	sbc	(*12),y		; F1 12
	sbc	(*dir),y	; F1 83
				; ---
.if	r65c02
	sbc	(12)		; F2 12
	sbc	(dir)		; F2 83
				; ---
	sbc	(*12)		; F2 12
	sbc	(*dir)		; F2 83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87 83
.endif

; 	sta	#12		; Illegal
				; ---
	sta	12		; 85 12
	sta	dir		; 85 83
	sta	1234		; 8D 34 12
	sta	ext		; 8D 22 81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85 83
				; ---
	sta	,x		; 95 00
	sta	12,x		; 95 12
	sta	dir,x		; 95 83
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9D 22 81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95 83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99 83 00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99 22 81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99 83 00
				; ---
	sta	(,x)		; 81 00
	sta	(12,x)		; 81 12
	sta	(dir,x)		; 81 83
				; ---
	sta	(*,x)		; 81 00
	sta	(*12,x)		; 81 12
	sta	(*dir,x)	; 81 83
				; ---
	sta	(12),y		; 91 12
	sta	(dir),y		; 91 83
				; ---
	sta	(*12),y		; 91 12
	sta	(*dir),y	; 91 83
				; ---
.if	r65c02
	sta	(12)		; 92 12
	sta	(dir)		; 92 83
				; ---
	sta	(*12)		; 92 12
	sta	(*dir)		; 92 83
.endif

	stx	12		; 86 12
	stx	dir		; 86 83
	stx	1234		; 8E 34 12
	stx	ext		; 8E 22 81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86 83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96 83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96 83

	sty	12		; 84 12
	sty	dir		; 84 83
	sty	1234		; 8C 34 12
	sty	ext		; 8C 22 81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84 83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94 83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94 83

.if	r65c02
	stz	12		; 64 12
	stz	dir		; 64 83
	stz	1234		; 9C 34 12
	stz	ext		; 9C 22 81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64 83
				; ---
	stz	,x		; 74 00
	stz	12,x		; 74 12
	stz	dir,x		; 74 83
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9E 22 81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74 83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 14 12
	trb	dir		; 14 83
	trb	1234		; 1C 34 12
	trb	ext		; 1C 22 81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14 83

	tsb	12		; 04 12
	tsb	dir		; 04 83
	tsb	1234		; 0C 34 12
	tsb	ext		; 0C 22 81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04 83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

;
; External Parameters
;
	.define		dir	"0x0083 + dirx"
	.define		ext	"0x8122 + extx"

XP_E:	adc	#12		; 69 12
				; ---
	adc	12		; 65 12
	adc	dir		; 6Dr83s00
	adc	1234		; 6D 34 12
	adc	ext		; 6Dr22s81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65*83
				; ---
	adc	,x		; 75 00
	adc	12,x		; 75 12
	adc	dir,x		; 7Dr83s00
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7Dr22s81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75*83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79r83s00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79r22s81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79r83s00
				; ---
	adc	(,x)		; 61 00
	adc	(12,x)		; 61 12
	adc	(dir,x)		; 61*83
				; ---
	adc	(*,x)		; 61 00
	adc	(*12,x)		; 61 12
	adc	(*dir,x)	; 61*83
				; ---
	adc	(12),y		; 71 12
	adc	(dir),y		; 71*83
				; ---
	adc	(*12),y		; 71 12
	adc	(*dir),y	; 71*83
				; ---
.if r65c02
	adc	(12)		; 72 12
	adc	(dir)		; 72*83
				; ---
	adc	(*12)		; 72 12
	adc	(*dir)		; 72*83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 25 12
	and	dir		; 2Dr83s00
	and	1234		; 2D 34 12
	and	ext		; 2Dr22s81
				; ---
	and	*12		; 25 12
	and	*dir		; 25*83
				; ---
	and	12,x		; 35 12
	and	dir,x		; 3Dr83s00
	and	1234,x		; 3D 34 12
	and	ext,x		; 3Dr22s81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35*83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39r83s00
	and	1234,y		; 39 34 12
	and	ext,y		; 39r22s81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39r83s00
				; ---
	and	(,x)		; 21 00
	and	(12,x)		; 21 12
	and	(dir,x)		; 21*83
				; ---
	and	(*,x)		; 21 00
	and	(*12,x)		; 21 12
	and	(*dir,x)	; 21*83
				; ---
	and	(12),y		; 31 12
	and	(dir),y		; 31*83
				; ---
	and	(*12),y		; 31 12
	and	(*dir),y	; 31*83
				; ---
.if	r65c02
	and	(12)		; 32 12
	and	(dir)		; 32*83
				; ---
	and	(*12)		; 32 12
	and	(*dir)		; 32*83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 06 12
	asl	dir		; 0Er83s00
	asl	1234		; 0E 34 12
	asl	ext		; 0Er22s81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06*83
				; ---
	asl	,x		; 16 00
	asl	12,x		; 16 12
	asl	dir,x		; 1Er83s00
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16*83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1Er22s81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F*83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F*83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 24 12
	bit	dir		; 2Cr83s00
	bit	1234		; 2C 34 12
	bit	ext		; 2Cr22s81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24*83
				; ---
.if	r65c02
	bit	,x		; 34 00
	bit	12,x		; 34 12
	bit	dir,x		; 3Cr83s00
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3Cr22s81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34*83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; C5 12
	cmp	dir		; CDr83s00
	cmp	1234		; CD 34 12
	cmp	ext		; CDr22s81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5*83
				; ---
	cmp	,x		; D5 00
	cmp	12,x		; D5 12
	cmp	dir,x		; DDr83s00
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DDr22s81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5*83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9r83s00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9r22s81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9r83s00
				; ---
	cmp	(,x)		; C1 00
	cmp	(12,x)		; C1 12
	cmp	(dir,x)		; C1*83
				; ---
	cmp	(*12,x)		; C1 12
	cmp	(*dir,x)	; C1*83
				; ---
	cmp	(12),y		; D1 12
	cmp	(dir),y		; D1*83
				; ---
	cmp	(*12),y		; D1 12
	cmp	(*dir),y	; D1*83
				; ---
.if	r65c02
	cmp	(12)		; D2 12
	cmp	(dir)		; D2*83
				; ---
	cmp	(*12)		; D2 12
	cmp	(*dir)		; D2*83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; E4 12
	cpx	dir		; ECr83s00
	cpx	1234		; EC 34 12
	cpx	ext		; ECr22s81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4*83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; C4 12
	cpy	dir		; CCr83s00
	cpy	1234		; CC 34 12
	cpy	ext		; CCr22s81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4*83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; C6 12
	dec	dir		; CEr83s00
	dec	1234		; CE 34 12
	dec	ext		; CEr22s81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6*83
				; ---
	dec	,x		; D6 00
	dec	12,x		; D6 12
	dec	dir,x		; DEr83s00
	dec	1234,x		; DE 34 12
	dec	ext,x		; DEr22s81
				; ---
	dec	*,x		; D6 00
	dec	*12,x		; D6 12
	dec	*dir,x		; D6*83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 45 12
	eor	dir		; 4Dr83s00
	eor	1234		; 4D 34 12
	eor	ext		; 4Dr22s81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45*83
				; ---
	eor	,x		; 55 00
	eor	12,x		; 55 12
	eor	dir,x		; 5Dr83s00
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5Dr22s81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55*83
				; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59r83s00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59r22s81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59r83s00
				; ---
	eor	(12),y		; 51 12
	eor	(dir),y		; 51*83
				; ---
	eor	(*12),y		; 51 12
	eor	(*dir),y	; 51*83
				; ---
	eor	(,x)		; 41 00
	eor	(12,x)		; 41 12
	eor	(dir,x)		; 41*83
				; ---
	eor	(*,x)		; 41 00
	eor	(*12,x)		; 41 12
	eor	(*dir,x)	; 41*83
				; ---
.if	r65c02
	eor	(12)		; 52 12
	eor	(dir)		; 52*83
				; ---
	eor	(*12)		; 52 12
	eor	(*dir)		; 52*83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; E6 12
	inc	dir		; EEr83s00
	inc	1234		; EE 34 12
	inc	ext		; EEr22s81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6*83
				; ---
	inc	,x		; F6 00
	inc	12,x		; F6 12
	inc	dir,x		; FEr83s00
	inc	1234,x		; FE 34 12
	inc	ext,x		; FEr22s81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6*83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4Cr83s00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4Cr22s81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4Cr83s00
				; ---
	jmp	(12)		; 6C 12 00
	jmp	(dir)		; 6Cr83s00
	jmp	(1234)		; 6C 34 12
	jmp	(ext)		; 6Cr22s81
		; ---
	jmp	(*12)		; 6C 12 00
	jmp	(*dir)		; 6Cr83s00
				; ---
.if	r65c02
	jmp	(1234,x)	; 7C 34 12
	jmp	(ext,x)		; 7Cr22s81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20r83s00
	jsr	1234		; 20 34 12
	jsr	ext		; 20r22s81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20r83s00

	lda	#12		; A9 12
				; ---
	lda	12		; A5 12
	lda	dir		; ADr83s00
	lda	1234		; AD 34 12
	lda	ext		; ADr22s81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5*83
				; ---
	lda	,x		; B5 00
	lda	12,x		; B5 12
	lda	dir,x		; BDr83s00
	lda	1234,x		; BD 34 12
	lda	ext,x		; BDr22s81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5*83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9r83s00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9r22s81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9r83s00
				; ---
	lda	(,x)		; A1 00
	lda	(12,x)		; A1 12
	lda	(dir,x)		; A1*83
				; ---
	lda	(*,x)		; A1 00
	lda	(*12,x)		; A1 12
	lda	(*dir,x)	; A1*83
				; ---
	lda	(12),y		; B1 12
	lda	(dir),y		; B1*83
				; ---
	lda	(*12),y		; B1 12
	lda	(*dir),y	; B1*83
				; ---
.if	r65c02
	lda	(12)		; B2 12
	lda	(dir)		; B2*83
				; ---
	lda	(*12)		; B2 12
	lda	(*dir)		; B2*83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; A6 12
	ldx	dir		; AEr83s00
	ldx	1234		; AE 34 12
	ldx	ext		; AEr22s81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6*83
				; ---
	ldx	,y		; B6 00
	ldx	12,y		; B6 12
	ldx	dir,y		; BEr83s00
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BEr22s81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6*83

	ldy	#12		; A0 12
				; ---
	ldy	12		; A4 12
	ldy	dir		; ACr83s00
	ldy	1234		; AC 34 12
	ldy	ext		; ACr22s81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4*83
				; ---
	ldy	,x		; B4 00
	ldy	12,x		; B4 12
	ldy	dir,x		; BCr83s00
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BCr22s81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4*83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 46 12
	lsr	dir		; 4Er83s00
	lsr	1234		; 4E 34 12
	lsr	ext		; 4Er22s81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46*83
				; ---
	lsr	,x		; 56 00
	lsr	12,x		; 56 12
	lsr	dir,x		; 5Er83s00
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5Er22s81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56*83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 05 12
	ora	dir		; 0Dr83s00
	ora	1234		; 0D 34 12
	ora	ext		; 0Dr22s81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05*83
				; ---
	ora	,x		; 15 00
	ora	12,x		; 15 12
	ora	dir,x		; 1Dr83s00
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1Dr22s81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15*83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19r83s00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19r22s81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19r83s00
				; ---
	ora	(,x)		; 01 00
	ora	(12,x)		; 01 12
	ora	(dir,x)		; 01*83
				; ---
	ora	(*,x)		; 01 00
	ora	(*12,x)		; 01 12
	ora	(*dir,x)	; 01*83
				; ---
	ora	(12),y		; 11 12
	ora	(dir),y		; 11*83
				; ---
	ora	(*12),y		; 11 12
	ora	(*dir),y	; 11*83
				; ---
.if	r65c02
	ora	(12)		; 12 12
	ora	(dir)		; 12*83
				; ---
	ora	(*12)		; 12 12
	ora	(*dir)		; 12*83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07*83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 26 12
	rol	dir		; 2Er83s00
	rol	1234		; 2E 34 12
	rol	ext		; 2Er22s81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26*83
				; ---
	rol	,x		; 36 00
	rol	12,x		; 36 12
	rol	dir,x		; 3Er83s00
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3Er22s81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36*83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 66 12
	ror	dir		; 6Er83s00
	ror	1234		; 6E 34 12
	ror	ext		; 6Er22s81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66*83
				; ---
	ror	,x		; 76 00
	ror	12,x		; 76 12
	ror	dir,x		; 7Er83s00
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7Er22s81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76*83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; E5 12
	sbc	dir		; EDr83s00
	sbc	1234		; ED 34 12
	sbc	ext		; EDr22s81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5*83
				; ---
	sbc	,x		; F5 00
	sbc	12,x		; F5 12
	sbc	dir,x		; FDr83s00
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FDr22s81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5*83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9r83s00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9r22s81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9r83s00
				; ---
	sbc	(,x)		; E1 00
	sbc	(12,x)		; E1 12
	sbc	(dir,x)		; E1*83
				; ---
	sbc	(*,x)		; E1 00
	sbc	(*12,x)		; E1 12
	sbc	(*dir,x)	; E1*83
				; ---
	sbc	(12),y		; F1 12
	sbc	(dir),y		; F1*83
				; ---
	sbc	(*12),y		; F1 12
	sbc	(*dir),y	; F1*83
				; ---
.if	r65c02
	sbc	(12)		; F2 12
	sbc	(dir)		; F2*83
				; ---
	sbc	(*12)		; F2 12
	sbc	(*dir)		; F2*83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87*83
.endif

; 	sta	#12
				; ---
	sta	12		; 85 12
	sta	dir		; 8Dr83s00
	sta	1234		; 8D 34 12
	sta	ext		; 8Dr22s81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85*83
				; ---
	sta	,x		; 95 00
	sta	12,x		; 95 12
	sta	dir,x		; 9Dr83s00
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9Dr22s81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95*83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99r83s00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99r22s81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99r83s00
				; ---
	sta	(,x)		; 81 00
	sta	(12,x)		; 81 12
	sta	(dir,x)		; 81*83
				; ---
	sta	(*,x)		; 81 00
	sta	(*12,x)		; 81 12
	sta	(*dir,x)	; 81*83
				; ---
	sta	(12),y		; 91 12
	sta	(dir),y		; 91*83
				; ---
	sta	(*12),y		; 91 12
	sta	(*dir),y	; 91*83
				; ---
.if	r65c02
	sta	(12)		; 92 12
	sta	(dir)		; 92*83
				; ---
	sta	(*12)		; 92 12
	sta	(*dir)		; 92*83
.endif

	stx	12		; 86 12
	stx	dir		; 8Er83s00
	stx	1234		; 8E 34 12
	stx	ext		; 8Er22s81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86*83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96*83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96*83

	sty	12		; 84 12
	sty	dir		; 8Cr83s00
	sty	1234		; 8C 34 12
	sty	ext		; 8Cr22s81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84*83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94*83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94*83

.if	r65c02
	stz	12		; 64 12
	stz	dir		; 9Cr83s00
	stz	1234		; 9C 34 12
	stz	ext		; 9Cr22s81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64*83
				; ---
	stz	,x		; 74 00
	stz	12,x		; 74 12
	stz	dir,x		; 9Er83s00
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9Er22s81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74*83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 14 12
	trb	dir		; 1Cr83s00
	trb	1234		; 1C 34 12
	trb	ext		; 1Cr22s81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14*83

	tsb	12		; 04 12
	tsb	dir		; 0Cr83s00
	tsb	1234		; 0C 34 12
	tsb	ext		; 0Cr22s81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04*83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

	.nval	val,.
	. = . - val

;
; All documented 650X, 651X, 65F11, 65F12, 65C00/21, 65C29,
; 65C02, 65C102, and 65C112 instructions with proper AS6500 syntax.
;

	; Disable Automatic Direct Page For Constants
	.dsabl	(autodpcnst)

 	; Set Default Radix
	.radix x

	r6500	= 0
	r65f11	= 0
	r65c00	= 0
	r65c02	= 1

;	Enable 6500 Core Instructions Only
.if r6500
	.r6500
.endif

;	Enable 6500 Core Plus 65F11 / 65F12 Instructions
.if r65f11
	.r65f11
.endif

;	Enable 6500 Core Plus 65C00/21 and 65C29 Instructions
.if r65c00
	.r65c00
.endif

;	Enable 6500 Core Plus 65C02, 65C102, and 65C112 Instructions
.if r65c02
	.r65c02
.endif

;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Instruction Test With Brackets - [ ]
;
;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Local Parameters
;
	.define		dir	"0x0083"
	.define		ext	"0x8122"

LB_D:
	adc	#12		; 69 12
				; ---
	adc	12		; 6D 12 00
	adc	dir		; 6D 83 00
	adc	1234		; 6D 34 12
	adc	ext		; 6D 22 81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65 83
				; ---
	adc	,x		; 7D 00 00
	adc	12,x		; 7D 12 00
	adc	dir,x		; 7D 83 00
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7D 22 81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75 83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79 83 00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79 22 81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79 83 00
				; ---
	adc	[,x]		; 61 00
	adc	[12,x]		; 61 12
	adc	[dir,x]		; 61 83
				; ---
	adc	[*,x]		; 61 00
	adc	[*12,x]		; 61 12
	adc	[*dir,x]	; 61 83
				; ---
	adc	[12],y		; 71 12
	adc	[dir],y		; 71 83
				; ---
	adc	[*12],y		; 71 12
	adc	[*dir],y	; 71 83
				; ---
.if r65c02
	adc	[12]		; 72 12
	adc	[dir]		; 72 83
				; ---
	adc	[*12]		; 72 12
	adc	[*dir]		; 72 83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 2D 12 00
	and	dir		; 2D 83 00
	and	1234		; 2D 34 12
	and	ext		; 2D 22 81
				; ---
	and	*12		; 25 12
	and	*dir		; 25 83
				; ---
	and	,x		; 3D 00 00
	and	12,x		; 3D 12 00
	and	dir,x		; 3D 83 00
	and	1234,x		; 3D 34 12
	and	ext,x		; 3D 22 81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35 83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39 83 00
	and	1234,y		; 39 34 12
	and	ext,y		; 39 22 81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39 83 00
				; ---
	and	[,x]		; 21 00
	and	[12,x]		; 21 12
	and	[dir,x]		; 21 83
				; ---
	and	[*,x]		; 21 00
	and	[*12,x]		; 21 12
	and	[*dir,x]	; 21 83
				; ---
	and	[12],y		; 31 12
	and	[dir],y		; 31 83
				; ---
	and	[*12],y		; 31 12
	and	[*dir],y	; 31 83
				; ---
.if	r65c02
	and	[12]		; 32 12
	and	[dir]		; 32 83
				; ---
	and	[*12]		; 32 12
	and	[*dir]		; 32 83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 0E 12 00
	asl	dir		; 0E 83 00
	asl	1234		; 0E 34 12
	asl	ext		; 0E 22 81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06 83
				; ---
	asl	,x		; 1E 00 00
	asl	12,x		; 1E 12 00
	asl	dir,x		; 1E 83 00
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16 83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1E 22 81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F 83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F 83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 2C 12 00
	bit	dir		; 2C 83 00
	bit	1234		; 2C 34 12
	bit	ext		; 2C 22 81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24 83
				; ---
.if	r65c02
	bit	,x		; 3C 00 00
	bit	12,x		; 3C 12 00
	bit	dir,x		; 3C 83 00
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3C 22 81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34 83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; CD 12 00
	cmp	dir		; CD 83 00
	cmp	1234		; CD 34 12
	cmp	ext		; CD 22 81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5 83
				; ---
	cmp	,x		; DD 00 00
	cmp	12,x		; DD 12 00
	cmp	dir,x		; DD 83 00
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DD 22 81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5 83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9 83 00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9 22 81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9 83 00
				; ---
	cmp	[,x]		; C1 00
	cmp	[12,x]		; C1 12
	cmp	[dir,x]		; C1 83
				; ---
	cmp	[*,x]		; C1 00
	cmp	[*12,x]		; C1 12
	cmp	[*dir,x]	; C1 83
				; ---
	cmp	[12],y		; D1 12
	cmp	[dir],y		; D1 83
				; ---
	cmp	[*12],y		; D1 12
	cmp	[*dir],y	; D1 83
				; ---
.if	r65c02
	cmp	[12]		; D2 12
	cmp	[dir]		; D2 83
				; ---
	cmp	[*12]		; D2 12
	cmp	[*dir]		; D2 83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; EC 12 00
	cpx	dir		; EC 83 00
	cpx	1234		; EC 34 12
	cpx	ext		; EC 22 81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4 83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; CC 12 00
	cpy	dir		; CC 83 00
	cpy	1234		; CC 34 12
	cpy	ext		; CC 22 81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4 83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; CE 12 00
	dec	dir		; CE 83 00
	dec	1234		; CE 34 12
	dec	ext		; CE 22 81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6 83
				; ---
	dec	12,x		; DE 12 00
	dec	dir,x		; DE 83 00
	dec	1234,x		; DE 34 12
	dec	ext,x		; DE 22 81
				; ---
	dec	*12,x		; D6 12
	dec	*dir,x		; D6 83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 4D 12 00
	eor	dir		; 4D 83 00
	eor	1234		; 4D 34 12
	eor	ext		; 4D 22 81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45 83
				; ---
	eor	,x		; 5D 00 00
	eor	12,x		; 5D 12 00
	eor	dir,x		; 5D 83 00
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5D 22 81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55 83
		; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59 83 00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59 22 81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59 83 00
				; ---
	eor	[12],y		; 51 12
	eor	[dir],y		; 51 83
				; ---
	eor	[*12],y		; 51 12
	eor	[*dir],y	; 51 83
				; ---
	eor	[,x]		; 41 00
	eor	[12,x]		; 41 12
	eor	[dir,x]		; 41 83
				; ---
	eor	[*,x]		; 41 00
	eor	[*12,x]		; 41 12
	eor	[*dir,x]	; 41 83
				; ---
.if	r65c02
	eor	[12]		; 52 12
	eor	[dir]		; 52 83
				; ---
	eor	[*12]		; 52 12
	eor	[*dir]		; 52 83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; EE 12 00
	inc	dir		; EE 83 00
	inc	1234		; EE 34 12
	inc	ext		; EE 22 81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6 83
				; ---
	inc	,x		; FE 00 00
	inc	12,x		; FE 12 00
	inc	dir,x		; FE 83 00
	inc	1234,x		; FE 34 12
	inc	ext,x		; FE 22 81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6 83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4C 83 00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4C 22 81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4C 83 00
				; ---
	jmp	[12]		; 6C 12 00
	jmp	[dir]		; 6C 83 00
	jmp	[1234]		; 6C 34 12
	jmp	[ext]		; 6C 22 81
				; ---
	jmp	[*12]		; 6C 12 00
	jmp	[*dir]		; 6C 83 00
				; ---
.if	r65c02
	jmp	[1234,x]	; 7C 34 12
	jmp	[ext,x]		; 7C 22 81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20 83 00
	jsr	1234		; 20 34 12
	jsr	ext		; 20 22 81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20 83 00

	lda	#12		; A9 12
				; ---
	lda	12		; AD 12 00
	lda	dir		; AD 83 00
	lda	1234		; AD 34 12
	lda	ext		; AD 22 81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5 83
				; ---
	lda	,x		; BD 00 00
	lda	12,x		; BD 12 00
	lda	dir,x		; BD 83 00
	lda	1234,x		; BD 34 12
	lda	ext,x		; BD 22 81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5 83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9 83 00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9 22 81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9 83 00
				; ---
	lda	[,x]		; A1 00
	lda	[12,x]		; A1 12
	lda	[dir,x]		; A1 83
				; ---
	lda	[*,x]		; A1 00
	lda	[*12,x]		; A1 12
	lda	[*dir,x]	; A1 83
				; ---
	lda	[12],y		; B1 12
	lda	[dir],y		; B1 83
				; ---
	lda	[*12],y		; B1 12
	lda	[*dir],y	; B1 83
				; ---
.if	r65c02
	lda	[12]		; B2 12
	lda	[dir]		; B2 83
				; ---
	lda	[*12]		; B2 12
	lda	[*dir]		; B2 83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; AE 12 00
	ldx	dir		; AE 83 00
	ldx	1234		; AE 34 12
	ldx	ext		; AE 22 81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6 83
				; ---
	ldx	,y		; BE 00 00
	ldx	12,y		; BE 12 00
	ldx	dir,y		; BE 83 00
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BE 22 81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6 83

	ldy	#12		; A0 12
				; ---
	ldy	12		; AC 12 00
	ldy	dir		; AC 83 00
	ldy	1234		; AC 34 12
	ldy	ext		; AC 22 81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4 83
				; ---
	ldy	,x		; BC 00 00
	ldy	12,x		; BC 12 00
	ldy	dir,x		; BC 83 00
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BC 22 81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4 83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 4E 12 00
	lsr	dir		; 4E 83 00
	lsr	1234		; 4E 34 12
	lsr	ext		; 4E 22 81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46 83
				; ---
	lsr	,x		; 5E 00 00
	lsr	12,x		; 5E 12 00
	lsr	dir,x		; 5E 83 00
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5E 22 81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56 83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 0D 12 00
	ora	dir		; 0D 83 00
	ora	1234		; 0D 34 12
	ora	ext		; 0D 22 81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05 83
				; ---
	ora	,x		; 1D 00 00
	ora	12,x		; 1D 12 00
	ora	dir,x		; 1D 83 00
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1D 22 81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15 83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19 83 00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19 22 81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19 83 00
				; ---
	ora	[,x]		; 01 00
	ora	[12,x]		; 01 12
	ora	[dir,x]		; 01 83
				; ---
	ora	[*,x]		; 01 00
	ora	[*12,x]		; 01 12
	ora	[*dir,x]	; 01 83
				; ---
	ora	[12],y		; 11 12
	ora	[dir],y		; 11 83
				; ---
	ora	[*12],y		; 11 12
	ora	[*dir],y	; 11 83
				; ---
.if	r65c02
	ora	[12]		; 12 12
	ora	[dir]		; 12 83
				; ---
	ora	[*12]		; 12 12
	ora	[*dir]		; 12 83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07 83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 2E 12 00
	rol	dir		; 2E 83 00
	rol	1234		; 2E 34 12
	rol	ext		; 2E 22 81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26 83
				; ---
	rol	,x		; 3E 00 00
	rol	12,x		; 3E 12 00
	rol	dir,x		; 3E 83 00
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3E 22 81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36 83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 6E 12 00
	ror	dir		; 6E 83 00
	ror	1234		; 6E 34 12
	ror	ext		; 6E 22 81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66 83
				; ---
	ror	,x		; 7E 00 00
	ror	12,x		; 7E 12 00
	ror	dir,x		; 7E 83 00
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7E 22 81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76 83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; ED 12 00
	sbc	dir		; ED 83 00
	sbc	1234		; ED 34 12
	sbc	ext		; ED 22 81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5 83
				; ---
	sbc	,x		; FD 00 00
	sbc	12,x		; FD 12 00
	sbc	dir,x		; FD 83 00
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FD 22 81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5 83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9 83 00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9 22 81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9 83 00
				; ---
	sbc	[12,x]		; E1 12
	sbc	[dir,x]		; E1 83
				; ---
	sbc	[*,x]		; E1 00
	sbc	[*12,x]		; E1 12
	sbc	[*dir,x]	; E1 83
				; ---
	sbc	[12],y		; F1 12
	sbc	[dir],y		; F1 83
				; ---
	sbc	[*12],y		; F1 12
	sbc	[*dir],y	; F1 83
				; ---
.if	r65c02
	sbc	[12]		; F2 12
	sbc	[dir]		; F2 83
				; ---
	sbc	[*12]		; F2 12
	sbc	[*dir]		; F2 83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87 83
.endif

; 	sta	#12		; Illegal
				; ---
	sta	12		; 8D 12 00
	sta	dir		; 8D 83 00
	sta	1234		; 8D 34 12
	sta	ext		; 8D 22 81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85 83
				; ---
	sta	,x		; 9D 00 00
	sta	12,x		; 9D 12 00
	sta	dir,x		; 9D 83 00
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9D 22 81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95 83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99 83 00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99 22 81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99 83 00
				; ---
	sta	[,x]		; 81 00
	sta	[12,x]		; 81 12
	sta	[dir,x]		; 81 83
				; ---
	sta	[*,x]		; 81 00
	sta	[*12,x]		; 81 12
	sta	[*dir,x]	; 81 83
				; ---
	sta	[12],y		; 91 12
	sta	[dir],y		; 91 83
				; ---
	sta	[*12],y		; 91 12
	sta	[*dir],y	; 91 83
				; ---
.if	r65c02
	sta	[12]		; 92 12
	sta	[dir]		; 92 83
				; ---
	sta	[*12]		; 92 12
	sta	[*dir]		; 92 83
.endif

	stx	12		; 8E 12 00
	stx	dir		; 8E 83 00
	stx	1234		; 8E 34 12
	stx	ext		; 8E 22 81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86 83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96 83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96 83

	sty	12		; 8C 12 00
	sty	dir		; 8C 83 00
	sty	1234		; 8C 34 12
	sty	ext		; 8C 22 81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84 83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94 83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94 83

.if	r65c02
	stz	12		; 9C 12 00
	stz	dir		; 9C 83 00
	stz	1234		; 9C 34 12
	stz	ext		; 9C 22 81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64 83
				; ---
	stz	,x		; 9E 00 00
	stz	12,x		; 9E 12 00
	stz	dir,x		; 9E 83 00
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9E 22 81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74 83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 1C 12 00
	trb	dir		; 1C 83 00
	trb	1234		; 1C 34 12
	trb	ext		; 1C 22 81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14 83

	tsb	12		; 0C 12 00
	tsb	dir		; 0C 83 00
	tsb	1234		; 0C 34 12
	tsb	ext		; 0C 22 81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04 83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

;
; External Parameters
;
	.define		dir	"0x0083 + dirx"
	.define		ext	"0x8122 + extx"

XB_D:
	adc	#12		; 69 12
				; ---
	adc	12		; 6D 12 00
	adc	dir		; 6Dr83s00
	adc	1234		; 6D 34 12
	adc	ext		; 6Dr22s81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65*83
				; ---
	adc	,x		; 7D 00 00
	adc	12,x		; 7D 12 00
	adc	dir,x		; 7Dr83s00
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7Dr22s81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75*83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79r83s00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79r22s81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79r83s00
				; ---
	adc	[,x]		; 61 00
	adc	[12,x]		; 61 12
	adc	[dir,x]		; 61*83
				; ---
	adc	[*,x]		; 61 00
	adc	[*12,x]		; 61 12
	adc	[*dir,x]	; 61*83
				; ---
	adc	[12],y		; 71 12
	adc	[dir],y		; 71*83
				; ---
	adc	[*12],y		; 71 12
	adc	[*dir],y	; 71*83
				; ---
.if r65c02
	adc	[12]		; 72 12
	adc	[dir]		; 72*83
				; ---
	adc	[*12]		; 72 12
	adc	[*dir]		; 72*83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 2D 12 00
	and	dir		; 2Dr83s00
	and	1234		; 2D 34 12
	and	ext		; 2Dr22s81
				; ---
	and	*12		; 25 12
	and	*dir		; 25*83
				; ---
	and	12,x		; 3D 12 00
	and	dir,x		; 3Dr83s00
	and	1234,x		; 3D 34 12
	and	ext,x		; 3Dr22s81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35*83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39r83s00
	and	1234,y		; 39 34 12
	and	ext,y		; 39r22s81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39r83s00
				; ---
	and	[,x]		; 21 00
	and	[12,x]		; 21 12
	and	[dir,x]		; 21*83
				; ---
	and	[*,x]		; 21 00
	and	[*12,x]		; 21 12
	and	[*dir,x]	; 21*83
				; ---
	and	[12],y		; 31 12
	and	[dir],y		; 31*83
				; ---
	and	[*12],y		; 31 12
	and	[*dir],y	; 31*83
				; ---
.if	r65c02
	and	[12]		; 32 12
	and	[dir]		; 32*83
				; ---
	and	[*12]		; 32 12
	and	[*dir]		; 32*83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 0E 12 00
	asl	dir		; 0Er83s00
	asl	1234		; 0E 34 12
	asl	ext		; 0Er22s81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06*83
				; ---
	asl	,x		; 1E 00 00
	asl	12,x		; 1E 12 00
	asl	dir,x		; 1Er83s00
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16*83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1Er22s81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F*83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F*83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 2C 12 00
	bit	dir		; 2Cr83s00
	bit	1234		; 2C 34 12
	bit	ext		; 2Cr22s81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24*83
				; ---
.if	r65c02
	bit	,x		; 3C 00 00
	bit	12,x		; 3C 12 00
	bit	dir,x		; 3Cr83s00
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3Cr22s81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34*83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; CD 12 00
	cmp	dir		; CDr83s00
	cmp	1234		; CD 34 12
	cmp	ext		; CDr22s81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5*83
				; ---
	cmp	,x		; DD 00 00
	cmp	12,x		; DD 12 00
	cmp	dir,x		; DDr83s00
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DDr22s81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5*83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9r83s00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9r22s81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9r83s00
				; ---
	cmp	[,x]		; C1 00
	cmp	[12,x]		; C1 12
	cmp	[dir,x]		; C1*83
				; ---
	cmp	[*12,x]		; C1 12
	cmp	[*dir,x]	; C1*83
				; ---
	cmp	[12],y		; D1 12
	cmp	[dir],y		; D1*83
				; ---
	cmp	[*12],y		; D1 12
	cmp	[*dir],y	; D1*83
				; ---
.if	r65c02
	cmp	[12]		; D2 12
	cmp	[dir]		; D2*83
				; ---
	cmp	[*12]		; D2 12
	cmp	[*dir]		; D2*83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; EC 12 00
	cpx	dir		; ECr83s00
	cpx	1234		; EC 34 12
	cpx	ext		; ECr22s81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4*83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; CC 12 00
	cpy	dir		; CCr83s00
	cpy	1234		; CC 34 12
	cpy	ext		; CCr22s81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4*83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; CE 12 00
	dec	dir		; CEr83s00
	dec	1234		; CE 34 12
	dec	ext		; CEr22s81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6*83
				; ---
	dec	,x		; DE 00 00
	dec	12,x		; DE 12 00
	dec	dir,x		; DEr83s00
	dec	1234,x		; DE 34 12
	dec	ext,x		; DEr22s81
				; ---
	dec	*,x		; D6 00
	dec	*12,x		; D6 12
	dec	*dir,x		; D6*83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 4D 12 00
	eor	dir		; 4Dr83s00
	eor	1234		; 4D 34 12
	eor	ext		; 4Dr22s81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45*83
				; ---
	eor	,x		; 5D 00 00
	eor	12,x		; 5D 12 00
	eor	dir,x		; 5Dr83s00
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5Dr22s81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55*83
				; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59r83s00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59r22s81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59r83s00
				; ---
	eor	[12],y		; 51 12
	eor	[dir],y		; 51*83
				; ---
	eor	[*12],y		; 51 12
	eor	[*dir],y	; 51*83
				; ---
	eor	[,x]		; 41 00
	eor	[12,x]		; 41 12
	eor	[dir,x]		; 41*83
				; ---
	eor	[*,x]		; 41 00
	eor	[*12,x]		; 41 12
	eor	[*dir,x]	; 41*83
				; ---
.if	r65c02
	eor	[12]		; 52 12
	eor	[dir]		; 52*83
				; ---
	eor	[*12]		; 52 12
	eor	[*dir]		; 52*83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; EE 12 00
	inc	dir		; EEr83s00
	inc	1234		; EE 34 12
	inc	ext		; EEr22s81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6*83
				; ---
	inc	,x		; FE 00 00
	inc	12,x		; FE 12 00
	inc	dir,x		; FEr83s00
	inc	1234,x		; FE 34 12
	inc	ext,x		; FEr22s81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6*83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4Cr83s00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4Cr22s81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4Cr83s00
				; ---
	jmp	[12]		; 6C 12 00
	jmp	[dir]		; 6Cr83s00
	jmp	[1234]		; 6C 34 12
	jmp	[ext]		; 6Cr22s81
				; ---
	jmp	[*12]		; 6C 12 00
	jmp	[*dir]		; 6Cr83s00
				; ---
.if	r65c02
	jmp	[1234,x]	; 7C 34 12
	jmp	[ext,x]		; 7Cr22s81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20r83s00
	jsr	1234		; 20 34 12
	jsr	ext		; 20r22s81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20r83s00

	lda	#12		; A9 12
				; ---
	lda	12		; AD 12 00
	lda	dir		; ADr83s00
	lda	1234		; AD 34 12
	lda	ext		; ADr22s81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5*83
				; ---
	lda	,x		; BD 00 00
	lda	12,x		; BD 12 00
	lda	dir,x		; BDr83s00
	lda	1234,x		; BD 34 12
	lda	ext,x		; BDr22s81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5*83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9r83s00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9r22s81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9r83s00
				; ---
	lda	[,x]		; A1 00
	lda	[12,x]		; A1 12
	lda	[dir,x]		; A1*83
				; ---
	lda	[*,x]		; A1 00
	lda	[*12,x]		; A1 12
	lda	[*dir,x]	; A1*83
				; ---
	lda	[12],y		; B1 12
	lda	[dir],y		; B1*83
				; ---
	lda	[*12],y		; B1 12
	lda	[*dir],y	; B1*83
				; ---
.if	r65c02
	lda	[12]		; B2 12
	lda	[dir]		; B2*83
				; ---
	lda	[*12]		; B2 12
	lda	[*dir]		; B2*83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; AE 12 00
	ldx	dir		; AEr83s00
	ldx	1234		; AE 34 12
	ldx	ext		; AEr22s81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6*83
				; ---
	ldx	,y		; BE 00 00
	ldx	12,y		; BE 12 00
	ldx	dir,y		; BEr83s00
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BEr22s81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6*83

	ldy	#12		; A0 12
				; ---
	ldy	12		; AC 12 00
	ldy	dir		; ACr83s00
	ldy	1234		; AC 34 12
	ldy	ext		; ACr22s81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4*83
				; ---
	ldy	,x		; BC 00 00
	ldy	12,x		; BC 12 00
	ldy	dir,x		; BCr83s00
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BCr22s81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4*83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 4E 12 00
	lsr	dir		; 4Er83s00
	lsr	1234		; 4E 34 12
	lsr	ext		; 4Er22s81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46*83
				; ---
	lsr	,x		; 5E 00 00
	lsr	12,x		; 5E 12 00
	lsr	dir,x		; 5Er83s00
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5Er22s81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56*83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 0D 12 00
	ora	dir		; 0Dr83s00
	ora	1234		; 0D 34 12
	ora	ext		; 0Dr22s81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05*83
				; ---
	ora	,x		; 1D 00 00
	ora	12,x		; 1D 12 00
	ora	dir,x		; 1Dr83s00
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1Dr22s81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15*83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19r83s00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19r22s81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19r83s00
				; ---
	ora	[,x]		; 01 00
	ora	[12,x]		; 01 12
	ora	[dir,x]		; 01*83
				; ---
	ora	[*,x]		; 01 00
	ora	[*12,x]		; 01 12
	ora	[*dir,x]	; 01*83
				; ---
	ora	[12],y		; 11 12
	ora	[dir],y		; 11*83
				; ---
	ora	[*12],y		; 11 12
	ora	[*dir],y	; 11*83
				; ---
.if	r65c02
	ora	[12]		; 12 12
	ora	[dir]		; 12*83
				; ---
	ora	[*12]		; 12 12
	ora	[*dir]		; 12*83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07*83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 2E 12 00
	rol	dir		; 2Er83s00
	rol	1234		; 2E 34 12
	rol	ext		; 2Er22s81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26*83
				; ---
	rol	,x		; 3E 00 00
	rol	12,x		; 3E 12 00
	rol	dir,x		; 3Er83s00
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3Er22s81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36*83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 6E 12 00
	ror	dir		; 6Er83s00
	ror	1234		; 6E 34 12
	ror	ext		; 6Er22s81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66*83
				; ---
	ror	,x		; 7E 00 00
	ror	12,x		; 7E 12 00
	ror	dir,x		; 7Er83s00
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7Er22s81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76*83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; ED 12 00
	sbc	dir		; EDr83s00
	sbc	1234		; ED 34 12
	sbc	ext		; EDr22s81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5*83
				; ---
	sbc	,x		; FD 00 00
	sbc	12,x		; FD 12 00
	sbc	dir,x		; FDr83s00
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FDr22s81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5*83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9r83s00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9r22s81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9r83s00
				; ---
	sbc	[,x]		; E1 00
	sbc	[12,x]		; E1 12
	sbc	[dir,x]		; E1*83
				; ---
	sbc	[*,x]		; E1 00
	sbc	[*12,x]		; E1 12
	sbc	[*dir,x]	; E1*83
				; ---
	sbc	[12],y		; F1 12
	sbc	[dir],y		; F1*83
				; ---
	sbc	[*12],y		; F1 12
	sbc	[*dir],y	; F1*83
				; ---
.if	r65c02
	sbc	[12]		; F2 12
	sbc	[dir]		; F2*83
				; ---
	sbc	[*12]		; F2 12
	sbc	[*dir]		; F2*83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87*83
.endif

; 	sta	#12
				; ---
	sta	12		; 8D 12 00
	sta	dir		; 8Dr83s00
	sta	1234		; 8D 34 12
	sta	ext		; 8Dr22s81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85*83
				; ---
	sta	,x		; 9D 00 00
	sta	12,x		; 9D 12 00
	sta	dir,x		; 9Dr83s00
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9Dr22s81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95*83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99r83s00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99r22s81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99r83s00
				; ---
	sta	[,x]		; 81 00
	sta	[12,x]		; 81 12
	sta	[dir,x]		; 81*83
				; ---
	sta	[*,x]		; 81 00
	sta	[*12,x]		; 81 12
	sta	[*dir,x]	; 81*83
				; ---
	sta	[12],y		; 91 12
	sta	[dir],y		; 91*83
				; ---
	sta	[*12],y		; 91 12
	sta	[*dir],y	; 91*83
				; ---
.if	r65c02
	sta	[12]		; 92 12
	sta	[dir]		; 92*83
				; ---
	sta	[*12]		; 92 12
	sta	[*dir]		; 92*83
.endif

	stx	12		; 8E 12 00
	stx	dir		; 8Er83s00
	stx	1234		; 8E 34 12
	stx	ext		; 8Er22s81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86*83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96*83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96*83

	sty	12		; 8C 12 00
	sty	dir		; 8Cr83s00
	sty	1234		; 8C 34 12
	sty	ext		; 8Cr22s81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84*83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94*83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94*83

.if	r65c02
	stz	12		; 9C 12 00
	stz	dir		; 9Cr83s00
	stz	1234		; 9C 34 12
	stz	ext		; 9Cr22s81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64*83
				; ---
	stz	,x		; 9E 00 00
	stz	12,x		; 9E 12 00
	stz	dir,x		; 9Er83s00
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9Er22s81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74*83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 1C 12 00
	trb	dir		; 1Cr83s00
	trb	1234		; 1C 34 12
	trb	ext		; 1Cr22s81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14*83

	tsb	12		; 0C 12 00
	tsb	dir		; 0Cr83s00
	tsb	1234		; 0C 34 12
	tsb	ext		; 0Cr22s81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04*83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Instruction Test With Parenthesis - ( )
;
;*****-----*****-----*****-----*****-----*****-----*****-----*****
;
; Local Parameters
;
	.define		dir	"0x0083"
	.define		ext	"0x8122"

LP_D:	adc	#12		; 69 12
				; ---
	adc	12		; 6D 12 00
	adc	dir		; 6D 83 00
	adc	1234		; 6D 34 12
	adc	ext		; 6D 22 81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65 83
				; ---
	adc	,x		; 7D 00 00
	adc	12,x		; 7D 12 00
	adc	dir,x		; 7D 83 00
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7D 22 81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75 83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79 83 00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79 22 81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79 83 00
				; ---
	adc	(,x)		; 61 00
	adc	(12,x)		; 61 12
	adc	(dir,x)		; 61 83
				; ---
	adc	(*,x)		; 61 00
	adc	(*12,x)		; 61 12
	adc	(*dir,x)	; 61 83
				; ---
	adc	(12),y		; 71 12
	adc	(dir),y		; 71 83
				; ---
	adc	(*12),y		; 71 12
	adc	(*dir),y	; 71 83
				; ---
.if r65c02
	adc	(12)		; 72 12
	adc	(dir)		; 72 83
				; ---
	adc	(*12)		; 72 12
	adc	(*dir)		; 72 83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 2D 12 00
	and	dir		; 2D 83 00
	and	1234		; 2D 34 12
	and	ext		; 2D 22 81
				; ---
	and	*12		; 25 12
	and	*dir		; 25 83
				; ---
	and	,x		; 3D 00 00
	and	12,x		; 3D 12 00
	and	dir,x		; 3D 83 00
	and	1234,x		; 3D 34 12
	and	ext,x		; 3D 22 81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35 83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39 83 00
	and	1234,y		; 39 34 12
	and	ext,y		; 39 22 81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39 83 00
				; ---
	and	(,x)		; 21 00
	and	(12,x)		; 21 12
	and	(dir,x)		; 21 83
				; ---
	and	(*,x)		; 21 00
	and	(*12,x)		; 21 12
	and	(*dir,x)	; 21 83
				; ---
	and	(12),y		; 31 12
	and	(dir),y		; 31 83
				; ---
	and	(*12),y		; 31 12
	and	(*dir),y	; 31 83
				; ---
.if	r65c02
	and	(12)		; 32 12
	and	(dir)		; 32 83
				; ---
	and	(*12)		; 32 12
	and	(*dir)		; 32 83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 0E 12 00
	asl	dir		; 0E 83 00
	asl	1234		; 0E 34 12
	asl	ext		; 0E 22 81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06 83
				; ---
	asl	,x		; 1E 00 00
	asl	12,x		; 1E 12 00
	asl	dir,x		; 1E 83 00
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16 83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1E 22 81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F 83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F 83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 2C 12 00
	bit	dir		; 2C 83 00
	bit	1234		; 2C 34 12
	bit	ext		; 2C 22 81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24 83
				; ---
.if	r65c02
	bit	,x		; 3C 00 00
	bit	12,x		; 3C 12 00
	bit	dir,x		; 3C 83 00
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3C 22 81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34 83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; CD 12 00
	cmp	dir		; CD 83 00
	cmp	1234		; CD 34 12
	cmp	ext		; CD 22 81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5 83
				; ---
	cmp	,x		; DD 00 00
	cmp	12,x		; DD 12 00
	cmp	dir,x		; DD 83 00
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DD 22 81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5 83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9 83 00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9 22 81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9 83 00
				; ---
	cmp	(,x)		; C1 00
	cmp	(12,x)		; C1 12
	cmp	(dir,x)		; C1 83
				; ---
	cmp	(*,x)		; C1 00
	cmp	(*12,x)		; C1 12
	cmp	(*dir,x)	; C1 83
				; ---
	cmp	(12),y		; D1 12
	cmp	(dir),y		; D1 83
				; ---
	cmp	(*12),y		; D1 12
	cmp	(*dir),y	; D1 83
				; ---
.if	r65c02
	cmp	(12)		; D2 12
	cmp	(dir)		; D2 83
				; ---
	cmp	(*12)		; D2 12
	cmp	(*dir)		; D2 83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; EC 12 00
	cpx	dir		; EC 83 00
	cpx	1234		; EC 34 12
	cpx	ext		; EC 22 81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4 83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; CC 12 00
	cpy	dir		; CC 83 00
	cpy	1234		; CC 34 12
	cpy	ext		; CC 22 81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4 83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; CE 12 00
	dec	dir		; CE 83 00
	dec	1234		; CE 34 12
	dec	ext		; CE 22 81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6 83
				; ---
	dec	12,x		; DE 12 00
	dec	dir,x		; DE 83 00
	dec	1234,x		; DE 34 12
	dec	ext,x		; DE 22 81
				; ---
	dec	*12,x		; D6 12
	dec	*dir,x		; D6 83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 4D 12 00
	eor	dir		; 4D 83 00
	eor	1234		; 4D 34 12
	eor	ext		; 4D 22 81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45 83
				; ---
	eor	,x		; 5D 00 00
	eor	12,x		; 5D 12 00
	eor	dir,x		; 5D 83 00
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5D 22 81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55 83
		; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59 83 00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59 22 81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59 83 00
				; ---
	eor	(12),y		; 51 12
	eor	(dir),y		; 51 83
				; ---
	eor	(*12),y		; 51 12
	eor	(*dir),y	; 51 83
				; ---
	eor	(,x)		; 41 00
	eor	(12,x)		; 41 12
	eor	(dir,x)		; 41 83
				; ---
	eor	(*,x)		; 41 00
	eor	(*12,x)		; 41 12
	eor	(*dir,x)	; 41 83
				; ---
.if	r65c02
	eor	(12)		; 52 12
	eor	(dir)		; 52 83
				; ---
	eor	(*12)		; 52 12
	eor	(*dir)		; 52 83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; EE 12 00
	inc	dir		; EE 83 00
	inc	1234		; EE 34 12
	inc	ext		; EE 22 81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6 83
				; ---
	inc	,x		; FE 00 00
	inc	12,x		; FE 12 00
	inc	dir,x		; FE 83 00
	inc	1234,x		; FE 34 12
	inc	ext,x		; FE 22 81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6 83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4C 83 00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4C 22 81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4C 83 00
				; ---
	jmp	(12)		; 6C 12 00
	jmp	(dir)		; 6C 83 00
	jmp	(1234)		; 6C 34 12
	jmp	(ext)		; 6C 22 81
				; ---
	jmp	(*12)		; 6C 12 00
	jmp	(*dir)		; 6C 83 00
				; ---
.if	r65c02
	jmp	(1234,x)	; 7C 34 12
	jmp	(ext,x)		; 7C 22 81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20 83 00
	jsr	1234		; 20 34 12
	jsr	ext		; 20 22 81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20 83 00

	lda	#12		; A9 12
				; ---
	lda	12		; AD 12 00
	lda	dir		; AD 83 00
	lda	1234		; AD 34 12
	lda	ext		; AD 22 81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5 83
				; ---
	lda	,x		; BD 00 00
	lda	12,x		; BD 12 00
	lda	dir,x		; BD 83 00
	lda	1234,x		; BD 34 12
	lda	ext,x		; BD 22 81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5 83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9 83 00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9 22 81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9 83 00
				; ---
	lda	(,x)		; A1 00
	lda	(12,x)		; A1 12
	lda	(dir,x)		; A1 83
				; ---
	lda	(*,x)		; A1 00
	lda	(*12,x)		; A1 12
	lda	(*dir,x)	; A1 83
				; ---
	lda	(12),y		; B1 12
	lda	(dir),y		; B1 83
				; ---
	lda	(*12),y		; B1 12
	lda	(*dir),y	; B1 83
				; ---
.if	r65c02
	lda	(12)		; B2 12
	lda	(dir)		; B2 83
				; ---
	lda	(*12)		; B2 12
	lda	(*dir)		; B2 83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; AE 12 00
	ldx	dir		; AE 83 00
	ldx	1234		; AE 34 12
	ldx	ext		; AE 22 81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6 83
				; ---
	ldx	,y		; BE 00 00
	ldx	12,y		; BE 12 00
	ldx	dir,y		; BE 83 00
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BE 22 81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6 83

	ldy	#12		; A0 12
				; ---
	ldy	12		; AC 12 00
	ldy	dir		; AC 83 00
	ldy	1234		; AC 34 12
	ldy	ext		; AC 22 81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4 83
				; ---
	ldy	,x		; BC 00 00
	ldy	12,x		; BC 12 00
	ldy	dir,x		; BC 83 00
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BC 22 81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4 83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 4E 12 00
	lsr	dir		; 4E 83 00
	lsr	1234		; 4E 34 12
	lsr	ext		; 4E 22 81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46 83
				; ---
	lsr	,x		; 5E 00 00
	lsr	12,x		; 5E 12 00
	lsr	dir,x		; 5E 83 00
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5E 22 81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56 83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 0D 12 00
	ora	dir		; 0D 83 00
	ora	1234		; 0D 34 12
	ora	ext		; 0D 22 81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05 83
				; ---
	ora	,x		; 1D 00 00
	ora	12,x		; 1D 12 00
	ora	dir,x		; 1D 83 00
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1D 22 81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15 83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19 83 00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19 22 81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19 83 00
				; ---
	ora	(,x)		; 01 00
	ora	(12,x)		; 01 12
	ora	(dir,x)		; 01 83
				; ---
	ora	(*,x)		; 01 00
	ora	(*12,x)		; 01 12
	ora	(*dir,x)	; 01 83
				; ---
	ora	(12),y		; 11 12
	ora	(dir),y		; 11 83
				; ---
	ora	(*12),y		; 11 12
	ora	(*dir),y	; 11 83
				; ---
.if	r65c02
	ora	(12)		; 12 12
	ora	(dir)		; 12 83
				; ---
	ora	(*12)		; 12 12
	ora	(*dir)		; 12 83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07 83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 2E 12 00
	rol	dir		; 2E 83 00
	rol	1234		; 2E 34 12
	rol	ext		; 2E 22 81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26 83
				; ---
	rol	,x		; 3E 00 00
	rol	12,x		; 3E 12 00
	rol	dir,x		; 3E 83 00
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3E 22 81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36 83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 6E 12 00
	ror	dir		; 6E 83 00
	ror	1234		; 6E 34 12
	ror	ext		; 6E 22 81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66 83
				; ---
	ror	,x		; 7E 00 00
	ror	12,x		; 7E 12 00
	ror	dir,x		; 7E 83 00
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7E 22 81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76 83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; ED 12 00
	sbc	dir		; ED 83 00
	sbc	1234		; ED 34 12
	sbc	ext		; ED 22 81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5 83
				; ---
	sbc	,x		; FD 00 00
	sbc	12,x		; FD 12 00
	sbc	dir,x		; FD 83 00
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FD 22 81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5 83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9 83 00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9 22 81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9 83 00
				; ---
	sbc	(12,x)		; E1 12
	sbc	(dir,x)		; E1 83
				; ---
	sbc	(*,x)		; E1 00
	sbc	(*12,x)		; E1 12
	sbc	(*dir,x)	; E1 83
				; ---
	sbc	(12),y		; F1 12
	sbc	(dir),y		; F1 83
				; ---
	sbc	(*12),y		; F1 12
	sbc	(*dir),y	; F1 83
				; ---
.if	r65c02
	sbc	(12)		; F2 12
	sbc	(dir)		; F2 83
				; ---
	sbc	(*12)		; F2 12
	sbc	(*dir)		; F2 83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87 83
.endif

; 	sta	#12		; Illegal
				; ---
	sta	12		; 8D 12 00
	sta	dir		; 8D 83 00
	sta	1234		; 8D 34 12
	sta	ext		; 8D 22 81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85 83
				; ---
	sta	,x		; 9D 00 00
	sta	12,x		; 9D 12 00
	sta	dir,x		; 9D 83 00
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9D 22 81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95 83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99 83 00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99 22 81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99 83 00
				; ---
	sta	(,x)		; 81 00
	sta	(12,x)		; 81 12
	sta	(dir,x)		; 81 83
				; ---
	sta	(*,x)		; 81 00
	sta	(*12,x)		; 81 12
	sta	(*dir,x)	; 81 83
				; ---
	sta	(12),y		; 91 12
	sta	(dir),y		; 91 83
				; ---
	sta	(*12),y		; 91 12
	sta	(*dir),y	; 91 83
				; ---
.if	r65c02
	sta	(12)		; 92 12
	sta	(dir)		; 92 83
				; ---
	sta	(*12)		; 92 12
	sta	(*dir)		; 92 83
.endif

	stx	12		; 8E 12 00
	stx	dir		; 8E 83 00
	stx	1234		; 8E 34 12
	stx	ext		; 8E 22 81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86 83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96 83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96 83

	sty	12		; 8C 12 00
	sty	dir		; 8C 83 00
	sty	1234		; 8C 34 12
	sty	ext		; 8C 22 81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84 83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94 83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94 83

.if	r65c02
	stz	12		; 9C 12 00
	stz	dir		; 9C 83 00
	stz	1234		; 9C 34 12
	stz	ext		; 9C 22 81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64 83
				; ---
	stz	,x		; 9E 00 00
	stz	12,x		; 9E 12 00
	stz	dir,x		; 9E 83 00
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9E 22 81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74 83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 1C 12 00
	trb	dir		; 1C 83 00
	trb	1234		; 1C 34 12
	trb	ext		; 1C 22 81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14 83

	tsb	12		; 0C 12 00
	tsb	dir		; 0C 83 00
	tsb	1234		; 0C 34 12
	tsb	ext		; 0C 22 81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04 83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

;
; External Parameters
;
	.define		dir	"0x0083 + dirx"
	.define		ext	"0x8122 + extx"

XP_D:	adc	#12		; 69 12
				; ---
	adc	12		; 6D 12 00
	adc	dir		; 6Dr83s00
	adc	1234		; 6D 34 12
	adc	ext		; 6Dr22s81
				; ---
	adc	*12		; 65 12
	adc	*dir		; 65*83
				; ---
	adc	,x		; 7D 00 00
	adc	12,x		; 7D 12 00
	adc	dir,x		; 7Dr83s00
	adc	1234,x		; 7D 34 12
	adc	ext,x		; 7Dr22s81
				; ---
	adc	*,x		; 75 00
	adc	*12,x		; 75 12
	adc	*dir,x		; 75*83
				; ---
	adc	,y		; 79 00 00
	adc	12,y		; 79 12 00
	adc	dir,y		; 79r83s00
	adc	1234,y		; 79 34 12
	adc	ext,y		; 79r22s81
				; ---
	adc	*,y		; 79 00 00
	adc	*12,y		; 79 12 00
	adc	*dir,y		; 79r83s00
				; ---
	adc	(,x)		; 61 00
	adc	(12,x)		; 61 12
	adc	(dir,x)		; 61*83
				; ---
	adc	(*,x)		; 61 00
	adc	(*12,x)		; 61 12
	adc	(*dir,x)	; 61*83
				; ---
	adc	(12),y		; 71 12
	adc	(dir),y		; 71*83
				; ---
	adc	(*12),y		; 71 12
	adc	(*dir),y	; 71*83
				; ---
.if r65c02
	adc	(12)		; 72 12
	adc	(dir)		; 72*83
				; ---
	adc	(*12)		; 72 12
	adc	(*dir)		; 72*83
.endif

	and	#12		; 29 12
				; ---
	and	12		; 2D 12 00
	and	dir		; 2Dr83s00
	and	1234		; 2D 34 12
	and	ext		; 2Dr22s81
				; ---
	and	*12		; 25 12
	and	*dir		; 25*83
				; ---
	and	12,x		; 3D 12 00
	and	dir,x		; 3Dr83s00
	and	1234,x		; 3D 34 12
	and	ext,x		; 3Dr22s81
				; ---
	and	*,x		; 35 00
	and	*12,x		; 35 12
	and	*dir,x		; 35*83
				; ---
	and	,y		; 39 00 00
	and	12,y		; 39 12 00
	and	dir,y		; 39r83s00
	and	1234,y		; 39 34 12
	and	ext,y		; 39r22s81
				; ---
	and	*,y		; 39 00 00
	and	*12,y		; 39 12 00
	and	*dir,y		; 39r83s00
				; ---
	and	(,x)		; 21 00
	and	(12,x)		; 21 12
	and	(dir,x)		; 21*83
				; ---
	and	(*,x)		; 21 00
	and	(*12,x)		; 21 12
	and	(*dir,x)	; 21*83
				; ---
	and	(12),y		; 31 12
	and	(dir),y		; 31*83
				; ---
	and	(*12),y		; 31 12
	and	(*dir),y	; 31*83
				; ---
.if	r65c02
	and	(12)		; 32 12
	and	(dir)		; 32*83
				; ---
	and	(*12)		; 32 12
	and	(*dir)		; 32*83
.endif

	asl	a		; 0A
	asl			; 0A
				; ---
	asl	12		; 0E 12 00
	asl	dir		; 0Er83s00
	asl	1234		; 0E 34 12
	asl	ext		; 0Er22s81
				; ---
	asl	*12		; 06 12
	asl	*dir		; 06*83
				; ---
	asl	,x		; 1E 00 00
	asl	12,x		; 1E 12 00
	asl	dir,x		; 1Er83s00
				; ---
	asl	*,x		; 16 00
	asl	*12,x		; 16 12
	asl	*dir,x		; 16*83
				; ---
	asl	1234,x		; 1E 34 12
	asl	ext,x		; 1Er22s81

.if	r65f11+r65c00+r65c02
	bbr0	12,.		; 0F 12 FD
	bbr1	12,.		; 1F 12 FD
	bbr2	12,.		; 2F 12 FD
	bbr3	12,.		; 3F 12 FD
	bbr4	12,.		; 4F 12 FD
	bbr5	12,.		; 5F 12 FD
	bbr6	12,.		; 6F 12 FD
	bbr7	12,.		; 7F 12 FD

	bbs0	12,.		; 8F 12 FD
	bbs1	12,.		; 9F 12 FD
	bbs2	12,.		; AF 12 FD
	bbs3	12,.		; BF 12 FD
	bbs4	12,.		; CF 12 FD
	bbs5	12,.		; DF 12 FD
	bbs6	12,.		; EF 12 FD
	bbs7	12,.		; FF 12 FD

1$:	bbr0	12,2$		; 0F 12 00
2$:	bbr0	dir,1$		; 0F*83 FA

3$:	bbs0	*12,4$		; 8F 12 00
4$:	bbs0	*dir,3$		; 8F*83 FA
.endif

	bcc	.		; 90 FE

	bcs	.		; B0 FE

	beq	.		; F0 FE

.if	r65c02
	bit	#12		; 89 12
.endif
				; ---
	bit	12		; 2C 12 00
	bit	dir		; 2Cr83s00
	bit	1234		; 2C 34 12
	bit	ext		; 2Cr22s81
				; ---
	bit	*12		; 24 12
	bit	*dir		; 24*83
				; ---
.if	r65c02
	bit	,x		; 3C 00 00
	bit	12,x		; 3C 12 00
	bit	dir,x		; 3Cr83s00
	bit	1234,x		; 3C 34 12
	bit	ext,x		; 3Cr22s81
				; ---
	bit	*,x		; 34 00
	bit	*12,x		; 34 12
	bit	*dir,x		; 34*83
.endif

	bmi	.		; 30 FE

	bne	.		; D0 FE

	bpl	.		; 10 FE

.if	r65c00+r65c02
	bra	.		; 80 FE
.endif

	brk			; 00

	bvc	.		; 50 FE

	bvs	.		; 70 FE

	clc			; 18

	cld			; D8

	cli			; 58

	clv			; B8

	cmp	#12		; C9 12
				; ---
	cmp	12		; CD 12 00
	cmp	dir		; CDr83s00
	cmp	1234		; CD 34 12
	cmp	ext		; CDr22s81
				; ---
	cmp	*12		; C5 12
	cmp	*dir		; C5*83
				; ---
	cmp	,x		; DD 00 00
	cmp	12,x		; DD 12 00
	cmp	dir,x		; DDr83s00
	cmp	1234,x		; DD 34 12
	cmp	ext,x		; DDr22s81
				; ---
	cmp	*,x		; D5 00
	cmp	*12,x		; D5 12
	cmp	*dir,x		; D5*83
				; ---
	cmp	,y		; D9 00 00
	cmp	12,y		; D9 12 00
	cmp	dir,y		; D9r83s00
	cmp	1234,y		; D9 34 12
	cmp	ext,y		; D9r22s81
				; ---
	cmp	*,y		; D9 00 00
	cmp	*12,y		; D9 12 00
	cmp	*dir,y		; D9r83s00
				; ---
	cmp	(,x)		; C1 00
	cmp	(12,x)		; C1 12
	cmp	(dir,x)		; C1*83
				; ---
	cmp	(*12,x)		; C1 12
	cmp	(*dir,x)	; C1*83
				; ---
	cmp	(12),y		; D1 12
	cmp	(dir),y		; D1*83
				; ---
	cmp	(*12),y		; D1 12
	cmp	(*dir),y	; D1*83
				; ---
.if	r65c02
	cmp	(12)		; D2 12
	cmp	(dir)		; D2*83
				; ---
	cmp	(*12)		; D2 12
	cmp	(*dir)		; D2*83
.endif

	cpx	#12		; E0 12
				; ---
	cpx	12		; EC 12 00
	cpx	dir		; ECr83s00
	cpx	1234		; EC 34 12
	cpx	ext		; ECr22s81
				; ---
	cpx	*12		; E4 12
	cpx	*dir		; E4*83
				; ---
	cpy	#12		; C0 12
				; ---
	cpy	12		; CC 12 00
	cpy	dir		; CCr83s00
	cpy	1234		; CC 34 12
	cpy	ext		; CCr22s81
				; ---
	cpy	*12		; C4 12
	cpy	*dir		; C4*83

.if	r65c02
	dec	a		; 3A
	dec			; 3A
.endif
				; ---
	dec	12		; CE 12 00
	dec	dir		; CEr83s00
	dec	1234		; CE 34 12
	dec	ext		; CEr22s81
				; ---
	dec	*12		; C6 12
	dec	*dir		; C6*83
				; ---
	dec	,x		; DE 00 00
	dec	12,x		; DE 12 00
	dec	dir,x		; DEr83s00
	dec	1234,x		; DE 34 12
	dec	ext,x		; DEr22s81
				; ---
	dec	*,x		; D6 00
	dec	*12,x		; D6 12
	dec	*dir,x		; D6*83

	dex			; CA

	dey			; 88

	eor	#12		; 49 12
				; ---
	eor	12		; 4D 12 00
	eor	dir		; 4Dr83s00
	eor	1234		; 4D 34 12
	eor	ext		; 4Dr22s81
				; ---
	eor	*12		; 45 12
	eor	*dir		; 45*83
				; ---
	eor	,x		; 5D 00 00
	eor	12,x		; 5D 12 00
	eor	dir,x		; 5Dr83s00
	eor	1234,x		; 5D 34 12
	eor	ext,x		; 5Dr22s81
				; ---
	eor	*,x		; 55 00
	eor	*12,x		; 55 12
	eor	*dir,x		; 55*83
				; ---
	eor	,y		; 59 00 00
	eor	12,y		; 59 12 00
	eor	dir,y		; 59r83s00
	eor	1234,y		; 59 34 12
	eor	ext,y		; 59r22s81
				; ---
	eor	*,y		; 59 00 00
	eor	*12,y		; 59 12 00
	eor	*dir,y		; 59r83s00
				; ---
	eor	(12),y		; 51 12
	eor	(dir),y		; 51*83
				; ---
	eor	(*12),y		; 51 12
	eor	(*dir),y	; 51*83
				; ---
	eor	(,x)		; 41 00
	eor	(12,x)		; 41 12
	eor	(dir,x)		; 41*83
				; ---
	eor	(*,x)		; 41 00
	eor	(*12,x)		; 41 12
	eor	(*dir,x)	; 41*83
				; ---
.if	r65c02
	eor	(12)		; 52 12
	eor	(dir)		; 52*83
				; ---
	eor	(*12)		; 52 12
	eor	(*dir)		; 52*83
.endif

.if	r65c02
	inc	a		; 1A
	inc			; 1A
.endif
				; ---
	inc	12		; EE 12 00
	inc	dir		; EEr83s00
	inc	1234		; EE 34 12
	inc	ext		; EEr22s81
				; ---
	inc	*12		; E6 12
	inc	*dir		; E6*83
				; ---
	inc	,x		; FE 00 00
	inc	12,x		; FE 12 00
	inc	dir,x		; FEr83s00
	inc	1234,x		; FE 34 12
	inc	ext,x		; FEr22s81
				; ---
	inc	*,x		; F6 00
	inc	*12,x		; F6 12
	inc	*dir,x		; F6*83

	inx			; E8

	iny			; C8

	jmp	12		; 4C 12 00
	jmp	dir		; 4Cr83s00
	jmp	1234		; 4C 34 12
	jmp	ext		; 4Cr22s81
				; ---
	jmp	*12		; 4C 12 00
	jmp	*dir		; 4Cr83s00
				; ---
	jmp	(12)		; 6C 12 00
	jmp	(dir)		; 6Cr83s00
	jmp	(1234)		; 6C 34 12
	jmp	(ext)		; 6Cr22s81
		; ---
	jmp	(*12)		; 6C 12 00
	jmp	(*dir)		; 6Cr83s00
				; ---
.if	r65c02
	jmp	(1234,x)	; 7C 34 12
	jmp	(ext,x)		; 7Cr22s81
.endif

	jsr	12		; 20 12 00
	jsr	dir		; 20r83s00
	jsr	1234		; 20 34 12
	jsr	ext		; 20r22s81
				; ---
	jsr	*12		; 20 12 00
	jsr	*dir		; 20r83s00

	lda	#12		; A9 12
				; ---
	lda	12		; AD 12 00
	lda	dir		; ADr83s00
	lda	1234		; AD 34 12
	lda	ext		; ADr22s81
				; ---
	lda	*12		; A5 12
	lda	*dir		; A5*83
				; ---
	lda	,x		; BD 00 00
	lda	12,x		; BD 12 00
	lda	dir,x		; BDr83s00
	lda	1234,x		; BD 34 12
	lda	ext,x		; BDr22s81
				; ---
	lda	*,x		; B5 00
	lda	*12,x		; B5 12
	lda	*dir,x		; B5*83
				; ---
	lda	,y		; B9 00 00
	lda	12,y		; B9 12 00
	lda	dir,y		; B9r83s00
	lda	1234,y		; B9 34 12
	lda	ext,y		; B9r22s81
				; ---
	lda	*,y		; B9 00 00
	lda	*12,y		; B9 12 00
	lda	*dir,y		; B9r83s00
				; ---
	lda	(,x)		; A1 00
	lda	(12,x)		; A1 12
	lda	(dir,x)		; A1*83
				; ---
	lda	(*,x)		; A1 00
	lda	(*12,x)		; A1 12
	lda	(*dir,x)	; A1*83
				; ---
	lda	(12),y		; B1 12
	lda	(dir),y		; B1*83
				; ---
	lda	(*12),y		; B1 12
	lda	(*dir),y	; B1*83
				; ---
.if	r65c02
	lda	(12)		; B2 12
	lda	(dir)		; B2*83
				; ---
	lda	(*12)		; B2 12
	lda	(*dir)		; B2*83
.endif

	ldx	#12		; A2 12
				; ---
	ldx	12		; AE 12 00
	ldx	dir		; AEr83s00
	ldx	1234		; AE 34 12
	ldx	ext		; AEr22s81
				; ---
	ldx	*12		; A6 12
	ldx	*dir		; A6*83
				; ---
	ldx	,y		; BE 00 00
	ldx	12,y		; BE 12 00
	ldx	dir,y		; BEr83s00
	ldx	1234,y		; BE 34 12
	ldx	ext,y		; BEr22s81
				; ---
	ldx	*,y		; B6 00
	ldx	*12,y		; B6 12
	ldx	*dir,y		; B6*83

	ldy	#12		; A0 12
				; ---
	ldy	12		; AC 12 00
	ldy	dir		; ACr83s00
	ldy	1234		; AC 34 12
	ldy	ext		; ACr22s81
				; ---
	ldy	*12		; A4 12
	ldy	*dir		; A4*83
				; ---
	ldy	,x		; BC 00 00
	ldy	12,x		; BC 12 00
	ldy	dir,x		; BCr83s00
	ldy	1234,x		; BC 34 12
	ldy	ext,x		; BCr22s81
				; ---
	ldy	*,x		; B4 00
	ldy	*12,x		; B4 12
	ldy	*dir,x		; B4*83

	lsr	a		; 4A
	lsr			; 4A
				; ---
	lsr	12		; 4E 12 00
	lsr	dir		; 4Er83s00
	lsr	1234		; 4E 34 12
	lsr	ext		; 4Er22s81
				; ---
	lsr	*12		; 46 12
	lsr	*dir		; 46*83
				; ---
	lsr	,x		; 5E 00 00
	lsr	12,x		; 5E 12 00
	lsr	dir,x		; 5Er83s00
	lsr	1234,x		; 5E 34 12
	lsr	ext,x		; 5Er22s81
				; ---
	lsr	*,x		; 56 00
	lsr	*12,x		; 56 12
	lsr	*dir,x		; 56*83

.if	r65c00
	mul			; 02
.endif

	nop			; EA

	ora	#12		; 09 12
				; ---
	ora	12		; 0D 12 00
	ora	dir		; 0Dr83s00
	ora	1234		; 0D 34 12
	ora	ext		; 0Dr22s81
				; ---
	ora	*12		; 05 12
	ora	*dir		; 05*83
				; ---
	ora	,x		; 1D 00 00
	ora	12,x		; 1D 12 00
	ora	dir,x		; 1Dr83s00
	ora	1234,x		; 1D 34 12
	ora	ext,x		; 1Dr22s81
				; ---
	ora	*,x		; 15 00
	ora	*12,x		; 15 12
	ora	*dir,x		; 15*83
				; ---
	ora	,y		; 19 00 00
	ora	12,y		; 19 12 00
	ora	dir,y		; 19r83s00
	ora	1234,y		; 19 34 12
	ora	ext,y		; 19r22s81
				; ---
	ora	*,y		; 19 00 00
	ora	*12,y		; 19 12 00
	ora	*dir,y		; 19r83s00
				; ---
	ora	(,x)		; 01 00
	ora	(12,x)		; 01 12
	ora	(dir,x)		; 01*83
				; ---
	ora	(*,x)		; 01 00
	ora	(*12,x)		; 01 12
	ora	(*dir,x)	; 01*83
				; ---
	ora	(12),y		; 11 12
	ora	(dir),y		; 11*83
				; ---
	ora	(*12),y		; 11 12
	ora	(*dir),y	; 11*83
				; ---
.if	r65c02
	ora	(12)		; 12 12
	ora	(dir)		; 12*83
				; ---
	ora	(*12)		; 12 12
	ora	(*dir)		; 12*83
.endif

	pha			; 48

	php			; 08

.if	r65c00+r65c02
	phx			; DA

	phy			; 5A
.endif

	pla			; 68

	plp			; 28

.if	r65c00+r65c02
	plx			; FA

	ply			; 7A
.endif

.if	r65f11+r65c00+r65c02
	rmb0	12		; 07 12
	rmb1	12		; 17 12
	rmb2	12		; 27 12
	rmb3	12		; 37 12
	rmb4	12		; 47 12
	rmb5	12		; 57 12
	rmb6	12		; 67 12
	rmb7	12		; 77 12

	rmb0	*12		; 07 12
	rmb0	*dir		; 07*83
.endif

.if	r65c02
	rol	a		; 2A
	rol			; 2A
.endif
				; ---
	rol	12		; 2E 12 00
	rol	dir		; 2Er83s00
	rol	1234		; 2E 34 12
	rol	ext		; 2Er22s81
				; ---
	rol	*12		; 26 12
	rol	*dir		; 26*83
				; ---
	rol	,x		; 3E 00 00
	rol	12,x		; 3E 12 00
	rol	dir,x		; 3Er83s00
	rol	1234,x		; 3E 34 12
	rol	ext,x		; 3Er22s81
				; ---
	rol	*,x		; 36 00
	rol	*12,x		; 36 12
	rol	*dir,x		; 36*83

	ror	a		; 6A
	ror			; 6A
				; ---
	ror	12		; 6E 12 00
	ror	dir		; 6Er83s00
	ror	1234		; 6E 34 12
	ror	ext		; 6Er22s81
				; ---
	ror	*12		; 66 12
	ror	*dir		; 66*83
				; ---
	ror	,x		; 7E 00 00
	ror	12,x		; 7E 12 00
	ror	dir,x		; 7Er83s00
	ror	1234,x		; 7E 34 12
	ror	ext,x		; 7Er22s81
				; ---
	ror	*,x		; 76 00
	ror	*12,x		; 76 12
	ror	*dir,x		; 76*83

	rti			; 40

	rts			; 60

	sbc	#12		; E9 12
				; ---
	sbc	12		; ED 12 00
	sbc	dir		; EDr83s00
	sbc	1234		; ED 34 12
	sbc	ext		; EDr22s81
				; ---
	sbc	*12		; E5 12
	sbc	*dir		; E5*83
				; ---
	sbc	,x		; FD 00 00
	sbc	12,x		; FD 12 00
	sbc	dir,x		; FDr83s00
	sbc	1234,x		; FD 34 12
	sbc	ext,x		; FDr22s81
				; ---
	sbc	*,x		; F5 00
	sbc	*12,x		; F5 12
	sbc	*dir,x		; F5*83
				; ---
	sbc	,y		; F9 00 00
	sbc	12,y		; F9 12 00
	sbc	dir,y		; F9r83s00
	sbc	1234,y		; F9 34 12
	sbc	ext,y		; F9r22s81
				; ---
	sbc	*,y		; F9 00 00
	sbc	*12,y		; F9 12 00
	sbc	*dir,y		; F9r83s00
				; ---
	sbc	(,x)		; E1 00
	sbc	(12,x)		; E1 12
	sbc	(dir,x)		; E1*83
				; ---
	sbc	(*,x)		; E1 00
	sbc	(*12,x)		; E1 12
	sbc	(*dir,x)	; E1*83
				; ---
	sbc	(12),y		; F1 12
	sbc	(dir),y		; F1*83
				; ---
	sbc	(*12),y		; F1 12
	sbc	(*dir),y	; F1*83
				; ---
.if	r65c02
	sbc	(12)		; F2 12
	sbc	(dir)		; F2*83
				; ---
	sbc	(*12)		; F2 12
	sbc	(*dir)		; F2*83
.endif

	sec			; 38

	sed			; F8

	sei			; 78

.if	r65f11+r65c00+r65c02
	smb0	12		; 87 12
	smb1	12		; 97 12
	smb2	12		; A7 12
	smb3	12		; B7 12
	smb4	12		; C7 12
	smb5	12		; D7 12
	smb6	12		; E7 12
	smb7	12		; F7 12

	smb0	*12		; 87 12
	smb0	*dir		; 87*83
.endif

; 	sta	#12
				; ---
	sta	12		; 8D 12 00
	sta	dir		; 8Dr83s00
	sta	1234		; 8D 34 12
	sta	ext		; 8Dr22s81
				; ---
	sta	*12		; 85 12
	sta	*dir		; 85*83
				; ---
	sta	,x		; 9D 00 00
	sta	12,x		; 9D 12 00
	sta	dir,x		; 9Dr83s00
	sta	1234,x		; 9D 34 12
	sta	ext,x		; 9Dr22s81
				; ---
	sta	*,x		; 95 00
	sta	*12,x		; 95 12
	sta	*dir,x		; 95*83
				; ---
	sta	,y		; 99 00 00
	sta	12,y		; 99 12 00
	sta	dir,y		; 99r83s00
	sta	1234,y		; 99 34 12
	sta	ext,y		; 99r22s81
				; ---
	sta	*,y		; 99 00 00
	sta	*12,y		; 99 12 00
	sta	*dir,y		; 99r83s00
				; ---
	sta	(,x)		; 81 00
	sta	(12,x)		; 81 12
	sta	(dir,x)		; 81*83
				; ---
	sta	(*,x)		; 81 00
	sta	(*12,x)		; 81 12
	sta	(*dir,x)	; 81*83
				; ---
	sta	(12),y		; 91 12
	sta	(dir),y		; 91*83
				; ---
	sta	(*12),y		; 91 12
	sta	(*dir),y	; 91*83
				; ---
.if	r65c02
	sta	(12)		; 92 12
	sta	(dir)		; 92*83
				; ---
	sta	(*12)		; 92 12
	sta	(*dir)		; 92*83
.endif

	stx	12		; 8E 12 00
	stx	dir		; 8Er83s00
	stx	1234		; 8E 34 12
	stx	ext		; 8Er22s81
				; ---
	stx	*12		; 86 12
	stx	*dir		; 86*83
				; ---
	stx	,y		; 96 00
	stx	12,y		; 96 12
	stx	dir,y		; 96*83
				; ---
	stx	*,y		; 96 00
	stx	*12,y		; 96 12
	stx	*dir,y		; 96*83

	sty	12		; 8C 12 00
	sty	dir		; 8Cr83s00
	sty	1234		; 8C 34 12
	sty	ext		; 8Cr22s81
				; ---
	sty	*12		; 84 12
	sty	*dir		; 84*83
				; ---
	sty	,x		; 94 00
	sty	12,x		; 94 12
	sty	dir,x		; 94*83
				; ---
	sty	*,x		; 94 00
	sty	*12,x		; 94 12
	sty	*dir,x		; 94*83

.if	r65c02
	stz	12		; 9C 12 00
	stz	dir		; 9Cr83s00
	stz	1234		; 9C 34 12
	stz	ext		; 9Cr22s81
				; ---
	stz	*12		; 64 12
	stz	*dir		; 64*83
				; ---
	stz	,x		; 9E 00 00
	stz	12,x		; 9E 12 00
	stz	dir,x		; 9Er83s00
	stz	1234,x		; 9E 34 12
	stz	ext,x		; 9Er22s81
				; ---
	stz	*,x		; 74 00
	stz	*12,x		; 74 12
	stz	*dir,x		; 74*83
.endif

	tax			; AA

	tay			; A8

.if	r65c02
	trb	12		; 1C 12 00
	trb	dir		; 1Cr83s00
	trb	1234		; 1C 34 12
	trb	ext		; 1Cr22s81
				; ---
	trb	*12		; 14 12
	trb	*dir		; 14*83

	tsb	12		; 0C 12 00
	tsb	dir		; 0Cr83s00
	tsb	1234		; 0C 34 12
	tsb	ext		; 0Cr22s81
				; ---
	tsb	*12		; 04 12
	tsb	*dir		; 04*83
.endif

	tsx			; BA

	txa			; 8A

	txs			; 9A

	tya			; 98


	.undefine	dir
	.undefine	ext

	.end

