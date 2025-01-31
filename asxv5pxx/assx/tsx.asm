	.Title	ASSX Test

	.include  "sx4852.def"

	.sbttl	Non Relocatable Forms

	; Logical Operations

	and	0x14,w			; 01 74
	and	w,0x17			; 01 57
	and	w,#0x55			; 0E 55

	not	0x01			; 02 61

	or	0x13,w			; 01 33
	or	w,0x16			; 01 16
	or	w,#0x44			; 0D 44

	xor	0x12,w			; 01 B2
	xor	w,0x15			; 01 95
	xor	w,#0x33			; 0F 33

	; Arithmetic and Shift Operations

	add	0x01,w			; 01 E1
	add	w,0x02			; 01 C2

	clr	0x03			; 00 63
	clr	w			; 00 40
	clr	!wdt			; 00 04

	dec	0x04			; 00 E4
	decsz	0x05			; 02 E5

	inc	0x06			; 02 A6
	incsz	0x07			; 03 E7

	rl	0x08			; 03 68
	rr	0x09			; 03 29

	sub	0x0A,w			; 00 AA

	swap	0x0B			; 03 AB

	; Bitwise Operations

	clrb	0x7.2			; 04 47

	sb	ra.3			; 07 65

	setb	0x17.4			; 05 97

	snb	re.5			; 06 A9

	; Data Movement Instructions

	mov	0x0F,w			; 00 2F

	mov	w,0x10			; 02 10
	mov	w,0x11-w		; 00 91
	mov	w,#0x12			; 0C 12
	mov	w,/#0x13		; 02 53
	mov	w,--0x14		; 00 D4
	mov	w,++0x15		; 02 95
	mov	w,<<0x16		; 03 56
	mov	w,>>0x17		; 03 17
	mov	w,<>0x18		; 03 98

	mov	w,m			; 00 42

	movsz	w,--0x19		; 02 D9
	movsz	w,++0x1A		; 03 DA

	mov	m,w			; 00 43

	mov	m,#0x0B			; 00 5B

	mov	!ra,w			; 00 05

	mov	!option,w		; 00 02

	test	0x0C			; 02 2C

	; Program Control Instructions

	call	0xA55			; 09 55

	jmp	0x977			; 0B 77

	nop				; 00 00

	ret				; 00 0C

	retp				; 00 0D

	reti				; 00 0E

	retiw				; 00 0F

	retw	0xAA			; 08 AA

	; System Control Instructions

	bank	0x345			; 00 1B

	iread				; 00 41

	page	0xABC			; 00 15

	sleep				; 00 03

	; Equivalent Assembler Mnemonics

	clc				; 04 03
	clz				; 04 43
	jmp	w			; 00 22
	jmp	pc+w			; 01 E2
	mode	#0x07			; 00 57
	not	w			; 0F FF
	sc				; 07 03
	sz				; 07 43

	.even
	skip				;s07r02

	.odd
	skip				;s06r02


	.sbttl	Relocatable Forms

	.globl	X

	; Logical Operations

	and	X+0x14,w		; 01 74
	and	w,X+0x17		; 01 57
	and	w,#X+0x55		; 0E 55

	not	X+0x01			; 02 61

	or	X+0x13,w		; 01 33
	or	w,X+0x16		; 01 16
	or	w,#X+0x44		; 0D 44

	xor	X+0x12,w		; 01 B2
	xor	w,X+0x15		; 01 95
	xor	w,#X+0x33		; 0F 33

	; Arithmetic and Shift Operations

	add	X+0x01,w		; 01 E1
	add	w,X+0x02		; 01 C2

	clr	X+0x03			; 00 63
	clr	w			; 00 40
	clr	!wdt			; 00 04

	dec	X+0x04			; 00 E4
	decsz	X+0x05			; 02 E5

	inc	X+0x06			; 02 A6
	incsz	X+0x07			; 03 E7

	rl	X+0x08			; 03 68
	rr	X+0x09			; 03 29

	sub	X+0x0A,w		; 00 AA

	swap	X+0x0B			; 03 AB

	; Bitwise Operations

	clrb	X+0x7.2			; 04 47

	sb	ra.3			; 07 65

	setb	X+0x17.4		; 05 97

	snb	re.5			; 06 A9

	; Data Movement Instructions

	mov	X+0x0F,w		; 00 2F

	mov	w,X+0x10		; 02 10
	mov	w,X+0x11-w		; 00 91
	mov	w,#X+0x12		; 0C 12
	mov	w,/#X+0x13		; 02 53
	mov	w,--X+0x14		; 00 D4
	mov	w,++X+0x15		; 02 95
	mov	w,<<X+0x16		; 03 56
	mov	w,>>X+0x17		; 03 17
	mov	w,<>X+0x18		; 03 98

	mov	w,m			; 00 42

	movsz	w,--X+0x19		; 02 D9
	movsz	w,++X+0x1A		; 03 DA

	mov	m,w			; 00 43

	mov	m,#X+0x0B		; 00 5B

	mov	!ra,w			; 00 05

	mov	!option,w		; 00 02

	test	X+0x0C			; 02 2C

	; Program Control Instructions

	call	X+0xA55			; 09 55

	jmp	X+0x977			; 0B 77

	nop				; 00 00

	ret				; 00 0C

	retp				; 00 0D

	reti				; 00 0E

	retiw				; 00 0F

	retw	X+0xAA			; 08 AA

	; System Control Instructions

	bank	X+0x345			; 00 1B

	iread				; 00 41

	page	X+0xABC			; 00 15

	sleep				; 00 03

	; Equivalent Assembler Mnemonics

	clc				; 04 03
	clz				; 04 43
	jmp	w			; 00 22
	jmp	pc+w			; 01 E2
	mode	#X+0x07			; 00 57
	not	w			; 0F FF
	sc				; 07 03
	sz				; 07 43

	.even
	skip				;s07r02

	.odd
	skip				;s06r02
