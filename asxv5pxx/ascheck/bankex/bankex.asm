; bankex.asm

	;*****-----*****-----*****-----*****-----*****-----*****-----*****
	;*
	;*			Bank Usage Example
	;*
	;*   1)	Create three banks each containing multiple
	;*	areas of varying size and content.
	;*
	;*   2)	Each area will be built in this file and then
	;*	rearranged at link time.
	;*
	;*****-----*****-----*****-----*****-----*****-----*****-----*****
	;*
	;*	The Area and Banking Information
	;*	can be specified in multiple ways.
	;*
	;*   1)	Place the area/bank definition in this file.
	;*   2)	As an include file at the beginning of the assembly file.
	;*   3) As a seperate file assembled and linked with this file.
	;*
	;*	The format is identical for all of the methods:
	;*
	;*	Parameters -	set base address,
	;*			do not specify a maximum size, and
	;*			do not output to an alternate file
	;*
	;*			(if the base address is not specified here
	;*			it can be specified as an option at link time)
	;*
	;*		.bank	A	(base=0x8000)
	;*
	;*		.bank	B	(base=0x4000)
	;*
	;*		.bank	C	(base=0x6000
	;*
	;*	Parameters -	set the code type
	;*			in this example the sections are
	;*			relocatable, concatenated, and
	;*			associated with a specific bank
	;*
	;*		.area	A1	(rel,con,bank=A)
	;*		.area	A2	(rel,con,bank=A)
	;*		.area	A3	(rel,con,bank=A)
	;*
	;*		.area	B1	(rel,con,bank=B)
	;*		.area	B2	(rel,con,bank=B)
	;*		.area	B3	(rel,con,bank=B)
	;*
	;*	NOTE:	Within a single file, area parameters
	;*		need to be specified in the first definition.
	;*		Subsequent area directives must be blank or
	;*		have the same parameters.
	;*
	;*	NOTE:	The areas are loaded in the order given to the linker:
	;*		In this example the order is A1, A2, and A3 in Bank A,
	;*		B1, B2, and B3 in Bank B. and C1, C2, and C3 in Bank C.
	;*
	;*****-----*****-----*****-----*****-----*****-----*****-----*****
	;*
	;*  Local Definition Of Banks and Areas -
	;*

	.bank	A	(base=0x8000)
	.bank	B	(base=0x4000)
	.bank	C	(base=0x6000)

	;*  Areas Will Be Concatenated In This Order

	.area	A1	(rel,con,bank=A)
	.area	A2	(rel,con,bank=A)
	.area	A3	(rel,con,bank=A)

	.area	B1	(rel,con,bank=B)
	.area	B2	(rel,con,bank=B)
	.area	B3	(rel,con,bank=B)

	.area	C1	(abs,ovr,bank=C)
	.area	C2	(abs,ovr,bank=C)
	.area	C3	(abs,con,bank=C)


	; Areas To Assemble

	.area	A3

a3:	.blkb	0x20		; allocate 0x20 bytes
end_a3:

	;*****

	.area	B2

b2:	.blkb	0x200		; allocate 0x200 bytes
end_b2:

	;*****

	.area	A2

a2:	.blkb	0x40		; allocate 0x40 bytes
end_a2:

	;*****

	.area	B1

b1:	.word	a1
	.word	end_a1
	.word	a2
	.word	end_a2
	.word	a3
	.word	end_a3
	.word	b1
	.word	end_b1
	.word	b2
	.word	end_b2
	.word	b3
	.word	end_b3

	bw = . - b1
	. = . + (0x0100 - bw)	; start at an offset of 0x100
	.blkb	0x10		; allocate 0x10 bytes
end_b1:

	;*****

	.area	B3

b3:	.blkb	0x80		; allocate 0x80 bytes
end_b3:

	;*****

	.area	A1

a1:	.word	a1
	.word	end_a1
	.word	a2
	.word	end_a2
	.word	a3
	.word	end_a3
	.word	b1
	.word	end_b1
	.word	b2
	.word	end_b2
	.word	b3
	.word	end_b3

	.blkb	0x180		; allocate 0x180 bytes
end_a1:

	;*****

	.area	A1
a1x:	.word	a1x
	.area	A2
a2x:	.word	a2x
	.area	A3
a3x:	.word	a3x

	;*****

	.area	C3

	.org	0x100

c3:	.word	c3

	;*****

	.area	C2

	.org	0x200

c2:	.word	c2

	;*****

	.area	C1

c1:	.word	c1


	.end
