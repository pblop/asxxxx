.nlist
;****************************************************************************
;
; Compile The Serial Interface Code
;
;	AS89LP -loxff sp0_x.asm
;
; To Define The Serial Interface Globals Place The Following Lines In Your Code
;
;	.define _sp0_x
;	.list	(!)	; This Inhibits The Include File Pagination
;	.include "sp0_x.asm"
;	.list
;
;****************************************************************************
;
; This Interrupt Driven Serial Port Handler Was Derived From The
; Series of SP0_ Drivers Written By John C. Wren (03/26/90 ).
;
;****************************************************************************
;
; SP0_X.ASM Globals In A Macro
;
	.macro	.sp0_x.globals	arg$
	  .iifne  arg$	.list	(!,src,me)
		.globl	SP0_INIT   
		.globl	SP0_INT    
		.globl	SP0_MCT
		.globl	SP0_MDT
		.globl	SP0_MXT
		.globl	SP0_IN	   
		.globl	SP0_INS    
		.globl	SP0_INCLEAR
		.globl	SP0_OUT    
		.globl	SP0_OUTS
		.globl	SP0_OUTEMPTY

		.globl	B_SP0DIR
	.endm
;
;****************************************************************************
;
; Serial Port Interrupt Vector

	.define	Int$Urt
	.define	SP0_INT	^/UrtInt/	; The Real Entry Point
	.undefine	Int$TF1		; Serial Port Uses This timer

;****************************************************************************
.ifdef _sp0_x
	.list	(!,src)
;	sp0_x.asm       Globals                 Defined
	.nlist

	.sp0_x.globals	0
.else
	.list
	.title	Serial Port 0

	.module	SP0_X

	.sp0_x.globals	1

;
;****************************************************************************
;
;  Purpose:
;	Interrupt Driven Serial Port Handler, External Memory Version
;
;  Processor:
;	AT89LP3240
;
;  Assembler:
;	AS89LP (04/23/19)
;
;  Comments:
;	A LJMP To SP0_INT Needs To Be Placed At Location 0023h.  
;
;****************************************************************************
;
; Global Serial Port Routines
;
;	SP0_INIT	- Initializes Serial Port And Timer 1
;	SP0_INT		- Redirects RCV and XMT Interrupts
;	SP0_MCT		- Outputs a Null Terminated String From Code
;	SP0_MDT		- Outputs a Null Terminated String From Data/IData Ram
;	SP0_MXT		- Outputs a Null Terminated String From XRAM
;	SP0_IN		- Get Character From Input Buffer (Wait If Empty)
;	SP0_INS		- Return Status Of Receive Buffer (C=1, Character Available)
;	SP0_INCLEAR	- Empty Input Buffer
;	SP0_OUT		- Put Character In Output Buffer (Wait If Full)
;	SP0_OUTS	- Return Status of Transmit Buffer (C=1, Buffer Full)
;	SP0_OUTEMPTY	- Empty Output Buffer
;	
;****************************************************************************
;
;  Includes
;
	.list	(!)	; This Inhibits The Include File Pagination
	.include "lp3240.sfr"
	.list
;
;****************************************************************************
;
;  Equates
;
;
;
;  These Are The Buffer Sizes, And Can Be Up To 255 Bytes
;
E_SP0IBL	=:	32			;  32 Character Input Buffer
E_SP0OBL	=:	224			; 224 Character Output Buffer
;
;****************************************************************************
;
;  Data Areas
;
	.area	Bits
B_SP0OFL:	.ds	1			; Serial Output Flag
B_SP0DIR:	.ds	1			; Direct Access Mode

.ifne	0
	.area	Data	; Normal Configuration
.else
	.area	RData	; Alternate Uses Register Space
.endif

D_SP0IBH:	.ds	1			; Serial Input Head Pointer
D_SP0IBT:	.ds	1			; Serial Input Tail Pointer
D_SP0ICC:	.ds	1			; Serial Input Character Count
D_SP0OBH:	.ds	1			; Serial Output Buffer Head Pointer
D_SP0OBT:	.ds	1			; Serial Output Buffer Tail Pointer
D_SP0OCC:	.ds	1			; Serial Output Character Count

	.area	EData
X_SP0IBB:	.ds	E_SP0IBL		; Serial Input Buffer
X_SP0OBB:	.ds	E_SP0OBL		; Serial Output Buffer
;
;****************************************************************************
;
;  Program Area
;
	.area	SP0_X
;
;****************************************************************************
;
;  Description:
;	Initialize Serial Port 0 Variables, Serial Port, Timer 1
;
;	Default Configuration Is Serial Port Interrupts Enabled
;	With System Wide Interrupts Enabled
;
;	Set Bit Variable B_SP0DIR = 1 To Enable Direct Port Access
;					 Disables Serial Interrupts
;	Set Bit Variable B_SP0DIR = 0 To Disable Direct Port Address
;					 Enables Serial Interrupts
;
;	If System Wide Interrupts are Disabled
;	Then Direct Port Access Becomes The Default
;
;  Entry Requirements:
;	'a' Has Baud Rate Table Entry Number (0-9)
;
;  On Exit:
;	None
;
;  Affected:
;	PSW, Acc, Dptr
;
;  Stack:
;	1 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	Sets Serial Port To Mode 1.  Timer 1 As 16-Bit Auto-Reload 
;	Must Be Called Before Any Serial I/O Performed.
;

		; Baud Rate Table (RH1,RL1)
TM1_BAUD:	.word	65536 - 11364		; (0)   110
		.word	65536 - 8333		; (1)   150
		.word	65536 - 4167		; (2)   300
		.word	65536 - 2083		; (3)   600
		.word	65536 - 1042		; (4)  1200
		.word	65536 - 521		; (5)  2400
		.word	65536 - 260		; (6)  4800
		.word	65536 - 130		; (7)  9600
		.word	65536 - 65		; (8) 19200
		.word	65536 - 33		; (9) 38400

SP0_INIT:	;  Set Timer 1 For Baud Rate: 16-Bit Auto Reload Timer
		mov	dptr,#TM1_BAUD		; Baud Rate Table
		rl	a			; 2 * a (assumes a.7 = 0)
		push	a			; Save a, The Table Index
		movc	a,@a+dptr		; Load High Byte Value
		mov	RH1,a
		pop	a			; Get a, The Table Index
		inc	dptr			; equivalent to 2 * a + 1
		movc	a,@a+dptr		; Load Low Byte Value
		mov	RL1,a

		mov	a,tmod			; TM1 16-Bit Auto-Reload Counter
		anl	a,#0x0F
		orl	a,#0b00010000
	        mov     tmod,a

	        mov     pcon,#0x80		; Set For Double Baud Rate
	        setb    tr1			; Start Timer For Serial Port

		; Initialize Character Buffers
		clr	a			; 0
		mov	D_SP0IBH,a		; Set Input Buffer Header To 0
		mov	D_SP0IBT,a		; Set Input Buffer Tail To 0
		mov	D_SP0ICC,a		; Set Input Character Count To 0
		mov	D_SP0OBH,a		; Set Output Buffer Header To 0
		mov	D_SP0OBT,a		; Set Output Buffer Tail To 0
		mov	D_SP0OCC,a		; Set Output Character Count To 0
		clr	B_SP0OFL		; Set No Characters To Go Out
 
		; Initialize Serial Port
		mov	scon,#0x40		; Set Serial Mode 1
		clr	ri			; Clear Receive Interrupt Flag
		setb	ti			; Pretend Character Sent OK
		setb	ren			; Allow Characters To Be Received
		setb	ps			; Set Serial As Low Priority
		jb	B_SP0DIR,1$		; Direct Access Mode - No Interrupts
		setb	es			; Allow Serial Interrupts
1$:		ret				; Return To Caller
;
;****************************************************************************
;
;  Description:
;	Output String From Code Area
;
;  Entry Requirements:
;	DPTR Points To Null Terminated String In Code Space
;
;  On Exit:
;	None
;
;  Affected:
;	PSW.CY
;
;  Stack:
;	3 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_MCT:	push	dpl			; Save DPL
		push	dph			; Save DPH
		push	acc			; Save Acc
l$:		clr	a			; Make A = 0 So MOVC Works
		movc	a,@a+dptr		; Get Character
		inc	dptr			; Point To Next Character
		jnz	2$			; If Not Null, Output Character
		pop	acc			; Recover Acc
		pop	dph			; Recover DPH
		pop	dpl			; Recover DPL
		ret				; Return To Caller
2$:		lcall	SP0_OUT 		; Output Character
		sjmp	l$			; And Loop
;
;****************************************************************************
;
;  Description:
;	Output String From Data/IData Memory Area
;
;  Entry Requirements:
;	R0 Points To A Null Terminated String In Data/IData RAM 
;
;  On Exit:
;	None
;
;  Affected:
;	PSW.CY
;
;  Stack:
;	2 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_MDT:	push	acc			; Save Acc
		mov	a,r0			; Register Bank Independent
		push	acc			; Save r0
1$:		movx	a,@r0	 		; Get Character
		inc	r0			; Point To Next Character
		jnz	2$			; If Not Null, Output Character
		pop	acc			; Recover r0
		mov	r0,acc			; Register Bank Independent
		pop	acc			; Recover Acc
		ret				; Return To Caller
2$:		lcall	SP0_OUT 		; Output Character
		sjmp	1$			; And Loop
;
;****************************************************************************
;
;  Description:
;	Output String From External Memory Area
;
;  Entry Requirements:
;	DPTR Points To A Null Terminated String In External RAM 
;
;  On Exit:
;	None
;
;  Affected:
;	PSW.CY
;
;  Stack:
;	3 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_MXT:	push	dpl			; Save DPL
		push	dph			; Save DPH
		push	acc			; Save Acc
1$:		movx	a,@dptr 		; Get Character
		inc	dptr			; Point To Next Character
		jnz	2$			; If Not Null, Output Character
		pop	acc			; Recover Acc
		pop	dph			; Recover DPH
		pop	dpl			; Recover DPL
		ret				; Return To Caller
2$:		lcall	SP0_OUT 		; Output Character
		sjmp	1$			; And Loop
;
;****************************************************************************
;
;  Description:
;	Interrupt Source Determiner
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	None
;
;  Affected:
;	None
;
;  Stack:
;	0 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	Normally, The RI Or TI Jump Should Always Be Taken.  On One 
;	Particular Emulator (That I'd Prefer Not To Mention Here), We've 
;	Seen It Generate A Serial Interrupt, With Neither RI Or TI Set.  
;	It Seems To Be Related To Transmitting, And I've Found That It
;	Works Best To Clear The Flag That Tells The Serial Transmit
;	Interrupt Routine Whether To Kick Start The Port By Setting TI
;	When Writing A Character.
;
SP0_INT:	jb	ri,SP0_IIN		; If Set, Receiver Interrupt
		jb	ti,SP0_IOUT		; If Set, Output Interrupt
		clr	B_SP0OFL		; If Weird Interrupt, Clear
		reti				; Neither?  (Should Never Happen!)
;
;****************************************************************************
;
;  Description:
;	Process Interrupt Generated By Receiving A Character
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	None
;
;  Affected:
;	None
;
;  Stack:
;	4 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_IIN:	push	psw			; Save PSW
		push	acc			; Save Acc
		push	dpl			; Save DPL
		push	dph			; Save DPH

		mov	a,D_SP0ICC		; Get Input Character Count
		inc	a			; Add One
		cjne	a,#E_SP0IBL,1$		; If Not Same, Buffer Not Full

		sjmp	3$			; Return From Interrupt

1$:		mov	a,D_SP0IBH		; Get End Of Buffer
		clr	c			; Clear Carry For Subtract
		subb	a,#E_SP0IBL		; Subtract Input Buffer Length
		mov	a,D_SP0IBH		; Get End Of Buffer
		jc	2$			; If Carry Set, Value Is In Range
		clr	a			; Point Back To Start Of Buffer
2$:		mov	dptr,#X_SP0IBB		; Get Buffer Address
		lcall	SP0_ADATD		; Add 'A' To 'DPTR'
		inc	a			; Point To Next Header Location
		mov	D_SP0IBH,a		; Store Back
		mov	a,sbuf			; Get Character At Serial Port
		movx	@dptr,a			; Store Into Input Buffer
		inc	D_SP0ICC		; Increment Number Of Characters In Buffer

3$:		pop	dph			; Recover DPH
		pop	dpl			; Recover DPL
		pop	acc			; Recover Acc
		pop	psw			; Recover PSW
		clr	ri			; Acknowledge We Got Character
		reti				; Return To Interrupted Routine
;
;****************************************************************************
;
;  Description:
;	Process Interrupt Generated By Empty Transmitter
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	None
;
;  Affected:
;	None
;
;  Stack:
;	4 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_IOUT:	push	psw			; Save PSW
		push	acc			; Save Acc
		push	dpl			; Save DPL
		push	dph			; Save DPH

		mov	a,D_SP0OCC		; Get Character Count
		jnz	1$			; If Character Count ~0, Stuff To Be Sent
		clr	B_SP0OFL		; Set Not Transmitting
		sjmp	3$			; Mark Interrupt As Done, And Return

1$:		mov	a,D_SP0OBH		; Get End Of Buffer
		clr	c			; Clear Carry For Subtract
		subb	a,#E_SP0OBL		; Subtract Output Buffer Length
		mov	a,D_SP0OBH		; Get End Of Buffer
		jc	2$			; If Carry Set, Value Is In Range
		clr	a			; Point Back To Start Of Buffer
2$:		mov	dptr,#X_SP0OBB		; Point To Buffer
		lcall	SP0_ADATD		; Add 'A' To 'DPTR'
		inc	a			; Point To Next Location
		mov	D_SP0OBH,a		; Store Back
		movx	a,@dptr			; Get Character
		mov	sbuf,a			; Get Character At Serial Port
		dec	D_SP0OCC		; Decrement Number Of Characters In Buffer

3$:		pop	dph			; Recover DPH
		pop	dpl			; Recover DPL
		pop	acc			; Recover Acc
		pop	psw			; Recover PSW
		clr	ti			; Transmitter Interrupt Acknowledged
		reti				; Return To Interrupted Routine
;
;****************************************************************************
;
;  Description:
;	Get A Character From The Serial Buffer, Waiting If None Present
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	Acc Contains Received Character
;
;  Affected:
;	PSW.CY, PSW.Z, PSW.P, Acc
;
;  Stack:
;	3 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	If System Interrupts Are Disabled - Use Direct Access
;	If The Direct Serial Access Mode Is Enabled (B_SP0DIR = 1)
;	And The Interrupts Are Disabled (ES == 0) Then The Serial Port
;	Is Accessed Directly.  The Direct Mode Will Wait For
;	A Character.
;
SP0_IN:		lcall	SP0_INS 		; See If Character Pending
		jnc	SP0_IN			; Nope, Wait For One To Show Up

		jnb	ea,1$			; Interrupts Disabled - Direct Access
    		jnb	B_SP0DIR,2$		; Direct Access Not Enabled - Use Buffer

1$:		jnb	ri,1$		        ; wait For Character
		mov	a,sbuf			; get Character
		clr	ri			; Clear Receive Flag
		ret
;
;  Comments:
;	If The Direct Access Mode is Disabled (B_SP0DIR = 0),
;	Serial Interrupts Are Disabled (ES == 0), And A Character Is 
;	Present In The Buffer, Then The Serial Interrupt Will Be ReEnabled
;	On Exit.  If ES == 0 And No Characters Are In The Buffer, Then
;	The Routine Will Hang Waiting For A Serial Interrupt To Place A
;	Character Into The Buffer.
;
2$:		push	dph			; Save DPH
		push	dpl			; Save DPL
		clr	es			; Disable Serial Interrupts
		mov	a,D_SP0IBT		; Get Tail
		push	acc			; Save Acc
		clr	c			; Clear Carry For Subtract
		subb	a,#E_SP0IBL		; Subtract Length
		pop	acc			; Recover Acc
		jc	3$			; If Carry, We Are In E_SP0IBL Length
		clr	a			; Point To Start of Buffer
3$:		mov	dptr,#X_SP0IBB		; Point To Buffer
		lcall	SP0_ADATD		; Add 'A' To 'DPTR'
		inc	a			; Point To Next Location
		mov	D_SP0IBT,a		; Store Updated Tail Pointer
		movx	a,@dptr			; Fetch Character From Output Buffer
		dec	D_SP0ICC		; Decrement Number Of Characters In Buffer
		setb	es			; Re-Enable Serial Interrupts
		pop	dpl			; Recover DPL
		pop	dph			; Recover DPH
		ret				; Return It To Caller
;
;****************************************************************************
;
;  Description:
;	Return Carry Clear If No Character Pending, Else Carry Set
;
;	B_SP0DIR Controls The Enabling / Disabling
;	Of Serial Interrupts When System Interrupts Are Enabled
;
;	When B_SP0DIR = 0 Serial Interrupts are Disabled
;			  And Direct Port Access Is Enabled
;
;	When B_SP0DIR = 1 Serial Interrupts are Enabled
;			  And Direct Port Access Is Disabled
;
;	If System Wide Interrupts Are Disabled Then Direct Access
;	Is Enabled Independently Of The Serial Port Interrupt State
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	CY == 1 If Character Present, CY == 0 If None
;
;  Affected:
;	PSW
;
;  Stack:
;	1 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_INS:	jnb	ea,1$			; Interrupts Disabled - Direct Access
    		jnb	B_SP0DIR,3$		; Direct Access Not Enabled - Use Buffer

1$:		jnb	es,2$			; Skip If Serial Interrupts Are Disabled
		clr	es			; Disable Serial Interrupts
		clr	ri			; Reset Receive Ready Bit
		setb	ti			; Set Transmitter Ready
		sjmp	5$			; Nothing Here

2$:		jb	ri,7$		        ; On Character - Go Set C
		sjmp	5$		        ; No Character - Go Clear C

3$:		jb	es,4$			; Skip If Serial Interrupts Are Enabled
		clr	ri			; Reset Receive Ready Bit
		setb	ti			; Set Transmitter Ready
		setb	es			; Enable Serial Interrupts
		sjmp	5$			; Nothing Here

4$:		push	acc			; Save Acc
		mov	a,D_SP0IBH		; Get Input Header
		cjne	a,D_SP0IBT,6$		; If Not Same, Character Pending

		pop	acc			; Recover Acc
5$:		clr	c			; Clear Carry Flag, No Character Is Here
		ret				; Return To Caller

6$:		pop	acc			; Recover Acc
7$:		setb	c			; Set Carry Flag, Character Is Here
		ret				; Return To Caller
;
;****************************************************************************
;
;  Description:
;	Clears Any Character In The Receive Character Buffer
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	Acc = 0
;
;  Affected:
;	PSW.Z, PSW.P, Acc
;
;  Stack:
;	0 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	Probably Would Be A Good Idea To Disable Receive Interrupts While
;	Doing This.  An Interrupt In The Middle May Cause Problems.
;
SP0_INCLEAR:	clr	a			; 0
		mov	D_SP0IBH,a		; Set Input Buffer Header To 0
		mov	D_SP0IBT,a		; Set Input Buffer Tail To 0
		mov	D_SP0ICC,a		; Set Input Character Count To 0
		ret				; Return To Caller
;
;****************************************************************************
;
;  Description:
;	Output Character To Serial Buffer
;
;  Entry Requirements:
;	Acc Has Character To Write To Output Buffer
;
;  On Exit:
;	None
;
;  Affected:
;	PSW.CY
;
;  Stack:
;	3 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	If System Interrupts Are Disabled - Use Direct Access
;	If The Direct Access Mode Is Enabled (B_SP0DIR = 1)
;	And The Serial Interrupts Are Disabled (ES == 0)
;	Then The Serial Port Is Accessed Directly.  The Routine
;	Will Wait Until The Previous Character Has Been Transmitted.
;
SP0_OUT:	lcall	SP0_OUTS		; Is Buffer Ready?
		jc	SP0_OUT			; No Wait Until Ready

		jnb	ea,1$			; Interrupts Disabled - Direct Access
    		jnb	B_SP0DIR,2$		; Direct Access Not Enabled - Use Buffer

1$:		jnb	ti,1$		        ; Wait For Character Transmitted
		mov	sbuf,a			; send Character
		clr	ti			; Clear Transmit Flag
		ret
;
;  Comments:
;	If The Direct Access Mode Is Disabled (B_SP0DIR = 0) The Buffer Is Used.
;	If The Output Buffer Is Full, We Spin Waiting For A Serial Transmit
;	Interrupt To Free Up A Byte.  If Serial Interrupts Are Disabled
;	(ES == 0) When This Routine Is Called And There Is At Least One Byte
;	Avilable In The Buffer, Interrupts Will Be Reenabled.  If The Buffer 
;	Is Full, The Routine Will Hang Waiting For Space To Become Available
;	In The Buffer.
;
2$:		push	dph			; Save DPH
		push	dpl			; Save DPL
		push	acc			; Save Acc
		
		clr	es			; Disable Interrupts

		mov	a,D_SP0OBT		; Get End Of Buffer
		clr	c			; Clear Carry For Subtract
		subb	a,#E_SP0OBL		; Subtract Output Buffer Length
		mov	a,D_SP0OBT		; Get End Of Buffer
		jc	3$			; If Carry Set, Value Is In Range
		clr	a			; Point Back To Start Of Buffer
3$:		mov	dptr,#X_SP0OBB		; Point To Buffer
		lcall	SP0_ADATD		; Add 'A' To 'DPTR'
		inc	a			; Next Buffer Location
		mov	D_SP0OBT,a		; Store Back
		pop	acc			; Get Character To Put In Buffer
		push	acc			; Resave Character
		movx	@dptr,a			; Store Character To Output Buffer
		inc	D_SP0OCC		; Increment Number Of Characters In Buffer

		jb	B_SP0OFL,4$		; If Output In Progress, Skip
		setb	B_SP0OFL		; Otherwise, Set Output In Progress Flag
		setb	ti			; Force Transmitter Interrupt

4$:		setb	es			; Enable Interrupts

		pop	acc			; Recover Acc
		pop	dpl			; Recover DPL
		pop	dph			; Recover DPH
		ret				; Return To Caller
;
;****************************************************************************
;
;  Description:
;	Return Carry Clear If Output Buffer Is Not Full, Else Carry Set
;
;	B_SP0DIR Controls The Enabling / Disabling
;	Of Serial Interrupts When System Interrupts Are Enabled
;
;	When B_SP0DIR = 0 Serial Interrupts are Disabled
;			  And Direct Port Access Is Enabled
;
;	When B_SP0DIR = 1 Serial Interrupts are Enabled
;			  And Direct Port Access Is Disabled
;
;	If System Wide Interrupts Are Disabled Then Direct Access
;	Is Enabled Independently Of The Serial Port Interrupt State
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	CY == 1 If Output Buffer Full, CY == 0 If Not
;
;  Affected:
;	PSW
;
;  Stack:
;	1 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_OUTS:	jnb	ea,1$			; Interrupts Disabled - Direct Access
    		jnb	B_SP0DIR,3$		; Direct Access Not Enabled - Use Buffer

1$:		jnb	es,2$			; Skip If Serial Interrupts Are Disabled
		clr	es			; Disable Serial Interrupts
		clr	ri			; Reset Receive Ready Bit
		setb	ti			; Set Transmitter Ready
		sjmp	7$			; Nothing Here

2$:		jnb	ti,5$		        ; Not Ready If Bit ti = 0
		sjmp	7$			; Ready If Bit ti = 1

3$:		jb	es,4$			; Skip If Serial Interrupts Are Enabled
		clr	ri			; Reset Receive Ready Bit
		setb	ti			; Set Transmitter Ready
		setb	es			; Enable Serial Interrupts
		sjmp	7$			; Nothing Here

4$:		push	a			; save character
		mov	a,D_SP0OCC		; Get Output Character Count
		inc	a			; Add 1
		cjne	a,#E_SP0OBL,6$		; If Not Same, Buffer Not Full

		pop	a
5$:		setb	c			; CY == 1 Means Buffer Full / Not Ready
		ret				; Return To Caller

6$:		pop	a
7$:		clr	c			; CY == 0 Means Buffer Not Full / Ready
		ret				; Return To Caller
;
;
;****************************************************************************
;
;  Description:
;	Return CY == 1 If Output Buffer Empty, Else CY == 0
;
;  Entry Requirements:
;	None
;
;  On Exit:
;	CY == 1 If Output Buffer Empty, CY == 0 If Not
;
;  Affected:
;	PSW.CY, PSW.Z, PSW.P, Acc
;
;  Stack:
;	0 (+2) Bytes, Not Including Space Used By Called Routines
;
;  Comments:
;	None
;
SP0_OUTEMPTY:	mov	a,D_SP0OCC		; Get Output Character Count
		jnz	1$			; If Not Empty
		setb	c			; CY ==	1 Means	Buffer Empty
		ret				; Return To Caller
;
1$:		clr	c			; CY ==	0 Means	Not Empty
		ret				; Return To Caller

;
;****************************************************************************
;
;  Description:
;	Add Value In Acc To DPTR
;
;  Entry Requirements:
;	Value In Acc To Add To DPTR
;
;  On Exit:
;	DPTR = DPTR + Acc
;
;  Affected:
;	PSW.CY, DPTR
;
;  Stack:
;	1 (+2) Bytes, Not Including Called Routines
;
;  Comments:
;	CY == 1 If DPTR + Acc > 0xffff
;
SP0_ADATD:	push	acc			; Make Sure Acc Gets Saved
		add	a,dpl			; Add 'A' To DPL
		mov	dpl,a			; Move Result To DPL
		mov	a,dph			; Get DPH
		addc	a,#0x00 		; If Carry Set, This Will Increment
		mov	dph,a			; Move Back To DPH
		pop	acc			; Recover Original 'A'
		ret				; Return To Caller
;
;*******************************************************************************
;
		.end

.endif	; .else of _sp0_x

