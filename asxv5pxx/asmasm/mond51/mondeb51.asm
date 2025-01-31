.nlist
;****************************************************************************
;
; Compile The Assembly Code
;
;   Normal Assembly With Monitor Register Bank 0 (Default)
;	AS89LP mondeb51.asm
;
;   Assembly With Alternate Monitor Register Bank (N = 0-3)
;	AS89LP -i "monbnk = N" mondeb51.asm
;
; This Code is NOT Register Bank Independent
; And Is Assembled With A Defined Register Bank (Default=0 or N)
;
;****************************************************************************
;
; Globals In A Macro
;
	.macro	.mondeb51.globals	arg$
	  .iifne  arg$	.list	(!,src,me)
	  ; The Monitor
	  .globl	mond51		; Normal Monitor Entry Point
	  ; Break Points
	  .globl	brkpnd		; The Break Point Number Set
	  .globl	brkirq		; Before Calling Break Point Entry
	  ; I/O Base
	  .globl	ibcode		; Input Base
	  .globl	dbcode		; Display Base
	  .globl	dbnbr
	  ; Numbers
	  .globl	number		; Put Number In <nbrhi:nbrlo>
	  .globl	nmdptr		; Put Number In DPTR
	  .globl	nbrlo	        ; LSB Of Number
	  .globl	nbrhi		; MSB Of Number
	  ; Temps
	  .globl	temp1,	temp2,	temp3,	temp4
	  .globl	temp5,	temp6,	temp7,	temp8
	  ; Characters
	  .globl	chrout		; Output A Character (To Console)
	  .globl	outchr		; Output A Character (Formatted)
	  .globl	outstr		; Output A String Via outchr
	  .globl	out1by		; Output 1 Byte
	  .globl	out2by		; Output 2 Bytes
	  .globl	outsp		; Output A Space
	  .globl	outeq		; Output An Equal Sign
	  .globl	docrlf		; Output A CR/LF
	  .globl	ctrl_c		; Check For ^C Character
	  .globl	uprflg		; Upper Case Only Flag
	  ; Time
	  .globl	timdel		; Time Delay Function
	  .globl	tm$.1s		; Time Delay Of .1 Seconds
	  ; Command Processing
	  .globl	bolflg		; Beginning Of Line Flag
	  .globl	ttybuf		; Input Buffer
	  .globl	ttyend		; End Of ttybuf
	  .globl	linptr		; Input Line Pointer
	  .globl	synptr		; Syntax Pointer
	  .globl	getlin		; Get An Input Line
	  .globl	mgetchr		; Get A Character From Input Line
	  .globl	fndlnm		; Find A List Number
	  .globl	comand		; Process Command
	  .globl	skpdlm		; Skip Delimiters
	  .globl	tstdlm		; Test For A Delimiter
	  .globl	tsteol		; Test For End-Of-Line
	  .globl	outadr		; Output String Pointer
	  .globl	nomore		; Good Return
	  .globl	badsyn		; Bad Syntax
	.endm
;
;****************************************************************************
;
  .ifdef _mondeb51
	.list	(!,src)
;	mondeb51.asm    Globals                 Defined
	.nlist

	.mondeb51.globals	0
.else
	.list
	.title	MONDEB - 51

	.module	MONDEB51

	.mondeb51.globals	1

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****

	.page
	;	*********************************************************
	;	*							*
	;	*	MONDEB - 51  -  a monitor/debugger		*
	;	*	for 8051 compatable microprocessors		*
	;	*							*
	;	*********************************************************
	;
	; author:	Don Peters	(6800 version)
	; date:		April 1977
	;
	; rewritten for the 8051
	; by:		Alan R. Baldwin
	; date:		June 2019	
	;
	;	  This 8051 monitor/debugger uses only a minimal
	;	amount of DATA bytes.  The monitor variables are
	;	placed in the XDATA space accessible through the
	;	indirect addressing of R0 and R1.  Thus the user
	;	program has available most DATA and IDATA memory.
	;
	;	  The bit adressable locations are typically
	;	allocated as follows:
	;	  0x00-0x2F - program breakpoints (they call brkirq)
	;	  0x30-0x5F - bit addressable bits for programs
	;	  0x60-0x7F - bit addressable bits for mondeb
	;
	;	  To add user functions to MONDEB - 51
	;
	;	1) add your commands to the end of command list #1
	;	2) add the command entry points to the jump table
	;	3) append any local command lists after MONDEB's
	;
	;	4) if using the extended help option update xhelp.asm
	;	   to include the new help strings
	;
	;	  Mondeb requires external initialization to
	;		set up the console port and
	;		any other startup processing.
	;

	.module	MONDEB51

	.ifndef	monbnk		; Specify Monitor Register Bank
		regbnk = 0	; Default is Bank 0
	.else
		regbnk = monbnk
	.endif
	.regbnk	regbnk		; tell the assembler

	.page
;****************************************************************************
;
; Include SFR, Global, And System Definitions
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
	.define	_startup
	.define	_xhelp

	.list	(!)	; This Inhibits The Include File Pagination
	.include "macros.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "startup.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "xhelp.asm"
	.list
;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;

	.page
	.sbttl	MONDEB - 51 working variables

	.radix	d

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
;	Saved Stack Data From Mondeb Entry
;
	.area	EData

m_stack:		; the register save area (18 bytes)
m_ie:	.blkb	1	; donot change order !
m_psw:	.blkb	1
m_a:	.blkb	1
m_b:	.blkb	1
m_r0:	.blkb	1
m_r1:	.blkb	1
m_r2:	.blkb	1
m_r3:	.blkb	1
m_r4:	.blkb	1
m_r5:	.blkb	1
m_r6:	.blkb	1
m_r7:	.blkb	1
m_dph:	.blkb	1
m_dpl:	.blkb	1

m_spx:	.blkb	1
m_sp:	.blkb	1

m_pch:	.blkb	1
m_pcl:	.blkb	1

m_brk:	.blkb	1	; the breakpoint number if a break is successful

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
;	Bit Flags
;
	.area	MBits

mninit:	.blkb	1	; monitor initialized flag
brkrdy:	.blkb	1	; break point service ready flag
brksvc:	.blkb	1	; break point service entered
brklst:	.blkb	1	; break point list flag
bolflg:	.blkb	1	; "beginning of line flag"
outflg:	.blkb	1	; alternate output flag
hdxflg:	.blkb	1	; half-duplex terminal flag (if non-zero, no echo)
uprflg:	.blkb	1	; upper case conversion flag
nummat:	.blkb	1	; character match
outbw:	.blkb	1	; byte/word flag
fndtyp:	.blkb	1	; cmd/lst search flag
sumdif:	.blkb	1	; sumnum/difnum flag

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
;	Mondeb Easy Access Parameters
;
	.area	Data

spsave:	.blkb	2	; saved stack pointer
brkpnd:	.blkb	1	; pending breakpoint number
brknum:	.blkb	1	; saved breakpoint number

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
;	Mondeb Work Space.
;
	.area	MData

cplmax	= 72		; "characters per line" maximum
ttybuf:	.blkb	cplmax	; start of input line buffer
ttyend	= .-1		; end of input line buffer

cplcnt:	.blkb	1	; "characters per line" count

linptr:	.blkb	1	; input line character pointer
			; (content => content of synptr)
synptr:	.blkb	1	; input line character pointer for good syntax
delim:	.blkb	1	; characters permitted as valid
			; command/modifier delimiter
ibcode:	.blkb	1	; input base (1=hex, 2=dec, 3=oct)
dbcode:	.blkb	1	; display base (1=hex, 2=dec, 3=oct, 4=bin)
dbnbr:	.blkb	1	; display base number (e.g., 16,10,8, or 2)
rdcode:	.blkb	1	; memory space  read (1=data/idata, 2=xdata, 3=code)
wtcode:	.blkb	1	; memory space write (1=data/idata, 2=xdata, 3=code)
nbrhi:	.blkb	1	; most significant byte of scanned number
nbrlo:	.blkb	1	; least significant byte of scanned number
ranglo:	.blkb	2	; range lower limit picked up by gtrang
ranghi:	.blkb	2	; range upper limit picked up by gtrang
verfrm:	.blkb	2	; beginning address of range to verify
verto:	.blkb	2	; ending address of range to checksum verify
chksum:	.blkb	1	; checksum of range given in the verify command
outadr:	.blkb	2	; alternate address that the output chars go to

	; temporary (locally used) variables

temp1:	.blkb	2	; various
temp2:	.blkb	2
temp3:	.blkb	2
temp4:	.blkb	2
temp5:	.blkb	2
temp6:	.blkb	2
temp7:	.blkb	2
temp8:	.blkb	2

lisnum:	.blkb	1	; used in command
comnum:	.blkb	1	; used in command
lisptr:	.blkb	2	; used in command
digit:	.blkb	1	; used by outnum, Keep this order
numbhi:	.blkb	1	; used by outnum, Keep this order
numblo:	.blkb	1	; used by outnum, Keep this order
dgtcnt:	.blkb	1	; used by outnum
nbr2x:	.blkb	2	; used by number

.ifgt	(. - ttybuf) - 0x080
	.error	1	; workspace exceeds 128 bytes
.endif
;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
;	Other Random Variables And Constants
;

memadr	=	temp1	; display, set, search, test
ascadr	=	temp2	; display

	; for "search" command

bytptr	=	temp2
nbytes	=	temp3
nbrmat	=	temp3+1
bytstr	=	temp4

	; for "load" command

ld_prm =	temp1	; uses temp1-temp8

	; other constants
tloop	=	20	; delay timer loop count
timcon	=	244	; delay time constant

;
; *****-----*****-----*****-----*****-----*****-----*****-----*****
;
	.page
	.sbttl	MOND51 Startup

	.area	Code

brkirq:	jbc	brkrdy,1$	; check if break service is ready
	ret			; recursive entry not allowed

1$:	setb	brksvc		; breakpoint service is active
	mov	brknum,brkpnd	; pending is now active

mond51:	mov	spsave+1,sp	; save the stack pointer
	mov	spsave+0,spx

	push	psw		; save current status
	mov	psw,#regbnk<<3	; set register bank

	push	spsave+1	; save working registers (16 bytes)
	push	spsave+0	; to restore at exit
	push	dpl
	push	dph
	push	r7
	push	r6
	push	r5
	push	r4
	push	r3
	push	r2
	push	r1
	push	r0
	push	b
	push	a
	push	psw
	push	ie


	mov	dptr,#m_stack	; save area
	mov	b,#16
1$:	pop	a		; recover stacked register
	movx	@dptr,a		; and save in m_stack
	inc	dptr
	djnz	b,1$		; loop for all registers

	pop	a		; pop psw
	.sb_rx	m_psw,a		; and save

	pop	dph		; pop return address into dptr
	pop	dpl
	push	dpl		; restore return address
	push	dph
	.sdptr_x m_pch		; save pc
	
	mov	dptr,#m_brk
	mov	a,brknum	; save breakpoint for list
	movx	@dptr,a

	lcall	inital		; initialize variables
	lcall	docrlf		; advance to a clean line
	.ldptr  #msghed		; get address of header
	lcall	outstr		; type it
	.sb_rx	delim,#3	; space or comma (code 3)

	jnb	brksvc,promp1	; normal startup entry
	setb	brklst		; break point list flag 
	ljmp	reg		; entered via a breakpoint

	; prepare to get a new command

prompt:	setb	bolflg		; set 'beginning of line' flag
	lcall	docrlf		; type cr-lf
	.lbi_rx	a,synptr
	cjne	a,#';,promp1	; semicolon?
	sjmp	getcmd		; continue scan if it is, 
				; skipping the prompt

promp1:	.ldptr  #msgprm		; type prompt
	lcall	outstr

	lcall	getlin		; get line of input

	cjne	a,#3,1$		; abort line on a control-c
	sjmp	prompt

1$:	mov	a,#ttybuf-1
	.sb_rx	synptr,a	; reset pointer to beginning
	inc	a
	mov	r1,a
	movx	a,@r1		; look at first character
	lcall	tsteol		; reprompt on an empty line
	jc	prompt		; (first char = cr,lf,or ;)
				; fall through to getcmd

	.page
	.sbttl	Get Command

	;================================================
	; come here to process a new command

getcmd:	mov	a,#1		; use list 1 when matching
	lcall	comand		; now go for a match
	jz	prompt		; reprompt if just a cr was typed
	jb	a.7,badsyn	; bad command if negative
	ljmp	jmpcmd		; good command if positive

badsyn: clr	outflg		; reset to terminal output
	mov	b,#ttybuf-1	; get start of line

1$:	.lb_rx	a,linptr	; space over to the error in syntax
	cjne	a,b,2$		; at error ? no - skip

	mov	a,#'^		; at error - get an up-arrow
	lcall	outchr		; print it
	lcall	docrlf
	sjmp	promp1		; ignore any succeeding packed
				; commands
2$:     lcall	outsp		; space forward
	inc	b		; move on
	sjmp	1$

nomore: clr	outflg		; reset to terminal output
	jbc	brklst,prompt	; break point list skips checks

	lcall	skpdlm
	jc	prompt		; if carry bit set, end of line
				; (normal)
	sjmp	badsyn		; there is something there but shouldn't be

	.page
	.sbttl	Command Dispatcher

	.page
	.sbttl	RESET - software reset function

reset:	lcall	tm$.1s		; .1s for serial output to complete
	mov	wdtrst,0x5A	; system resets
	mov	wdtrst,0xA5
	ljmp	nomore		; should never get here

	.page
	.sbttl	REG - display registers

	;================================================
	; display registers of interrupted process

	; look for (register name, register value) pairs

reg:	mov	a,#5		; register names in list #5
	lcall	comand
	jz	lstreg		; just list
	jb	a.7,1$		; bad syntax
	lcall	number		; get new value
	jb	a.7,1$		; bad syntax
	jz	1$		; a number is required

	.lb_rx	a,comnum	; register index
	.ldptr	#m_ie		; register values
	mov	b,#14		; 1st 14 are single bytes
	lcall	set1by

	.ldptr	#m_dph		; dptr
	mov	b,#1		; 1 2-byte value
	lcall	set2by

	mov	b,#2		; spx and sp
	lcall	set1by		; single byte values

	.ldptr	#m_spx		; [spx,sp] and pc
	mov	b,#2		; 2 2-byte values
	lcall	set2by

1$:	ljmp	badsyn

set1by:	dec	a		; are we at the selected register?
	jz	1$		; yes
	inc	dptr		; no, continue to next
	djnz	b,set1by
	ret

1$:	.lb_rx	a,nbrlo		; get the data value
	movx	@dptr,a		; update single byte
	sjmp	setbyx		; go to exit

set2by:	dec	a		; are we at the selected register?
	jz	1$		; yes
	inc	dptr		; no, continue to next
	inc	dptr
	djnz	b,set2by
	ret

1$:	.lb_rx	a,nbrhi		; get the data value
	movx	@dptr,a		; update 2-byte value
	inc	dptr
	inc	r1
	movx	a,@r1
	movx	@dptr,a
;	sjmp	setbyx

setbyx:	pop	a		; dump return
	pop	a
	ljmp	nomore		; and done

	; List All Registers

lstreg:	.clrb_rx comnum		; initialize command number

	mov	dptr,#m_stack	; data area
	lcall	2$		; type ie
	lcall	2$		; type psw
	lcall	2$		; type a
	lcall	2$		; type b
	lcall	docrlf		; advance to a clean line
	lcall	2$		; type r0
	lcall	2$		; type r1
	lcall	2$		; type r2
	lcall	2$		; type r3
	lcall	docrlf		; advance to a clean line
	lcall	2$		; type r4
	lcall	2$		; type r5
	lcall	2$		; type r6
	lcall	2$		; type r7
	lcall	docrlf		; advance to a clean line
	lcall	2$		; type dph
	lcall	2$		; type dpl
	mov	dptr,#m_dph
	lcall	3$		; type dptr
	lcall	docrlf		; advance to a clean line
	lcall	2$		; type spx
	lcall	2$		; type sp
	mov	dptr,#m_spx
	lcall	3$		; type [spx,sp]
	lcall	docrlf		; advance to a clean line
	lcall	3$		; type PC
	jnb	brksvc,1$
	lcall	2$		; type breakpoint
1$:	ljmp	nomore

	; output content of a 1 byte register

2$:	lcall	4$
	movx	a,@dptr		; load 1-byte as MSB
	mov	b,a
	inc	dptr		; address uptdated by 1
	lcall	out1by
	ret

	; output content of a 2 byte register

3$:	lcall	4$
	movx	a,@dptr		; load MSB
	inc	dptr
	mov	b,a
	movx	a,@dptr		; load LSB
	inc	dptr		; address uptdated by 2
	lcall	out2by
	ret

	; misc setup for register display

4$:	lcall	outsp		; output a space
	.incb_rx comnum		; next register
	mov	a,#5		; register name is in list 5
	lcall	typcmd		; type it
	lcall	outeq		; type an '='
	ret

	.page
	.sbttl	GOTO - Go To Memory Address

	;================================================
	; set a go to return memory address

goto:	lcall	number
	jz	contin
	.lb_rx	a,nbrhi		; set new pc
	.sb_x	m_pch,a	        ; MSB
	inc	r1
	inc	dptr
	movx	a,@r1
	movx	@dptr,a		; LSB

 	.sbttl	Continue - Resume After Interrupt

	;================================================
	; resume after interrupt/breakpoint

contin: mov	dptr,#0d100	; wait ~100 ms. for terminal output
	lcall	timdel		; before changing anything

	clr	ea		; disable interrupts during restore
	mov	spx,spsave+0	; restore stack
	mov	sp, spsave+1

	pop	a		; dump original return address
	pop	a
	.ldptr  #m_pch		; replace with new return address
	movx	a,@dptr		; pch
	mov	b,a
	inc	dptr
	movx	a,@dptr		; pcl
	push	a		; push pcl
	push	b		; push pch

	.ldptr  #m_stack	; pointer to save area
	mov	b,#14
1$:	movx	a,@dptr		; get next register
	push	a		; and push on stack
	inc	dptr
	djnz	b,1$		; loop for dpl-ie registers

	pop	dpl
	pop	dph
	pop	r7
	pop	r6
	pop	r5
	pop	r4
	pop	r3
	pop	r2
	pop	r1
	pop	r0
	pop	b
	pop	a

	clr	brknum		; clear break point number
	clr	brksvc		; clear service active flag
	setb	brkrdy		; set break service ready flag

	pop	psw		; restore system status
	pop	ie		; load system interrupt control
	ret			; exit with all restored

	;================================================
	; specific interrupt enables

	.sbttl	SEI - Enable System Interrupts

sei:	setb	ea		; system enable interrupts
	ljmp	nomore

	.sbttl	SEIX0 - Enable External Interrupt 0

seix0:	setb	ex0		; external interrupt 0 enabled
	ljmp	nomore

	.sbttl	SEIX0 - Enable External Interrupt 1

seix1:	setb	ex1		; external interrupt 1 enabled
	ljmp	nomore

	;================================================
	; specific interrupt disables

	.sbttl	CLI - Disable System Interrupts

cli:	clr	ea		; system disable interrupts
	ljmp	nomore

	.sbttl	CLIX1 - Disable External Interrupt 0

clix0:	clr	ex0		; external interrupt 0 disabled
	ljmp	nomore

	.sbttl	CLIX1 - Disable External Interrupt 1

clix1:	clr	ex1		; external interrupt 1 disabled
	ljmp	nomore

	.page
	.sbttl	COPY - Copy From One Location To Another

	;================================================
	; copy memory from one location to another
	;
	; reads from Data/Idata, Xdata, or Code
	; writes to Data/Idata or Xdata

copy:	lcall	gtrang		; get source range into ranglo & ranghi
	jb	a.7,3$		; error if no source
	jz	3$

	lcall	number		; get destination
	jb	a.7,3$		; error if no destination
	jz	3$

	.ldptr_rx ranglo	; load source address
1$:	lcall	rdbyte		; read byte value
	.ldptr_rx nbrhi		; load destination address
	lcall	wtbyte		; write byte value
	inc	dptr		; increment destination address
	.sdptr_rx nbrhi		; save destination address
	.cmpw_rx ranglo,ranghi	; compare addresses
	jc	2$		; if equal, all done
	.ldptr_rx ranglo	; increment source address
	inc	dptr
	.sdptr_rx ranglo
	lcall	wchdog		; hit the watch dog timer
	sjmp	1$		; loop

2$:	ljmp	nomore
3$:	ljmp	badsyn

	.page
	.sbttl	CASE - Set Upper Case Conversion Flag

	;================================================
	; set input case conversion to upper or upper and lower

case:	mov	a,#9		; look for upper or reset in list #9
	lcall	comand
	jb	a.7,3$		; unrecognizable base, try'?'
	jnz	2$
1$:	setb	uprflg		; no selection - default to upper
	sjmp	5$

2$:	cjne	a,#2,1$		; not 'reset' then set 'upper'
	clr	uprflg
	sjmp	5$	        ; done

3$:	mov	a,#4		; look for '?' in list #4
	lcall	comand
	jb	a.7,6$		; error if the 'something' was not a '?'
	jz	6$
	mov	a,#1		; default - upper
	jb	uprflg,4$
	inc	a		; else - normal
4$:	.sb_rx	comnum,a	; store case code for typcmd
	mov	a,#9		; case code is in list 9
	lcall	typcmd		; type out space
5$:	ljmp	nomore

6$:	pop	a		; dump mode code
	ljmp	badsyn		; error if the 'something' was not a '?'

	.page
	.sbttl	RSPACE - Set Read Memory Access Space

	;================================================
	; set the read area to Data/Idata, Xdata, or Code

rdspace:
	mov	a,#8		; look for data/idata, xdata, or code in list #8
	lcall	comand
	jb	a.7,2$		; unrecognizable base, try'?'
	jnz	1$
	mov	a,#1		; no base given - default to data/idata
1$:	.sb_rx	rdcode,a	; save read memory type
	ljmp	nomore	        ; done

2$:	.lb_rx	a,rdcode	; get rdcode in case its needed
	sjmp	rdwtq

	.sbttl	WSPACE - Set Write Memory Access Space

	;================================================
	; set the write area to Data/Idata or Xdata

wtspace:
	mov	a,#8		; look for data/idata, xdata, or code in list #8
	lcall	comand
	jb	a.7,3$		; unrecognizable base, try'?'
	jnz	1$
	mov	a,#1		; no base given - default to data/idata
1$:     cjne	a,#3,2$
	ljmp	badsyn		; writing to code not allowed

2$:	.sb_rx	wtcode,a	; save write memory type
	ljmp	nomore	        ; done

3$:	.lb_rx	a,wtcode	; get wtcode in case its needed
;	sjmp	rdwtq

rdwtq:	push	a		; save it on stack temporarily
	mov	a,#4		; look for '?' in list #4
	lcall	comand
	jb	a.7,1$		; error if the 'something' was not a '?'
	jz	1$
	pop	a		; retrieve read/write space code
	.sb_rx	comnum,a	; store space code for typcmd
	mov	a,#8		; space code is in list 8
	lcall	typcmd		; type out space
	ljmp	nomore

1$:	pop	a		; dump space code
	ljmp	badsyn		; error if the 'something' was not a '?'

	.page
	.sbttl	IBASE - Set Input Base

	;================================================
	; set the input base to Hex, Decicmal, or Octal

ibase:	mov	a,#3		; look for hex,dec,or oct in list #3
	lcall	comand
	jb	a.7,2$		; unrecognizable base, try'?'
	jnz	1$
	mov	a,#1		; no base given - default to hex
1$:	.sb_rx	ibcode,a	; save base code
	ljmp	nomore	        ; done

2$:	.lb_rx	a,ibcode	; get ib code in case its needed
	sjmp	ibdbq

	.sbttl	DBASE - Set Display Base

	;================================================
	; set the display base to Hex, Decimal, Octal, or Binary

dbase:	mov	a,#3		; look for hex,dec,oct, or bin in list #3
	lcall	comand
	jb	a.7,3$		; unrecognizable base, try '?'
	jnz	1$
	mov	a,#1		; no base given - default to hex
1$:	.sb_rx	dbcode,a
	mov	dptr,#2$-1	; get numeric base from table
	movc	a,@a+dptr
	.sb_rx	dbnbr,a		; save it
	ljmp	nomore		; done

2$:	.byte	16		; display base table
	.byte	10
	.byte	8
	.byte	2

3$:	.lb_rx	a,dbcode	; get db code in case its needed
;	sjmp	ibdbq

ibdbq:	push	a		; save it on stack temporarily
	mov	a,#4		; look for '?' in list #4
	lcall	comand
	jz	1$		; error if the 'something' was not a '?'
	jb	a.7,1$
	pop	a		; retrieve input base/display base code
	.sb_rx	comnum,a	; store base code
	mov	a,#3		; base code is in list 3
	lcall	typcmd		; type out base
	ljmp	nomore

1$:	pop	a		; dump ib/db base
	ljmp	badsyn		; error if the 'something' was not a '?'
	
	.page
	.sbttl	Display - Display Memory Data

	;================================================
	; display memory data in current display base

displa:	lcall	gtrang		; get memory display range
	jb	a.7,8$
	jz	8$

	.mvw_rx	memadr,ranglo	; initialize address pointer
	.mvw_rx	ascadr,ranglo
	mov	a,#6		; search list 6 for
	lcall	comand		; display modifiers 'data' or 'used'
	jb	a.7,8$		; any other modifier is illegal
	dec	a
	.sb_rx	comnum,a	; -1=addr & data, 0=data, 1=used
	mov	r2,#1		; init 'data values per line' counter

1$:	.ldptr_rx memadr	; this is the memory address
	.lb_rx	a,comnum	; which display option?
	jb	a.7,9$		; if 'address & data', go there
	djnz	r2,2$		; count data values per line
	lcall	docrlf		; get to line beginning
	mov	b,dph		; address of data
	mov	a,dpl
	lcall	out2by		; output address
	lcall	outsp		; and a space
	.lb_rx	a,dbnbr		; reset 'data values per line' counter
	mov	r2,a

2$:	.lb_rx	a,comnum
	jb	a.7,3$		; want 'data' option?
	jnz	4$		; if not, go to 'used' code

3$:	lcall	outsp		; output preceedng space
	sjmp	10$

4$:	lcall	rdbyte		; read proper memory byte
	jnz	5$
	mov	a,#'.		; its 0x00, get a '.'
	sjmp	7$

5$:     cpl	a
	jnz	6$
	mov	a,#'+		; its 0xFF, get a '+'
	sjmp	7$

6$:	mov	a,#'?		; its other, get a '?'
7$:	lcall	outchr 		; output the '.', '?', or '+'
	sjmp	11$

8$:	ljmp	badsyn		; address is required

9$:	lcall	docrlf		; new line
	lcall	outsp		; output a preceeding space
	mov	b,dph		; address
	mov	a,dpl
	lcall	out2by		; type address
	lcall	outeq		; type '='
10$:	lcall	rdbyte		; read proper memory byte
	mov	b,a
	lcall	out1by		; type it

11$:	.lb_rx	a,ranghi	; compare memadr to ranghi
	cjne	a,dph,14$	; if not equal then continue
	inc	r1
	movx	a,@r1
	cjne	a,dpl,14$	; if not equal then continue
	sjmp	13$

12$:	lcall	outsp		; fill for unprinted bytes
	lcall	outsp
	lcall	outsp
13$:	lcall	mltchr		; display ascii trailer
	djnz	r2,12$
	ljmp	nomore		; done

14$:	lcall	mltchr		; display ascii trailer
	inc	dptr		; on to next address
	.sdptr_rx memadr	; save next address
	lcall	ctrl_c		; ^C typed ?
	jc	15$		; yes - exit
	ljmp	1$		; and loop

15$:	lcall	docrlf		; next line
	mov	dptr,#msgctc	; echo a ^C
	lcall	outstr
	ljmp	nomore

mltchr:	.lb_rx	a,comnum	; which display option?
	jnb	a.7,1$
	lcall	outsp		; if 'address & data',
	lcall	outsp		; then single character
	sjmp	sglchr

1$:	cjne	r2,#1,4$	; skip out until last byte

	push	dph		; save dptr
	push	dpl

	lcall	outsp		; two spaces
	lcall	outsp
	.lb_rx	a,dbnbr		; reset 'data values per line' counter
	mov	r3,a

2$:	.ldptr_rx ascadr	; this is the memory address
	lcall	sglchr		; output the character
	
	.lb_rx	a,ranghi	; compare ascadr to ranghi
	cjne	a,dph,3$	; if not equal then continue
	inc	r1
	movx	a,@r1
	cjne	a,dpl,3$	; if not equal then continue
	mov	r3,#1		; early termination

3$:	inc	dptr		; on to next address
	.sdptr_rx ascadr	; save next address
	djnz	r3,2$

	pop	dpl		; restore dpdtr
	pop	dph

4$:	ret

sglchr:	lcall	rdbyte		; read proper memory byte
	anl	a,#0b01111111	; mask 8th bit
	cjne	a,#127,1$
1$:	jnc	3$		; = 127 is non ascii
	cjne	a,#32,2$
2$:	jnc	4$		; <  32 is non ascii
3$:	mov	a,#0xFF		; non ascii character
4$:	lcall	chrout		; output single caharacter
	ret

	.sbttl	Read A Byte Of Data From Current Memory Space

	;================================================
	; read a data byte from Data/Idata, Xdata, or Code
	;
	; data byte address is always in dptr
	; data byte value is returned in a

rdbyte:	.lb_rx	a,rdcode,ppr$	; memory space select

	cjne	a,#2,1$		; xdata ?
	movx	a,@dptr
	ret

1$:	cjne	a,#3,2$		; code ?
	clr	a
	movc	a,@a+dptr
	ret

	; default to data / idata

2$:     clr	a		; data/idata only 0x0000-0x00FF
	cjne	a,dph,3$	; bad address - return 0
	mov	a,dpl
	cjne	a,#1 + (regbnk<<3),4$
	mov	a,r1		; access directly
3$:	ret

4$:     push	r1
	mov	r1,a
	mov	a,@r1		; access indirectly
	pop	r1
	ret

	.sbttl	Write A Byte Of Data To Current Memory Space

	;================================================
	; write a byte of data to the Data/IData or XData
	;
	; data byte address is always in dptr
	; data byte value is in a

wtbyte:  push	a		; save byte
	.lb_rx	a,wtcode,ppr$	; memory space select

	cjne	a,#2,1$		; xdata ?
	pop	a
	movx	@dptr,a
	clr	c
	ret

	; default to data / idata

1$:     clr	a		; data/idata only 0x0000-0x00FF
	cjne	a,dph,2$	; bad address - skip write
	mov	a,dpl
	cjne	a,#1 + (regbnk<<3),3$
	pop	a		; recover byte
	mov	r1,a		; access directly
	clr	c
	ret

2$:	pop	a		; pop a
	setb	c		; set c - no write
	ret			; and exit

3$:	pop	a		; recover byte
	push	r1
	mov	r1,dpl
	mov	@r1,a		; access indirectly
	pop	r1
	clr	c
	ret

	.page
	.sbttl	SET - Set Memory Locations

	;================================================
	; set memory to a value
	; change register values

set:	lcall	gtrang		; get memory location/range
	jb	a.7,2$		; if not an address exit
	jnz	3$
1$:	ljmp	badsyn
2$:	ljmp	nomore
	
	; range of address specified?

3$:	.mvw_rx memadr,ranglo
	.cmpw_rx ranglo,ranghi	; compare addresses
	jc	5$		; if single address, set up
				; addresses individually

	; set a range of addresses to a single value

	lcall	number		; get that value
	jb	a.7,1$		; its	required
	jz	1$

4$:	.ldptr_rx memadr	; load address
	.lb_rx	a,nbrlo		; get byte value
	lcall	wtbyte		; write byte
	.cmpw_rx memadr,ranghi	; compare addresses
	jc	2$		; if equal, all done
	inc	dptr		; else next address
	.sdptr_rx memadr	; save memadr
	sjmp	4$		; loop

	; set addresses up individually

5$:	lcall	number		; get data to put there
	jb	a.7,1$		; abort if bad syntax
	jz	6$		; end of line?
	.lb_rx	a,nbrlo		; load data byte
	.ldptr_rx memadr	; load address
	lcall	wtbyte		; store data
	inc	dptr		; update and save address
	.sdptr_rx memadr
	sjmp	5$

6$:	.lbi_rx	a,synptr	; get character at end of line
	cjne	a,#lf,2$	; line feed? no, done
	.ldptr_rx memadr	; yes, get next address to be set
	mov	b,dph
	mov	a,dpl
	lcall	out2by		; type it
	lcall	outsp		; and a space
	lcall	getlin		; get a new line
	.sb_rx	synptr,#ttybuf-1
	sjmp	5$		; reset scan pointer and loop

	.page
	.sbttl	Checksum Verify a Block of Memory

	;================================================
	; checksum verify memory

verify:	lcall	gtrang		; get a number range
	jz	1$		; no modifier means check what we have
	jb	a.7,4$		; anything else is illegal

	.mvw_rx	verfrm,ranglo	; good range given,
	.mvw_rx	verto,ranghi	; transfer it to checksum addresses

	lcall	cksum		; compute checksum
	.sb_rx	chksum,a	; save it
	mov	b,a		; type the checksum
	lcall	out1by
	sjmp	3$

1$:	lcall	cksum		; compute checksum
	mov	b,a
	.lb_rx	a,chksum	; same as stored checksum?
	clr	c
	subb	a,b
	jnz	2$

	mov	dptr,#msgver	; they verify - say so
	lcall	outstr
	sjmp	3$

2$:	mov	b,a		; they don't - say so
	lcall	out1by
	mov	dptr,#msgnve
	lcall	outstr
3$:	ljmp	nomore
4$:	ljmp	badsyn

	; compute the checksum from addresses verfrm to verto
	; return the checksum in acca

cksum:	mov	r0,#verfrm	; r0 = #verfrm
	movx	a,@r0		; MSB of from address
	mov	dph,a
	inc	r0
	movx	a,@r0		; LSB of from address
	mov	dpl,a
	inc	r0		; r0 = #verto
	movx	a,@r0		; MSB of to address
	mov	r1,a
	inc	r0
	movx	a,@r0		; LSB of to address
	mov	r0,a

	mov	b,#0	        ; initialize chksum

1$:	lcall	rdbyte
	add	a,b
	mov	b,a
	mov	a,r0
	cjne	a,dpl,2$
	mov	a,r1
	cjne	a,dph,2$
	sjmp	3$

2$:	inc	dptr
	lcall	wchdog		; hit watch dog timer
	sjmp	1$

3$:     mov	a,b
	cpl	a
	ret

	.page
	.sbttl	Search Memory for Byte String

	;================================================
	; search memory
	;
	; global variables used
	;  ranglo - 'search from' address
	;  ranghi - 'search to' address
	;
	; local variables used
	;  memadr - first matching character memory address
	;  bytptr - address pointer used to fill bytstr buffer
	;  nbytes - number of bytes in byte string
	;  nbrmat - number of chars that match so far
	;  bytstr - starting address of 6 byte sring buffer
	;
	;  memadr - temp1			(2 bytes)
	;  bytptr - temp2			(1 byte)
	;  nbytes - temp3			(1 byte)
	;  nbrmat - temp3+1			(1 byte)
	;  bytstr - temp4, temp5, & temp6	(6 bytes max)

search:	lcall	gtrang		; get search range
	jb	a.7,2$		; abort if no pair
	jz	2$

	.sb_rx bytptr,#bytstr	; get start of byte string
	.clrb_rx nbytes		; zero # of bytes in byte string

1$:	lcall	number		; get a byte string
	jz	4$		; begin search if eol
	jb	a.7,2$
	
	.incb_rx nbytes		; count this  byte
	clr	c
	subb	a,#6+1		; don't accept over 6 bytes
	jnc	2$
	.lb_rx	a,nbrlo		; get (low order) byte
	.sbi_rx bytptr,a	; save byte, bump pointer
	.incb_rx bytptr
	sjmp	1$		; get another

2$: 	ljmp	badsyn
3$:	ljmp	nomore
	
4$:	.lb_rx	a,nbytes	; is # of bytes to look for >0
	jz	2$		; if not,bad syntax

5$:	.sb_rx	bytptr,#bytstr	; initialize byte pointer
	.clrb_rx nbrmat		; clear matched count

6$:     lcall	wchdog		; hit watch dog timer
	.lbi_rx	b,bytptr	; get byte from byte string
	.ldptr_rx ranglo
	lcall	rdbyte
	cjne	a,b,9$		; compare memory & byte string
				; characters
				; if no match, test for range end
	.sdptr_rx memadr	; first matching character

7$:	.lb_rx	b,nbytes	; required matching bytes
	.incb_rx nbrmat		; nbrmat left in a
	cjne	a,b,10$		; no match - continue scan

	.ldptr_rx memadr	; match on byte string achieved,
	mov	b,dph
	mov	a,dpl
	lcall	out2by		; type out memory address
	lcall	outsp		; and a space

8$:	.cmpw_rx memadr,ranghi	; this test handles special case
	jc	3$		; of a match on range end
	.ldptr_rx memadr
	inc	dptr
	.sdptr_rx ranglo
	sjmp	5$		; go reset the byte string pointer

9$:	.cmpw_rx ranglo,ranghi	; have we reached the range
	jc	3$		; yes, go prompt for next command
	inc	dptr		; else continue scan
	.sdptr_rx ranglo
	sjmp	6$

10$:    .incb_rx bytptr		; haven't matched all yet, get next pair
	.lbi_rx	b,bytptr	; even if past 'search to' address
	inc	dptr
	lcall	rdbyte
	cjne	a,b,8$
	sjmp	7$

	.page
	.sbttl	Test Ram

	;================================================
	; test memory

test:	lcall	gtrang		; get an address range
	jb	a.7,4$
	jz	4$

	.ldptr_rx ranglo	; ranglo holds starting address of range
				; ranghi holds ending address of range
1$:	lcall	rdbyte		; get byte stored at test location
	push	a		; save it

	mov	a,#0
	lcall	wtbyte		; zero the location
	lcall	rdbyte		; read back location
	cjne	a,#0,5$		; error if != zero

	mov	a,#0xFF
	lcall	wtbyte
	lcall	rdbyte
	cjne	a,#0xFF,6$	; error if != 0xFF

2$:	pop	a
	lcall	wtbyte		; restore previous content
	.cmpw_rx ranglo,ranghi	; hit end of test range?
	jc	3$		; yes, all done

	.ldptr_rx ranglo	; move to test next location
	inc	dptr
	.sdptr_rx ranglo
	lcall	wchdog		; hit watch dog timer
	sjmp	1$

3$:	ljmp	nomore
4$:	ljmp	badsyn

5$:	.ldptr  #msgccl		; can't clear location
	sjmp	7$

6$:	.ldptr  #msgcso		; can't set location to one's
;	sjmp	7$

7$:	.sdptr_rx temp3		; save error message temporarily
	.ldptr_rx ranglo	; address of error
	mov	b,dph
	mov	a,dpl
	lcall	out2by		; type out bad address
	lcall	outeq		; and equal sign
	lcall	rdbyte
	mov	b,a
	lcall	out1by		; its content
	lcall	outsp		; a space
	.ldptr_rx  temp3
	lcall	outstr		; and the type of error
	lcall	docrlf
	sjmp	2$

	.page
	.sbttl	compare numbers

	;================================================
	; compare - output sum & difference of two input numbers

compar:	lcall	nmdptr		; get first number
	.sdptr_rx  ranglo	; put it in ranglo
	lcall	nmdptr		; get second number
	.sdptr_rx  nbrhi	; save it in nbrhi

	; compute and output the sum

	lcall	sumnum		; compute sum
	.ldptr	#msgsis		; get its title
	lcall	1$		; output title & sum

	lcall	difnum		; compute difference
	.ldptr	#msgdis		; get its title
	lcall	1$		; output title & diff

	ljmp	nomore

	; compute and output the result

1$:	lcall	outstr		; output it
	.lb_rx	b,ranghi	; get result
	inc	r1
	movx	a,@r1
	lcall	out2by		; display result
	ret

	.page
	.sbttl	Dump Memory In Hex Format

	;================================================
	; dump - dump portion of memory in hex format
	;
	; get address range: start in ranglo (2 bytes), end in
	;		ranghi (2bytes)
	; if no address range is given, use whatever is in
	;		ranlo & ranghi

dump:	lcall	gtrang
	jb	a.7,3$

1$:	mov	a,#2
	lcall	comand
	jz	2$
	jb	a.7,3$
	cjne	a,#1,1$

	lcall	nmdptr		; get 'TO' address
	.sdptr_rx outadr	; save it
	setb	outflg		; use alternate output
	sjmp	1$		; go look for another modifier

2$:	.ldptr_rx ranglo
	mov	r3,dph
	mov	r2,dpl
	.ldptr_rx ranghi
	inc	dptr
	mov	r5,dph
	mov	r4,dpl

	lcall	ctrl_c
	jnc	4$
	sjmp	9$		; just exit

3$:	ljmp	badsyn		; some error

4$:	lcall	docrlf
	mov	dpl,r2
	mov	dph,r3
5$:	mov	a, r4		; how many more bytes to output??
	clr	c
	subb	a, dpl
	mov	r2, a
	mov	a, r5
	subb	a, dph
	jnz	6$		; if >256 left, then do next 16
	mov	a, r2
	jz	10$		; if we're all done
	anl	a, #0b11110000
	jnz	6$		; if >= 16 left, then do next 16
	sjmp	7$		; otherwise just finish it off
6$:	mov	r2, #16
7$:	mov	a, #':		; begin the line
	lcall	chrout
	mov	a,r2
	lcall	phex8		; output # of data bytes
	lcall	phex16		; output memory location
	mov	a, dph
	add	a, dpl
	add	a, r2
	mov	r3, a		; r3 will become checksum
	clr	a
	lcall	phex8		; output 00 code for data
8$:	lcall	rdbyte
	lcall	phex8		; output each byte
	add	a, r3
	mov	r3, a
	inc	dptr
	djnz	r2, 8$		; do however many bytes we need
	mov	a, r3
	cpl	a
	inc	a
	lcall	phex8		; and finally the checksum
	lcall	docrlf
	lcall	lindly
	lcall	ctrl_c
	jnc	5$		; keep working if no esc pressed

9$:	.ldptr  #msgabt		; get address of abort message
	lcall	outstr		; type it
	ljmp	nomore

10$:	mov	a, #':
	lcall	chrout
	clr	a
	lcall	phex8
	lcall	phex8
	lcall	phex8
	inc	a
	lcall	phex8
	mov	a, #255
	lcall	phex8
	lcall	docrlf
	lcall	docrlf
	clr	outflg
	ljmp	nomore

	; check for a '^C' character

ctrl_c:	lcall	coninp
	jnc	1$
	cjne	a,#3,1$		; a ^C ? - exit if not
	clr	outflg		; reset to terminal output
	setb	c		; char found
	ret
1$:	clr	c		; char not found
	ret
	
 	; a brief delay between line while uploading, so the
	; receiving host can be slow (i.e. most windows software)

lindly:	push	dph
	push	dpl
	lcall	tm$.1s
	pop	dpl
	pop	dph
	ret

; Highly code efficient resursive call phex contributed
; by Alexander B. Alexandrov <abalex@cbr.spb.ru>


phex8:	lcall	1$
1$:	swap	a		;SWAP A will be twice => A unchanged
	push	a
	anl	a, #15
	add	a, #0x90	; acc is 0x9X, where X is hex digit
	da	a		; if A to F, C=1 and lower four bits are 0..5
	addc	a, #0x40
	da	a
	lcall	chrout
	pop	a
	ret

phex16:	push	a
	mov	a, dph
	lcall	phex8
	mov	a, dpl
	lcall	phex8
	pop	a
	ret



	.page
	.sbttl	Load Memory In Hex Format

	;================================================
	; load - load portion of memory in hex format
	;
	; get address range: start in ranglo (2 bytes), end in
	;		ranghi (2bytes)
	; if no address range is given, use whatever is in
	;		ranlo & ranghi

ld_s1:	.ascii	"Begin sending Intel HEX format data, <ESC> to abort"
	.byte	cr,lf,eot
ld_s2: .byte	cr,lf
	.ascii	"Download aborted"
	.byte	cr,lf,eot
ld_s3: .byte	cr,lf
	.ascii	"Download completed"
	.byte	cr,lf,eot
ld_s4:	.ascii	"Summary:"
	.byte	eot
ld_s5:	.ascii	" lines received"
	.byte	eot
ld_s6:	.ascii	" bytes received"
	.byte	eot
ld_s7:	.ascii	" bytes written"
	.byte	eot
ld_s8:	.ascii	"Errors:"
	.byte	eot
ld_s9:	.ascii	" bytes unable to write"
	.byte	eot
ld_s10:	.ascii	" incorrect checksums"
	.byte	eot
ld_s11:	.ascii	" unexpected begin of line"
	.byte	eot
ld_s12:	.ascii	" unexpected hex digits"
	.byte	eot
ld_s13:	.ascii	" unexpected non-hex digits"
	.byte	eot
ld_s14:	.ascii	"No errors detected"
	.byte	eot

	;================================================
	;
	;16 byte parameter table: (eight 16 bit values)
	;  *   0 = lines received
	;  *   1 = bytes received
	;  *   2 = bytes written
	;  *   3 = bytes unable to write
	;  *   4 = incorrect checksums
	;  *   5 = unexpected begin of line
	;  *   6 = unexpected hex digits (while waiting for bol)
	;  *   7 = unexpected non-hex digits (in middle of a line)

load:	mov	dptr, #ld_s1
	lcall	outstr	 
	lcall	ld_ini

	; look for begining of line marker ':'
ld_inp:	lcall	inpchr
	cjne	a, #3, 1$	;Test for ^C
	ljmp	ld_ctc

1$:	cjne	a, #':, 2$
	sjmp	3$

	; check to see if it's a hex digit, error if it is
2$:	lcall	ld_2hx
	jc	ld_inp
	mov	r1, #6
	lcall	ld_inc
	sjmp	ld_inp

3$:	mov	r1, #0
	lcall	ld_inc

	; begin taking in the line of data
ld_lin:	mov	r4, #0		; r4 will count up checksum
	lcall	ld_gln
	mov	r0, a		; R0 = # of data bytes
	mov	a, #'.
	lcall	outchr
	lcall	ld_gln
	mov	dph, a		; High byte of load address
	lcall	ld_gln
	mov	dpl, a		; Low byte of load address
	lcall	ld_gln		; Record type
	cjne	a, #1, 1$	; End record?
	sjmp	7$
1$:	jnz	5$		; is it a unknown record type???
2$:	mov	a, r0
	jz	3$
	lcall	ld_gln		; Get data byte
	mov	r2, a
	mov	r1, #1
	lcall	ld_inc		; count total data bytes received
	mov	a, r2
	lcall	wtbyte		; c=1 if an error writing
	clr	a
	addc	a, #2		; 2 = byte write succeeded
	mov	r1, a		; 3 = byte write failed
	lcall	ld_inc
	inc	dptr
	djnz	r0, 2$

3$:	lcall	ld_gln		; get checksum
	mov	a, r4
	jz	ld_inp		; should always add to zero
4$:
	mov	r1, #4
	lcall	ld_inc		; all we can do it count # of cksum errors
	sjmp	ld_inp

	; handle unknown line type
5$:	mov	a, r0
	jz	3$		; skip data if size is zero
6$:	lcall	ld_gln		; consume all of unknown data
	djnz	r0, 6$
	sjmp	3$

	; handles the proper end-of-download marker
7$:	mov	a, r0
	jz	8$		; should usually be zero
	lcall	ld_gln		; consume all of useless data
	djnz	r0, 6$
8$:	lcall	ld_gln		; get the last checksum
	mov	a, r4
	jnz	4$
	lcall	lindly		; ~.1 second
	mov	dptr, #ld_s3	; "download went ok..."
	lcall	outstr

	; consume any characters that
	; may be left in the buffer

9$:	lcall	coninp
	jc	9$
	ljmp	ld_sum

	;================================================
	; handle ^C received in the download stream
ld_ctc:	lcall	lindly		; ~.1 second
	mov	dptr, #ld_s2	; "download aborted."
        lcall	outstr
	ljmp	ld_sum

	;================================================
	; increment parameter specified by R1
	; note, values in Acc and R1 are destroyed
ld_inc:	mov	a, r1
	anl	a, #0b00000111	;just in case
	rl	a
	add	a, #ld_prm
	mov	r1, a		;now r1 points to LSB
	movx	a,@r1
	inc	a
	movx	@r1,a
	jnz	1$
	inc	r1
	movx	a,@r1
	inc	a
	movx	@r1,a
1$:	ret

	;================================================
	; get parameter, and inc to next one (@r1)
	; carry clear if parameter is zero.
	; 16 bit value returned in dptr
ld_gp:	setb	c
	movx	a, @r1
	mov	dpl,a
	inc	r1
	movx	a, @r1
	mov	dph,a
	inc	r1
	mov	a, dpl
	jnz	1$
	mov	a, dph
	jnz	1$
	clr	c
1$:	ret

	;================================================
	; a special version of getlin just for the download.  Does not
	; look for special control characters. Handles ESC key by
	; popping the return address (I know, nasty, but it saves many
	; bytes of code) and then jumps to the esc key
	; handling.  This getlin doesn't echo characters, and if it
	; sees ':', it pops the return and jumps to an error handler
	; for ':' in the middle of a line.  Non-hex digits also jump
	; to error handlers, depending on which digit.
	  
ld_gln:	lcall	inpchr
	lcall	upper
	cjne	a, #3, 2$
1$:	pop	acc
	pop	acc
	sjmp	ld_ctc
2$:	cjne	a, #':, 4$
3$:	mov	r1, #5		; handle unexpected beginning of line
	lcall	ld_inc
	pop	acc
	pop	acc
	ljmp	ld_lin		; and now we're on a new line!
4$:	lcall	ld_2hx
	jnc	5$
	mov	r1, #7
	lcall	ld_inc
	sjmp	ld_gln
5$:	mov	r2, a		; keep first digit in r2
6$:	lcall	inpchr
 	lcall	upper
	cjne	a, #27, 7$
	sjmp	1$
7$:	cjne	a, #':, 8$
	sjmp	3$
8$:	lcall	ld_2hx
	jnc	9$
	mov	r1, #7
	lcall	ld_inc
	sjmp	6$
9$:	xch	a, r2
	swap	a
	orl	a, r2
	mov	r2, a
	add	a, r4		; add into checksum
	mov	r4, a
	mov	a, r2		; return value in acc
	ret

	;================================================
	; print out download summary
ld_sum:
	mov	a, r6
	push	acc
	mov	a, r7
	push	acc
	mov	dptr, #ld_s4
	lcall	outstr
	lcall	docrlf
	mov	r1, #ld_prm
	mov	r6, #<ld_s5
	mov	r7, #>ld_s5
	lcall	ld_ner
	mov	r6, #<ld_s6
	mov	r7, #>ld_s6
	lcall	ld_ner
	mov	r6, #<ld_s7
	mov	r7, #>ld_s7
	lcall	ld_ner

	; now print out error summary
	mov	r2, #5
1$:	lcall	ld_gp
	jc	2$		;any errors?
	djnz	r2, 1$
	; no errors, so we print the nice message
	mov	dptr, #ld_s14
	lcall	outstr
	sjmp	3$

	; there were errors, so now we print 'em
2$:	mov	dptr, #ld_s8
	lcall	outstr
	lcall	docrlf
	; but let's not be nasty... only print if necessary
	mov	r1, #(ld_prm+6)
	mov	r6, #<ld_s9
	mov	r7, #>ld_s9
	lcall	ld_err
	mov	r6, #<ld_s10
	mov	r7, #>ld_s10
	lcall	ld_err
	mov	r6, #<ld_s11
	mov	r7, #>ld_s11
	lcall	ld_err
	mov	r6, #<ld_s12
	mov	r7, #>ld_s12
	lcall	ld_err
	mov	r6, #<ld_s13
	mov	r7, #>ld_s13
	lcall	ld_err

3$:	pop	acc
	mov	r7, a
	pop	acc
	mov	r6, a
	lcall	docrlf
	ljmp	nomore

ld_err:	lcall	ld_gp		;error conditions
	jnc	2$

1$:	lcall	outsp
	push	r1
	.lb_rx	a,dbase
	push	a
	.sb_rx	dbase,#2	; set decimal
	mov	a,dpl
	mov	b,dph
	lcall	out2by
	pop	a
	.sb_rx	dbase,a
	pop	r1
	lcall	r6r7todptr
	lcall	outstr
	lcall	docrlf
2$:	ret

ld_ner=.
	lcall	ld_gp		;non-error conditions
	sjmp	1$

	;================================================
	; init all load parms to zero.

ld_ini:	mov	r0, #ld_prm
	clr	a
1$:	movx	@r0, a
	inc	r0
	cjne	r0, #ld_prm + 16, 1$
	ret

	;================================================
	; move r6/r7 to/from dptr routines

r6r7todptr:
	mov	dpl, r6
	mov	dph, r7
	ret

dptrtor6r7:
	mov	r6, dpl
	mov	r7, dph
	ret

	;================================================
	; convert ascii to hex value

	; carry set if invalid input
ld_2hx:	add	a, #208
	jnc	2$
	add	a, #246
	jc	1$
	add	a, #10
	clr	c
	ret

1$:	add	a, #249
	jnc	2$
	add	a, #250
	jc	2$
	add	a, #16
	clr	c
	ret

2$:	setb	c
	ret

	.page
	.sbttl	Delay Function

	;================================================
	; delay - delay specified # of milliseconds

delay:	lcall	nmdptr		; get delay time
	lcall	timdel
	ljmp	nomore

	;================================================
	; time delay subroutine
	; dptr is input as the # of milliseconds to delay
	; adj tloop so (tloop * 50 * cycle time=1 ms)

tm$.1s:	mov	dptr,#100	; .1 second wait

timdel: push	a
	push	b

	mov	a,dpl		; complement dptr (1's complement)
	cpl	a
	mov	dpl,a
	mov	a,dph
	cpl	a
	mov	dph,a		; complement of 0 is -1

1$:	inc	dptr
	clr	a
	cjne	a,dpl,2$	; test low byte
	cjne	a,dph,2$	; test high byte

	pop	b		; exit
	pop	a
	ret

2$:	mov	a,#tloop	; tloop	= ~20
3$:	lcall	wchdog		; hit watch dog timer
	mov	b,#timcon	; at 20MHz inplace loop is ~50 us.
	djnz	b,.		; inplace loop
	djnz	a,3$		; loop tloop times ~ 1ms.
	sjmp	1$

	.page
	.sbttl	Help List

	;================================================
	; help command - list all monitor commands

help:

.ifdef	_xhelp
	mov	a,#1		; search for specific help
	lcall	comand
	jb	a.7,1$		; command search failed
	jz	1$
	lcall	xhelp		; returns with expanded help
	lcall	outstr		; string address in dptr
	lcall	nomore
.endif

1$:	lcall	docrlf		; next line
	mov	dptr,#comlst	; command list

2$:	mov	r3,#4		; commands per line

3$:	mov	r2,#12		; positions per command
				; must be larger than longest command
4$:	clr	a
	movc	a,@a+dptr	; get character
	inc	dptr
	cjne	a,#cr,5$
	sjmp	6$

5$:	lcall	outchr		; print command character
	djnz	r2,4$

6$:	clr	a
	movc	a,@a+dptr	; get character
	cjne	a,#lf,7$	; end of list ?

	lcall	docrlf		; yes - next line
	ljmp	nomore

7$:	djnz	r3,8$
	lcall	docrlf		; new line
	sjmp	2$

8$:	mov	a,#spc		; space to next command
	lcall	outchr
	djnz	r2,8$
	sjmp	3$

	.page
	.sbttl	Command Lists

	;================================================
	;
	;          c o m m a n d   l i s t 
	;       s c a n n i n g   r o u t i n e
	;
	; this routine seeks a match of the characters pointed
	; at by the input line scanning pointer to one of the
	; commands in a list specified by acca.
	; the result of the scan for a match is returned in
	; acca as follows:
	;
	;	acca=-1: the match was unsuccessful. the syntax
	;		 pointer (synptr) was not updated
	;			(advanced).
	;
	;	acca= 0: the match was unsuccessful since there
	;			were
	;		  no more characters, i.e., the end of
	;			the
	;		line was reached.
	;
	;	acca=+n: successful match. the syntax pointer
	;			was updated
	;		 to the first character following the 
	;		  command
	;		  delimiter.  acca holds the number of
	;		      the
	;		  command matched.
	; global variables for external communication
	; synptr - good syntax input line char pointer
	; linptr - input line character pointer
	; delim - class of permissible command delimiters
	;
	; temporary 2 byte internal variables
	; lisptr - command list character pointer
	;
	; temporary 1 byte internal variables
	; nummat - number of characters that successfully match
	; lisnum - # of list within which a match will be sought
	; comnum - command number matched
	;
	; a, b and dptr are not preserved

comand:	.sb_rx	lisnum,a
	lcall	skpdlm
	jnc	1$
	clr	a
	ret

	; initialize the command list pointer to
	; the beginning of the command lists

1$:	mov	dptr,#comlst-1	; entry point

	; move to the beginning of the desired command list

	.lb_rx	a,lisnum
	lcall	fndlst

	; the list pointer, lisptr, now points to one less than
	; the first character
	; of the first command in the desired list

	.clrb_rx comnum

	; reset input line pointer to:
	; 1) beginning of line, or
	; 2) point where last successful scan terminated

2$:     .incb_rx comnum		; initialize the command # to 1
	.mvb_rx	linptr,synptr   ; copy synptr
	clr	nummat		; clear characters matched flag

3$:	lcall	mgetchr		; get input line char in b
	lcall	tstdlm		; test for a delimiter
	jc	6$		; success (found delimiter)

	lcall	getlst		; get command list char in a

	cjne	a,#lf,4$
	sjmp	7$

4$:	cjne	a,#cr,5$
	sjmp	7$

5$:	cjne	a,b,8$		; compare the two characters
	setb	nummat		; note match
	sjmp	3$

6$:     .mvb_rx	synptr,linptr	; successful match
	.lb_rx	a,comnum	; return command number
	ret

	; no match

7$:	jnb	nummat,8$	; did at least one match? no - next command
	lcall	tstdlm		; at least one matched - test for delimiter
	jc	6$		; if a delimiter, match has been achieved
	clr	a
	movc	a,@a+dptr	; retrieve last character

	; illegal delimiter
	; move to next command within list

8$:	cjne	a,#lf,9$
	mov	a,#-1 		; match failure
	ret			; no match possible within this list

9$:	cjne	a,#cr,10$
	ljmp	2$

10$:	lcall	getlst
	sjmp	8$

	.page
	.sbttl	Typeout Command

	;====================================
	; type out command number "comnum"
	; the list is specified in a
	; b and dptr are preserved

typcmd:	push	dph
	push	dpl
	push	b
				; list number in a
	mov	dptr,#comlst-1	; entry point
	lcall	fndlst		; go to head of desired list
	.lb_rx	a,comnum
	lcall	fndcmd		; go to head of desired command
	sjmp	2$

1$:	lcall	outchr		; type it

2$:	inc	dptr		; move to next character
	clr	a
	movc	a,@a+dptr	; get the command character
	cjne	a,#cr,1$	; if not terminator - type it

	pop	b		; if so, return
	pop	dpl
	pop	dph
	ret

	.page
	.sbttl	Find string

	;======================================
	; move to beginning of desired
	;   a - lst/cmd number
	;   b - termination character
	; each list string is terminated
	;   by a lf
	; each cmd string is terminated
	;   by a cr
	; the dptr register is assumed
	;   initialized pointing to one
	;   less than the first character
	;   of the first string
	; a, b and dptr are not preserved

fndlst:
	mov	b,#lf
	sjmp	1$

fndcmd=.
	mov	b,#cr
;	sjmp	1$

1$:	djnz	a,2$
	ret

2$:     push	a
3$:	inc	dptr
	clr	a
	movc	a,@a+dptr
	clr	c
	subb	a,b
	jnz	3$
	pop	a
	sjmp	1$

fndlnm:
	mov	r2,dph		; save address
	mov	r3,dpl
	mov	r4,#0		; at beginning

1$:	lcall	wchdog		; hit watch dog timer
	mov	dptr,#comlst-1	; beginning of lists
	inc	r4		; update number
	mov	a,r4		; search for this list
	lcall	fndlst
	inc	dptr		; point to address
	mov	a,r2		; compare with wanted address
	cjne	a,dph,1$
	mov	a,r3
	cjne	a,dpl,1$	; loop until list found
	mov	a,r4		; return the list number
	ret

	.page
	.sbttl	Skip Leading Delimiters

	;=================================================
	; skip leading delimiters
	; this routine should be called prior to scanning
	; for any information on the input line
	; the current character is ignored if the scannng
	; pointer is at the beginning of a line. if not, the
	; scanning pointer skips over spaces and commas
	; until an end of line or non-delimiter is found.
	; carry bit is set if and end of line is encountered.

	; a, b, and dptr are not preserved

skpdlm:	jb	bolflg,2$	; at beginning of line?

	; look at current input character

1$:     .lbi_rx	a,synptr	; get char
	lcall	tsteol		; test for end of line
	jnc	2$
	ret			; yes, end hit, carry is set

	; "peek" at next char in line

2$:	.lb_rx	a,synptr
	inc	a
	mov	r0,a
	movx	a,@r0
	mov	b,a
	lcall	tstdlm		; see if its a delimiter
	jc	3$
	ret			; if not, return

	; next char is a delimiter

3$:	lcall	mgetchr		; move to next char in input line
	.mvb_rx	synptr,linptr	; update syntax pointer
	sjmp	1$		; go test for end of line

	.page
	.sbttl	Test for End-of-Line Character

	;============================================
	; test for end-of-line character
	; sets c = 1 if char in a is a terminator
	; a is preserved

tsteol:	cjne	a,#cr,1$	; carriage return?
	sjmp	4$
1$:	cjne	a,#lf,2$	; line feed? (continued lines)
	sjmp	4$
2$:	cjne	a,#';,3$	; for several commands on one line
	sjmp	4$
3$:	clr	c		; terminator not found
	ret
4$:	setb	c		; terminator found 
	ret

	.sbttl	Test for Delimeter

	;===============================================
	; check the character in b against the 
	;  delimiter(s) specified by variable delim
	; a, b, and dptr are preserved
	; c is set to 0 if b is not a delimiter
	; c is set to 1 if b is a delimiter
	;  if delim=1, space is delimiter
	;  if delim=2, comma is delimiter
	;  if delim=3, space or comma is delimiter
	;  if delim=4, any non-alphanumeric is a delimiter
	; test for end-of-line (logical or physical)

tstdlm: push	b
	push	a
	mov	a,b		; character in b ==>> a
	lcall	tsteol		; check other terminations
	jc	5$		; terminations found

	.lb_rx	a,delim		; searching for this terminator
	cjne	a,#1,1$
	xch	a,b		; after: a = char, b = delim
	cjne	a,#spc,6$	; want a space - is it?
	sjmp	5$

1$:	cjne	a,#2,3$
	xch	a,b		; after: a = char, b = delim
2$:	cjne	a,#',,6$	; want a comma - is it?
	sjmp	5$

3$:	cjne	a,#3,4$
	xch	a,b		; after: a = char, b = delim
	cjne	a,#spc,2$	; want a space - is it?
	sjmp	5$

4$:	cjne	a,#4,6$
	mov	a,b		; after: a = char, b = char
	clr	c
	subb	a,#'0
	jc	7$		; (c = 1), a <  "O" - a delimiter
	subb	a,#'9-'0	; (c = 0)
	jc	6$		; (c = 1), a <= "9" - not a delimiter
	jz	7$		; (c = 0), a  = "9" - not a delimiter
	subb	a,#'A-'9	; (c = 0)
	jc	7$		; (c = 1), a <  "A" - a delimiter
	subb	a,#'Z-'A	; (c = 0)
	jc	6$		; (c = 1), a <= "Z" - not a delimiter
	jz	7$	        ; (c = 0), a  = "Z" - not a delimiter
				; (c = 0), a  > "Z" - a delimiter

5$:	setb	c		; c = 1, delimeter found
	sjmp	7$

6$:	clr	c		; c = 0, delimeter not found

7$:	pop	a		; restore values
	pop	b
	ret

	.page
	.sbttl	Sum Two Numbers
	;====================================================
	; add the 2 byte number stored in (ranglo,ranglo+1)
	; to the two byte number stored in (nbrhi,nbrlo)
	; and put the result in (ranghi,ranghi+1)

	.sbttl	Subtract Two Numbers

	;====================================================
	; subtract the 2 byte number stored in (nbrhi,nbrlo)
	; from the two byte number stored in (ranglo,ranglo+1)
	; and put the result in (ranghi,ranghi+1)

sumnum:	clr	sumdif		; set flag for SUM
	sjmp	1$

difnum=.
	setb	sumdif		; set flag for DIF
;	sjmp	1$

1$:	push	a
	push	b
	mov	r0,#nbrlo	; LSB of [nbrhi,nbrlo]
	movx	a,@r0
	mov	b,a
	mov	r1,#ranglo+1	; LSB of [ranglo,ranglo+1]
	movx	a,@r1
	jb	sumdif,2$
	add	a,b		; SUM of LSBs
	sjmp	3$
2$:	clr	c
	subb	a,b		; DIF of LSBs
3$:	push	a
	dec	r0
	dec	r1
	movx	a,@r0		; MSB of [nbrhi,nbrlo]
	mov	b,a
	movx	a,@r1		; MSB of [ranglo,ranglo+1]
	jb	sumdif,4$
	addc	a,b		; SUM of MSBs
	sjmp	5$
4$:	subb	a,b		; DIF of MSBs
5$:	mov	r1,#ranghi
	movx	@r1,a		; save MSB SUM in [ranghi,ranghi+1]
	pop	a
	inc	r1
	movx	@r1,a		; save LSB SUM in [ranghi,ranghi+1]
	pop	b
	pop	a
	ret

	.page
	.sbttl	Get Range

	;===================================================
	; this routine scans the input line for a pair of numbers
	; representing an address range.
	; a colon separating the pair implies "thru",
	; while an "!" implies "thru the following"
	; e.g., 100:105 is equivalent to 100!5
	; a single number implies a range of 1
	; on return (ranglo,ranglo+1) holds the range start, and
	; (ranghi,ranghi+1) holds the range end
	; a, b, r0, r1, and dptr are not preserved

gtrang:	lcall	number		; pick up first number
	jb	a.7,2$
	jnz	1$
	ret			; nothing more on input line

1$:     .mvw_rx	ranglo,nbrhi	; good single number
	sjmp	3$

	; bad number, but is it bad due to a ":" or "!" delimiter?
	; get the terminator for the first number

2$:	.lbi_rx	a,linptr
	cjne	a,#':,4$	; was it a colon? if not, go test for "!"
	lcall	8$		; was ":", process first number &
				; get next one
	jb	a.7,7$		; illegal if end of line or non-numeric
	jz	7$

3$:	.mvw_rx	ranghi,nbrhi	; transfer second number to ranghi
	sjmp	5$

4$:	cjne	a,#'!,6$	; was delimiter a "!"?

	lcall	8$		; was "!", process first number &
				; get next one
	jb	a.7,7$		; illegal if end of line or non-numeric
	jz	7$
	lcall	sumnum		; compute range end, put into ranghi

5$:	mov	a,#1		; success, return
	ret

6$:	mov	a,#-1		; illegal delimiter, return
7$:	ret

	; update syntax pointer, move first number to ranglo,
	; & get 2nd number

8$:	.mvb_rx	synptr,linptr
	.mvw_rx	ranglo,nbrhi
	lcall	number
	ret

	.page
	.sbttl	Get number in DPTR

	;====================================================
	; get a 2 byte number & return it in the index register

nmdptr:	lcall	number
	cjne	a,#1,1$
	.ldptr_rx nbrhi
	ret

1$:     pop	a		; dump return address
	pop	a
	ljmp	badsyn

	.page
	.sbttl	Scan For a Number

	;==================================================
	; scan for a number
	; return the most significant byte in nbrhi
	; and the least significant byte in nbrlo
	; the result of the scan for a number is returned in
	; acca as follows:
	;
	;	acca=-1: the match was unsuccessful. the syntax
	;		pointer (synptr) was not updated.
	;
	;	acca= 0: the scan was unsuccessful since there
	;		were no more characters. (i.e., the end
	;		of the line was encountered.)
	;
	;	acca=+1: the scan was successful. the syntax
	;		pointer was updated to the first character
	;		following the command.
	;
	; ix is preserved
	; global variables for external communication
	; nbrhi - number hi byte
	; nbrlo - number lo byte
	; ibcode - input base code
	; dbcode - display base code
	;
	; local variables
	; nbr2x - used in decimal conversion
	; initialize both bytes to zero

number:	push	r1
	push	r0
	.sb_rx	nbrhi,#0	; initialize
	.sb_rx	nbrlo,#0
	.mvb_rx	linptr,synptr	; initialize the line scanning pointer
	lcall	skpdlm		; are we at end of line?
	jnc	1$		; no, process a number
	pop	r0
	pop	r1
	clr	a		; yes, zero a
	ret

1$:	lcall	mgetchr		; get a character from the input
	lcall	tstdlm		; test for a delimiter
	jc	9$		; good delimiter if c is set
	mov	a,b
	clr	c
	subb	a,#'0		; subtract ascii 0
	jc	11$		; error if less
	mov	b,a		; save initial value

	.lb_rx	a,ibcode	; determine input base & go to right routine
	cjne	a,#1,2$
	sjmp	4$		; hexadecimal
2$:	cjne	a,#2,3$
	sjmp	7$		; decimal
3$:	cjne	a,#3,4$		; default an illegal input base to hex
	sjmp	8$		; octal

	; hex input processing

4$:	mov	a,b
	clr	c
	subb	a,#'9-'0
	jc	6$		; if 9 or less
	jz	6$
	mov	a,b
	subb	a,#'A-'0	; (c = 0)
	jc	11$		; not hex if < A
	mov	a,b
	subb	a,#'F-'0	; (c = 0)
	jc	5$
	jnz	11$		; not hex if > F
5$:	mov	a,b
	clr	c
	subb	a,#7		; move A-F above 0-9
	mov	b,a		; save value in b

6$:	lcall	14$		; shift lo & hi bytes left 4 bits
	lcall	14$
	.lb_rx	a,nbrlo		; or in new digit
	orl	a,b
	movx	@r1,a
	sjmp	1$

	; decimal input

7$:	mov	a,b
	clr	c
	subb	a,#0d10		; not decimal if > 9
	jnc	11$

	; multiply saved value by 10 & add in new digit

	lcall	15$		; multiply current number by 2 to get 2x value
	.mvw_rx	nbr2x,nbrhi	; save this *2 number temporarily
	lcall	14$		; multiply this # by 4 to get 8x value
	lcall	13$		; Compute 10x=2x+8x and add new digit
	sjmp	1$

	; octal input

8$:	mov	a,b
	clr	c
	subb	a,#0d8		; not octal if > 7
	jnc	11$
	lcall	14$		; shift hi & lo bytes 3 places left
	lcall	15$		; carry out of hibyte is illegal
	.lb_rx	a,nbrlo		; add in new digit
	orl	a,b
	movx	@r1,a
	sjmp	1$

9$:	.mvb_rx	synptr,linptr	; update good syntax line pointer
	mov	a,#1		; set "good scan" flag
	sjmp	12$

10$:	pop	a		; dump 'lcall 8$, 9$, or 10$' return address
	pop	a

11$:	mov	a,#-1		; conversion error - scan was unsuccessful

12$:	pop	r0
	pop	r1
	ret

13$:	mov	r1,#nbrhi+1
	mov	r0,#nbr2x+1
	movx	a,@r1		; LSB (nbrlo x 8)
	add	a,b		; LSB (nbrlo x 8) + new digit
	mov	b,a
	movx	a,@r0		; LSB (nbrlo x 2))
	addc	a,b		; LSB (nbrlo x 10) + new digit
	movx	@r1,a		; save new LSB
	dec	r1
	dec	r0
	movx	a,@r1		; MSB (nbrhi x 8)
	addc	a,#0		; MSB (nbrhi x 8) + carry
	jc	10$
	mov	b,a
	movx	a,@r0		; MSB (nbrhi x 2))
	addc	a,b		; MSB (nbrhi x 10) + carry
	movx	@r1,a		; save new MSB
	jc	10$
	ret

14$:	mov	r1,#nbrlo	; shift a two byte number left one position
	movx	a,@r1
	clr	c
	rlc	a
	movx	@r1,a
	dec	r1
	movx	a,@r1
	rlc	a
	movx	@r1,a
	jc	10$
15$:	mov	r1,#nbrlo	; shift a two byte number left one position
	movx	a,@r1
	clr	c
	rlc	a
	movx	@r1,a
	dec	r1
	movx	a,@r1
	rlc	a
	movx	@r1,a
	jc	10$
	ret

	.page
	.sbttl	General Output Routines

	;===========================================
	; output a space

outsp:	mov	a,#spc
	ljmp	outchr		; returns to caller

	;===========================================
	; output an "=" sign

outeq:	mov	a,#'=
	ljmp	outchr		; returns to caller

	;==========================================
	; output a 1 byte number

out1by:	clr	outbw		; set flag for 1-byte
	sjmp	outnum

	;==========================================
	; output a 2 byte number

out2by:	setb	outbw		; set flag for 2-bytes
;	sjmp	outnum
	
	.page
	.sbttl	Output A Number

	;==========================================
	; display the number contained in [b] or [b,a]
	; according to the base specified in "dbcode"
	; leading zeros are included
	; a, b, r0, r1, and dptr are preserved
	;
	; global variables for external communication
	; dbcode - display base code
	;
	; bit flags:
	; outbw  - byte (0), word (1)
	;
	; local variables:
	; digit  - decimal digit being built
	; numbhi - hi byte of number being output
	; numblo - lo byte of number being output
	; dgtcnt - number of output digits

outnum:	push	a		; save these
	push	b
	push	r0
	push	r1
	push	dpl
	push	dph

	.sb_rx	numblo,a	; save LSB
	.sb_rx	numbhi,b	; save MSB

	mov	a,#1		; assume 1-byte
	jnb	outbw,1$
	mov	a,#2		; else 2-bytes
1$:	push	a

	.lb_rx	a,dbcode
	cjne	a,#1,2$		; 1 - hex
	sjmp	cnvhex
2$:	cjne	a,#2,3$		; 2 - decimal
	sjmp	cnvdec
3$:	cjne	a,#3,4$		; 3 - octal
	ljmp	cnvoct
4$:	cjne	a,#4,5$		; 4 - binary
	ljmp	cnvbin
5$:				; fall through to hex

	; output a hex number

cnvhex:	pop	a		; 1 byte=2 chars, 2 bytes=4 chars
	rl	a
	mov	b,a
2$:	lcall	shiftby2	; get next 4 bits
	lcall	shiftby2

	anl	a,#0x0F		; extract 4 bits
	clr	c
	subb	a,#0d10		; convert to ascii
	jc	3$		; 0-9
	add	a,#7		; A-F
3$:	add	a,#10

	lcall	toascii
	djnz	b,2$
	sjmp	outxit

	; output a decimal number

cnvdec: pop	a
	cjne	a,#1,1$
	.lb_rx	a,numbhi	; load MSB
	inc	r1
	movx	@r1,a		; move to LSB
	dec	r1
	clr	a
	movx	@r1,a		; clear MSB
	mov	a,#3
	sjmp	2$
1$:	mov	a,#5
2$:	.sb_rx	dgtcnt,a

3$:	mov	dptr,#6$
	.lb_rx	a,dgtcnt	; digit count
	sjmp	5$
4$:	inc	dptr
	inc	dptr
5$:	djnz	a,4$		; update pointer to proper digit
	movc	a,@a+dptr	; MSB of comparison value (a == 0)
	mov	b,a
	mov	a,#1
	movc	a,@a+dptr	; LSB of comparison value
	mov	dpl,a
	mov	dph,b
	.clrb_rx digit
	sjmp	7$

6$:	.word	0d1
	.word	0d10
	.word	0d100
	.word	0d1000
	.word	0d10000

7$:	clr	c
	.lb_rx	a,numblo	; load LSB
	push	a		; save value for restore
	subb	a,dpl		; perform subtraction
	movx	@r1,a		; save difference LSB
	dec	r1
	movx	a,@r1		; load MSB
	push	a		; save value for restore
	subb	a,dph		; perform subtraction
	movx	@r1,a		; save difference MSB
	jc	8$		; finish up on carry
	.incb_rx digit		; else update digit
	pop	a		; dump restore data
	pop	a
	sjmp	7$		; and loop

8$:	pop	a
	movx	@r1,a		; restore numbhi
	inc	r1
	pop	a
	movx	@r1,a		; restore numblo

	.lb_rx	a,digit
	lcall	toascii		; convert to ascii

	.decb_rx dgtcnt
	jnz	3$		; any more ? yes - loop

outxit:	pop	dph
	pop	dpl
	pop	r1
	pop	r0
	pop	b
	pop	a
	ret

	; output an octal number

cnvoct:	pop	a		; first approximation of # of
	rl	a
	mov	b,a
	cjne	a,#2,1$
	.clrb_rx digit
	lcall	shiftby2	; 1 byte - get first 2 bits
	lcall	toascii
	sjmp	2$		; go output last 2 digits

1$:	.clrb_rx digit
	lcall	shiftby1	; two byte # - output hi order bit/digit
	lcall	toascii
	inc	b		; 5 more digits to go

2$:	lcall	shiftby2	; get next 3 bits
	lcall	shiftby1
	anl	a,#7		; extract 3 bits
	lcall	toascii
	djnz	b,2$
	sjmp	outxit

	; output a binary number

cnvbin:	pop	a		; 1 byte=8 bits, 2 bytes=16 bits
	rl	a
	rl	a
	rl	a
	mov	b,a
1$:	lcall	shiftby1
	anl	a,#1
	lcall	toascii
	djnz	b,1$
	sjmp	outxit

shiftby2:
	lcall	shiftby1	; left shift 2 bits

shiftby1:
	clr	c		; left shift [numblo, numbhi, digit] 1 bit
	.lb_rx	a,numblo	; numblo
	rlc	a
	movx	@r1,a		; save numblo
	dec	r1
	movx	a,@r1		; numbhi
	rlc	a
	movx	@r1,a		; save numbhi
	dec	r1
	movx	a,@r1		; digit
	rlc	a
	movx	@r1,a		; save digit
	ret

toascii:
	add	a,#'0	; convert to a numeric ascii digit & output it
	lcall	outchr
	ret

	.page
	.sbttl	Get Character Routines

	;=================================================
	; this routine gets the next character
	; from the input line buffer
	; a is preserved
	; b is loaded with the character
	; linptr is incremented and left
	; pointing to the character returned

mgetchr:
	push	a
	push	r0
	push	r1
	.incb_rx linptr		; increment pointer
	mov	r0,a		; pointer => r0
	movx	a,@r0		; get character @r0
	mov	b,a		; place character in b
	clr	bolflg		; clr flag to not at "beginning of line"
	pop	r1
	pop	r0
	pop	a
	ret

	;==================================================
	; this routine gets the next character in the command
	; lists
	; acca is the character retrieved
	; accb is preserved
	; ix is incremented & left pointing to the character returned


getlst:	inc	dptr
	clr	a
	movc	a,@a+dptr
	ret

	.page
	.sbttl	Get a line

	;=======================================================
	; this routine constructs a line of input by getting all
	; input characters up to and including a carriage return
	; (which then designates "end of line").
	; lf/cr are placed in the input line
	; typing rubout will delete the previous character
	; typing control-c will abort the line
	; typing control-z will use the previous line
	; all other control characters are stripped
	; the input line is stored beginning at the address
	; ttybuf and ending at the address ttyend
	; acca, accb, & ix are not preserved
	;
	; global variables
	; ttybuf - input line start of buffer
	; ttyend - input line end of buffer
	;
	; local constants

getlin:	mov	a,#0		; a holds last input char
	mov	r0,#ttybuf-1	; set pointer to one less than
				; the beginning of the line buffer
			
1$:	cjne	r0,#ttyend,2$	; check current line end against buffer end

	; line too long - abort it as if a control-c had been typed

	.ldptr  #msgltl		; get message
	lcall	outstr		; output it
	mov	a,#'C-64	; put ctl-c in a
	ret

2$:	lcall	inpchr		; get a character (returned in a)

	cjne	a,#26,3$	; is char a control-z?
	lcall	docrlf		; yes, type cr-lf, use last line
	ret

3$:	cjne	a,#cr,4$	; is char a cr?
	sjmp	5$
4$:	cjne	a,#lf,7$	; or a lf?

5$:	inc	r0
	movx	@r0,a		; yes, store the terminator

	jb	hdxflg,6$	; test for half-duplex terminal
	lcall	docrlf		; type cr-lf
6$:	ret			; now return

7$:	cjne	a,#'C-64,8$	; is char a control-c?
				; return ctl-c in a
	mov	dptr,#msgctc	; echo a ^C
	lcall	outstr
	ret

8$:	cjne	a,#127,12$
	
	; current character is a delete
	; test line length - if its zero, ignore this delete
	; since we can't delete prior to first char in input line

	cjne	r0,#ttybuf-1,9$
	sjmp	1$

9$:	lcall	outchr		; delete character on screen
	dec	r0
	cjne	r0,#ttybuf-1,11$
10$:	clr	a
	sjmp	1$

11$:	movx	a,@r0
	sjmp	1$

12$:    cjne	a,#spc,13$	; all other control characters are
13$:	jc	15$		; output but not inserted into the buffer
	jnb	uprflg,14$	; skip on no case conversion
	lcall	upper
14$:	inc	r0		; not a delete, so advance to next char
	movx	@r0,a		; store it in inplin
15$:	jb	hdxflg,16$	; check half duplex? yes - skip
	lcall	outchr		; echo character
16$:	sjmp	1$		; get another

	;====================================================
	; converts the ascii code in Acc to uppercase, if it is lowercase

	; Code efficient (saves 6 byes) upper contributed
	; by Alexander B. Alexandrov <abalex@cbr.spb.ru>

upper:	cjne	a, #97, 1$
1$:	jc	3$		;end if acc < 97
	cjne	a, #123, 2$
2$:	jnc	3$		;end if acc >= 123
	add	a, #224		;convert to uppercase
3$:	ret

	;====================================================
	; initialization routine

inital:	jb	mninit,1$	; setup once

	.sb_rx	ibcode,#1	; set input base to hex
	.sb_rx	dbcode,#1	; set display base to hex
	.sb_rx	rdcode,#1	; set memory space to data/idata
	.sb_rx	wtcode,#1	; set memory space to data/idata

	setb	uprflg		; default is upper case conversion

	.sb_rx	linptr,#ttybuf-1	; set to beginning of buffer
	.sb_rx	synptr,#ttybuf-1	; set to beginning of buffer

	; set up display base number

	.sb_rx	dbnbr,#16

	; preset flags

	clr	outflg		; default output to terminal
	clr	hdxflg		; clear	half-duplex flag

	; prepare break point processing

	clr	brksvc		; break service not active
	setb	brkrdy		; break service ready

	setb	mninit		; initialization complete
1$:	ret

	;=====================================================
	; input a character (returned in a)

inpchr: lcall	coninp
	jnc	inpchr		; wait for character
	ret

	;======================================================
	; output the character in a
	; to the desired output device/location
	; if outflg = 0, output is to terminal
	; if outflg = 1, output is to address in outadr
	;		 and this address is then incremented
	;		 and outflg is set to 0

outchr: push	r1
	push	r0
	push	b
	push	a

	jb	outflg,11$	; skip if not terminal

	cjne	a,#lf,1$	; (lf)? - no skip
	sjmp	12$		; done

1$:	cjne	a,#cr,2$	; (cr)? - no skip
	lcall	docrlf		; new line
	sjmp	12$		; done

2$:	cjne	a,#127,3$	; (delete)? - no skip
	push	a		; save a
	lcall	chrout
	mov	a,#spc
	lcall	chrout
	.decb_rx cplcnt		; bump counter
	sjmp	10$

3$:	cjne	a,#spc,4$	; don't count control characters
4$:	jc	11$		; but output them as non printing

5$:     push	a		; save a
	.lb_rx	a,cplcnt	; get "chars per line" count

	; greater than or equal to max, send cr-lf

	cjne	a,#cplmax,6$	; get "max chars per line"
6$:	jnc	8$		; send cr-lf if greater/equal

	; less than max, but also send cr-lf
	; if 10 from end and printing a space

	cjne	a,#cplmax-10,7$
7$:	jc	9$
	pop	a
	push	a
	cjne	a,#spc,9$	; near end, test if about to print a space
	
	; terminal line full or nearly full - interject a cr-lf

8$:	lcall	docrlf
9$:	.incb_rx cplcnt		; bump counter
10$:	pop	a		; pop character
11$:	lcall	chrout		; and output

12$:	pop	a
	pop	b
	pop	r0
	pop	r1
	ret

	;======================================================
	; send a carriage return-line feed to the terminal

docrlf:	push	a
	push	r1

	mov	a,#cr
	lcall	chrout
	mov	a,#lf
	lcall	chrout
	clr	a
	.sb_rx	cplcnt,a

	pop	r1
	pop	a
	ret

	;======================================================
	; send char in a

chrout:	jb   outflg,1$	; check destination
	ljmp	conout	; output to console
			; returns to caller of chrout
1$:	lcall	wchdog	; hit watch dog timer
	push	dph
	push	dpl
	push	r1
	.ldptr_rx	outadr
	lcall	wtbyte
	inc	dptr
	.sdptr_rx	outadr
	pop	r1
	pop	dpl
	pop	dph
	ret

	;===================================================
	; output a character string which begins at the address
	; in the  register dptr
	; a and b are preserved
	; dptr is left pointing to the string terminator

outstr:	push	a
	sjmp	2$

1$:	lcall	outchr
	inc	dptr
2$:     clr	a
	movc	a,@a+dptr
	cjne	a,#eot,1$

	pop	a
	ret

	;======================================================
	; misc character strings

msghed:	.ascii	/MONDEB-51 1.00 (2020-04-23)/
	.byte	cr,eot
msgprm:	.byte	'*,eot
msgctc:	.byte	'^,'C,eot
msgltl:	.ascii	/too long/
	.byte	eot
msgver:	.ascii	/ ok/
	.byte	eot
msgnve:	.ascii	/ checksum error /
	.byte	eot
msgccl:	.ascii	/ can't clear/
	.byte	eot
msgcso:	.ascii	/can't set to ones/
	.byte	eot
msgsis:	.ascii	/ sum is /
	.byte	eot
msgdis:	.ascii	/, dif is /
	.byte	eot
msgabt:	.ascii	/ aborted by ^C/
	.byte	cr,eot

	.page
	.sbttl	Command Jump Table

	;================================================
	; execute a computed 'goto' to the proper command

	.area	CmdTbl

jmpcmd:	dec	a		; compute (a - 1) * 3
	mov	b,#3
	mul	ab		; a is product
	mov	dptr,#1$
	jmp	@a+dptr		; jump into jump table
;table-command
1$:	ljmp	case
	ljmp	compar
	ljmp	contin
	ljmp	copy
	ljmp	dbase
	ljmp	delay
	ljmp	displa
	ljmp	dump
	ljmp	goto
	ljmp	help
	ljmp	ibase
	ljmp	load
	ljmp	rdspace
	ljmp	reg
	ljmp	reset
	ljmp	set
	ljmp	search
	ljmp	test
	ljmp	verify
	ljmp	wtspace
	ljmp	cli
	ljmp	clix0
	ljmp	clix1
	ljmp	sei
	ljmp	seix0
	ljmp	seix1

	.page
	.sbttl	Command Lists

	;=====================================================
	; command lists
	;  The cr signifies end-of-command
	;  The lf signifies end-of-command-list
	; list 1 - major commands

	.area	CmdLst

comlst:
	.ascii	/CASE/		; Upper/Normal Character Case
	.byte	cr
	.ascii	/COMPARE/	; print sum & difference of 2 numbers
	.byte	cr
	.ascii	/CONTINUE/	; continue after entry call
	.byte	cr
	.ascii	/COPY/		; copy from one location to another
	.byte	cr
	.ascii	/DBASE/		; set display base
	.byte	cr
	.ascii	/DELAY/		; delay specified # of bytes
	.byte	cr
	.ascii	/DISPLAY/	; display memory data
	.byte	cr
	.ascii	/DUMP/		; dump hex file
	.byte	cr
	.ascii	/GOTO/		; go to memory address
	.byte	cr
	.ascii	/HELP/		; help listing
	.byte	cr
	.ascii	/IBASE/		; set input base
	.byte	cr
	.ascii	/LOAD/		; load hex file
	.byte	cr
	.ascii	/RDSPACE/	; reading memory space
	.byte	cr
	.ascii	/REG/		; display registers
	.byte	cr
	.ascii	/RESET/		; software reset
	.byte	cr
	.ascii	/SET/		; set memory data
	.byte	cr
	.ascii	/SEARCH/	; search memory for a byte string
	.byte	cr
	.ascii	/TEST/		; test a range of memory
	.byte	cr
	.ascii	/VERIFY/	; verify that memory content is unchanged
	.byte	cr
	.ascii	/WTSPACE/	; writing memory space
	.byte	cr
	.ascii	/CLI/		; clear interrupt mask
	.byte	cr
	.ascii	/CLIX0/		; clear ex0 interrupt mask
	.byte	cr
	.ascii	/CLIX1/		; clear ex1 interrupt mask
	.byte	cr
	.ascii	/SEI/		; set interrupt mask
	.byte	cr
	.ascii	/SEIX0/		; set ex0 interrupt mask
	.byte	cr
	.ascii	/SEIX1/		; set ex1 interrupt mask
	.byte	cr

	.area	OptLst

	.byte	lf		; end of list 1

	; list 2 - modifier to dump

dmplst:	.ascii	/TO/		; destination
	.byte	cr
	.byte	lf		; end of list 2

	; list 3 - number base specifiers

baslst:	.ascii	/HEX/		; base 16
	.byte	cr
	.ascii	/DEC/		; base 10
	.byte	cr
	.ascii	/OCT/		; base 8
	.byte	cr
	.ascii	/BIN/		; base 2
	.byte	cr
	.byte	lf		; end of list 3

	; list 4 - information request

inflst:	.ascii	/?/
	.byte	cr
	.byte	lf		; end of list 4

	; list 5 - register names

reglst:	.ascii	/.IE/	        ; m_stack data order
	.byte	cr
	.ascii	/.PSW/
	.byte	cr
	.ascii	/.A/
	.byte	cr
	.ascii	/.B/
	.byte	cr
	.ascii	/.R0/
	.byte	cr
	.ascii	/.R1/
	.byte	cr
	.ascii	/.R2/
	.byte	cr
	.ascii	/.R3/
	.byte	cr
	.ascii	/.R4/
	.byte	cr
	.ascii	/.R5/
	.byte	cr
	.ascii	/.R6/
	.byte	cr
	.ascii	/.R7/
	.byte	cr
	.ascii	/.DPH/
	.byte	cr
	.ascii	/.DPL/
	.byte	cr
	.ascii	/.DPTR=[DPH,DPL]/
	.byte	cr
	.ascii	/.SPX/
	.byte	cr
	.ascii	/.SP/
	.byte	cr
	.ascii	/.[SPX,SP]/
	.byte	cr
	.ascii	/.PC/
	.byte	cr
	.ascii	/.BRKPNT/
	.byte	cr
	.byte	lf		; end of list 5

	; list 6 - modifiers to "display"

dsplst:	.ascii	/DATA/
	.byte	cr
	.ascii	/USED/
	.byte	cr
	.byte	lf		; end of list 6

	; list 7 - modifier to "load"

srclst:	.ascii	/FROM/		; source
	.byte	cr
	.byte	lf		; end of list 7

	; list 8 - modifier to "rdspace/wtspace"

msplst:	.ascii	/DATA/		; data / idata memory space
	.byte	cr
	.ascii	/XDATA/		; edate / fdata / xdata memory spaces
	.byte	cr
	.ascii	/CODE/		; program code space
	.byte	cr
	.byte	lf		; end of list 8

	; list 9 - modifier to "case"

caslst:	.ascii	/UPPER/		; change case to upper
	.byte	cr
	.ascii	/LOWER+UPPER/	; reset case conversion
	.byte	cr
	.byte	lf		; end of list 9

	.area	EndLst

	; end of lists

	.byte	0


	.end

.endif	; .else of _mondeb51

