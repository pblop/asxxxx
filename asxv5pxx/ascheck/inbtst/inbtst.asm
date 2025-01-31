	.title	.incbin Test

	; File 'txt.bin' has 20 characters - '0123456789ABCDEFGHIJ'
	; File 'txt.b' does not exist

	.radix D

	.byte	'-				; 2D
B1:	.incbin	"txt.b",	0,	10	;    ;<i>
	.byte	. - B1				; 00

	.byte	'-				; 2D
B2:	.incbin	"txt.bin",	0,	0	;
	.byte	. - B2				; 00

	.byte	'-				; 2D
B3:	.incbin	"txt.bin",	0,	5	; 30 31 32 33 34
	.byte	. - B3				; 05

	.byte	'-				; 2D
B4:	.incbin	"txt.bin",	0,	10	; 30 31 32 33 34 35
	.byte	. - B4				; 0A

	.byte	'-				; 2D
B5:	.incbin	"txt.bin",	0,	15	; 30 31 32 33 34 35
	.byte	. - B5				; 0F

	.byte	'-				; 2D
B6:	.incbin	"txt.bin",	0,	20	; 30 31 32 33 34 35
	.byte	. - B6				; 14

	.byte	'-				; 2D
B7:	.incbin	"txt.bin",	0,	25	; 30 31 32 33 34 35
	.byte	. - B7				; 14

	; *****-----*****-----*****-----*****-----*****

	.byte	'-				; 2D
B8:	.incbin	"txt.bin"	10	0	;
	.byte	. - B8				; 00

	.byte	'-				; 2D
B9:	.incbin	"txt.bin"	10	5	; 41 42 43 44 45
	.byte	. - B9				; 05

	.byte	'-				; 2D
B10:	.incbin	"txt.bin"	10	10	; 41 42 43 44 45 46
	.byte	. - B10				; 0A

	.byte	'-				; 2D
B11:	.incbin	"txt.bin"	10	15	; 41 42 43 44 45 46
	.byte	. - B11				; 0A

	; *****-----*****-----*****-----*****-----*****

	.byte	'-				; 2D
B12:	.incbin	"txt.bin",	20,	0	;    ;<i>
	.byte	. - B12				; 00

	.byte	'-				; 2D
B13:	.incbin	"txt.bin",	20,	1	;    ;<i>
	.byte	. - B13				; 00

	.byte	'-				; 2D
B14:	.incbin	"txt.bin",	25,	0	;    ;<i>
	.byte	. - B14				; 00

	; *****-----*****-----*****-----*****-----*****

	.byte	'-				; 2D
B15:	.incbin	"txt.bin"			; 30 31 32 33 34 35
	.byte	. - B15				; 14

	.byte	'-				; 2D
B16:	.incbin	"txt.bin"	10		; 41 42 43 44 45 46
	.byte	. - B16				; 0A

	.byte	'-				; 2D
B17:	.incbin	"txt.bin",	,	15	; 30 31 32 33 34 35
	.byte	. - B17				; 0F


	.end
