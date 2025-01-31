	.title	AS78K0 Opcode Error Test

	; Notes:
	;	Absolute addresses (CONSTANTS) will be checked as
	;	being in the 'saddr' range first and then as being
	;	in the 'sfr' range if no explicit @ or * is specified.
	;
	;	!  -  address is NOT PC Relative
	;	#  -  immediate value
	;	@  -  force 'saddr' address (0xFE20-0xFF1F)
	;	*  -  force   'sfr' address (0xFF00-0xFFCF, 0xFFE0-0xFFFF)
	;
	;	If the 'sfr' or 'saddr' address is external then the
	;	user is responsible to ensure the addresses are in the
	;	proper ranges.  NO ERRORS will be reported by the linker.

			; sfr addresses
	sfrFF00		=	0xFF00
	sfrFF21		=	0xFF21

			; saddr addresses
	saddrFE20	=	0xFE20
	saddrFF17	=	0xFF17

			; Byte values

	byt01		=	0x01
	byt23		=	0x23
	byt45		=	0x45
	byt67		=	0x67

			; addr11 addresses
	addr11		=	0x0865

			; addr16 addresses
	addr16		=	0xE016

			; bit addresses
	bit0		=	0
	bit1		=	1
	bit2		=	2
	bit3		=	3
	bit4		=	4
	bit5		=	5
	bit6		=	6
	bit7		=	7

			; Indirect addresses
	ind40		=	0x40
	ind50		=	0x50
	ind60		=	0x60
	ind70		=	0x70


	.page
	.sbttl	Error Generating Instructions

	cmp	l,b
	movw	ax,saddrFF17




	.end

