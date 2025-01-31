	.title	Test of GB assembler

	; Define The Parameters

	.globl	xn8
	.globl	xp8
	.globl	xa8
	.globl	xa16
	.globl	xd8
	.globl	xd16

	; Define Arguments

	.define		n8	"0x56"
	.define		p8	"0xFF56"
	.define		a8	"0xFF56"
	.define		a16	"0x3412"
	.define		d8	"0x20"
	.define		d16	"0x0584"

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; Sequential Assembled Code
	; From - https://gbdev.io/gb-opcodes/optables/
	;
	; Local Parameters
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	nop			; 00
	ld	bc,#d16		; 01 84 05
	ld	(bc),a		; 02
	inc	bc		; 03
	inc	b		; 04
	dec	b		; 05
	ld	b,#d8		; 06 20
	rlca			; 07
	ld	(a16),sp	; 08 12 34
	add	hl,bc		; 09
	ld	a,(bc)		; 0A
	dec	bc		; 0B
	inc	c		; 0C
	dec	c		; 0D
	ld	c,#d8		; 0E 20
	rrca			; 0F

	stop			; 10 00
	ld	de,#d16		; 11 84 05
	ld	(de),a		; 12
	inc	de		; 13
	inc	d		; 14
	dec	d		; 15
	ld	d,#d8		; 16 20
	rla			; 17
	jr	.		; 18 FE
	add	hl,de		; 19
	ld	a,(de)		; 1A
	dec	de		; 1B
	inc	e		; 1C
	dec	e		; 1D
	ld	e,#d8		; 1E 20
	rra			; 1F

	jr	nz,.		; 20 FE
	ld	hl,#d16		; 21 84 05
	ld	(hl+),a		; 22
	inc	hl		; 23
	inc	h		; 24
	dec	h		; 25
	ld	h,#d8		; 26 20
	daa			; 27
	jr	z,.		; 28 FE
	add	hl,hl		; 29
	ld	a,(hl+)		; 2A
	dec	hl		; 2B
	inc	l		; 2C
	dec	l		; 2D
	ld	l,#d8		; 2E 20
	cpl			; 2F

	jr	nc,.		; 30 FE
	ld	sp,#d16		; 31 84 05
	ld	(hl-),a		; 32
	inc	sp		; 33
	inc	(hl)		; 34
	dec	(hl)		; 35
	ld	(hl),#d8	; 36 20
	scf			; 37
	jr	c,.		; 38 FE
	add	hl,sp		; 39
	ld	a,(hl-)		; 3A
	dec	sp		; 3B
	inc	a		; 3C
	dec	a		; 3D
	ld	a,#d8		; 3E 20
	ccf			; 3F

	ld	b,b		; 40
	ld	b,c		; 41
	ld	b,d		; 42
	ld	b,e		; 43
	ld	b,h		; 44
	ld	b,l		; 45
	ld	b,(hl)		; 46
	ld	b,a		; 47

	ld	c,b		; 48
	ld	c,c		; 49
	ld	c,d		; 4A
	ld	c,e		; 4B
	ld	c,h		; 4C
	ld	c,l		; 4D
	ld	c,(hl)		; 4E
	ld	c,a		; 4F

	ld	d,b		; 50
	ld	d,c		; 51
	ld	d,d		; 52
	ld	d,e		; 53
	ld	d,h		; 54
	ld	d,l		; 55
	ld	d,(hl)		; 56
	ld	d,a		; 57

	ld	e,b		; 58
	ld	e,c		; 59
	ld	e,d		; 5A
	ld	e,e		; 5B
	ld	e,h		; 5C
	ld	e,l		; 5D
	ld	e,(hl)		; 5E
	ld	e,a		; 5F

	ld	h,b		; 60
	ld	h,c		; 61
	ld	h,d		; 62
	ld	h,e		; 63
	ld	h,h		; 64
	ld	h,l		; 65
	ld	h,(hl)		; 66
	ld	h,a		; 67

	ld	l,b		; 68
	ld	l,c		; 69
	ld	l,d		; 6A
	ld	l,e		; 6B
	ld	l,h		; 6C
	ld	l,l		; 6D
	ld	l,(hl)		; 6E
	ld	l,a		; 6F

	ld	(hl),b		; 70
	ld	(hl),c		; 71
	ld	(hl),d		; 72
	ld	(hl),e		; 73
	ld	(hl),h		; 74
	ld	(hl),l		; 75
	halt			; 76
	ld	(hl),a		; 77

	ld	a,b		; 78
	ld	a,c		; 79
	ld	a,d		; 7A
	ld	a,e		; 7B
	ld	a,h		; 7C
	ld	a,l		; 7D
	ld	a,(hl)		; 7E
	ld	a,a		; 7F

	add	a,b		; 80
	add	a,c		; 81
	add	a,d		; 82
	add	a,e		; 83
	add	a,h		; 84
	add	a,l		; 85
	add	a,(hl)		; 86
	add	a,a		; 87

	adc	a,b		; 88
	adc	a,c		; 89
	adc	a,d		; 8A
	adc	a,e		; 8B
	adc	a,h		; 8C
	adc	a,l		; 8D
	adc	a,(hl)		; 8E
	adc	a,a		; 8F

	sub	a,b		; 90
	sub	a,c		; 91
	sub	a,d		; 92
	sub	a,e		; 93
	sub	a,h		; 94
	sub	a,l		; 95
	sub	a,(hl)		; 96
	sub	a,a		; 97

	sbc	a,b		; 98
	sbc	a,c		; 99
	sbc	a,d		; 9A
	sbc	a,e		; 9B
	sbc	a,h		; 9C
	sbc	a,l		; 9D
	sbc	a,(hl)		; 9E
	sbc	a,a		; 9F

	and	a,b		; A0
	and	a,c		; A1
	and	a,d		; A2
	and	a,e		; A3
	and	a,h		; A4
	and	a,l		; A5
	and	a,(hl)		; A6
	and	a,a		; A7

	xor	a,b		; A8
	xor	a,c		; A9
	xor	a,d		; AA
	xor	a,e		; AB
	xor	a,h		; AC
	xor	a,l		; AD
	xor	a,(hl)		; AE
	xor	a,a		; AF

	or	a,b		; B0
	or	a,c		; B1
	or	a,d		; B2
	or	a,e		; B3
	or	a,h		; B4
	or	a,l		; B5
	or	a,(hl)		; B6
	or	a,a		; B7

	cp	a,b		; B8
	cp	a,c		; B9
	cp	a,d		; BA
	cp	a,e		; BB
	cp	a,h		; BC
	cp	a,l		; BD
	cp	a,(hl)		; BE
	cp	a,a		; BF

	ret	nz		; C0
	pop	bc		; C1
	jp	nz,a16		; C2 12 34
	jp	a16		; C3 12 34
	call	nz,a16		; C4 12 34
	push	bc		; C5
	add	a,#d8		; C6 20
	rst	0x00		; C7
	ret	z		; C8
	ret			; C9
	jp	z,a16		; CA 12 34
	; CB Is The Page Prefix	; CB
	call	z,a16		; CC 12 34
	call	a16		; CD 12 34
	adc	a,#d8		; CE 20
	rst	0x08		; CF

	ret	nc		; D0
	pop	de		; D1
	jp	nc,a16		; D2 12 34
	; ---			; D3
	call	nc,a16		; D4 12 34
	push	de		; D5
	sub	a,#d8		; D6 20
	rst	0x10		; D7
	ret	c		; D8
	reti			; D9
	jp	c,a16		; DA 12 34
	; ---			; DB
	call	c,a16		; DC 12 34
	; ---			; DD
	sbc	a,#d8		; DE 20
	rst	0x18		; DF

	ldh	(n8),a		; E0 56
	pop	hl		; E1
	ld	(c),a		; E2
	; ---			; E3
	; ---			; E4
	push	hl		; E5
	and	a,#d8		; E6 20
	rst	0x20		; E7
	add	sp,#d8		; E8 20
	jp	(hl)		; E9
	ld	(a16),a		; EA 12 34
	; ---			; EB
	; ---			; EC
	; ---			; ED
	xor	a,#d8		; EE 20
	rst	0x28		; EF

	ld	a,(a8)		; F0 56
	  ld	(a8)		; F0 56
	  lda	(a8)		; F0 56
	  ldh	a,(n8)		; F0 56
	pop	af		; F1
	ld	a,(c)		; F2
	di			; F3
	; ---			; F4
	push	af		; F5
	or	a,#d8		; F6 20
	rst	0x30		; F7
	ld	hl,sp+d8	; F8 20
	ld	sp,hl		; F9
	ld	a,(a16)		; FA 12 34
	ei			; FB
	; ---			; FC
	; ---			; FD
	cp	a,#d8		; FE 20
	rst	0x38		; FF

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; 0xCB Page Instructions
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	rlc	b		; CB 00
	rlc	c		; CB 01
	rlc	d		; CB 02
	rlc	e		; CB 03
	rlc	h		; CB 04
	rlc	l		; CB 05
	rlc	(hl)		; CB 06
	rlc	a		; CB 07
	  rlca			; 07

	rrc	b		; CB 08
	rrc	c		; CB 09
	rrc	d		; CB 0A
	rrc	e		; CB 0B
	rrc	h		; CB 0C
	rrc	l		; CB 0D
	rrc	(hl)		; CB 0E
	rrc	a		; CB 0F
	  rrca			; 0F

	rl	b		; CB 10
	rl	c		; CB 11
	rl	d		; CB 12
	rl	e		; CB 13
	rl	h		; CB 14
	rl	l		; CB 15
	rl	(hl)		; CB 16
	rl	a		; CB 17
	  rla			; 17

	rr	b		; CB 18
	rr	c		; CB 19
	rr	d		; CB 1A
	rr	e		; CB 1B
	rr	h		; CB 1C
	rr	l		; CB 1D
	rr	(hl)		; CB 1E
	rr	a		; CB 1F
	  rra			; 1F

	sla	b		; CB 20
	sla	c		; CB 21
	sla	d		; CB 22
	sla	e		; CB 23
	sla	h		; CB 24
	sla	l		; CB 25
	sla	(hl)		; CB 26
	sla	a		; CB 27

	sra	b		; CB 28
	sra	c		; CB 29
	sra	d		; CB 2A
	sra	e		; CB 2B
	sra	h		; CB 2C
	sra	l		; CB 2D
	sra	(hl)		; CB 2E
	sra	a		; CB 2F

	swap	b		; CB 30
	swap	c		; CB 31
	swap	d		; CB 32
	swap	e		; CB 33
	swap	h		; CB 34
	swap	l		; CB 35
	swap	(hl)		; CB 36
	swap	a		; CB 37

	srl	b		; CB 38
	srl	c		; CB 39
	srl	d		; CB 3A
	srl	e		; CB 3B
	srl	h		; CB 3C
	srl	l		; CB 3D
	srl	(hl)		; CB 3E
	srl	a		; CB 3F

	bit	0,b		; CB 40
	bit	0,c		; CB 41
	bit	0,d		; CB 42
	bit	0,e		; CB 43
	bit	0,h		; CB 44
	bit	0,l		; CB 45
	bit	0,(hl)		; CB 46
	bit	0,a		; CB 47

	bit	1,b		; CB 48
	bit	1,c		; CB 49
	bit	1,d		; CB 4A
	bit	1,e		; CB 4B
	bit	1,h		; CB 4C
	bit	1,l		; CB 4D
	bit	1,(hl)		; CB 4E
	bit	1,a		; CB 4F

	bit	2,b		; CB 50
	bit	2,c		; CB 51
	bit	2,d		; CB 52
	bit	2,e		; CB 53
	bit	2,h		; CB 54
	bit	2,l		; CB 55
	bit	2,(hl)		; CB 56
	bit	2,a		; CB 57

	bit	3,b		; CB 58
	bit	3,c		; CB 59
	bit	3,d		; CB 5A
	bit	3,e		; CB 5B
	bit	3,h		; CB 5C
	bit	3,l		; CB 5D
	bit	3,(hl)		; CB 5E
	bit	3,a		; CB 5F

	bit	4,b		; CB 60
	bit	4,c		; CB 61
	bit	4,d		; CB 62
	bit	4,e		; CB 63
	bit	4,h		; CB 64
	bit	4,l		; CB 65
	bit	4,(hl)		; CB 66
	bit	4,a		; CB 67

	bit	5,b		; CB 68
	bit	5,c		; CB 69
	bit	5,d		; CB 6A
	bit	5,e		; CB 6B
	bit	5,h		; CB 6C
	bit	5,l		; CB 6D
	bit	5,(hl)		; CB 6E
	bit	5,a		; CB 6F

	bit	6,b		; CB 70
	bit	6,c		; CB 71
	bit	6,d		; CB 72
	bit	6,e		; CB 73
	bit	6,h		; CB 74
	bit	6,l		; CB 75
	bit	6,(hl)		; CB 76
	bit	6,a		; CB 77

	bit	7,b		; CB 78
	bit	7,c		; CB 79
	bit	7,d		; CB 7A
	bit	7,e		; CB 7B
	bit	7,h		; CB 7C
	bit	7,l		; CB 7D
	bit	7,(hl)		; CB 7E
	bit	7,a		; CB 7F

	res	0,b		; CB 80
	res	0,c		; CB 81
	res	0,d		; CB 82
	res	0,e		; CB 83
	res	0,h		; CB 84
	res	0,l		; CB 85
	res	0,(hl)		; CB 86
	res	0,a		; CB 87

	res	1,b		; CB 88
	res	1,c		; CB 89
	res	1,d		; CB 8A
	res	1,e		; CB 8B
	res	1,h		; CB 8C
	res	1,l		; CB 8D
	res	1,(hl)		; CB 8E
	res	1,a		; CB 8F

	res	2,b		; CB 90
	res	2,c		; CB 91
	res	2,d		; CB 92
	res	2,e		; CB 93
	res	2,h		; CB 94
	res	2,l		; CB 95
	res	2,(hl)		; CB 96
	res	2,a		; CB 97

	res	3,b		; CB 98
	res	3,c		; CB 99
	res	3,d		; CB 9A
	res	3,e		; CB 9B
	res	3,h		; CB 9C
	res	3,l		; CB 9D
	res	3,(hl)		; CB 9E
	res	3,a		; CB 9F

	res	4,b		; CB A0
	res	4,c		; CB A1
	res	4,d		; CB A2
	res	4,e		; CB A3
	res	4,h		; CB A4
	res	4,l		; CB A5
	res	4,(hl)		; CB A6
	res	4,a		; CB A7

	res	5,b		; CB A8
	res	5,c		; CB A9
	res	5,d		; CB AA
	res	5,e		; CB AB
	res	5,h		; CB AC
	res	5,l		; CB AD
	res	5,(hl)		; CB AE
	res	5,a		; CB AF

	res	6,b		; CB B0
	res	6,c		; CB B1
	res	6,d		; CB B2
	res	6,e		; CB B3
	res	6,h		; CB B4
	res	6,l		; CB B5
	res	6,(hl)		; CB B6
	res	6,a		; CB B7

	res	7,b		; CB B8
	res	7,c		; CB B9
	res	7,d		; CB BA
	res	7,e		; CB BB
	res	7,h		; CB BC
	res	7,l		; CB BD
	res	7,(hl)		; CB BE
	res	7,a		; CB BF

	set	0,b		; CB C0
	set	0,c		; CB C1
	set	0,d		; CB C2
	set	0,e		; CB C3
	set	0,h		; CB C4
	set	0,l		; CB C5
	set	0,(hl)		; CB C6
	set	0,a		; CB C7

	set	1,b		; CB C8
	set	1,c		; CB C9
	set	1,d		; CB CA
	set	1,e		; CB CB
	set	1,h		; CB CC
	set	1,l		; CB CD
	set	1,(hl)		; CB CE
	set	1,a		; CB CF

	set	2,b		; CB D0
	set	2,c		; CB D1
	set	2,d		; CB D2
	set	2,e		; CB D3
	set	2,h		; CB D4
	set	2,l		; CB D5
	set	2,(hl)		; CB D6
	set	2,a		; CB D7

	set	3,b		; CB D8
	set	3,c		; CB D9
	set	3,d		; CB DA
	set	3,e		; CB DB
	set	3,h		; CB DC
	set	3,l		; CB DD
	set	3,(hl)		; CB DE
	set	3,a		; CB DF

	set	4,b		; CB E0
	set	4,c		; CB E1
	set	4,d		; CB E2
	set	4,e		; CB E3
	set	4,h		; CB E4
	set	4,l		; CB E5
	set	4,(hl)		; CB E6
	set	4,a		; CB E7

	set	5,b		; CB E8
	set	5,c		; CB E9
	set	5,d		; CB EA
	set	5,e		; CB EB
	set	5,h		; CB EC
	set	5,l		; CB ED
	set	5,(hl)		; CB EE
	set	5,a		; CB EF

	set	6,b		; CB F0
	set	6,c		; CB F1
	set	6,d		; CB F2
	set	6,e		; CB F3
	set	6,h		; CB F4
	set	6,l		; CB F5
	set	6,(hl)		; CB F6
	set	6,a		; CB F7

	set	7,b		; CB F8
	set	7,c		; CB F9
	set	7,d		; CB FA
	set	7,e		; CB FB
	set	7,h		; CB FC
	set	7,l		; CB FD
	set	7,(hl)		; CB FE
	set	7,a		; CB FF

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; Alternate Instruction Forms
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	ld	a,(de)		; 1A
	  ld	(de)		; 1A
	  lda	(de)		; 1A

	ld	a,(hl+)		; 2A
	  ld	(hl+)		; 2A
	  lda	(hl+)		; 2A

	ld	a,(hl-)		; 3A
	  ld	(hl-)		; 3A
	  lda	(hl-)		; 3A

	ld	a,#d8		; 3E 20
	  ld	#d8		; 3E 20
	  lda	#d8		; 3E 20

	ld	a,(a8)		; F0 56
	  ld	(a8)		; F0 56
	  lda	(a8)		; F0 56
	  ldh	a,(n8)		; F0 56
	  ldh	(n8)		; F0 56

	ld	a,(*p8)		; F0 56
	  ld	(*p8)		; F0 56
	  lda	(*p8)		; F0 56

	ld	a,(c)		; F2
	  ld	(c)		; F2
	  lda	(c)		; F2
	  in	a,(c)		; F2

	ld	a,(a16)		; FA 12 34
	  ld	(a16)		; FA 12 34
	  lda	(a16)		; FA 12 34

	ld	a,b		; 78
	  ld	b		; 78
	  lda	b		; 78
	ld	a,c		; 79
	  ld	c		; 79
	  lda	c		; 79
	ld	a,d		; 7A
	  ld	d		; 7A
	  lda	d		; 7A
	ld	a,e		; 7B
	  ld	e		; 7B
	  lda	e		; 7B
	ld	a,h		; 7C
	  ld	h		; 7C
	  lda	h		; 7C
	ld	a,l		; 7D
	  ld	l		; 7D
	  lda	l		; 7D
	ld	a,(hl)		; 7E
	  ld	(hl)		; 7E
	  lda	(hl)		; 7E
	ld	a,a		; 7F
	  ld	a		; 7F
	  lda	a		; 7F

	ld	hl,#d16		; 21 84 05
	  lda	hl,#d16		; 21 84 05
	  ldhl	#d16		; 21 84 05

	ld	hl,sp+d8	; F8 20
	  ld	hl,sp+#d8	; F8 20
	  ld	hl,sp,d8	; F8 20
	  ld	hl,sp,#d8	; F8 20
	  ld	hl,d8(sp)	; F8 20
	  ld	hl,#d8(sp)	; F8 20
	  ld	hl,0(sp)	; F8 00
	  ld	hl,sp		; F8 00

	  lda	hl,sp+d8	; F8 20
	  lda	hl,sp+#d8	; F8 20
	  lda	hl,sp,d8	; F8 20
	  lda	hl,sp,#d8	; F8 20
	  lda	hl,d8(sp)	; F8 20
	  lda	hl,#d8(sp)	; F8 20
	  lda	hl,0(sp)	; F8 00
	  lda	hl,sp		; F8 00

	  ldhl	sp+d8		; F8 20
	  ldhl	sp+#d8		; F8 20
	  ldhl	sp,d8		; F8 20
	  ldhl	sp,#d8		; F8 20
	  ldhl	d8(sp)		; F8 20
	  ldhl	#d8(sp)		; F8 20
	  ldhl	0(sp)		; F8 00
	  ldhl	sp		; F8 00

	add	sp,#d8		; E8 20
	  ld	sp,d8(sp)	; E8 20
	  ld	sp,#d8(sp)	; E8 20
	  ld	sp,0(sp)	; E8 00
	  ld	sp,sp		; E8 00

	  lda	sp,d8(sp)	; E8 20
	  lda	sp,#d8(sp)	; E8 20
	  lda	sp,0(sp)	; E8 00
	  lda	sp,sp		; E8 00 

	add	a,#d8		; C6 20
	  add	#d8		; C6 20
	adc	a,#d8		; CE 20
	  adc	#d8		; CE 20
	sub	a,#d8		; D6 20
	  sub	#d8		; D6 20
	sbc	a,#d8		; DE 20
	  sbc	#d8		; DE 20
	and	a,#d8		; E6 20
	  and	#d8		; E6 20
	xor	a,#d8		; EE 20
	  xor	#d8		; EE 20
	or	a,#d8		; F6 20
	  or	#d8		; F6 20
	cp	a,#d8		; FE 20
	  cp	#d8		; FE 20

	add	a,b		; 80
	add	a,c		; 81
	add	a,d		; 82
	add	a,e		; 83
	add	a,h		; 84
	add	a,l		; 85
	add	a,(hl)		; 86
	add	a,a		; 87

	  add	b		; 80
	  add	c		; 81
	  add	d		; 82
	  add	e		; 83
	  add	h		; 84
	  add	l		; 85
	  add	(hl)		; 86
	  add	a		; 87

	adc	a,b		; 88
	adc	a,c		; 89
	adc	a,d		; 8A
	adc	a,e		; 8B
	adc	a,h		; 8C
	adc	a,l		; 8D
	adc	a,(hl)		; 8E
	adc	a,a		; 8F

	  adc	b		; 88
	  adc	c		; 89
	  adc	d		; 8A
	  adc	e		; 8B
	  adc	h		; 8C
	  adc	l		; 8D
	  adc	(hl)		; 8E
	  adc	a		; 8F

	sub	a,b		; 90
	sub	a,c		; 91
	sub	a,d		; 92
	sub	a,e		; 93
	sub	a,h		; 94
	sub	a,l		; 95
	sub	a,(hl)		; 96
	sub	a,a		; 97

	  sub	b		; 90
	  sub	c		; 91
	  sub	d		; 92
	  sub	e		; 93
	  sub	h		; 94
	  sub	l		; 95
	  sub	(hl)		; 96
	  sub	a		; 97

	sbc	a,b		; 98
	sbc	a,c		; 99
	sbc	a,d		; 9A
	sbc	a,e		; 9B
	sbc	a,h		; 9C
	sbc	a,l		; 9D
	sbc	a,(hl)		; 9E
	sbc	a,a		; 9F

	  sbc	b		; 98
	  sbc	c		; 99
	  sbc	d		; 9A
	  sbc	e		; 9B
	  sbc	h		; 9C
	  sbc	l		; 9D
	  sbc	(hl)		; 9E
	  sbc	a		; 9F

	and	a,b		; A0
	and	a,c		; A1
	and	a,d		; A2
	and	a,e		; A3
	and	a,h		; A4
	and	a,l		; A5
	and	a,(hl)		; A6
	and	a,a		; A7

	  and	b		; A0
	  and	c		; A1
	  and	d		; A2
	  and	e		; A3
	  and	h		; A4
	  and	l		; A5
	  and	(hl)		; A6
	  and	a		; A7

	xor	a,b		; A8
	xor	a,c		; A9
	xor	a,d		; AA
	xor	a,e		; AB
	xor	a,h		; AC
	xor	a,l		; AD
	xor	a,(hl)		; AE
	xor	a,a		; AF

	  xor	b		; A8
	  xor	c		; A9
	  xor	d		; AA
	  xor	e		; AB
	  xor	h		; AC
	  xor	l		; AD
	  xor	(hl)		; AE
	  xor	a		; AF

	or	a,b		; B0
	or	a,c		; B1
	or	a,d		; B2
	or	a,e		; B3
	or	a,h		; B4
	or	a,l		; B5
	or	a,(hl)		; B6
	or	a,a		; B7

	  or	b		; B0
	  or	c		; B1
	  or	d		; B2
	  or	e		; B3
	  or	h		; B4
	  or	l		; B5
	  or	(hl)		; B6
	  or	a		; B7

	cp	a,b		; B8
	cp	a,c		; B9
	cp	a,d		; BA
	cp	a,e		; BB
	cp	a,h		; BC
	cp	a,l		; BD
	cp	a,(hl)		; BE
	cp	a,a		; BF

	  cp	b		; B8
	  cp	c		; B9
	  cp	d		; BA
	  cp	e		; BB
	  cp	h		; BC
	  cp	l		; BD
	  cp	(hl)		; BE
	  cp	a		; BF

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; pseudo-op to help build characters
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	.tile " .+*0123"		;55 33
	.tile " .+*0123 .+*0123"	;55 33 55 33

	; UnDefine Arguments

	.undefine	n8
	.undefine	p8
	.undefine	a8
	.undefine	a16
	.undefine	d8
	.undefine	d16

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; Sequential Assembled Code
	; From - https://gbdev.io/gb-opcodes/optables/
	;
	; External Parameters
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	; Define Arguments

	.define		n8	"xn8 + 0x56"
	.define		p8	"xp8 + 0x0056"
	.define		a8	"xa8 + 0xFF56"
	.define		a16	"xa16 + 0x3412"
	.define		d8	"xd8 + 0x20"
	.define		d16	"xd16 + 0x0584"

	nop			; 00
	ld	bc,#d16		; 01r84s05
	ld	(bc),a		; 02
	inc	bc		; 03
	inc	b		; 04
	dec	b		; 05
	ld	b,#d8		; 06r20
	rlca			; 07
	ld	(a16),sp	; 08r12s34
	add	hl,bc		; 09
	ld	a,(bc)		; 0A
	dec	bc		; 0B
	inc	c		; 0C
	dec	c		; 0D
	ld	c,#d8		; 0Er20
	rrca			; 0F

	stop			; 10 00
	ld	de,#d16		; 11r84s05
	ld	(de),a		; 12
	inc	de		; 13
	inc	d		; 14
	dec	d		; 15
	ld	d,#d8		; 16r20
	rla			; 17
	jr	.		; 18 FE
	add	hl,de		; 19
	ld	a,(de)		; 1A
	dec	de		; 1B
	inc	e		; 1C
	dec	e		; 1D
	ld	e,#d8		; 1Er20
	rra			; 1F

	jr	nz,.		; 20 FE
	ld	hl,#d16		; 21r84s05
	ld	(hl+),a		; 22
	inc	hl		; 23
	inc	h		; 24
	dec	h		; 25
	ld	h,#d8		; 26r20
	daa			; 27
	jr	z,.		; 28 FE
	add	hl,hl		; 29
	ld	a,(hl+)		; 2A
	dec	hl		; 2B
	inc	l		; 2C
	dec	l		; 2D
	ld	l,#d8		; 2Er20
	cpl			; 2F

	jr	nc,.		; 30 FE
	ld	sp,#d16		; 31r84s05
	ld	(hl-),a		; 32
	inc	sp		; 33
	inc	(hl)		; 34
	dec	(hl)		; 35
	ld	(hl),#d8	; 36r20
	scf			; 37
	jr	c,.		; 38 FE
	add	hl,sp		; 39
	ld	a,(hl-)		; 3A
	dec	sp		; 3B
	inc	a		; 3C
	dec	a		; 3D
	ld	a,#d8		; 3Er20
	ccf			; 3F

	ld	b,b		; 40
	ld	b,c		; 41
	ld	b,d		; 42
	ld	b,e		; 43
	ld	b,h		; 44
	ld	b,l		; 45
	ld	b,(hl)		; 46
	ld	b,a		; 47

	ld	c,b		; 48
	ld	c,c		; 49
	ld	c,d		; 4A
	ld	c,e		; 4B
	ld	c,h		; 4C
	ld	c,l		; 4D
	ld	c,(hl)		; 4E
	ld	c,a		; 4F

	ld	d,b		; 50
	ld	d,c		; 51
	ld	d,d		; 52
	ld	d,e		; 53
	ld	d,h		; 54
	ld	d,l		; 55
	ld	d,(hl)		; 56
	ld	d,a		; 57

	ld	e,b		; 58
	ld	e,c		; 59
	ld	e,d		; 5A
	ld	e,e		; 5B
	ld	e,h		; 5C
	ld	e,l		; 5D
	ld	e,(hl)		; 5E
	ld	e,a		; 5F

	ld	h,b		; 60
	ld	h,c		; 61
	ld	h,d		; 62
	ld	h,e		; 63
	ld	h,h		; 64
	ld	h,l		; 65
	ld	h,(hl)		; 66
	ld	h,a		; 67

	ld	l,b		; 68
	ld	l,c		; 69
	ld	l,d		; 6A
	ld	l,e		; 6B
	ld	l,h		; 6C
	ld	l,l		; 6D
	ld	l,(hl)		; 6E
	ld	l,a		; 6F

	ld	(hl),b		; 70
	ld	(hl),c		; 71
	ld	(hl),d		; 72
	ld	(hl),e		; 73
	ld	(hl),h		; 74
	ld	(hl),l		; 75
	halt			; 76
	ld	(hl),a		; 77

	ld	a,b		; 78
	ld	a,c		; 79
	ld	a,d		; 7A
	ld	a,e		; 7B
	ld	a,h		; 7C
	ld	a,l		; 7D
	ld	a,(hl)		; 7E
	ld	a,a		; 7F

	add	a,b		; 80
	add	a,c		; 81
	add	a,d		; 82
	add	a,e		; 83
	add	a,h		; 84
	add	a,l		; 85
	add	a,(hl)		; 86
	add	a,a		; 87

	adc	a,b		; 88
	adc	a,c		; 89
	adc	a,d		; 8A
	adc	a,e		; 8B
	adc	a,h		; 8C
	adc	a,l		; 8D
	adc	a,(hl)		; 8E
	adc	a,a		; 8F

	sub	a,b		; 90
	sub	a,c		; 91
	sub	a,d		; 92
	sub	a,e		; 93
	sub	a,h		; 94
	sub	a,l		; 95
	sub	a,(hl)		; 96
	sub	a,a		; 97

	sbc	a,b		; 98
	sbc	a,c		; 99
	sbc	a,d		; 9A
	sbc	a,e		; 9B
	sbc	a,h		; 9C
	sbc	a,l		; 9D
	sbc	a,(hl)		; 9E
	sbc	a,a		; 9F

	and	a,b		; A0
	and	a,c		; A1
	and	a,d		; A2
	and	a,e		; A3
	and	a,h		; A4
	and	a,l		; A5
	and	a,(hl)		; A6
	and	a,a		; A7

	xor	a,b		; A8
	xor	a,c		; A9
	xor	a,d		; AA
	xor	a,e		; AB
	xor	a,h		; AC
	xor	a,l		; AD
	xor	a,(hl)		; AE
	xor	a,a		; AF

	or	a,b		; B0
	or	a,c		; B1
	or	a,d		; B2
	or	a,e		; B3
	or	a,h		; B4
	or	a,l		; B5
	or	a,(hl)		; B6
	or	a,a		; B7

	cp	a,b		; B8
	cp	a,c		; B9
	cp	a,d		; BA
	cp	a,e		; BB
	cp	a,h		; BC
	cp	a,l		; BD
	cp	a,(hl)		; BE
	cp	a,a		; BF

	ret	nz		; C0
	pop	bc		; C1
	jp	nz,a16		; C2r12s34
	jp	a16		; C3r12s34
	call	nz,a16		; C4r12s34
	push	bc		; C5
	add	a,#d8		; C6r20
	rst	0x00		; C7
	ret	z		; C8
	ret			; C9
	jp	z,a16		; CAr12s34
	; CB Is The Page Prefix	; CB
	call	z,a16		; CCr12s34
	call	a16		; CDr12s34
	adc	a,#d8		; CEr20
	rst	0x08		; CF

	ret	nc		; D0
	pop	de		; D1
	jp	nc,a16		; D2r12s34
	; ---			; D3
	call	nc,a16		; D4r12s34
	push	de		; D5
	sub	a,#d8		; D6r20
	rst	0x10		; D7
	ret	c		; D8
	reti			; D9
	jp	c,a16		; DAr12s34
	; ---			; DB
	call	c,a16		; DCr12s34
	; ---			; DD
	sbc	a,#d8		; DEr20
	rst	0x18		; DF

	ldh	(n8),a		; E0*56
	pop	hl		; E1
	ld	(c),a		; E2
	; ---			; E3
	; ---			; E4
	push	hl		; E5
	and	a,#d8		; E6r20
	rst	0x20		; E7
	add	sp,#d8		; E8r20
	jp	(hl)		; E9
	ld	(a16),a		; EAr12s34
	; ---			; EB
	; ---			; EC
	; ---			; ED
	xor	a,#d8		; EEr20
	rst	0x28		; EF

	ld	a,(a8)		; FAr56sFF
	pop	af		; F1
	ld	a,(c)		; F2
	di			; F3
	; ---			; F4
	push	af		; F5
	or	a,#d8		; F6r20
	rst	0x30		; F7
	ld	hl,sp+d8	; F8r20
	ld	sp,hl		; F9
	ld	a,(a16)		; FAr12s34
	ei			; FB
	; ---			; FC
	; ---			; FD
	cp	a,#d8		; FEr20
	rst	0x38		; FF

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; 0xCB Page Instructions
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	rlc	b		; CB 00
	rlc	c		; CB 01
	rlc	d		; CB 02
	rlc	e		; CB 03
	rlc	h		; CB 04
	rlc	l		; CB 05
	rlc	(hl)		; CB 06
	rlc	a		; CB 07
	  rlca			; 07

	rrc	b		; CB 08
	rrc	c		; CB 09
	rrc	d		; CB 0A
	rrc	e		; CB 0B
	rrc	h		; CB 0C
	rrc	l		; CB 0D
	rrc	(hl)		; CB 0E
	rrc	a		; CB 0F
	  rrca			; 0F

	rl	b		; CB 10
	rl	c		; CB 11
	rl	d		; CB 12
	rl	e		; CB 13
	rl	h		; CB 14
	rl	l		; CB 15
	rl	(hl)		; CB 16
	rl	a		; CB 17
	  rla			; 17

	rr	b		; CB 18
	rr	c		; CB 19
	rr	d		; CB 1A
	rr	e		; CB 1B
	rr	h		; CB 1C
	rr	l		; CB 1D
	rr	(hl)		; CB 1E
	rr	a		; CB 1F
	  rra			; 1F

	sla	b		; CB 20
	sla	c		; CB 21
	sla	d		; CB 22
	sla	e		; CB 23
	sla	h		; CB 24
	sla	l		; CB 25
	sla	(hl)		; CB 26
	sla	a		; CB 27

	sra	b		; CB 28
	sra	c		; CB 29
	sra	d		; CB 2A
	sra	e		; CB 2B
	sra	h		; CB 2C
	sra	l		; CB 2D
	sra	(hl)		; CB 2E
	sra	a		; CB 2F

	swap	b		; CB 30
	swap	c		; CB 31
	swap	d		; CB 32
	swap	e		; CB 33
	swap	h		; CB 34
	swap	l		; CB 35
	swap	(hl)		; CB 36
	swap	a		; CB 37

	srl	b		; CB 38
	srl	c		; CB 39
	srl	d		; CB 3A
	srl	e		; CB 3B
	srl	h		; CB 3C
	srl	l		; CB 3D
	srl	(hl)		; CB 3E
	srl	a		; CB 3F

	bit	0,b		; CB 40
	bit	0,c		; CB 41
	bit	0,d		; CB 42
	bit	0,e		; CB 43
	bit	0,h		; CB 44
	bit	0,l		; CB 45
	bit	0,(hl)		; CB 46
	bit	0,a		; CB 47

	bit	1,b		; CB 48
	bit	1,c		; CB 49
	bit	1,d		; CB 4A
	bit	1,e		; CB 4B
	bit	1,h		; CB 4C
	bit	1,l		; CB 4D
	bit	1,(hl)		; CB 4E
	bit	1,a		; CB 4F

	bit	2,b		; CB 50
	bit	2,c		; CB 51
	bit	2,d		; CB 52
	bit	2,e		; CB 53
	bit	2,h		; CB 54
	bit	2,l		; CB 55
	bit	2,(hl)		; CB 56
	bit	2,a		; CB 57

	bit	3,b		; CB 58
	bit	3,c		; CB 59
	bit	3,d		; CB 5A
	bit	3,e		; CB 5B
	bit	3,h		; CB 5C
	bit	3,l		; CB 5D
	bit	3,(hl)		; CB 5E
	bit	3,a		; CB 5F

	bit	4,b		; CB 60
	bit	4,c		; CB 61
	bit	4,d		; CB 62
	bit	4,e		; CB 63
	bit	4,h		; CB 64
	bit	4,l		; CB 65
	bit	4,(hl)		; CB 66
	bit	4,a		; CB 67

	bit	5,b		; CB 68
	bit	5,c		; CB 69
	bit	5,d		; CB 6A
	bit	5,e		; CB 6B
	bit	5,h		; CB 6C
	bit	5,l		; CB 6D
	bit	5,(hl)		; CB 6E
	bit	5,a		; CB 6F

	bit	6,b		; CB 70
	bit	6,c		; CB 71
	bit	6,d		; CB 72
	bit	6,e		; CB 73
	bit	6,h		; CB 74
	bit	6,l		; CB 75
	bit	6,(hl)		; CB 76
	bit	6,a		; CB 77

	bit	7,b		; CB 78
	bit	7,c		; CB 79
	bit	7,d		; CB 7A
	bit	7,e		; CB 7B
	bit	7,h		; CB 7C
	bit	7,l		; CB 7D
	bit	7,(hl)		; CB 7E
	bit	7,a		; CB 7F

	res	0,b		; CB 80
	res	0,c		; CB 81
	res	0,d		; CB 82
	res	0,e		; CB 83
	res	0,h		; CB 84
	res	0,l		; CB 85
	res	0,(hl)		; CB 86
	res	0,a		; CB 87

	res	1,b		; CB 88
	res	1,c		; CB 89
	res	1,d		; CB 8A
	res	1,e		; CB 8B
	res	1,h		; CB 8C
	res	1,l		; CB 8D
	res	1,(hl)		; CB 8E
	res	1,a		; CB 8F

	res	2,b		; CB 90
	res	2,c		; CB 91
	res	2,d		; CB 92
	res	2,e		; CB 93
	res	2,h		; CB 94
	res	2,l		; CB 95
	res	2,(hl)		; CB 96
	res	2,a		; CB 97

	res	3,b		; CB 98
	res	3,c		; CB 99
	res	3,d		; CB 9A
	res	3,e		; CB 9B
	res	3,h		; CB 9C
	res	3,l		; CB 9D
	res	3,(hl)		; CB 9E
	res	3,a		; CB 9F

	res	4,b		; CB A0
	res	4,c		; CB A1
	res	4,d		; CB A2
	res	4,e		; CB A3
	res	4,h		; CB A4
	res	4,l		; CB A5
	res	4,(hl)		; CB A6
	res	4,a		; CB A7

	res	5,b		; CB A8
	res	5,c		; CB A9
	res	5,d		; CB AA
	res	5,e		; CB AB
	res	5,h		; CB AC
	res	5,l		; CB AD
	res	5,(hl)		; CB AE
	res	5,a		; CB AF

	res	6,b		; CB B0
	res	6,c		; CB B1
	res	6,d		; CB B2
	res	6,e		; CB B3
	res	6,h		; CB B4
	res	6,l		; CB B5
	res	6,(hl)		; CB B6
	res	6,a		; CB B7

	res	7,b		; CB B8
	res	7,c		; CB B9
	res	7,d		; CB BA
	res	7,e		; CB BB
	res	7,h		; CB BC
	res	7,l		; CB BD
	res	7,(hl)		; CB BE
	res	7,a		; CB BF

	set	0,b		; CB C0
	set	0,c		; CB C1
	set	0,d		; CB C2
	set	0,e		; CB C3
	set	0,h		; CB C4
	set	0,l		; CB C5
	set	0,(hl)		; CB C6
	set	0,a		; CB C7

	set	1,b		; CB C8
	set	1,c		; CB C9
	set	1,d		; CB CA
	set	1,e		; CB CB
	set	1,h		; CB CC
	set	1,l		; CB CD
	set	1,(hl)		; CB CE
	set	1,a		; CB CF

	set	2,b		; CB D0
	set	2,c		; CB D1
	set	2,d		; CB D2
	set	2,e		; CB D3
	set	2,h		; CB D4
	set	2,l		; CB D5
	set	2,(hl)		; CB D6
	set	2,a		; CB D7

	set	3,b		; CB D8
	set	3,c		; CB D9
	set	3,d		; CB DA
	set	3,e		; CB DB
	set	3,h		; CB DC
	set	3,l		; CB DD
	set	3,(hl)		; CB DE
	set	3,a		; CB DF

	set	4,b		; CB E0
	set	4,c		; CB E1
	set	4,d		; CB E2
	set	4,e		; CB E3
	set	4,h		; CB E4
	set	4,l		; CB E5
	set	4,(hl)		; CB E6
	set	4,a		; CB E7

	set	5,b		; CB E8
	set	5,c		; CB E9
	set	5,d		; CB EA
	set	5,e		; CB EB
	set	5,h		; CB EC
	set	5,l		; CB ED
	set	5,(hl)		; CB EE
	set	5,a		; CB EF

	set	6,b		; CB F0
	set	6,c		; CB F1
	set	6,d		; CB F2
	set	6,e		; CB F3
	set	6,h		; CB F4
	set	6,l		; CB F5
	set	6,(hl)		; CB F6
	set	6,a		; CB F7

	set	7,b		; CB F8
	set	7,c		; CB F9
	set	7,d		; CB FA
	set	7,e		; CB FB
	set	7,h		; CB FC
	set	7,l		; CB FD
	set	7,(hl)		; CB FE
	set	7,a		; CB FF

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; Alternate Instruction Forms
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	ld	a,(de)		; 1A
	  ld	(de)		; 1A
	  lda	(de)		; 1A

	ld	a,(hl+)		; 2A
	  ld	(hl+)		; 2A
	  lda	(hl+)		; 2A

	ld	a,(hl-)		; 3A
	  ld	(hl-)		; 3A
	  lda	(hl-)		; 3A

	ld	a,#d8		; 3Er20
	  ld	#d8		; 3Er20
	  lda	#d8		; 3Er20

	ld	a,(a8)		; FAr56sFF
	  ld	(a8)		; FAr56sFF
	  lda	(a8)		; FAr56sFF
	  ldh	a,(n8)		; F0*56
	  ldh	(n8)		; F0*56

	ld	a,(*p8)		; F0*56
	  ld	(*p8)		; F0*56
	  lda	(*p8)		; F0*56

	ld	a,(c)		; F2
	  ld	(c)		; F2
	  lda	(c)		; F2
	  in	a,(c)		; F2

	ld	a,(a16)		; FAr12s34
	  ld	(a16)		; FAr12s34
	  lda	(a16)		; FAr12s34

	ld	a,b		; 78
	  ld	b		; 78
	  lda	b		; 78
	ld	a,c		; 79
	  ld	c		; 79
	  lda	c		; 79
	ld	a,d		; 7A
	  ld	d		; 7A
	  lda	d		; 7A
	ld	a,e		; 7B
	  ld	e		; 7B
	  lda	e		; 7B
	ld	a,h		; 7C
	  ld	h		; 7C
	  lda	h		; 7C
	ld	a,l		; 7D
	  ld	l		; 7D
	  lda	l		; 7D
	ld	a,(hl)		; 7E
	  ld	(hl)		; 7E
	  lda	(hl)		; 7E
	ld	a,a		; 7F
	  ld	a		; 7F
	  lda	a		; 7F

	ld	hl,#d16		; 21r84s05
	  lda	hl,#d16		; 21r84s05
	  ldhl	#d16		; 21r84s05

	ld	hl,sp+d8	; F8r20
	  ld	hl,sp+#d8	; F8r20
	  ld	hl,sp,d8	; F8r20
	  ld	hl,sp,#d8	; F8r20
	  ld	hl,d8(sp)	; F8r20
	  ld	hl,#d8(sp)	; F8r20
	  ld	hl,0(sp)	; F8 00
	  ld	hl,sp		; F8 00

	  lda	hl,sp+d8	; F8r20
	  lda	hl,sp+#d8	; F8r20
	  lda	hl,sp,d8	; F8r20
	  lda	hl,sp,#d8	; F8r20
	  lda	hl,d8(sp)	; F8r20
	  lda	hl,#d8(sp)	; F8r20
	  lda	hl,0(sp)	; F8 00
	  lda	hl,sp		; F8 00

	  ldhl	sp+d8		; F8r20
	  ldhl	sp+#d8		; F8r20
	  ldhl	sp,d8		; F8r20
	  ldhl	sp,#d8		; F8r20
	  ldhl	d8(sp)		; F8r20
	  ldhl	#d8(sp)		; F8r20
	  ldhl	0(sp)		; F8 00
	  ldhl	sp		; F8 00

	ld	sp,#d16		; 31r84s05
	  lda	sp,#d16		; 31r84s05

	add	sp,#d8		; E8r20
	  ld	sp,d8(sp)	; E8r20
	  ld	sp,#d8(sp)	; E8r20
	  ld	sp,0(sp)	; E8 00
	  ld	sp,sp		; E8 00

	  lda	sp,d8(sp)	; E8r20
	  lda	sp,#d8(sp)	; E8r20
	  lda	sp,0(sp)	; E8 00
	  lda	sp,sp		; E8 00

	add	a,#d8		; C6r20
	  add	#d8		; C6r20
	adc	a,#d8		; CEr20
	  adc	#d8		; CEr20
	sub	a,#d8		; D6r20
	  sub	#d8		; D6r20
	sbc	a,#d8		; DEr20
	  sbc	#d8		; DEr20
	and	a,#d8		; E6r20
	  and	#d8		; E6r20
	xor	a,#d8		; EEr20
	  xor	#d8		; EEr20
	or	a,#d8		; F6r20
	  or	#d8		; F6r20
	cp	a,#d8		; FEr20
	  cp	#d8		; FEr20

	add	a,b		; 80
	add	a,c		; 81
	add	a,d		; 82
	add	a,e		; 83
	add	a,h		; 84
	add	a,l		; 85
	add	a,(hl)		; 86
	add	a,a		; 87

	  add	b		; 80
	  add	c		; 81
	  add	d		; 82
	  add	e		; 83
	  add	h		; 84
	  add	l		; 85
	  add	(hl)		; 86
	  add	a		; 87

	adc	a,b		; 88
	adc	a,c		; 89
	adc	a,d		; 8A
	adc	a,e		; 8B
	adc	a,h		; 8C
	adc	a,l		; 8D
	adc	a,(hl)		; 8E
	adc	a,a		; 8F

	  adc	b		; 88
	  adc	c		; 89
	  adc	d		; 8A
	  adc	e		; 8B
	  adc	h		; 8C
	  adc	l		; 8D
	  adc	(hl)		; 8E
	  adc	a		; 8F

	sub	a,b		; 90
	sub	a,c		; 91
	sub	a,d		; 92
	sub	a,e		; 93
	sub	a,h		; 94
	sub	a,l		; 95
	sub	a,(hl)		; 96
	sub	a,a		; 97

	  sub	b		; 90
	  sub	c		; 91
	  sub	d		; 92
	  sub	e		; 93
	  sub	h		; 94
	  sub	l		; 95
	  sub	(hl)		; 96
	  sub	a		; 97

	sbc	a,b		; 98
	sbc	a,c		; 99
	sbc	a,d		; 9A
	sbc	a,e		; 9B
	sbc	a,h		; 9C
	sbc	a,l		; 9D
	sbc	a,(hl)		; 9E
	sbc	a,a		; 9F

	  sbc	b		; 98
	  sbc	c		; 99
	  sbc	d		; 9A
	  sbc	e		; 9B
	  sbc	h		; 9C
	  sbc	l		; 9D
	  sbc	(hl)		; 9E
	  sbc	a		; 9F

	and	a,b		; A0
	and	a,c		; A1
	and	a,d		; A2
	and	a,e		; A3
	and	a,h		; A4
	and	a,l		; A5
	and	a,(hl)		; A6
	and	a,a		; A7

	  and	b		; A0
	  and	c		; A1
	  and	d		; A2
	  and	e		; A3
	  and	h		; A4
	  and	l		; A5
	  and	(hl)		; A6
	  and	a		; A7

	xor	a,b		; A8
	xor	a,c		; A9
	xor	a,d		; AA
	xor	a,e		; AB
	xor	a,h		; AC
	xor	a,l		; AD
	xor	a,(hl)		; AE
	xor	a,a		; AF

	  xor	b		; A8
	  xor	c		; A9
	  xor	d		; AA
	  xor	e		; AB
	  xor	h		; AC
	  xor	l		; AD
	  xor	(hl)		; AE
	  xor	a		; AF

	or	a,b		; B0
	or	a,c		; B1
	or	a,d		; B2
	or	a,e		; B3
	or	a,h		; B4
	or	a,l		; B5
	or	a,(hl)		; B6
	or	a,a		; B7

	  or	b		; B0
	  or	c		; B1
	  or	d		; B2
	  or	e		; B3
	  or	h		; B4
	  or	l		; B5
	  or	(hl)		; B6
	  or	a		; B7

	cp	a,b		; B8
	cp	a,c		; B9
	cp	a,d		; BA
	cp	a,e		; BB
	cp	a,h		; BC
	cp	a,l		; BD
	cp	a,(hl)		; BE
	cp	a,a		; BF

	  cp	b		; B8
	  cp	c		; B9
	  cp	d		; BA
	  cp	e		; BB
	  cp	h		; BC
	  cp	l		; BD
	  cp	(hl)		; BE
	  cp	a		; BF

	; *****-----*****-----*****-----*****-----*****-----*****
	;
	; pseudo-op to help build characters
	;
	; *****-----*****-----*****-----*****-----*****-----*****

	.tile " .+*0123"		;55 33
	.tile " .+*0123 .+*0123"	;55 33 55 33

	; UnDefine Arguments

	.undefine	p8
	.undefine	a8
	.undefine	a16
	.undefine	d8
	.undefine	d16

	.end

