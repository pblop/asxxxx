.nlist
;****************************************************************************
;
; Compile The Extra Help Code
;
;	AS89LP -loxff xhelp.asm
;
;
; To Define The XHELP Globals Place The Following Lines In Your Code
;
;	.define _xhelp
;	.list	(!)	; This Inhibits The Include File Pagination
;	.include "xhelp.asm"
;	.list
;
;****************************************************************************
;
; XHELP.ASM Globals In A Macro
;
	.macro	.xhelp.globals	arg$
	  .iifne  arg$	.list	(!,src,me)
	  .globl	xhelp
	  .nlist
	.endm
;
;****************************************************************************
;
.ifdef _xhelp
	.list	(!,src)
;	xhelp.asm       Globals                 Defined
	.nlist

	.xhelp.globals	0
.else
	.list
	.title	Extended Help

	.module	XHELP

	.xhelp.globals	1

;
;****************************************************************************
;
;  Purpose:
;	Provide Extended Help For The MONDEB-51 Monitor
;
;  Comments:
;	The Help String Tables MUST Mirror Those In MONDEB
;
;****************************************************************************
;
;  Includes
;
	.list	(!)	; This Inhibits The Include File Pagination
	.include "lp3240.sfr"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "ascii.def"
	.list
;
;****************************************************************************
;
;  Externals By Inclusion
;
	.define	_macros
	.define	_mondeb51

	.list	(!)	; This Inhibits The Include File Pagination
	.include "macros.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mondeb51.asm"
	.list
;
;****************************************************************************
;
	.area	X_Help
;
;****************************************************************************
; compute address of the selected string pointer
;
;	Enter With a Containing The Help Command Index
;	Returns With dptr Containing The Help String Address
;
xhelp:	dec	a		; compute (a - 1) * 2
	rl	a
	push	a
	mov	dptr,#xsptrs
	movc	a,@a+dptr	; get string pointer
	mov	b,a
	pop	a
	inc	dptr
	movc	a,@a+dptr
	mov	dph,b
	mov	dpl,a
	ret			; return with string pointer in dptr

;
;****************************************************************************

	.area	X_Ptrs

;****************************************************************************
;
;pointers to help strings
;
xsptrs:	.word	$case
	.word	$compar
	.word	$contin
	.word	$copy
	.word	$dbase
	.word	$delay
	.word	$displa
	.word	$dump
	.word	$goto
	.word	$help
	.word	$ibase
	.word	$load
	.word	$rdspace
	.word	$reg
	.word	$reset
	.word	$set
	.word	$search
	.word	$test
	.word	$verify
	.word	$wtspace
	.word	$cli
	.word	$clix0
	.word	$clix1
	.word	$sei
	.word	$seix0
	.word	$seix1
;
;****************************************************************************

	.page
	.sbttl	Help Strings

;****************************************************************************
;
	.area	X_Strs
;
;****************************************************************************
;

$case:
	.ascii	" CA[SE] U[PPER] Convert all characters to UPPER CASE"
        .byte	cr,lf
	.ascii	" CA[SE] L[OWER+UPPER] No character conversion"
	.byte	cr,lf
	.ascii	"   Default with no option specified is UPPER CASE"
	.byte	cr,lf
	.ascii	" CA[SE] ?"
	.byte	cr,lf
	.ascii	"   Shows the current CASE"
        .byte	eot

$compar:
	.ascii	" COM[PARE] N1 N2"
	.byte	cr,lf
	.ascii	"   Computes N1+N2 and N1-N2"
	.byte	eot

$contin:
	.ascii	" CON[TINUE]"
	.byte	cr,lf
	.ascii	"   Restores process context and returns to caller"
	.byte	eot

$copy:
	.ascii	" COP[Y] N M  or  N1:N2 M  or  N1!N2 M"
	.byte	cr,lf
	.ascii	"   N M      Copies location N to M"
	.byte	cr,lf
	.ascii	"   N1:N2 M  Copies locations N1 through N2 to M ..."
	.byte	cr,lf
	.ascii	"   N1!N2 M  Copies locations N1 through N1+N2 to M ..."
	.byte	eot

$dbase:
	.ascii	" DB[ASE] H[EX] or D[EC] or O[CT] or B[IN]"
	.byte	cr,lf
	.ascii	"   Sets the display base to HEX, DECIMAL, OCTAL, or BINARY"
	.byte	cr,lf
	.ascii	"   HEX is the default with no argument."
	.byte	cr,lf
	.ascii	" DB[ASE] ?"
	.byte	cr,lf
	.ascii	"   Shows the current display base"
	.byte	eot

$delay:
	.ascii	" DE[LAY] N"
	.byte	cr,lf
	.ascii	"   Perform a time delay of N milliseconds."
	.byte	eot

$displa:
	.ascii	" DI[SPLAY]   N or N1:N2 or N1!N2   [ D[ATA] or U[SED] ]"
	.byte	cr,lf
	.ascii	"   N      Displays the contents of location N"
	.byte	cr,lf
	.ascii	"   N1:N2  Displays the contents of locations N1 through N2"
	.byte	cr,lf
	.ascii	"   N1!N2  Displays the contents of locations N1 through N1+N2"
	.byte	cr,lf
	.ascii	"   Option D[ATA]  multiple byte values per line" 
	.byte	cr,lf
	.ascii	"   Option U[SED]  multiple bytes per line as .(0), +(~0), ?(other)"
	.byte	cr,lf
        .ascii	"   No Option displays one byte per line"
	.byte	cr,lf
	.ascii	"   Use DBASE to select the display type"
	.byte	eot

$dump:
	.ascii	" DU[MP]   N or N1:N2 or N1!N2 [ T[O] M ]"
	.byte	cr,lf
	.ascii	"   Outputs locations as a loadable HEX listing"
	.byte	lf,cr
	.ascii	"   N      Dumps location N"
	.byte	cr,lf
	.ascii	"   N1:N2  Dumps locations N1 through N2"
	.byte	cr,lf
	.ascii	"   N1!N2  Dumps locations N1 through N1+N2"
	.byte	cr,lf
	.ascii	"   Option T[O] M  Outputs the dump to memory location M ..." 
	.byte	eot

$goto:
	.ascii	" G[OTO] N"
	.byte	cr,lf
	.ascii	"   Restores process context but returns to caller at location N"
	.byte	eot

$help:
	.ascii	" H[ELP]"
	.byte	cr,lf
	.ascii	"   Lists all MONDEB commands"
	.byte	cr,lf
	.ascii	" Notes:"
	.byte	cr,lf
	.ascii	"   ^C  Will terminate console output"
	.byte	cr,lf
	.ascii	"   ^Z  Will repeat last command"
	.byte	cr,lf
	.ascii	"   Syntax errors will be shown with the ^ symbol"
	.byte	eot

$ibase:
	.ascii	" IB[ASE] H[EX] or D[EC] or O[CT]"
	.byte	cr,lf
	.ascii	"   Sets the input base to HEX, DECIMAL, or OCTAL"
	.byte	cr,lf
	.ascii	"   HEX is the default with no argument."
	.byte	cr,lf
	.ascii	" IB[ASE] ?"
	.byte	cr,lf
	.ascii	"   Shows the current input base"
	.byte	eot

$load:
	.ascii	" LO[AD]  Load Intel Hex Stream"
	.byte	eot

$rdspace:
	.ascii	" RD[SPACE]   [ D[ATA] or X[DATA] or C[ODE] ]"
	.byte	cr,lf
	.ascii	"   Sets the READ SPACE to DATA/IDATA, XDATA, or CODE"
	.byte	cr,lf
	.ascii	"   Default with no option specified is DATA/IDATA space"
	.byte	cr,lf
	.ascii	" RD[SPACE] ?"
	.byte	cr,lf
	.ascii	"   Shows the current READ SPACE"
	.byte	eot

$reg:
	.ascii	" REG  [.reg V]"
	.byte	cr,lf
	.ascii	"   Blank argument lists the register context at entry to the monitor"
	.byte	cr,lf
	.ascii	"   [.reg V] Places the value V into the selected register"
	.byte	cr,lf
	.ascii	"   The command CON[TINUE] restores the context with the change"
	.byte	eot

$reset:
	.ascii	" RES[ET]  Causes a system reset"
	.byte	eot

$set:
	.ascii	" SET   N or N1:N2 or N1!N2   V"
	.byte	cr,lf
	.ascii	"   N V      Sets location N to the value V"
	.byte	cr,lf
	.ascii	"   N1:N2 V  Sets locations N1 through N2 to the value V"
	.byte	cr,lf
	.ascii	"   N1!N2 V  Sets locations N1 through N1+N2 to the value V"
	.byte	eot

$search:
	.ascii	" SEA[RCH]  N or N1:N2 or N1!N2  [ V1 [V2 [V3 [V4 [V5 [V6]]]]] ]"
        .byte	cr,lf
	.ascii	"   Searches locations N1 through N2 for upto a 6 byte sequence"
	.byte	cr,lf
	.ascii	"   Searches locations N1 through N1+N2 for upto a 6 byte sequence"
	.byte	eot

$test:
	.ascii	" T[EST]  N or N1:N2 or N1!N2"
	.byte	cr,lf
	.ascii	"   N      Performs a memory test on location N"
	.byte	cr,lf
	.ascii	"   N1:N2  Performs a memory test on locations N1 through N2"
	.byte	cr,lf
	.ascii	"   N1!N2  Performs a memory test on locations N1 through N1+N2"
	.byte	cr,lf
	.ascii	"   A non destructive test verifies 0x00s and 0xFFs can be written"
	.byte	eot

$verify:
	.ascii	" V[ERIFY]  [ N or N1:N2 or N1!N2 ]"
	.byte	cr,lf
	.ascii	"   N      Creates an 8-bit checksum for location N"
	.byte	cr,lf
	.ascii	"   N1:N2  Creates an 8-bit checksum for location N1 through N2"
	.byte	cr,lf
	.ascii	"   N1!N2  Creates an 8-bit checksum for location N1 through N1+N2"
	.byte	cr,lf
	.ascii	"   No argument repeats calculation"
	.byte	eot

$wtspace:
	.ascii	" WT[SPACE]   [ D[ATA] or X[DATA] ]"
	.byte	cr,lf
	.ascii	"   Sets the WRITE SPACE to DATA/IDATA, XDATA"
	.byte	cr,lf
	.ascii	"   Default with no option specified is DATA/IDATA space"
	.byte	cr,lf
	.ascii	" WT[SPACE] ?"
	.byte	cr,lf
	.ascii	"   Shows the current WRITE SPACE"
	.byte	eot

$cli:
	.ascii	" CLI  Clears the system wide interrupt enable bit"
	.byte	eot

$clix0:
	.ascii	" CLIX0  Clears the external interrupt 0 enable bit"
	.byte	eot

$clix1:
	.ascii	" CLIX1  Clears the external interrupt 1 enable bit"
	.byte	eot

$sei:
	.ascii	" SEI  Sets the system wide interrupt enable bit"
	.byte	eot

$seix0:
	.ascii	" SEIX0  Sets the external interrupt 0 enable bit"
	.byte	eot

$seix1:
	.ascii	" SEIX1  Sets the external interrupt 1 enable bit"
	.byte	eot


;*******************************************************************************

.endif	; .else of _xhelp

	.end

