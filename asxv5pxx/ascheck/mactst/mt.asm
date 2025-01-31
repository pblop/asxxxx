	.title	Macro Processor Tests
	.list	(me)

	; MACRO Evaluation Definitions

	SCtrl = 20

	.macro	bld	BLOCK=10,CTRL=\SCtrl
	  .word	BLOCK
	  .word	CTRL
	.endm

	bld				; BLOCK=10, CTRL=20

	bld	1,BLOCK=3		; BLOCK=3 WIll Overwrite Argument 1

	bld	CTRL=2,BLOCK=1		; Define Elements

	bld	CTRL=5,BLOCK=\SCtrl	; Use '\' Evaluation

	; NOTE: Defined Elements Do Not Count As Arguments

	bld	CTRL=6,BLOCK=5,1,2	; BLOCK becomes 1, CTRL becomes 2

	bld	1,2,CTRL=6,BLOCK=5	; Block becomes 5, CTRL becomes 6


	; MACRO Comma Processing

	.macro	setab,   A,B,C	; Define macro seta
	  .iifnb A	.byte	A
	  .iifnb B	.byte	B
	  .iifnb C	.byte	C
	.endm

	val = 3

	setab   1,2,\val

	setab,   ,2,3

	setab   ,2,

	setab,   ,,3

	setab	1

	setab,,2,


