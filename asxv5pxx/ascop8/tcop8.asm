	.title	National Semiconductor COP8 Instruction Test

	; Error Testing Parameters
	.ifndef	Err
	  Err = 0	; Test Instruction Errors: 0 = NO, 1 = YES
	.endif

	.ifndef	Xtnd
	  Xtnd = 1 	; Enable Extended Instructions: 0 = NO, 1 = YES
	.endif

	.area	COP8	(REL,CON)

	.globl	x$	;(=0)	; External Reference

	PSW =: 0xEF		; Processor Status

	adc	a,[b]		; 80
	adc	a,#0x55		; 90 55
	adc	a,0x55		; BD 55 80
	adc	a,#x		; 90 FC
	adc	a,x		; BD FC 80
	adc	a,0xFC		; BD FC 80
	.iifne	Err	adc	b,[b]
	.iifne	Err	adc	a,[x]
	.iifne	Err	adc	a,0x0100	; BD 00 80

	add	a,[b]		; 84
	add	a,#0x55		; 94 55
	add	a,0x55		; BD 55 84
	add	a,#x		; 94 FC
	add	a,x		; BD FC 84
	add	a,0xFC		; BD FC 84
	.iifne	Err	add	b,[b]
	.iifne	Err	add	a,[x]
	.iifne	Err	add	a,0x0100	; BD 00 84

	and	a,[b]		; 85
	and	a,#0x55		; 95 55
	and	a,0x55		; BD 55 85
	and	a,#x		; 95 FC
	and	a,x		; BD FC 85
	and	a,0xFC		; BD FC 85
	.iifne	Err	and	b,[b]
	.iifne	Err	and	a,[x]
	.iifne	Err	and	a,0x0100	; BD 00 85

	.ifne	Xtnd
        .xtnd	1
	.iifne	Err	andsz	a,[b]		; 50
	andsz	a,#0x55		; 60 55
	.iifne	Err	andsz	a,0x55		; BD 55 50
	andsz	a,#x		; 60 FC
	.iifne	Err	andsz	a,x		; BD FC 50
	.iifne	Err	andsz	a,0xFC		; BD FC 50
	.iifne	Err	andsz	b,[b]
	.iifne	Err	andsz	a,[x]
	.iifne	Err	andsz	a,0x0100	; BD 00 50
	.xtnd
	.else
	.iifne	Err	andsz	a,#0x55		; 60 55
	.iifne	Err	andsz	a,#x		; 60 FC
	.endif

	clr	a		; 64
	clra			; 64
	.iifne	Err	clr	r0

	dcor	a		; 66
	dcora			; 66
	.iifne	Err	dcor	r0
	dec	a		; 8B
	deca			; 8B
	.iifne	Err	dec	r0

	drsz	r0		; C0
	drsz	#1		; C1
	.iifne	Err	drsz	a
	.iifne	Err	drsz	16
	.iifne	Err	drsz	#17

	ifbit	#3,[B]		; 73
	ifbit	#5,0xFE		; BD FE 75
	ifbit	#7,x		; BD FC 77
	.iifne	Err	ifbit	a,[b]
	.iifne	Err	ifbit	#2,[x]

	ifbne	#7		; 47
	.iifne	Err	ifbne	a
	.iifne	Err	ifbne	#16
	.iifne	Err	ifbne	0xFE

	ifc			; 88

	ifeq	a,[b]		; 82
	ifeq	a,#0x55		; 92 55
	ifeq	a,0x55		; BD 55 82
	ifeq	a,#x		; 92 FC
	ifeq	a,x		; BD FC 82
	ifeq	a,0xFC		; BD FC 82
	.iifne	Err	ifeq	b,[b]
	.iifne	Err	ifeq	a,[x]
	.iifne	Err	ifeq	a,0x0100	; BD 00 82

	.ifne	Xtnd
	.xtnd	1
	ifeq	x,#0x55		; A9 FC 55
	ifeq	0x77,#0x55	; A9 77 55
	.iifne	Err	ifeq	x,[b]
	.iifne	Err	ifeq	x,b
	.iifne	Err	ifeq	x,0x55
	.xtnd
	.else
	.iifne	Err	ifeq	x,#0x55		; A9 FC 55
	.iifne	Err	ifeq	0x77,#0x55	; A9 77 55
	.endif

	.ifne	Xtnd
	.xtnd	1
	ifne	a,[b]		; B9
	ifne	a,#0x55		; 99 55
	ifne	a,0x55		; BD 55 B9
	ifne	a,#x		; 99 FC
	ifne	a,x		; BD FC B9
	ifne	a,0xFC		; BD FC B9
	.iifne	Err	ifne	b,[b]
	.iifne	Err	ifne	a,[x]
	.iifne	Err	ifne	a,0x0100	; BD 00 B9
	.xtnd
	.else
	.iifne	Err	ifne	a,[b]		; B9
	.iifne	Err	ifne	a,#0x55		; 99 55
	.iifne	Err	ifne	a,0x55		; BD 55 B9
	.iifne	Err	ifne	a,#x		; 99 FC
	.iifne	Err	ifne	a,x		; BD FC B9
	.iifne	Err	ifne	a,0xFC		; BD FC B9
	.endif

	ifgt	a,[b]		; 83
	ifgt	a,#0x55		; 93 55
	ifgt	a,0x55		; BD 55 83
	ifgt	a,#x		; 93 FC
	ifgt	a,x		; BD FC 83
	ifgt	a,0xFC		; BD FC 83
	.iifne	Err	ifgt	b,[b]
	.iifne	Err	ifgt	a,[x]
	.iifne	Err	ifgt	a,0x0100	; BD 00 83

	ifnc			; 89

	inc	a		; 8A
	inca			; 8A

	intr			; 00

	jid			; A5

	jmp	0xFFF		;n2F*FF
	.iifne	Err	jmp	0x2000
	jmpl	0x7FFF		; AC 7F FF

	.iifne	Err	jp	.-32
	jp	.-31		; E0
	jp	.		; FF
	.iifne	Err	jp	.+1
	jp	.+32		; 1F
	.iifne	Err	jp	.+33
	.iifne	Err	jp	x$

	jsr	0xFFE		;n3F*FE
	.iifne	Err	jsr	0x1001
	jsrl	0x7FFE		; AD 7F FE

	laid			; A4

	ld	a,[b]		; AE
	ld	a,[b+]		; AA
	ld	a,[b-]		; AB
	ld	a,#0x55		; 98 55
	ld	a,0x55		; 9D 55
	ld	a,#PSW		; 98 EF
	ld	a,PSW		; 9D EF
	ld	a,x		; 9D FC
	ld	a,[x]		; BE
	ld	a,[x+]		; BA
	ld	a,[x-]		; BB

	ld	r2,#0x77	; D2 77
	ld	x,#0x77		; DC 77

	ld	[b],#0x22	; 9E 22
	ld	[b+],#0x33	; 9A 33
	ld	[b-],#0x44	; 9B 44
	ld	b,#9		; 56
	ld	b,#sp		; DE FD
	ld	0xFE,#0xFD	; BC FE FD
	.ifne	Xtnd
	.xtnd	1
	ld	b,#0xFD		; 9F FD
	.xtnd
	.else
	ld	b,#0xFD		; DE FD
	.endif

	.iifne	Err	ld	b,b
	.iifne	Err	ld	b,[b]
	.iifne	Err	ld	b,[b+]
	.iifne	Err	ld	b,[b-]
	.iifne	Err	ld	b,x
	.iifne	Err	ld	b,[x]
	.iifne	Err	ld	b,[x+]
	.iifne	Err	ld	b,[x-]

	nop			; B8
 
	or	a,[b]		; 87
	or	a,#0x55		; 97 55
	or	a,0x55		; BD 55 87
	or	a,#x		; 97 FC
	or	a,x		; BD FC 87
	or	a,0xFC		; BD FC 87
	.iifne	Err	or	b,[b]
	.iifne	Err	or	a,[x]
	.iifne	Err	or	a,0x0100	; BD 00 87

	.ifne	Xtnd
	.xtnd	1
	pop	a		; 8C
	popa			; 8C
	push	a		; 67
	pusha			; 67
	.xtnd
	.else
	.iifne	Err	pop	a		; 8C
	.iifne	Err	popa			; 8C
	.iifne	Err	push	a		; 67
	.iifne	Err	pusha			; 67
	.endif

	rbit	#3,[b]		; 6B
	rbit	#1,0xFE		; BD FE 69
	rbit	#2,x		; BD FC 6A

	rc			; A0
	ret			; 8E
	reti			; 8F
	retsk			; 8D

	.ifne	Xtnd
	.xtnd	1
	rlc	a		; A8
	rlca			; A8

	rpnd			; B5
	.xtnd
	.else
	.iifne	Err	rlc	a		; A8
	.iifne	Err	rlca			; A8

	.iifne	Err	rpnd			; B5
	.endif

	rrc	a		; B0
	rrca			; B0

	sbit	#3,[b]		; 7B
	sbit	#1,0xFE		; BD FE 79
	sbit	#2,x		; BD FC 7A

	sc			; A1

	subc	a,[b]		; 81
	subc	a,#0x55		; 91 55
	subc	a,0x55		; BD 55 81
	subc	a,#x		; 91 FC
	subc	a,x		; BD FC 81
	subc	a,0xFC		; BD FC 81
	.iifne	Err	subc	b,[b]
	.iifne	Err	subc	a,[x]
	.iifne	Err	subc	a,0x0100	; BD 00 81

	swap	a		; 65
	swapa			; 65

	.ifne	Xtnd
	.xtnd	1
	vis			; B4
	.xtnd
	.else
	.iifne	Err	vis			; B4
	.endif

	x	a,[b]		; A6
	x	a,[b+]		; A2
	x	a,[b-]		; A3
	x	a,0x88		; 9C 88
	x	a,x		; 9C FC
	x	a,[x]		; B6
	x	a,[x+]		; B2
	x	a,[x-]		; B3

	xor	a,[b]		; 86
	xor	a,#0x55		; 96 55
	xor	a,0x55		; BD 55 86
	xor	a,#x		; 96 FC
	xor	a,x		; BD FC 86
	xor	a,0xFC		; BD FC 86
	.iifne	Err	xor	b,[b]
	.iifne	Err	xor	a,[x]
	.iifne	Err	xor	a,0x0100	; BD 00 86

	.nval	dot,.
	. = . - dot
	.assume	.		; . == 0x0000
base0:
	.iifne	Err	jmp	base0 - 1	;n2F*FF 
	jmp	base0		;n20*00
	jmp	base0 + 1	;n20*01
	jmp	base0 + 4094	;n2F*FE
	jmp	base0 + 4095	;n2F*FF
	.iifne	Err	jmp	base0 + 4096	;n20*00

	.nval	dot,.
	. = . - dot + 4096
	.assume	. - 4096	; . == 0x1000

base1:
	.iifne	Err	jmp	base1 - 1	;n2F*FF 
	jmp	base1		;n20*00
	jmp	base1 + 1	;n20*01
	jmp	base1 + 4094	;n2F*FE
	jmp	base1 + 4095	;n2F*FF
	.iifne	Err	jmp	base1 + 4096	;n20*00


	.sbttl	External References

	.nval	dot,.
	. = . - dot
	.assume	.		; . == 0x0000

 	adc	a,[b]		; 80
	adc	a,#0x55 + x$	; 90r55
	adc	a,0x55 + x$	; BD*55 80
	adc	a,#x + x$	; 90rFC
	.iifne	Err	adc	a,x + x$	; BD FC 80
	adc	a,0xFC + x$	; BD*FC 80
	.iifne	Err	adc	b,[b]
	.iifne	Err	adc	a,[x]
	.iifne	Err	adc	a,0x0100 + x$	; BD*00 80

	add	a,[b]		; 84
	add	a,#0x55 + x$	; 94r55
	add	a,0x55 + x$	; BD*55 84
	add	a,#x + x$	; 94rFC
	.iifne	Err	add	a,x + x$	; BD FC 84
	add	a,0xFC + x$	; BD*FC 84
	.iifne	Err	add	b,[b]
	.iifne	Err	add	a,[x]
	.iifne	Err	add	a,0x0100	; BD 00 84

	and	a,[b]		; 85
	and	a,#0x55 + x$	; 95r55
	and	a,0x55 + x$	; BD*55 85
	and	a,#x + x$	; 95rFC
	.iifne	Err	and	a,x + x$	; BD FC 85
	and	a,0xFC + x$	; BD*FC 85
	.iifne	Err	and	b,[b]
	.iifne	Err	and	a,[x]
	.iifne	Err	and	a,0x0100	; BD 00 85

	.ifne	Xtnd
        .xtnd	1
	.iifne	Err	andsz	a,[b]		; 50
	andsz	a,#0x55 + x$	; 60r55
	.iifne	Err	andsz	a,0x55		; BD 55 50
	andsz	a,#x + x$	; 60rFC
	.iifne	Err	andsz	a,x + x$	; BD FC 50
	.iifne	Err	andsz	a,0xFC + x$	; BD*FC 50
	.iifne	Err	andsz	b,[b]
	.iifne	Err	andsz	a,[x]
	.iifne	Err	andsz	a,0x0100 + x$	; BD*00 50
	.xtnd
	.else
	.iifne	Err	andsz	a,#0x55		; 60 55
	.iifne	Err	andsz	a,#x		; 60 FC
	.endif

	clr	a		; 64
	clra			; 64
	.iifne	Err	clr	r0

	dcor	a		; 66
	dcora			; 66
	.iifne	Err	dcor	r0
	dec	a		; 8B
	deca			; 8B
	.iifne	Err	dec	r0

	drsz	r0		; C0
	drsz	#1 + x$		;uC1
	.iifne	Err	drsz	a
	.iifne	Err	drsz	16
	.iifne	Err	drsz	#17

	ifbit	#3 + x$,[B]		;u73
	ifbit	#5,0xFE + x$		; BD*FE 75
	ifbit	#7 + x$,x		; BD FCu77
	.iifne	Err	ifbit	a,[b]
	.iifne	Err	ifbit	#2,[x]

	ifbne	#7 + x$		;u47
	.iifne	Err	ifbne	a
	.iifne	Err	ifbne	#16
	.iifne	Err	ifbne	0xFE

	ifc			; 88

	ifeq	a,[b]		; 82
	ifeq	a,#0x55 + x$	; 92r55
	ifeq	a,0x55 + x$	; BD*55 82
	ifeq	a,#x + x$	; 92rFC
	.iifne	Err	ifeq	a,x + x$	; BD FC 82
	ifeq	a,0xFC + x$	; BD*FC 82
	.iifne	Err	ifeq	b,[b]
	.iifne	Err	ifeq	a,[x]
	.iifne	Err	ifeq	a,0x0100	; BD 00 82

	.ifne	Xtnd
	.xtnd	1
	ifeq	x,#0x55 + x$	; A9 FCr55
	ifeq	0x77 + x$,#0x55	; A9*77 55
	.iifne	Err	ifeq	x,[b]
	.iifne	Err	ifeq	x,b
	.iifne	Err	ifeq	x,0x55
	.xtnd
	.else
	.iifne	Err	ifeq	x,#0x55		; A9 FC 55
	.iifne	Err	ifeq	0x77,#0x55	; A9 77 55
	.endif

	.ifne	Xtnd
	.xtnd	1
	ifne	a,[b]		; B9
	ifne	a,#0x55 + x$	; 99r55
	ifne	a,0x55 + x$	; BD*55 B9
	ifne	a,#x + x$	; 99rFC
	.iifne	Err	ifne	a,x + x$	; BD FC B9
	ifne	a,0xFC + x$	; BD*FC B9
	.iifne	Err	ifne	b,[b]
	.iifne	Err	ifne	a,[x]
	.iifne	Err	ifne	a,0x0100	; BD 00 B9
	.xtnd
	.else
	.iifne	Err	ifne	a,[b]		; B9
	.iifne	Err	ifne	a,#0x55		; 99 55
	.iifne	Err	ifne	a,0x55		; BD 55 B9
	.iifne	Err	ifne	a,#x		; 99 FC
	.iifne	Err	ifne	a,x		; BD FC B9
	.iifne	Err	ifne	a,0xFC		; BD FC B9
	.endif

	ifgt	a,[b]		; 83
	ifgt	a,#0x55 + x$	; 93r55
	ifgt	a,0x55 + x$	; BD*55 83
	ifgt	a,#x + x$	; 93rFC
	.iifne	Err	ifgt	a,x + x$	; BD FC 83
	ifgt	a,0xFC + x$	; BD*FC 83
	.iifne	Err	ifgt	b,[b]
	.iifne	Err	ifgt	a,[x]
	.iifne	Err	ifgt	a,0x0100	; BD 00 83

	ifnc			; 89

	inc	a		; 8A
	inca			; 8A

	intr			; 00

	jid			; A5

	jmp	0xFFF + x$	;n2F*FF
	.iifne	Err	jmp	0x2000
	jmpl	0x7FFF + x$	; ACs7FrFF

	.iifne	Err	jp	.-32
	jp	.-31		; E0
	jp	.		; FF
	.iifne	Err	jp	.+1
	jp	.+32		; 1F
	.iifne	Err	jp	.+33
	.iifne	Err	jp	x$

	jsr	0xFFE + x$	;n3F*FE
	.iifne	Err	jsr	0x1001
	jsrl	0x7FFE + x$	; ADs7FrFE

	laid			; A4

	ld	a,[b]		; AE
	ld	a,[b+]		; AA
	ld	a,[b-]		; AB
	ld	a,#0x55 + x$	; 98r55
	ld	a,0x55 + x$	; 9D*55
	ld	a,#PSW + x$	; 98rEF
	ld	a,PSW + x$	; 9D*EF
	.iifne	Err	ld	a,x + x$	; 9D FC
	ld	a,[x]		; BE
	ld	a,[x+]		; BA
	ld	a,[x-]		; BB

	ld	r2,#0x77 + x$	; D2r77
	ld	x,#0x77 + x$	; DCr77

	ld	[b],#0x22 + x$	; 9Er22
	ld	[b+],#0x33 + x$	; 9Ar33
	ld	[b-],#0x44 + x$	; 9Br44
	ld	b,#9 + x$	; DEr09
	ld	b,#sp + x$	; DErFD
	ld	0xFE + x$,#0xFD	; BC*FE FD
	.ifne	Xtnd
	.xtnd	1
	ld	b,#0xFD + x$	; 9FrFD
	.xtnd
	.else
	ld	b,#0xFD + x$	; DErFD
	.endif

	.iifne	Err	ld	b,b
	.iifne	Err	ld	b,[b]
	.iifne	Err	ld	b,[b+]
	.iifne	Err	ld	b,[b-]
	.iifne	Err	ld	b,x
	.iifne	Err	ld	b,[x]
	.iifne	Err	ld	b,[x+]
	.iifne	Err	ld	b,[x-]

	nop			; B8
 
	or	a,[b]		; 87
	or	a,#0x55 + x$	; 97r55
	or	a,0x55 + x$	; BD*55 87
	or	a,#x + x$	; 97rFC
	.iifne	Err	or	a,x + x$	; BD FC 87
	or	a,0xFC + x$	; BD*FC 87
	.iifne	Err	or	b,[b]
	.iifne	Err	or	a,[x]
	.iifne	Err	or	a,0x0100	; BD 00 87

	.ifne	Xtnd
	.xtnd	1
	pop	a		; 8C
	popa			; 8C
	push	a		; 67
	pusha			; 67
	.xtnd
	.else
	.iifne	Err	pop	a		; 8C
	.iifne	Err	popa			; 8C
	.iifne	Err	push	a		; 67
	.iifne	Err	pusha			; 67
	.endif

	rbit	#3,[b]		; 6B
	rbit	#1,0xFE + x$	; BD*FE 69
	.iifne	Err	rbit	#2,x + x$	; BD FC 6A

	rc			; A0
	ret			; 8E
	reti			; 8F
	retsk			; 8D

	.ifne	Xtnd
	.xtnd	1
	rlc	a		; A8
	rlca			; A8

	rpnd			; B5
	.xtnd
	.else
	.iifne	Err	rlc	a		; A8
	.iifne	Err	rlca			; A8

	.iifne	Err	rpnd			; B5
	.endif

	rrc	a		; B0
	rrca			; B0

	sbit	#3,[b]		; 7B
	sbit	#1,0xFE + x$	; BD*FE 79
	.iifne	Err	sbit	#2,x + x$	; BD FC 7A

	sc			; A1

	subc	a,[b]		; 81
	subc	a,#0x55 + x$	; 91r55
	subc	a,0x55 + x$	; BD*55 81
	subc	a,#x + x$	; 91rFC
	.iifne	Err	subc	a,x + x$	; BD FC 81
	subc	a,0xFC + x$	; BD*FC 81
	.iifne	Err	subc	b,[b]
	.iifne	Err	subc	a,[x]
	.iifne	Err	subc	a,0x0100	; BD 00 81

	swap	a		; 65
	swapa			; 65

	.ifne	Xtnd
	.xtnd	1
	vis			; B4
	.xtnd
	.else
	.iifne	Err	vis			; B4
	.endif

	x	a,[b]		; A6
	x	a,[b+]		; A2
	x	a,[b-]		; A3
	x	a,0x88 + x$	; 9C*88
	.iifne	Err	x	a,x + x$	; 9C FC
	x	a,[x]		; B6
	x	a,[x+]		; B2
	x	a,[x-]		; B3

	xor	a,[b]		; 86
	xor	a,#0x55 + x$	; 96r55
	xor	a,0x55 + x$	; BD*55 86
	xor	a,#x + x$	; 96rFC
	.iifne	Err	xor	a,x + x$	; BD FC 86
	xor	a,0xFC + x$	; BD*FC 86
	.iifne	Err	xor	b,[b]
	.iifne	Err	xor	a,[x]
	.iifne	Err	xor	a,0x0100	; BD 00 86

	.nval	dot,.
	. = . - dot
	.assume	.		; . == 0x0000
base2:
	.iifne	Err	jmp	base2 - 1	;n2F*FF 
	.iifne	Err	jmp	base2 + x$		;n20*00
	.iifne	Err	jmp	base2 + 1 + x$		;n20*01
	.iifne	Err	jmp	base2 + 4094 + x$	;n2F*FE
	.iifne	Err	jmp	base2 + 4095 + x$	;n2F*FF
	.iifne	Err	jmp	base2 + 4096	;n20*00

	.nval	dot,.
	. = . - dot + 4096
	.assume	. - 4096	; . == 0x1000

base3:
	.iifne	Err	jmp	base3 - 1	;n2F*FF 
	.iifne	Err	jmp	base3 + x$		;n20*00
	.iifne	Err	jmp	base3 + 1 + x$		;n20*01
	.iifne	Err	jmp	base3 + 4094 + x$	;n2F*FE
	.iifne	Err	jmp	base3 + 4095 + x$	;n2F*FF
	.iifne	Err	jmp	base3 + 4096	;n20*00

	.end

