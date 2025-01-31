	.title	National Semiconductor COP4 Instruction Test

	;*****-----*****-----*****-----*****-----*****-----*****
	;*
	;*	  This test file includes all instructions
	;*	in the COP400 family of processors.  The
	;*	file is normally assembled with no .cop4xx
	;*	processor configuration directive.
	;*
	;*	  To verify the instruction set for a
	;*	specific processor type there are two methods
	;*	of chip selection.  The first is the built
	;*	in assembler directive .cop followed by the
	;*	processor number:
	;*	
	;*	.cop	402
        ;*
	;*	.cop	404		.cop	404M
	;*
	;*	.cop	410		.cop	410L		.cop	410C
	;*	.cop	411		.cop	411L		.cop	411C
	;*
	;*	.cop	413		.cop	413C		.cop	413CH
	;*
	;*	.cop	420		.cop	420L
	;*	.cop	421		.cop	421L
	;*	.cop	422		.cop	422L
	;*
	;*	.cop	424		.cop	424L
	;*	.cop	425		.cop	425L
	;*	.cop	426		.cop	426L
	;*
	;*	.cop	440
	;*	.cop	441
	;*	.cop	442
	;*
	;*	.cop	444		.cop	444L
	;*	.cop	445		.cop	445L
	;*
	;*	.cop	2440
	;*	.cop	2441
	;*	.cop	2442
	;*
	;*	.cop	; Remove Processor Selection
	;*
	;*
	;*	The second is to use the ascop4.mac macro library
	;*	developed as the initial processor type selection
	;*	before the .cop directive was available:
	;*
	;*	.include "ascop4.mac"		; Macro CPU Type Selection
	;*
	;*	Contains all of the following macros:
	;*
	;*	.cop402		COP402
	;*
	;*	.cop404		COP404 / COP404M
	;*
	;*	.cop410 [C]	COP410C / COP410L / COP310C / COP310L
	;*	.cop411 [C]	COP411C / COP411L / COP311C / COP311L
	;*
	;*	.cop413		COP413C / COP413CH / COP313C / COP313CH
	;*
	;*	.cop420		COP420L / COP320L
	;*	.cop421		COP421L / COP321L
	;*	.cop422		COP422L / COP322L
	;*
	;*	.cop424		COP424L / COP324L
	;*	.cop425		COP425L / COP325L
	;*	.cop426		COP426L / COP326L
	;*
	;*	.cop440		COP440 / COP340
	;*	.cop441		COP441 / COP341
	;*	.cop442		COP442 / COP342
	;*
	;*	.cop444		COP444L / COP344L
	;*	.cop445		COP445L / COP345L
	;*
	;*	.cop2440	COP2440 / COP2340
	;*	.cop2441	COP2441 / COP2341
	;*	.cop2442	COP2442 / COP2342
	;*
	;*	.copclr		; Remove Processor Selection
	;*
	;*
	;*	  The result of selecting a specific processor
	;*	is to flag instructions that are not available
        ;*	in this processor.
	;*
	;*****-----*****-----*****-----*****-----*****-----*****


	.area	COP4	(ABS,OVR)

	.globl	x$	;(=0)	; External Reference

	; Testing Instructions With Various Formats
	;
	;   Instructions With Ram:		Rn or N Allowed, #N Invalid
	;   Instructions With Addresses:	Names or N, #N Invalid
	;   Instructions With Paging Options:	Based on Current Page
	;   Instructions With Two Arguments:	Only One Argument May Be External
	;

	.sbttl	Sequential Instruction Opcodes

	.org	0

	clra			; 00
	skmbz	0		; 01
	xor			; 02
	skmbz	2		; 03
	xis	r0		; 04
	ld	0		; 05
	x	r0		; 06
	xds	0		; 07

	lbi	r0,0x09		; 08
	lbi	0,0x0A		; 09
	lbi	r0,0x0B		; 0A
	lbi	0,0x0C		; 0B
	lbi	r0,0x0D		; 0C
	lbi	0,0x0E		; 0D
	lbi	r0,0x0F		; 0E
	lbi	0,0x00		; 0F

	casc			; 10
	skmbz	1		; 11
	xabr			; 12
	skmbz	3		; 13
	xis	1		; 14
	ld	r1		; 15
	x	1		; 16
	xds	r1		; 17

	lbi	r1,0x09		; 18
	lbi	1,0x0A		; 19
	lbi	r1,0x0B		; 1A
	lbi	1,0x0C		; 1B
	lbi	r1,0x0D		; 1C
	lbi	1,0x0E		; 1D
	lbi	r1,0x0F		; 1E
	lbi	1,0x00		; 1F

	skc			; 20
	ske			; 21
	sc			; 22

	ldd	r0,0x00		; 23 00
	ldd	0,0x01		; 23 01
	ldd	r0,0x02		; 23 02
	ldd	0,0x03		; 23 03
	ldd	r0,0x04		; 23 04
	ldd	0,0x05		; 23 05
	ldd	r0,0x06		; 23 06
	ldd	0,0x07		; 23 07
	ldd	r0,0x08		; 23 08
	ldd	0,0x09		; 23 09
	ldd	r0,0x0A		; 23 0A
	ldd	0,0x0B		; 23 0B
	ldd	r0,0x0C		; 23 0C
	ldd	0,0x0D		; 23 0D
	ldd	r0,0x0E		; 23 0E
	ldd	0,0x0F		; 23 0F

	ldd	r1,0x00		; 23 10
	ldd	1,0x01		; 23 11
	ldd	r1,0x02		; 23 12
	ldd	1,0x03		; 23 13
	ldd	r1,0x04		; 23 14
	ldd	1,0x05		; 23 15
	ldd	r1,0x06		; 23 16
	ldd	1,0x07		; 23 17
	ldd	r1,0x08		; 23 18
	ldd	1,0x09		; 23 19
	ldd	r1,0x0A		; 23 1A
	ldd	1,0x0B		; 23 1B
	ldd	r1,0x0C		; 23 1C
	ldd	1,0x0D		; 23 1D
	ldd	r1,0x0E		; 23 1E
	ldd	1,0x0F		; 23 1F

	ldd	r2,0x00		; 23 20
	ldd	2,0x01		; 23 21
	ldd	r2,0x02		; 23 22
	ldd	2,0x03		; 23 23
	ldd	r2,0x04		; 23 24
	ldd	2,0x05		; 23 25
	ldd	r2,0x06		; 23 26
	ldd	2,0x07		; 23 27
	ldd	r2,0x08		; 23 28
	ldd	2,0x09		; 23 29
	ldd	r2,0x0A		; 23 2A
	ldd	2,0x0B		; 23 2B
	ldd	r2,0x0C		; 23 2C
	ldd	2,0x0D		; 23 2D
	ldd	r2,0x0E		; 23 2E
	ldd	2,0x0F		; 23 2F

	ldd	r3,0x00		; 23 30
	ldd	3,0x01		; 23 31
	ldd	r3,0x02		; 23 32
	ldd	3,0x03		; 23 33
	ldd	r3,0x04		; 23 34
	ldd	3,0x05		; 23 35
	ldd	r3,0x06		; 23 36
	ldd	3,0x07		; 23 37
	ldd	r3,0x08		; 23 38
	ldd	3,0x09		; 23 39
	ldd	r3,0x0A		; 23 3A
	ldd	3,0x0B		; 23 3B
	ldd	r3,0x0C		; 23 3C
	ldd	3,0x0D		; 23 3D
	ldd	r3,0x0E		; 23 3E
	ldd	3,0x0F		; 23 3F

	xad	r0,0x00		; 23 80
	xad	0,0x01		; 23 81
	xad	r0,0x02		; 23 82
	xad	0,0x03		; 23 83
	xad	r0,0x04		; 23 84
	xad	0,0x05		; 23 85
	xad	r0,0x06		; 23 86
	xad	0,0x07		; 23 87
	xad	r0,0x08		; 23 88
	xad	0,0x09		; 23 89
	xad	r0,0x0A		; 23 8A
	xad	0,0x0B		; 23 8B
	xad	r0,0x0C		; 23 8C
	xad	0,0x0D		; 23 8D
	xad	r0,0x0E		; 23 8E
	xad	0,0x0F		; 23 8F

	xad	r1,0x00		; 23 90
	xad	1,0x01		; 23 91
	xad	r1,0x02		; 23 92
	xad	1,0x03		; 23 93
	xad	r1,0x04		; 23 94
	xad	1,0x05		; 23 95
	xad	r1,0x06		; 23 96
	xad	1,0x07		; 23 97
	xad	r1,0x08		; 23 98
	xad	1,0x09		; 23 99
	xad	r1,0x0A		; 23 9A
	xad	1,0x0B		; 23 9B
	xad	r1,0x0C		; 23 9C
	xad	1,0x0D		; 23 9D
	xad	r1,0x0E		; 23 9E
	xad	1,0x0F		; 23 9F

	xad	r2,0x00		; 23 A0
	xad	2,0x01		; 23 A1
	xad	r2,0x02		; 23 A2
	xad	2,0x03		; 23 A3
	xad	r2,0x04		; 23 A4
	xad	2,0x05		; 23 A5
	xad	r2,0x06		; 23 A6
	xad	2,0x07		; 23 A7
	xad	r2,0x08		; 23 A8
	xad	2,0x09		; 23 A9
	xad	r2,0x0A		; 23 AA
	xad	2,0x0B		; 23 AB
	xad	r2,0x0C		; 23 AC
	xad	2,0x0D		; 23 AD
	xad	r2,0x0E		; 23 AE
	xad	2,0x0F		; 23 AF

	xad	r3,0x00		; 23 B0
	xad	3,0x01		; 23 B1
	xad	r3,0x02		; 23 B2
	xad	3,0x03		; 23 B3
	xad	r3,0x04		; 23 B4
	xad	3,0x05		; 23 B5
	xad	r3,0x06		; 23 B6
	xad	3,0x07		; 23 B7
	xad	r3,0x08		; 23 B8
	xad	3,0x09		; 23 B9
	xad	r3,0x0A		; 23 BA
	xad	3,0x0B		; 23 BB
	xad	r3,0x0C		; 23 BC
	xad	3,0x0D		; 23 BD
	xad	r3,0x0E		; 23 BE
	xad	3,0x0F		; 23 BF

	xis	r2		; 24
	ld	2		; 25
	x	r2		; 26
	xds	2		; 27

	lbi	r2,0x09		; 28
	lbi	2,0x0A		; 29
	lbi	r2,0x0B		; 2A
	lbi	2,0x0C		; 2B
	lbi	r2,0x0D		; 2C
	lbi	2,0x0E		; 2D
	lbi	r2,0x0F		; 2E
	lbi	2,0x00		; 2F

	asc			; 30
	add			; 31
	rc			; 32

	skgbz	0		; 33 01
	skgbz	2		; 33 03

	xan			; 33 0B
	cema			; 33 0F

	skgbz	1		; 33 11
	skgbz	3		; 33 13

	lid			; 33 19
	or			; 33 1A
	sksz			; 33 1C

	came			; 33 1F
	skgz			; 33 21

	inin			; 33 28
	inil			; 33 29
	ing			; 33 2A
	inh			; 33 2B
	cqma			; 33 2C
	inr			; 33 2D
	inl			; 33 2E
	ctma			; 33 2F
	halt			; 33 38
	it			; 33 39
	omg			; 33 3A
	omh			; 33 3B
	camq			; 33 3C
	camr			; 33 3D
	obd			; 33 3E
	camt			; 33 3F

	ogi	#0		; 33 50
	ogi	1		; 33 51
	ogi	#2		; 33 52
	ogi	3		; 33 53
	ogi	#4		; 33 54
	ogi	5		; 33 55
	ogi	#6		; 33 56
	ogi	7		; 33 57
	ogi	#8		; 33 58
	ogi	9		; 33 59
	ogi	#10		; 33 5A
	ogi	11		; 33 5B
	ogi	#12		; 33 5C
	ogi	13		; 33 5D
	ogi	#14		; 33 5E
	ogi	15		; 33 5F

	lei	#0		; 33 60
	lei	1		; 33 61
	lei	#2		; 33 62
	lei	3		; 33 63
	lei	#4		; 33 64
	lei	5		; 33 65
	lei	#6		; 33 66
	lei	7		; 33 67
	lei	#8		; 33 68
	lei	9		; 33 69
	lei	#10		; 33 6A
	lei	11		; 33 6B
	lei	#12		; 33 6C
	lei	13		; 33 6D
	lei	#14		; 33 6E
	lei	15		; 33 6F

	lbi	r0,#0 + x$	;v33u80
	lbi	0,1 + x$	;v33u81
	lbi	r0,#2 + x$	;v33u82
	lbi	0,3 + x$	;v33u83
	lbi	r0,#4 + x$	;v33u84
	lbi	0,5 + x$	;v33u85
	lbi	r0,#6 + x$	;v33u86
	lbi	0,7 + x$	;v33u87
	lbi	r0,#8 + x$	;v33u88
	lbi	0,9 + x$	;v33u89
	lbi	r0,#10 + x$	;v33u8A
	lbi	0,11 + x$	;v33u8B
	lbi	r0,#12 + x$	;v33u8C
	lbi	0,13 + x$	;v33u8D
	lbi	r0,#14 + x$	;v33u8E
	lbi	0,15 + x$	;v33u8F

	lbi	r1,#0 + x$	;v33u90
	lbi	1,1 + x$	;v33u91
	lbi	r1,#2 + x$	;v33u92
	lbi	1,3 + x$	;v33u93
	lbi	r1,#4 + x$	;v33u94
	lbi	1,5 + x$	;v33u95
	lbi	r1,#6 + x$	;v33u96
	lbi	1,7 + x$	;v33u97
	lbi	r1,#8 + x$	;v33u98
	lbi	1,9 + x$	;v33u99
	lbi	r1,#10 + x$	;v33u9A
	lbi	1,11 + x$	;v33u9B
	lbi	r1,#12 + x$	;v33u9C
	lbi	1,13 + x$	;v33u9D
	lbi	r1,#14 + x$	;v33u9E
	lbi	1,15 + x$	;v33u9F

	lbi	r2,#0 + x$	;v33uA0
	lbi	2,1 + x$	;v33uA1
	lbi	r2,#2 + x$	;v33uA2
	lbi	2,3 + x$	;v33uA3
	lbi	r2,#4 + x$	;v33uA4
	lbi	2,5 + x$	;v33uA5
	lbi	r2,#6 + x$	;v33uA6
	lbi	2,7 + x$	;v33uA7
	lbi	r2,#8 + x$	;v33uA8
	lbi	2,9 + x$	;v33uA9
	lbi	r2,#10 + x$	;v33uAA
	lbi	2,11 + x$	;v33uAB
	lbi	r2,#12 + x$	;v33uAC
	lbi	2,13 + x$	;v33uAD
	lbi	r2,#14 + x$	;v33uAE
	lbi	2,15 + x$	;v33uAF
				
	lbi	r3,#0 + x$	;v33uB0
	lbi	3,1 + x$	;v33uB1
	lbi	r3,#2 + x$	;v33uB2
	lbi	3,3 + x$	;v33uB3
	lbi	r3,#4 + x$	;v33uB4
	lbi	3,5 + x$	;v33uB5
	lbi	r3,#6 + x$	;v33uB6
	lbi	3,7 + x$	;v33uB7
	lbi	r3,#8 + x$	;v33uB8
	lbi	3,9 + x$	;v33uB9
	lbi	r3,#10 + x$	;v33uBA
	lbi	3,11 + x$	;v33uBB
	lbi	r3,#12 + x$	;v33uBC
	lbi	3,13 + x$	;v33uBD
	lbi	r3,#14 + x$	;v33uBE
	lbi	3,15 + x$	;v33uBF

	cqma			; 33 2C
	camq			; 33 3C

	xis	r3		; 34
	ld	3		; 35
	x	r3		; 36
	xds	3		; 37

	lbi	r3,0x09		; 38
	lbi	3,0x0A		; 39
	lbi	r3,0x0B		; 3A
	lbi	3,0x0C		; 3B
	lbi	r3,0x0D		; 3C
	lbi	3,0x0E		; 3D
	lbi	r3,0x0F		; 3E
	lbi	3,0x00		; 3F

	comp			; 40
	skt			; 41
	rmb	2		; 42
	rmb	3		; 43
	nop			; 44
	rmb	1		; 45
	smb	2		; 46
	smb	1		; 47
	ret			; 48
	retsk			; 49
	adt			; 4A
	smb	3		; 4B
	rmb	0		; 4C
	smb	0		; 4D
	cba			; 4E
	xas			; 4F

	cab			; 50

	aisc	#0		; 50
	aisc	1		; 51
	aisc	#2		; 52
	aisc	3		; 53
	aisc	#4		; 54
	aisc	5		; 55
	aisc	#6		; 56
	aisc	7		; 57
	aisc	#8		; 58
	aisc	9		; 59
	aisc	#10		; 5A
	aisc	11		; 5B
	aisc	#12		; 5C
	aisc	13		; 5D
	aisc	#14		; 5E
	aisc	15		; 5F

	jmp	0x0F0		;v60uF0
	jmp	0x1E0		;v61uE0
	jmp	0x2D0		;v62uD0
	jmp	0x3C0		;v63uC0
	jmp	0x4B0		;v64uB0
	jmp	0x5A0		;v65uA0
	jmp	0x690		;v66u90
	jmp	0x780		;v67u80

	jsr	0x070		;v68u70
	jsr	0x160		;v69u60
	jsr	0x250		;v6Au50
	jsr	0x340		;v6Bu40
	jsr	0x430		;v6Cu30
	jsr	0x520		;v6Du20
	jsr	0x610		;v6Eu10
	jsr	0x700		;v6Fu00

	stii	#0		; 70
	stii	1		; 71
	stii	#2		; 72
	stii	3		; 73
	stii	#4		; 74
	stii	5		; 75
	stii	#6		; 76
	stii	7		; 77
	stii	#8		; 78
	stii	9		; 79
	stii	#10		; 7A
	stii	11		; 7B
	stii	#12		; 7C
	stii	13		; 7D
	stii	#14		; 7E
	stii	15		; 7F

	jsrp	0x082		;*82
	jsrp	0x0BE		;*BE

	.nval	a$,.
	a$ = (a$ & ~0x3F)	; Current Page Boundary
	a$ = a$ + 0x0040	; Next Page Boundary
	.org	a$
	jp	a$		;*C0
	jp	a$ + 0x3E	;*FE

	lqid			; BF

	jid			; FF


	.sbttl	Sequential Instruction Opcodes With Externals

	.org	0

	clra			; 00
	skmbz	0		; 01
	xor			; 02
	skmbz	2		; 03
	xis	r0		; 04
	ld	0 + x$		;u05
	x	r0		; 06
	xds	0 + x$		;u07

	lbi	r0,0x09		; 08
	lbi	0 + x$,0x0A	;u09
	lbi	r0,0x0B		; 0A
	lbi	0 + x$,0x0C	;u0B
	lbi	r0,0x0D		; 0C
	lbi	0 + x$,0x0E	;u0D
	lbi	r0,0x0F		; 0E
	lbi	0 + x$,0x00	;u0F

	casc			; 10
	skmbz	1		; 11
	xabr			; 12
	skmbz	3		; 13
	xis	1 + x$		;u14
	ld	r1		; 15
	x	1 + x$		;u16
	xds	r1		; 17

	lbi	r1,0x09		; 18
	lbi	1 + x$,0x0A	;u19
	lbi	r1,0x0B		; 1A
	lbi	1 + x$,0x0C	;u1B
	lbi	r1,0x0D		; 1C
	lbi	1 + x$,0x0E	;u1D
	lbi	r1,0x0F		; 1E
	lbi	1 + x$,0x00	;u1F

	skc			; 20
	ske			; 21
	sc			; 22

	ldd	r0,0x00 + x$	;v23u00
	ldd	0 + x$,0x01	;v23u01
	ldd	r0,0x02 + x$	;v23u02
	ldd	0 + x$,0x03	;v23u03
	ldd	r0,0x04 + x$	;v23u04
	ldd	0 + x$,0x05	;v23u05
	ldd	r0,0x06 + x$	;v23u06
	ldd	0 + x$,0x07	;v23u07
	ldd	r0,0x08 + x$	;v23u08
	ldd	0 + x$,0x09	;v23u09
	ldd	r0,0x0A	+ x$	;v23u0A
	ldd	0 + x$,0x0B	;v23u0B
	ldd	r0,0x0C + x$	;v23u0C
	ldd	0 + x$,0x0D	;v23u0D
	ldd	r0,0x0E + x$	;v23u0E
	ldd	0 + x$,0x0F	;v23u0F

	ldd	r1,0x00 + x$	;v23u10
	ldd	1,0x01 + x$	;v23u11
	ldd	r1,0x02 + x$	;v23u12
	ldd	1,0x03 + x$	;v23u13
	ldd	r1,0x04 + x$	;v23u14
	ldd	1,0x05 + x$	;v23u15
	ldd	r1,0x06 + x$	;v23u16
	ldd	1,0x07 + x$	;v23u17
	ldd	r1,0x08 + x$	;v23u18
	ldd	1,0x09 + x$	;v23u19
	ldd	r1,0x0A + x$	;v23u1A
	ldd	1,0x0B + x$	;v23u1B
	ldd	r1,0x0C + x$	;v23u1C
	ldd	1,0x0D + x$	;v23u1D
	ldd	r1,0x0E + x$	;v23u1E
	ldd	1,0x0F + x$	;v23u1F

	ldd	r2,0x00 + x$	;v23u20
	ldd	2 + x$,0x01	;v23u21
	ldd	r2,0x02 + x$	;v23u22
	ldd	2 + x$,0x03	;v23u23
	ldd	r2,0x04 + x$	;v23u24
	ldd	2 + x$,0x05	;v23u25
	ldd	r2,0x06 + x$	;v23u26
	ldd	2 + x$,0x07	;v23u27
	ldd	r2,0x08 + x$	;v23u28
	ldd	2 + x$,0x09	;v23u29
	ldd	r2,0x0A + x$	;v23u2A
	ldd	2 + x$,0x0B	;v23u2B
	ldd	r2,0x0C + x$	;v23u2C
	ldd	2 + x$,0x0D	;v23u2D
	ldd	r2,0x0E + x$	;v23u2E
	ldd	2 + x$,0x0F	;v23u2F

	ldd	r3,0x00 + x$	;v23u30
	ldd	3,0x01 + x$	;v23u31
	ldd	r3,0x02 + x$	;v23u32
	ldd	3,0x03 + x$	;v23u33
	ldd	r3,0x04 + x$	;v23u34
	ldd	3,0x05 + x$	;v23u35
	ldd	r3,0x06 + x$	;v23u36
	ldd	3,0x07 + x$	;v23u37
	ldd	r3,0x08 + x$	;v23u38
	ldd	3,0x09 + x$	;v23u39
	ldd	r3,0x0A + x$	;v23u3A
	ldd	3,0x0B + x$	;v23u3B
	ldd	r3,0x0C + x$	;v23u3C
	ldd	3,0x0D + x$	;v23u3D
	ldd	r3,0x0E + x$	;v23u3E
	ldd	3,0x0F + x$	;v23u3F

	xad	r0,0x00 + x$	;v23u80
	xad	0 + x$,0x01	;v23u81
	xad	r0,0x02 + x$	;v23u82
	xad	0 + x$,0x03	;v23u83
	xad	r0,0x04 + x$	;v23u84
	xad	0 + x$,0x05	;v23u85
	xad	r0,0x06 + x$	;v23u86
	xad	0 + x$,0x07	;v23u87
	xad	r0,0x08 + x$	;v23u88
	xad	0 + x$,0x09	;v23u89
	xad	r0,0x0A + x$	;v23u8A
	xad	0 + x$,0x0B	;v23u8B
	xad	r0,0x0C + x$	;v23u8C
	xad	0 + x$,0x0D	;v23u8D
	xad	r0,0x0E + x$	;v23u8E
	xad	0 + x$,0x0F	;v23u8F

	xad	r1,0x00 + x$	;v23u90
	xad	1,0x01 + x$	;v23u91
	xad	r1,0x02 + x$	;v23u92
	xad	1,0x03 + x$	;v23u93
	xad	r1,0x04 + x$	;v23u94
	xad	1,0x05 + x$	;v23u95
	xad	r1,0x06 + x$	;v23u96
	xad	1,0x07 + x$	;v23u97
	xad	r1,0x08 + x$	;v23u98
	xad	1,0x09 + x$	;v23u99
	xad	r1,0x0A + x$	;v23u9A
	xad	1,0x0B + x$	;v23u9B
	xad	r1,0x0C + x$	;v23u9C
	xad	1,0x0D + x$	;v23u9D
	xad	r1,0x0E + x$	;v23u9E
	xad	1,0x0F + x$	;v23u9F

	xad	r2,0x00 + x$	;v23uA0
	xad	2 + x$,0x01	;v23uA1
	xad	r2,0x02 + x$	;v23uA2
	xad	2 + x$,0x03	;v23uA3
	xad	r2,0x04 + x$	;v23uA4
	xad	2 + x$,0x05	;v23uA5
	xad	r2,0x06 + x$	;v23uA6
	xad	2 + x$,0x07	;v23uA7
	xad	r2,0x08 + x$	;v23uA8
	xad	2 + x$,0x09	;v23uA9
	xad	r2,0x0A + x$	;v23uAA
	xad	2 + x$,0x0B	;v23uAB
	xad	r2,0x0C + x$	;v23uAC
	xad	2 + x$,0x0D	;v23uAD
	xad	r2,0x0E + x$	;v23uAE
	xad	2 + x$,0x0F	;v23uAF

	xad	r3,0x00 + x$	;v23uB0
	xad	3,0x01 + x$	;v23uB1
	xad	r3,0x02 + x$	;v23uB2
	xad	3,0x03 + x$	;v23uB3
	xad	r3,0x04 + x$	;v23uB4
	xad	3,0x05 + x$	;v23uB5
	xad	r3,0x06 + x$	;v23uB6
	xad	3,0x07 + x$	;v23uB7
	xad	r3,0x08 + x$	;v23uB8
	xad	3,0x09 + x$	;v23uB9
	xad	r3,0x0A + x$	;v23uBA
	xad	3,0x0B + x$	;v23uBB
	xad	r3,0x0C + x$	;v23uBC
	xad	3,0x0D + x$	;v23uBD
	xad	r3,0x0E + x$	;v23uBE
	xad	3,0x0F + x$	;v23uBF

	xis	r2		; 24
	ld	2 + x$		;u25
	x	r2		; 26
	xds	2 + x$		;u27

	lbi	r2,0x09		; 28
	lbi	2 + x$,0x0A	;u29
	lbi	r2,0x0B		; 2A
	lbi	2 + x$,0x0C	;u2B
	lbi	r2,0x0D		; 2C
	lbi	2 + x$,0x0E	;u2D
	lbi	r2,0x0F		; 2E
	lbi	2 + x$,0x00	;u2F

	asc			; 30
	add			; 31
	rc			; 32

	skgbz	0		; 33 01
	skgbz	2		; 33 03

	xan			; 33 0B
	cema			; 33 0F

	skgbz	1		; 33 11
	skgbz	3		; 33 13

	lid			; 33 19
	or			; 33 1A
	sksz			; 33 1C

	came			; 33 1F
	skgz			; 33 21

	inin			; 33 28
	inil			; 33 29
	ing			; 33 2A
	inh			; 33 2B
	cqma			; 33 2C
	inr			; 33 2D
	inl			; 33 2E
	ctma			; 33 2F
	halt			; 33 38
	it			; 33 39
	omg			; 33 3A
	omh			; 33 3B
	camq			; 33 3C
	camr			; 33 3D
	obd			; 33 3E
	camt			; 33 3F

	ogi	#0 + x$		; 33r50
	ogi	1 + x$		; 33r51
	ogi	#2 + x$		; 33r52
	ogi	3 + x$		; 33r53
	ogi	#4 + x$		; 33r54
	ogi	5 + x$		; 33r55
	ogi	#6 + x$		; 33r56
	ogi	7 + x$		; 33r57
	ogi	#8 + x$		; 33r58
	ogi	9 + x$		; 33r59
	ogi	#10 + x$	; 33r5A
	ogi	11 + x$		; 33r5B
	ogi	#12 + x$	; 33r5C
	ogi	13 + x$		; 33r5D
	ogi	#14 + x$	; 33r5E
	ogi	15 + x$		; 33r5F

	lei	#0 + x$		; 33r60
	lei	1 + x$		; 33r61
	lei	#2 + x$		; 33r62
	lei	3 + x$		; 33r63
	lei	#4 + x$		; 33r64
	lei	5 + x$		; 33r65
	lei	#6 + x$		; 33r66
	lei	7 + x$		; 33r67
	lei	#8 + x$		; 33r68
	lei	9 + x$		; 33r69
	lei	#10 + x$	; 33r6A
	lei	11 + x$		; 33r6B
	lei	#12 + x$	; 33r6C
	lei	13 + x$		; 33r6D
	lei	#14 + x$	; 33r6E
	lei	15 + x$		; 33r6F

	lbi	r0,#0 + x$	;v33u80
	lbi	0,1 + x$	;v33u81
	lbi	r0,#2 + x$	;v33u82
	lbi	0,3 + x$	;v33u83
	lbi	r0,#4 + x$	;v33u84
	lbi	0,5 + x$	;v33u85
	lbi	r0,#6 + x$	;v33u86
	lbi	0,7 + x$	;v33u87
	lbi	r0,#8 + x$	;v33u88
	lbi	0,9 + x$	;v33u89
	lbi	r0,#10 + x$	;v33u8A
	lbi	0,11 + x$	;v33u8B
	lbi	r0,#12 + x$	;v33u8C
	lbi	0,13 + x$	;v33u8D
	lbi	r0,#14 + x$	;v33u8E
	lbi	0,15 + x$	;v33u8F

	lbi	r1,#0 + x$	;v33u90
	lbi	1,1 + x$	;v33u91
	lbi	r1,#2 + x$	;v33u92
	lbi	1,3 + x$	;v33u93
	lbi	r1,#4 + x$	;v33u94
	lbi	1,5 + x$	;v33u95
	lbi	r1,#6 + x$	;v33u96
	lbi	1,7 + x$	;v33u97
	lbi	r1,#8 + x$	;v33u98
	lbi	1,9 + x$	;v33u99
	lbi	r1,#10 + x$	;v33u9A
	lbi	1,11 + x$	;v33u9B
	lbi	r1,#12 + x$	;v33u9C
	lbi	1,13 + x$	;v33u9D
	lbi	r1,#14 + x$	;v33u9E
	lbi	1,15 + x$	;v33u9F

	lbi	r2,#0 + x$	;v33uA0
	lbi	2,1 + x$	;v33uA1
	lbi	r2,#2 + x$	;v33uA2
	lbi	2,3 + x$	;v33uA3
	lbi	r2,#4 + x$	;v33uA4
	lbi	2,5 + x$	;v33uA5
	lbi	r2,#6 + x$	;v33uA6
	lbi	2,7 + x$	;v33uA7
	lbi	r2,#8 + x$	;v33uA8
	lbi	2,9 + x$	;v33uA9
	lbi	r2,#10 + x$	;v33uAA
	lbi	2,11 + x$	;v33uAB
	lbi	r2,#12 + x$	;v33uAC
	lbi	2,13 + x$	;v33uAD
	lbi	r2,#14 + x$	;v33uAE
	lbi	2,15 + x$	;v33uAF
				
	lbi	r3,#0 + x$	;v33uB0
	lbi	3,1 + x$	;v33uB1
	lbi	r3,#2 + x$	;v33uB2
	lbi	3,3 + x$	;v33uB3
	lbi	r3,#4 + x$	;v33uB4
	lbi	3,5 + x$	;v33uB5
	lbi	r3,#6 + x$	;v33uB6
	lbi	3,7 + x$	;v33uB7
	lbi	r3,#8 + x$	;v33uB8
	lbi	3,9 + x$	;v33uB9
	lbi	r3,#10 + x$	;v33uBA
	lbi	3,11 + x$	;v33uBB
	lbi	r3,#12 + x$	;v33uBC
	lbi	3,13 + x$	;v33uBD
	lbi	r3,#14 + x$	;v33uBE
	lbi	3,15 + x$	;v33uBF

	cqma			; 33 2C
	camq			; 33 3C

	xis	r3		; 34
	ld	3 + x$		;u35
	x	r3		; 36
	xds	3 + x$		;u37

	lbi	r3,0x09		; 38
	lbi	3 + x$,0x0A	;u39
	lbi	r3,0x0B		; 3A
	lbi	3 + x$,0x0C	;u3B
	lbi	r3,0x0D		; 3C
	lbi	3 + x$,0x0E	;u3D
	lbi	r3,0x0F		; 3E
	lbi	3 + x$,0x00	;u3F

	comp			; 40
	skt			; 41
	rmb	2		; 42
	rmb	3		; 43
	nop			; 44
	rmb	1		; 45
	smb	2		; 46
	smb	1		; 47
	ret			; 48
	retsk			; 49
	adt			; 4A
	smb	3		; 4B
	rmb	0		; 4C
	smb	0		; 4D
	cba			; 4E
	xas			; 4F

	cab			; 50

	aisc	#0 + x$		;r50
	aisc	1 + x$		;r51
	aisc	#2 + x$		;r52
	aisc	3 + x$		;r53
	aisc	#4 + x$		;r54
	aisc	5 + x$		;r55
	aisc	#6 + x$		;r56
	aisc	7 + x$		;r57
	aisc	#8 + x$		;r58
	aisc	9 + x$		;r59
	aisc	#10 + x$	;r5A
	aisc	11 + x$		;r5B
	aisc	#12 + x$	;r5C
	aisc	13 + x$		;r5D
	aisc	#14 + x$	;r5E
	aisc	15 + x$		;r5F

	jmp	0x0F0 + x$	;v60uF0
	jmp	0x1E0 + x$	;v61uE0
	jmp	0x2D0 + x$	;v62uD0
	jmp	0x3C0 + x$	;v63uC0
	jmp	0x4B0 + x$	;v64uB0
	jmp	0x5A0 + x$	;v65uA0
	jmp	0x690 + x$	;v66u90
	jmp	0x780 + x$	;v67u80

	jsr	0x070 + x$	;v68u70
	jsr	0x160 + x$	;v69u60
	jsr	0x250 + x$	;v6Au50
	jsr	0x340 + x$	;v6Bu40
	jsr	0x430 + x$	;v6Cu30
	jsr	0x520 + x$	;v6Du20
	jsr	0x610 + x$	;v6Eu10
	jsr	0x700 + x$	;v6Fu00

	stii	#0 + x$		;r70
	stii	1 + x$		;r71
	stii	#2 + x$		;r72
	stii	3 + x$		;r73
	stii	#4 + x$		;r74
	stii	5 + x$		;r75
	stii	#6 + x$		;r76
	stii	7 + x$		;r77
	stii	#8 + x$		;r78
	stii	9 + x$		;r79
	stii	#10 + x$	;r7A
	stii	11 + x$		;r7B
	stii	#12 + x$	;r7C
	stii	13 + x$		;r7D
	stii	#14 + x$	;r7E
	stii	15 + x$		;r7F

	jsrp	0x082 + x$	;*82
	jsrp	0x0BE + x$	;*BE

	.nval	a$,.
	a$ = (a$ & ~0x3F)	; Current Page Boundary
	a$ = a$ + 0x0040	; Next Page Boundary
	.org	a$
	jp	a$		;*C0
	jp	a$ + 0x3E	;*FE

	lqid			; BF

	jid			; FF


	.sbttl	Verify JP Instruction Paging

	.macro	jp_Paging	A
	  .list
	  .list	(mel)

	  .org	'A * 0x0040
jpg'A:	  jp	.			;*C0
	  jp	. + 0x3D		;*FE
	  jp	jpg'A			;*C0
	  jp	jpg'A + 0x3E		;*FE
	  jp	'A * 0x0040		;*C0
	  jp	'A * 0x0040 + 0x3E	;*FE
	  jp	'A * 0x0040 + x$	;*C0
	  jp	'A * 0x0040 + 0x3E + x$	;*FE

	.endm

	.sbttl	Pages 0 - 7	(0x0000 - 0x01FF)

	.nlist
	.irp	A, 0, 1, 2, 3, 4, 5, 6, 7
	  jp_Paging	A
	.endm
	.list

	.sbttl	pages 8 - 15	(0x0200 - 0x03FF)

	.nlist
	.irp	A, 8, 9,10,11,12,13,14,15
	  jp_Paging	A
	.endm
	.list

	.sbttl	Pages 16 - 23	(0x0400 - 0x05F)

	.nlist
	.irp	A,16,17,18,19,20,21,22,23
	  jp_Paging	A
	.endm
	.list

	.sbttl	Pages 24 - 31	(0x0600 - 0x07FF)

	.nlist
	.irp	A,24,25,26,27,28,29,30,31
	  jp_Paging	A
	.endm
	.list


	.sbttl	Verify jp23 Instruction Paging

	.org	2 * 0x0040	; Page 2
page2A:	jp23	page2A		;*80
	jp23	page2A + 0x3E	;*BE
	jp23	page3A		;*C0
	jp23	page3A + 0x3E	;*FE

	.org	3 * 0x0040	; Page 3
page3A:	jp23	page2A		;*80
	jp23	page2A + 0x3E	;*BE
	jp23	page3A		;*C0
	jp23	page3A + 0x3E	;*FE


	.sbttl	Verify jsrp Instruction Paging

	.macro	jsrp_Paging	A
	  .list
	  .list	(mel)
	  .org	'A * 0x0040
jsrpg'A:  .ifne	'A - 2
	  jsrp	jsrpg2			;*80
	  jsrp	jsrpg2 + 0x3E		;*BE
	  jsrp	2 * 0x0040		;*80
	  jsrp	2 * 0x0040 + 0x3E	;*BE
	  jsrp	2 * 0x0040 + x$		;*80
	  jsrp	2 * 0x0040 + 0x3E + x$	;*BE
	  .endif

	.endm

	.sbttl	Pages 0 - 1 (0x0000 - 0x007F) and 3 - 7 (0x00C0 - 0x01FF)

	.nlist
	.irp	A, 0, 1, 2, 3, 4, 5, 6, 7
	  jsrp_Paging	A
	.endm
	.list

	.sbttl	pages 8 - 15	(0x0200 - 0x03FF)

	.nlist
	.irp	A, 8, 9,10,11,12,13,14,15
	  jsrp_Paging	A
	.endm
	.list

	.sbttl	Pages 16 - 23	(0x0400 - 0x05F)

	.nlist
	.irp	A,16,17,18,19,20,21,22,23
	  jsrp_Paging	A
	.endm
	.list

	.sbttl	Pages 24 - 31	(0x0600 - 0x07FF)

	.nlist
	.irp	A,24,25,26,27,28,29,30,31
	  jsrp_Paging	A
	.endm
	.list

	.sbttl	Linking With Alternate Areas

	jsrp	pg4A_2
	jsrp	pg4A_2+0x03E

	jp23	pg4A_2
	jp23	pg4A_2+0x03E
	jp23	pg4A_3
	jp23	pg4A_3+0x03E

	jsrp	pg4A_2
	jsrp	pg4A_2+0x03E

 	.sbttl	Linking With Relocated Alternate Area

	jsrp	pg4B_2
	jsrp	pg4B_2+0x03E

	jp23	pg4B_2
	jp23	pg4B_2+0x03E
	jp23	pg4B_3
	jp23	pg4B_3+0x03E

	jsrp	pg4B_2
	jsrp	pg4B_2+0x03E


	.sbttl	Alternate Areas / Pages

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

