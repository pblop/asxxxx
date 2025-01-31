	.title	Linking Tests

	; This assembler file tests the error checking of the
	; linker.  If the linker processing detects the following
	; conditions then a warning message will be issued:
	;
	;	signed 8-bit values		< -128	 or	> 127
	;	unsigned 8-bit values		< 0	 or	> 255
	;
	;	signed 16-bit values		< -32768  or	> 32767
	;	unsigned 16-bit values		< 0       or	> 65535
	;
	;	PC Relative Short Branchs	< -128	  or	> 127
	;	PC Relative Long Branches	< -32768  or	> 32767
	;
	; Note that the as6816 assembler cannot detect all
	; underflow or overflow conditions when evaluation
	; of an argument does not include an external variable.
	;
	; This is due to the fact that certain evaluations are not
	; actually signed but are interpreted as signed.  As an
	; example:
	;
	;	For a signed byte argument, 0x80, it is interpreted
	;	as -128.  However the machine has been defined as
	;	24-bit and the internal arithmetic is 24-bit.
	;	Thus the value is evaluated as +128.  The addition
	;	of -1 to -128 is -129 which underflows the range and
	;	should report an error.  However the 24-bit arithmatic
	;	gives a result of 127 (128 - 1) which is not an
	;	underflow or overflow and thus reports no error.
	;	The bit pattern of the generated 8-bit result for 127
	;	(0...0[01111111]) has the same pattern as the low
	;	8-bits of -129 (1...1[01111111]).
	;
	; This inconsistancy is the result of the assemblers internal
	; arithmatic precision and the specific interpretation of
	; values not in the full precision of the underlying arithmatic.

	; External Definitions
	;
	; Normally INTENAL is not defined and all
	; errors are reported by the linker.
	;
	; When LCL is defined the external symbols are given
	; values.  This results in all errors, except branches,
	; being reported during assembly.
	;
.ifdef	INTERNAL
	xz0 = 0
	xp1 = +1
	xp2 = +2
	xm1 = -1
	xm2 = -2
.endif

	;.globl	xz0, xp1, xm1, xp2, xm2

	.page
	.sbttl	S_IMMA Type Instructions

	; Signed 16-Bit Integers
zer0:	ais	#0x8000+xm1	; 37 3F 7F FF	; underflow	(linker error)
	ais	#0x8000+xz0	; 37 3F 80 00
	ais	#0x8000+xp1	; 37 3F 80 01
	ais	#+0x7FFF+xm1	; 37 3F 7F FE
	ais	#+0x7FFF+xz0	; 37 3F 7F FF
	ais	#+0x7FFF+xp1	; 37 3F 80 00	; overflow	(linker error)

	.page
	.sbttl	S_IMMB Type Instructions

	; Signed 8-Bit Bytes
	ais.b	#0x80+xm1	; 3F 7F		; underflow	(linker error)
	ais.b	#0x80+xz0	; 3F 80
	ais.b	#0x80+xp1	; 3F 81
	ais.b	#0x7F+xm1	; 3F 7E
	ais.b	#0x7F+xz0	; 3F 7F
	ais.b	#0x7F+xp1	; 3F 80		; overflow	(linker error)

	.page
	.sbttl	S_IM16 Type Instructions

	andp	#0xFFFF+xp1	; 37 3A 00 00	; overflow	(linker error)
	andp	#0xFFFF+xz0	; 37 3A FF FF
	andp	#0xFFFF+xm1	; 37 3A FF FE
	andp	#0x0000+xp1	; 37 3A 00 01
	andp	#0x0000+xz0	; 37 3A 00 00
	andp	#0x0000+xm1	; 37 3A FF FF	; underflow	(linker error)

	.page
	.sbttl	S_BIT Type Instructions

	; Signed 16-Bit Index, Fixed Value Mask
	bclr	0x8000+xm1,x,#0x67	; 08 67 7F FF	; underflow	(linker error)
	bclr	0x8000+xz0,x,#0x67	; 08 67 80 00
	bclr	0x8000+xp1,x,#0x67	; 08 67 80 01
	bclr	0x7FFF+xm1,x,#0x67	; 08 67 7F FE
	bclr	0x7FFF+xz0,x,#0x67	; 08 67 7F FF
	bclr	0x7FFF+xp1,x,#0x67	; 08 67 80 00	; overflow	(linker error)

	; Fixed Signed 16-Bit Index, Unsigned 8-Bit Mask
	bclr	0x8000,x,#0xFF+xp1	; 08 00 80 00	; overflow	(linker error)
	bclr	0x8000,x,#0xFF+xz0	; 08 FF 80 00
	bclr	0x8000,x,#0xFF+xm1	; 08 FE 80 00
	bclr	0x7FFF,x,#0x00+xp1	; 08 01 7F FF
	bclr	0x7FFF,x,#0x00+xz0	; 08 00 7F FF
	bclr	0x7FFF,x,#0x00+xm1	; 08 FF 7F FF	; underflow	(linker error)

	; Unsigned 8-Bit Index, Fixed Value Mask
	bclr	0xFF+xp1,x8,#0x67	; 17 08 67 00	; overflow	(linker error)
	bclr	0xFF+xz0,x8,#0x67	; 17 08 67 FF
	bclr	0xFF+xm1,x8,#0x67	; 17 08 67 FE

	bclr	0x00+xp1,x8,#0x67	; 17 08 67 01		
	bclr	0x00+xz0,x8,#0x67	; 17 08 67 00		
	bclr	0x00+xm1,x8,#0x67	; 17 08 67 FF	; underflow	(linker error)

	; Fixed 8-Bit Index, Unsigned 8-Bit Mask
	bclr	0xFF,x8,#0xFF+xp1	; 17 08 00 FF	; overflow	(linker error)
	bclr	0xFF,x8,#0xFF+xz0	; 17 08 FF FF
	bclr	0xFF,x8,#0xFF+xm1	; 17 08 FE FF
	bclr	0x00,x8,#0x00+xp1	; 17 08 01 00		
	bclr	0x00,x8,#0x00+xz0	; 17 08 00 00		
	bclr	0x00,x8,#0x00+xm1	; 17 08 FF 00	; underflow	(linker error)

	; Unsigned Address, Fixed Value Mask
	bclr	0xFFFF+xp1,#0x67	; 38 67 00 00	; overflow	(linker error)
	bclr	0xFFFF+xz0,#0x67	; 38 67 FF FF
	bclr	0xFFFF+xm1,#0x67	; 38 67 FF FE
	bclr	0x0000+xp1,#0x67	; 38 67 00 01
	bclr	0x0000+xz0,#0x67	; 38 67 00 00
	bclr	0x0000+xm1,#0x67	; 38 67 FF FF	; underflow	(linker error)

	; Fixed Address, Unsigned 8-Bit Mask
	bclr	0xFFFF,#0xFF+xp1	; 38 00 FF FF	; overflow	(linker error)
	bclr	0xFFFF,#0xFF+xz0	; 38 FF FF FF
	bclr	0xFFFF,#0xFF+xm1	; 38 Fe FF FF
	bclr	0x0000,#0x00+xp1	; 38 01 00 00
	bclr	0x0000,#0x00+xz0	; 38 00 00 00
	bclr	0x0000,#0x00+xm1	; 38 FF 00 00	; underflow	(linker error)

	.page
	.sbttl	S_BITW Type Instructions

	; Signed 16-Bit Index, Fixed Value Mask
	bclrw	0x8000+xm1,x,#0b0101	; 27 08 7F FF 00 05	; underflow	(linker error)
	bclrw	0x8000+xz0,x,#0b0101	; 27 08 80 00 00 05
	bclrw	0x8000+xp1,x,#0b0101	; 27 08 80 01 00 05
	bclrw	0x7FFF+xm1,x,#0b0101	; 27 08 7F FE 00 05
	bclrw	0x7FFF+xz0,x,#0b0101	; 27 08 7F FF 00 05
	bclrw	0x7FFF+xp1,x,#0b0101	; 27 08 80 00 00 05	; overflow	(linker error)

	; Fixed 16-Bit Index, Unsigned 16-Bit Mask
 	bclrw	,x,#0xFFFF+xp1		; 27 08 00 00 00 00	; overflow	(linker error
 	bclrw	,x,#0xFFFF+xz0		; 27 08 00 00 FF FF
 	bclrw	,x,#0xFFFF+xm1		; 27 08 00 00 FF FE
 	bclrw	,x,#0x0000+xp1		; 27 08 00 00 00 01
 	bclrw	,x,#0x0000+xz0		; 27 08 00 00 00 00
 	bclrw	,x,#0x0000+xm1		; 27 08 00 00 FF FF	; underflow	(linker error)

	; Unsigned Address, Fixed Value Mask
	bclrw	0xFFFF+xp1,#0b0101	; 27 38 00 00 00 05	; overflow	(linker error)
	bclrw	0xFFFF+xz0,#0b0101	; 27 38 FF FF 00 05
	bclrw	0xFFFF+xm1,#0b0101	; 27 38 FF FE 00 05
	bclrw	0x0000+xp1,#0b0101	; 27 38 00 01 00 05
	bclrw	0x0000+xz0,#0b0101	; 27 38 00 00 00 05
	bclrw	0x0000+xm1,#0b0101	; 27 38 FF FF 00 05	; underflow	(linker error)

	; Fixed Address, Unsigned 16-Bit Mask
	bclrw	0xFFFF,#0xFFFF+xp1	; 27 38 FF FF 00 00	; overflow	(linker error)
	bclrw	0xFFFF,#0xFFFF+xz0	; 27 38 FF FF FF FF
	bclrw	0xFFFF,#0xFFFF+xm1	; 27 38 FF FF FF FE
	bclrw	0x0000,#0x0000+xp1	; 27 38 00 00 00 01
	bclrw	0x0000,#0x0000+xz0	; 27 38 00 00 00 00
	bclrw	0x0000,#0x0000+xm1	; 27 38 00 00 FF FF	; underflow	(linker error)

	.page
	.sbttl	S_BRBT Type Instructions

	; Unsigned 8-Bit Mask Values
	brclr	0x12,x,#0xFF+xp1,.	; CB 00 12 FA	; overflow	(linker error)
	brclr	0x12,x,#0xFF+xz0,.	; CB FF 12 FA
	brclr	0x12,x,#0xFF+xm1,.	; CB FE 12 FA
	brclr	0x12,x,#0x00+xp1,.	; CB 01 12 FA
	brclr	0x12,x,#0x00+xz0,.	; CB 00 12 FA
	brclr	0x12,x,#0x00+xm1,.	; CB FF 12 FA	; underflow	(linker error)

	; Signed 8-Bit Index Offset
	brclr	0x80+xm1,x8,#0x34,.	; CB 34 7F FA	; overflow	(linker error)
	brclr	0x80+xz0,x8,#0x34,.	; CB 34 80 FA
	brclr	0x80+xp1,x8,#0x34,.	; CB 34 81 FA
	brclr	0x7F+xm1,x8,#0x34,.	; CB 34 7E FA
	brclr	0x7F+xz0,x8,#0x34,.	; CB 34 7F FA
	brclr	0x7F+xp1,x8,#0x34,.	; CB 34 80 FA	; underflow	(linker error)

	; Signed 16-Bit Index Offset
.ifdef	INTERNAL
	brclr	0x80+xm1,x16,#0x34,.	; 0A 34 00 7F FF FA 
	brclr	0x80+xz0,x16,#0x34,.	; 0A 34 00 80 FF FA
	brclr	0x80+xp1,x16,#0x34,.	; 0A 34 00 81 FF FA
	brclr	0x7F+xm1,x16,#0x34,.	; 0A 34 00 7E FF FA
	brclr	0x7F+xz0,x16,#0x34,.	; 0A 34 00 7F FF FA
	brclr	0x7F+xp1,x16,#0x34,.	; 0A 34 00 80 FF FA
.else
	brclr	0x80+xm1,x,#0x34,.	; 0A 34 00 7F FF FA 
	brclr	0x80+xz0,x,#0x34,.	; 0A 34 00 80 FF FA
	brclr	0x80+xp1,x,#0x34,.	; 0A 34 00 81 FF FA
	brclr	0x7F+xm1,x,#0x34,.	; 0A 34 00 7E FF FA
	brclr	0x7F+xz0,x,#0x34,.	; 0A 34 00 7F FF FA
	brclr	0x7F+xp1,x,#0x34,.	; 0A 34 00 80 FF FA
.endif
	brclr	0x8000+xm1,x,#0x34,.	; 0A 34 7F FF FF FA	; underflow	(linker error) 
	brclr	0x8000+xz0,x,#0x34,.	; 0A 34 80 00 FF FA
	brclr	0x8000+xp1,x,#0x34,.	; 0A 34 80 01 FF FA
	brclr	0x7FFF+xm1,x,#0x34,.	; 0A 34 7F FE FF FA
	brclr	0x7FFF+xz0,x,#0x34,.	; 0A 34 7F FF FF FA
	brclr	0x7FFF+xp1,x,#0x34,.	; 0A 34 80 00 FF FA	; overflow	(linker error)

	; Short Branch Range
	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0x80,x,#0x34,(v1+0)+6-0x80+xm2	; 0A 34 00 80 FF 7E	; promoted to long branch

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0x80,x8,#0x34,(v1+0)+6-0x80+xm2	; CB 34 80 7E	; out of range	(linker error)
	brclr	0x80,x8,#0x34,(v1+4)+6-0x80+xz0	; CB 34 80 80
	brclr	0x80,x8,#0x34,(v1+8)+6-0x80+xp2	; CB 34 80 82

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0x7F,x8,#0x34,(v1+0)+6+0x7E+xm2	; CB 34 7F 7C
	brclr	0x7F,x8,#0x34,(v1+4)+6+0x7E+xz0	; CB 34 7F 7E
	brclr	0x7F,x8,#0x34,(v1+8)+6+0x7E+xp2	; CB 34 7F 80	; out of range	(linker error)

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0x7F,x,#0x34,(v1+0)+6+0x7E+xp2	; 0A 34 00 7F 00 80	; promoted to long branch

	; Long Branch Range
	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0x40,x,#0x34,(v1+0)+6-0x8000+xm2	; 0A 34 00 40 7F FE	; out of range	(linker error)
	brclr	0x40,x,#0x34,(v1+6)+6-0x8000+xz0	; 0A 34 00 40 80 00
	brclr	0x40,x,#0x34,(v1+12)+6-0x8000+xp2	; 0A 34 00 40 80 02

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0x40,x,#0x34,(v1+0)+6+0x7FFE+xm2	; 0A 34 00 40 7F FC
	brclr	0x40,x,#0x34,(v1+6)+6+0x7FFE+xz0	; 0A 34 00 40 7F FE
	brclr	0x40,x,#0x34,(v1+12)+6+0x7FFE+xp2	; 0A 34 00 40 80 00	; out of range	(linker error)

	; Unsigned 16-Bit Address
	brclr	0xFFFE+xp2,#0x34,.	; 3A 34 00 00 FF FA	; out of range	(linker error)
	brclr	0xFFFE+xz0,#0x34,.	; 3A 34 FF FE FF FA
	brclr	0xFFFE+xm2,#0x34,.	; 3A 34 FF FC FF FA
	brclr	0x0000+xp2,#0x34,.	; 3A 34 00 02 FF FA
	brclr	0x0000+xz0,#0x34,.	; 3A 34 00 00 FF FA
	brclr	0x0000+xm2,#0x34,.	; 3A 34 FF FE FF FA	; out of range	(linker error)

	; Long Branch Range (with Unsigned 16-Bit Address)
	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0xFFFE,#0x34,(v1+0)+6-0x8000+xm2	; 3A 34 FF FE 7F FE	; out of range	(linker error)
	brclr	0xFFFE,#0x34,(v1+6)+6-0x8000+xz0	; 3A 34 FF FE 80 00
	brclr	0xFFFE,#0x34,(v1+12)+6-0x8000+xp2	; 3A 34 FF FE 80 02

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	brclr	0x0000,#0x34,(v1+0)+6+0x7FFE+xm2	; 3A 34 00 00 7F FC
	brclr	0x0000,#0x34,(v1+6)+6+0x7FFE+xz0	; 3A 34 00 00 7F FE
	brclr	0x0000,#0x34,(v1+12)+6+0x7FFE+xp2	; 3A 34 00 00 80 00	; out of range	(linker error)

	.page
	.sbttl	S_LDED Type Instructions

	; Unsigned 16-Bit Address
	lded	0xFFFF+xp1		; 27 71 00 00	; overflow	(linker error)
	lded	0xFFFF+xz0		; 27 71 FF FF
	lded	0xFFFF+xm1		; 27 71 FF FE
	lded	0x0000+xp1		; 27 71 00 01
	lded	0x0000+xz0		; 27 71 00 00
	lded	0x0000+xm1		; 27 71 FF FF 	; underflow	(linker error)

	.page
	.sbttl	S_JXX Type Instructions

	; Unsigned 20-Bit Address
	jmp	0x0FFFFE+xp2		; 7A 00 00 00	; out of range	(linker error)
	jmp	0x0FFFFE+xz0		; 7A 0F FF FE
	jmp	0x0FFFFE+xm2		; 7A 0F FF FC
	jmp	0x000000+xp2	        ; 7A 00 00 02
	jmp	0x000000+xz0	        ; 7A 00 00 00
	jmp	0x000000+xm2		; 7A 0F FF FE	; out of range	(linker error)

	; Signed 20-Bit Index
	jmp	0x080000+xm2,x		; 4B 07 FF FE	; out of range	(linker error)
	jmp	0x080000+xz0,x		; 4B 08 00 00
	jmp	0x080000+xp2,x		; 4B 08 00 02
	jmp	0x07FFFE+xm2,x		; 4B 07 FF FC
	jmp	0x07FFFE+xz0,x		; 4B 07 FF FE
	jmp	0x07FFFE+xp2,x		; 4B 08 00 00	; out of range	(linker error)

	.page
	.sbttl	S_MOVB  Type Instructions

	movb	0xFFFF+xp1,0x1234	; 37 FE 00 00 12 34	; out of range	(linker error)
	movb	0xFFFF+xz0,0x1234	; 37 FE FF FF 12 34
	movb	0xFFFF+xm1,0x1234	; 37 FE FF FE 12 34
	movb	0x0000+xp1,0x1234	; 37 FE 00 01 12 34
	movb	0x0000+xz0,0x1234	; 37 FE 00 00 12 34
	movb	0x0000+xm1,0x1234	; 37 FE FF FF 12 34	; out of range	(linker error)

	movb	0x1234,0xFFFF+xp1	; 37 FE 12 34 00 00	; out of range	(linker error)
	movb	0x1234,0xFFFF+xz0	; 37 FE 12 34 FF FF
	movb	0x1234,0xFFFF+xm1	; 37 FE 12 34 FF FE
	movb	0x1234,0x0000+xp1	; 37 FE 12 34 00 01
	movb	0x1234,0x0000+xz0	; 37 FE 12 34 00 00
	movb	0x1234,0x0000+xm1	; 37 FE 12 34 FF FF	; out of range	(linker error)

	movb	0x7F+xp1,x,0x1234	; 30 80 12 34		; out of range	(linker error)
	movb	0x7F+xz0,x,0x1234	; 30 7F 12 34
	movb	0x7F+xm1,x,0x1234	; 30 7E 12 34
	movb	0x80+xp1,x,0x1234	; 30 81 12 34
	movb	0x80+xz0,x,0x1234	; 30 80 12 34
	movb	0x80+xm1,x,0x1234	; 30 7F 12 34		; out of range	(linker error)

	movb	0x7F,x,0xFFFF+xp1	; 30 7F 00 00		; out of range	(linker error)
	movb	0x7F,x,0xFFFF+xz0	; 30 7F FF FF
	movb	0x7F,x,0xFFFF+xm1	; 30 7F FF FE
	movb	0x80,x,0x0000+xp1	; 30 80 00 01
	movb	0x80,x,0x0000+xz0	; 30 80 00 00
	movb	0x80,x,0x0000+xm1	; 30 80 FF FF		; out of range	(linker error)

	movb	0x1234,0x7F+xp1,x	; 32 80 12 34		; out of range	(linker error)
	movb	0x1234,0x7F+xz0,x	; 32 7F 12 34
	movb	0x1234,0x7F+xm1,x	; 32 7E 12 34
	movb	0x1234,0x80+xp1,x	; 32 81 12 34
	movb	0x1234,0x80+xz0,x	; 32 80 12 34
	movb	0x1234,0x80+xm1,x	; 32 7F 12 34		; out of range	(linker error)

	movb	0xFFFF+xp1,0x7F,x	; 32 7F 00 00		; out of range	(linker error)
	movb	0xFFFF+xz0,0x7F,x	; 32 7F FF FF
	movb	0xFFFF+xm1,0x7F,x	; 32 7F FF FE
	movb	0x0000+xp1,0x80,x	; 32 80 00 01
	movb	0x0000+xz0,0x80,x	; 32 80 00 00
	movb	0x0000+xm1,0x80,x	; 32 80 FF FF		; out of range	(linker error)

	xmovb	0xFFFF+xp1,0x1234	; 37 FE 00 00 12 34	; out of range	(linker error)
	xmovb	0xFFFF+xz0,0x1234	; 37 FE FF FF 12 34
	xmovb	0xFFFF+xm1,0x1234	; 37 FE FF FE 12 34
	xmovb	0x0000+xp1,0x1234	; 37 FE 00 01 12 34
	xmovb	0x0000+xz0,0x1234	; 37 FE 00 00 12 34
	xmovb	0x0000+xm1,0x1234	; 37 FE FF FF 12 34	; out of range	(linker error)

	xmovb	0x1234,0xFFFF+xp1	; 37 FE 12 34 00 00	; out of range	(linker error)
	xmovb	0x1234,0xFFFF+xz0	; 37 FE 12 34 FF FF
	xmovb	0x1234,0xFFFF+xm1	; 37 FE 12 34 FF FE
	xmovb	0x1234,0x0000+xp1	; 37 FE 12 34 00 01
	xmovb	0x1234,0x0000+xz0	; 37 FE 12 34 00 00
	xmovb	0x1234,0x0000+xm1	; 37 FE 12 34 FF FF	; out of range	(linker error)

	.page
	.sbttl	S_MOVW  Type Instructions

	movw	0xFFFE+xp2,0x1234	; 37 FF 00 00 12 34	; out of range	(linker error)
	movw	0xFFFE+xz0,0x1234	; 37 FF FF FE 12 34
	movw	0xFFFE+xm2,0x1234	; 37 FF FF FC 12 34
	movw	0x0000+xp2,0x1234	; 37 FF 00 02 12 34
	movw	0x0000+xz0,0x1234	; 37 FF 00 00 12 34
	movw	0x0000+xm2,0x1234	; 37 FF FF FE 12 34	; out of range	(linker error)

	movw	0x1234,0xFFFE+xp2	; 37 FF 12 34 00 00	; out of range	(linker error)
	movw	0x1234,0xFFFE+xz0	; 37 FF 12 34 FF FE
	movw	0x1234,0xFFFE+xm2	; 37 FF 12 34 FF FC
	movw	0x1234,0x0000+xp2	; 37 FF 12 34 00 02
	movw	0x1234,0x0000+xz0	; 37 FF 12 34 00 00
	movw	0x1234,0x0000+xm2	; 37 FF 12 34 FF FE	; out of range	(linker error)

	movw	0x7E+xp2,x,0x1234	; 31 80 12 34		; out of range	(linker error)
	movw	0x7E+xz0,x,0x1234	; 31 7E 12 34
	movw	0x7E+xm2,x,0x1234	; 31 7C 12 34
	movw	0x80+xp2,x,0x1234	; 31 82 12 34
	movw	0x80+xz0,x,0x1234	; 31 80 12 34
	movw	0x80+xm2,x,0x1234	; 31 7E 12 34		; out of range	(linker error)

	movw	0x7F,x,0xFFFE+xp2	; 31 7F 00 00		; out of range	(linker error)
	movw	0x7F,x,0xFFFE+xz0	; 31 7F FF FE
	movw	0x7F,x,0xFFFE+xm2	; 31 7F FF FC
	movw	0x80,x,0x0000+xp2	; 31 80 00 02
	movw	0x80,x,0x0000+xz0	; 31 80 00 00
	movw	0x80,x,0x0000+xm2	; 31 80 FF FE		; out of range	(linker error)

	movw	0x1234,0x7E+xp2,x	; 33 80 12 34		; out of range	(linker error)
	movw	0x1234,0x7E+xz0,x	; 33 7E 12 34
	movw	0x1234,0x7E+xm2,x	; 33 7C 12 34
	movw	0x1234,0x80+xp2,x	; 33 82 12 34
	movw	0x1234,0x80+xz0,x	; 33 80 12 34
	movw	0x1234,0x80+xm2,x	; 33 7E 12 34		; out of range	(linker error)

	movw	0xFFFE+xp2,0x7F,x	; 33 7F 00 00		; out of range	(linker error)
	movw	0xFFFE+xz0,0x7F,x	; 33 7F FF FE
	movw	0xFFFE+xm2,0x7F,x	; 33 7F FF FC
	movw	0x0000+xp2,0x80,x	; 33 80 00 02
	movw	0x0000+xz0,0x80,x	; 33 80 00 00
	movw	0x0000+xm2,0x80,x	; 33 80 FF FE		; out of range	(linker error)

	xmovw	0xFFFE+xp2,0x1234	; 37 FF 00 00 12 34	; out of range	(linker error)
	xmovw	0xFFFE+xz0,0x1234	; 37 FF FF FE 12 34
	xmovw	0xFFFE+xm2,0x1234	; 37 FF FF FC 12 34
	xmovw	0x0000+xp2,0x1234	; 37 FF 00 02 12 34
	xmovw	0x0000+xz0,0x1234	; 37 FF 00 00 12 34
	xmovw	0x0000+xm2,0x1234	; 37 FF FF FE 12 34	; out of range	(linker error)

	xmovw	0x1234,0xFFFE+xp2	; 37 FF 12 34 00 00	; out of range	(linker error)
	xmovw	0x1234,0xFFFE+xz0	; 37 FF 12 34 FF FE
	xmovw	0x1234,0xFFFE+xm2	; 37 FF 12 34 FF FC
	xmovw	0x1234,0x0000+xp2	; 37 FF 12 34 00 02
	xmovw	0x1234,0x0000+xz0	; 37 FF 12 34 00 00
	xmovw	0x1234,0x0000+xm2	; 37 FF 12 34 FF FE	; out of range	(linker error)

	.page
	.sbttl	S_CMP/S_LOAD/S_STOR  Type Instructions

	cps	0xFF+xp1,x8	; 4F 00		; overflow	(linker error)
	cps	0xFF+xz0,x8	; 4F FF
	cps	0xFF+xm1,x8	; 4F FE
	cps	0x00+xp1,x8	; 4F 01
	cps	0x00+xz0,x8	; 4F 00
	cps	0x00+xm1,x8	; 4F FF		; underflow	(linker error)

	cps	0x8000+xm1,x16	; 17 4F 7F FF	; underflow	(linker error)
	cps	0x8000+xz0,x16	; 17 4F 80 00
	cps	0x8000+xp1,x16	; 17 4F 80 01
	cps	0x7FFF+xm1,x16	; 17 4F 7F FE
	cps	0x7FFF+xz0,x16	; 17 4F 7F FF
	cps	0x7FFF+xp1,x16	; 17 4F 80 00	; overflow	(linker error)

	cps	#0x8000+xm2	; 37 7F 7F FE	; underflow	(linker error)
	cps	#0x8000+xz0	; 37 7F 80 00
	cps	#0x8000+xp2	; 37 7F 80 02
	cps	#0x7FFE+xm2	; 37 7F 7F FC
	cps	#0x7FFE+xz0	; 37 7F 7F FE
	cps	#0x7FFE+xp2	; 37 7F 80 00	; overflow	(linker error)

	cps	0xFFFE+xp2	; 17 7F 00 00	; out of range	(linker error)
	cps	0xFFFE+xz0	; 17 7F FF FE
	cps	0xFFFE+xm2	; 17 7F FF FC
	cps	0x0000+xp2	; 17 7F 00 02
	cps	0x0000+xz0	; 17 7F 00 00
	cps	0x0000+xm2	; 17 7F FF FE	; out of range	(linker error)

	.page
	.sbttl	S_SOPW  Type Instructions

	aslw	0x8000+xm1,x	; 27 04 7F FF	; underflow	(linker error)
	aslw	0x8000+xz0,x	; 27 04 80 00
	aslw	0x8000+xp1,x	; 27 04 80 01
	aslw	0x7FFF+xm1,x	; 27 04 7F FE
	aslw	0x7FFF+xz0,x	; 27 04 7F FF
	aslw	0x7FFF+xp1,x	;27 04 80 00	; overflow	(linker error)

	aslw	0xFFFE+xp2	; 27 34 00 00	; overflow	(linker error)
	aslw	0xFFFE+xz0	; 27 34 FF FE
	aslw	0xFFFE+xm2	; 27 34 FF FC
	aslw	0x0000+xp2	; 27 34 00 02
	aslw	0x0000+xz0	; 27 34 00 00
	aslw	0x0000+xm2	; 27 34 FF FE	; underflow	(linker error)

	.page
	.sbttl	S_SOP  Type Instructions

	asl	0xFF+xp1,x8	; 04 00		; out of range	(linker error)
	asl	0xFF+xz0,x8	; 04 FF
	asl	0xFF+xm1,x8	; 04 FE
	asl	0x00+xp1,x8	; 04 01
	asl	0x00+xz0,x8	; 04 00
	asl	0x00+xm1,x8	; 04 FF		; out of range	(linker error)

	asl	0x8000+xm1,x	; 17 04 7F FF	; underflow	(linker error)
	asl	0x8000+xz0,x	; 17 04 80 00
	asl	0x8000+xp1,x	; 17 04 80 01
	asl	0x7FFF+xm1,x	; 17 04 7F FE
	asl	0x7FFF+xz0,x	; 17 04 7F FF
	asl	0x7FFF+xp1,x	; 17 04 80 00	; overflow	(linker error)

	asl	0xFFFF+xp1	; 17 34 00 00	; overflow	(linker error)
	asl	0xFFFF+xz0	; 17 34 FF FF
	asl	0xFFFF+xm1	; 17 34 FF FE
	asl	0x0000+xp1	; 17 34 00 01
	asl	0x0000+xz0	; 17 34 00 00
	asl	0x0000+xm1	; 17 34 FF FF	; underflow	(linker error)

	.page
	.sbttl	S_DOP  Type Instructions

	adda	#0x80+xm1	; 71 7F		; underflow	(linker error)
	adda	#0x80+xz0	; 71 80
	adda	#0x80+xp1	; 71 81
	adda	#0x7F+xm1	; 71 7E
	adda	#0x7F+xz0	; 71 7F
	adda	#0x7F+xp1	; 71 80		; overflow	(linker error)

	adda	0xFF+xp1,x8	; 41 00		; overflow	(linker error)
 	adda	0xFF+xz0,x8	; 41 FF
	adda	0xFF+xm1,x8	; 41 FE
	adda	0x00+xp1,x8	; 41 01
	adda	0x00+xz0,x8	; 41 00
	adda	0x00+xm1,x8	; 41 FF		; underflow	(linker error)

	adda	0x8000+xm1,x	; 17 41 7F FF	; underflow	(linker error)
	adda	0x8000+xz0,x	; 17 41 80 00
	adda	0x8000+xp1,x	; 17 41 80 01
	adda	0x7FFF+xm1,x	; 17 41 7F FE
	adda	0x7FFF+xz0,x	; 17 41 7F FF
	adda	0x7FFF+xp1,x	; 17 41 80 00	; overflow	(linker error)

	adda	0xFFFF+xp1	; 17 71 00 00	; overflow	(linker error)
	adda	0xFFFF+xz0	; 17 71 FF FF
	adda	0xFFFF+xm1	; 17 71 FF FE
	adda	0x0000+xp1	; 17 71 00 01
	adda	0x0000+xz0	; 17 71 00 00
	adda	0x0000+xm1	; 17 71 FF FF	; underflow	(linker error)

	.page
	.sbttl	S_DOPD  Type Instructions

	addd	#0x8000+xm1	; 37 B1 7F FF	; underflow	(linker error)
	addd	#0x8000+xz0	; 37 B1 80 00
	addd	#0x8000+xp1	; 37 B1 80 01
	addd	#0x7FFF+xm1	; 37 B1 7F FE
	addd	#0x7FFF+xz0	; 37 B1 7F FF
	addd	#0x7FFF+xp1	; 37 B1 80 00	; overflow	(linker error)

	addd	0xFF+xp1,x8	; 81 00		; overflow	(linker error)
 	addd	0xFF+xz0,x8	; 81 FF
	addd	0xFF+xm1,x8	; 81 FE
	addd	0x00+xp1,x8	; 81 01
	addd	0x00+xz0,x8	; 81 00
	addd	0x00+xm1,x8	; 81 FF		; underflow	(linker error)

	addd	0x8000+xm1,x	; 37 C1 7F FF	; underflow	(linker error)
	addd	0x8000+xz0,x	; 37 C1 80 00
	addd	0x8000+xp1,x	; 37 C1 80 01
	addd	0x7FFF+xm1,x	; 37 C1 7F FE
	addd	0x7FFF+xz0,x	; 37 C1 7F FF
	addd	0x7FFF+xp1,x	; 37 C1 80 00	; overflow	(linker error)

	addd	0xFFFF+xp1	; 37 F1 00 00	; overflow	(linker error)
	addd	0xFFFF+xz0	; 37 F1 FF FF
	addd	0xFFFF+xm1	; 37 F1 FF FE
	addd	0x0000+xp1	; 37 F1 00 01
	addd	0x0000+xz0	; 37 F1 00 00
	addd	0x0000+xm1	; 37 F1 FF FF	; underflow	(linker error)

	.page
	.sbttl	S_DOPDB  Type Instructions

	addd.b	#0x80+xm1	; FC 7F		; underflow	(linker error)
	addd.b	#0x80+xz0	; FC 80
	addd.b	#0x80+xp1	; FC 81
	addd.b	#0x7F+xm1	; FC 7E
	addd.b	#0x7F+xz0	; FC 7F
	addd.b	#0x7F+xp1	; FC 80		; overflow	(linker error)

	.page
	.sbttl	S_DOPE  Type Instructions

	adde	#0x8000+xm1	; 37 31 7F FF	; underflow	(linker error)
	adde	#0x8000+xz0	; 37 31 80 00
	adde	#0x8000+xp1	; 37 31 80 01
	adde	#0x7FFF+xm1	; 37 31 7F FE
	adde	#0x7FFF+xz0	; 37 31 7F FF
	adde	#0x7FFF+xp1	; 37 31 80 00	; overflow	(linker error)

	adde	0x8000+xm1,x	; 37 41 7F FF	; underflow	(linker error)
	adde	0x8000+xz0,x	; 37 41 80 00
	adde	0x8000+xp1,x	; 37 41 80 01
	adde	0x7FFF+xm1,x	; 37 41 7F FE
	adde	0x7FFF+xz0,x	; 37 41 7F FF
	adde	0x7FFF+xp1,x	; 37 41 80 00	; overflow	(linker error)

	adde	0xFFFF+xp1	; 37 71 00 00	; overflow	(linker error)
	adde	0xFFFF+xz0	; 37 71 FF FF
	adde	0xFFFF+xm1	; 37 71 FF FE
	adde	0x0000+xp1	; 37 71 00 01
	adde	0x0000+xz0	; 37 71 00 00
	adde	0x0000+xm1	; 37 71 FF FF	; underflow	(linker error)

	.page
	.sbttl	S_DOPEB  Type Instructions

	adde.b	#0x80+xm1	; 7C 7F		; underflow	(linker error)
	adde.b	#0x80+xz0	; 7C 80
	adde.b	#0x80+xp1	; 7C 81
	adde.b	#0x7F+xm1	; 7C 7E
	adde.b	#0x7F+xz0	; 7C 7F
	adde.b	#0x7F+xp1	; 7C 80		; overflow	(linker error)

	.page
	.sbttl	S_BRA  Type Instructions

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	bra	(v1+0)+6-0x80+xm1		; B0 7F		; out of range	(linker error)
	bra	(v1+2)+6-0x80+xz0		; B0 80
	bra	(v1+4)+6-0x80+xp1		; B0 81

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	bra	(v1+0)+6+0x7F+xm1		; B0 7E
	bra	(v1+2)+6+0x7F+xz0		; B0 7F
	bra	(v1+4)+6+0x7F+xp1		; B0 80		; out of range	(linker error)

	.page
	.sbttl	S_LBRA/S_LBSR  Type Instructions

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	lbra	(v1+0)+6-0x8000+xm1		; 37 80 7F FF	; out of range	(linker error)
	lbra	(v1+4)+6-0x8000+xz0		; 37 80 80 00
	lbra	(v1+8)+6-0x8000+xp1		; 37 80 80 01

	.nval	v1,.	; v1 Is The Address Of The Next Instruction
	lbra	(v1+0)+6+0x7FFF+xm1		; 37 80 7F FE
	lbra	(v1+4)+6+0x7FFF+xz0		; 37 80 7F FF
	lbra	(v1+8)+6+0x7FFF+xp1		; 37 80 80 00	; out of range	(linker error)


	.end
