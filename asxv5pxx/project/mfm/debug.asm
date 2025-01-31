.nlist
;****************************************************************************
;
; Compile The Assembly Code
;
;	AS89LP -loxff debug.asm
;
; To Define The debug.asm Globals Place The Following Lines In Your Code
;
;	.define _debug
;	.list	(!)	; This Inhibits The Include File Pagination
;	.include "debug.asm"
;	.list
;
;****************************************************************************
;
; DEBUG.ASM Globals In A Macro
;
	.macro	.debug.globals	arg$
	  .ifne mfm$dbg
	    .iifne  arg$	.list	(!,src,me)
  	  .globl	debug_init
	    .nlist
	  .endif
	.endm
;
;****************************************************************************
;
; These Definitions Control The Inclusion Of Diagnostics
; In All Elements Of The System.
;
	; mfmide.asm
	mfm$dbg	=: 1		; Include Debug Option

	; debug.asm
	dbg.db$pct =: 1		; Port/Cylinder/Track Logging 
;
;****************************************************************************
;
;	Project Debugging
;
;	  The debugging interface section provided a means to test and
;	verify the operation of various subsystems in this project.
;	Each is briefly described by command:
;
;	M[FMDBG] C[OUNTERS [Z[ERO]
;
;	  This function lists the type and number of Ex0 Interrupt
;	events processed during the MFM emulation process.  The event
;	types are:
;
;		mfmbsy - events while processing a previous event
;		wrtbck - events while a writeback process is active
;		mfmcpy - events while dskcfg is copying a partition
;		Active - events immediately processed
;		 NULL  - events for initialization (Not By An Ex0 Interrupt)
;		duplct - events duplicating a queued event
;
;	Under normal operation the mfmbsy events occur only while the
;	host controller is initializing. Wrtbck events occur if while
;	in a writeback operation an Ex0 Interrupt is serviced. It is
;	recommended that partition copy operations are not performed
;	while the host is actively accessing partitions, this will
;	result in mfmcpy events.  Active events signify the normal
;	processing of Ex0 interrupts while actively accessing the
;	partitions.  The NULL event is caused when the Ex0Int entry
;	point is programatically called to initialize the disk
;	track0 and seek complete signals for the active partitions
;	as there was no actual Ex0 interrupt.  And finally, the
;	duplct event reports a duplicate queue entry was attempted
;	in the event queue buffer. This event is counted and discarded.
;
;	  The Z[ERO] option simply resets the event counters to zero.
;
;
;	M[FMDBG] P[CT]
;
;	  This function enters an active scanning routine which
;	continuously checks the active port, track, and cylinder
;	selected by the host controller and prints any change.
;	The output format is:
;
;		PRT _ CYL ____ TRK __
;
;	Terminate the scanning process by entering a ^C.
;
;
;	M[FMDBG] E[X0] Options
;
;	  The EX0 debug function records every Ex0Int event in a
;	1024 byte circular buffer capable of holding upto 256 events.
;	The host creates an Ex0Int each time it issues a step command.
;	The Ex0Int service routine adds each step command to a
;	command list until no more step commands are issued for
;	approximately 250 us.  This command sequence is then terminated
;	with an end of event flag and the event command is saved
;	in the event buffer.  (The command is also queued for processing.)
;	The event log can be displayed with the EX0 functions.
;
;	M[FMDBG] E[X0] ON	- Enable  Event Logging
;	M[FMDBG] E[X0] OF[F]	- Disable Event Logging
;
;	M[FMDBG] E[X0] S[TATES] N
;
;	  Display upto N command events.  The following output
;	shows a typical display when the command 'M E S 12'
;	is given.  The information is shown by event number,
;	0 being the most recent and -11 being the first event
;	recorded.  The numbers following the '.' indicate if
;	multiple ports were processed during the event.  Any
;	event number with multiple '.' listings should never
;	occur.  This usually indicates some host controller
;	error or internal process error.  The parameters shown
;	are: the port number, the partition number associated
;	with the port number, step up pulses and step down
;	pulses in the event, whether some condition inhibited
;	immediate processing of the event - currently busy,
;	in a writeback state, or in a copy mode.  The time
;	is a running elapsed time of 0 to 255 ms.  The
;	time rolls over from 255 ms. to 0ms.
;
;	   Seq   PORT PART UPCNT DNCNT BSY WBK CPY TIME(ms.)
;	  -11.1    1    1   +37                     101
;	  -10.1    1    1         -35               123
;	  - 9.1    3    2   +2                      171
;	  - 8.1    3    2         -2                159
;	  - 7.1    3    2   +1                      221
;	  - 6.1    3    2         -1                 53
;	  - 5.1    3    2   +1                       34
;	  - 4.1    3    2   +1                      226
;	  - 3.1    1    1         -2                 97
;	  - 2.1    1    1         -2                 76
;	  - 1.1    1    1   +3                       62
;	    0.1    1    1   +1                       98
;
;
;	M[FMDBG] E[X0] Z[ERO]	- Zeros The Event Log
;
;
;	M[FMDBG] L[OGGING] Options
;
;	M[FMDBG] L[OGGING] ON		- Enable R/W Queue Logging
;	M[FMDBG] L[OGGING] OF[F]	- Disable R/W Queue Logging
;
;	M[FMDBG] M[AP] S		- Track Mapping
;
;	  The  S parameter selects the 'Tracks Touched' list
;	mapping: '1' - selects the internal mapping by port and
;	'2' - selects the external track mapping of the host
;	controller interface.  As discussed in mfmide.asm the
;	internal mapping by port is automatically performed by
;	the FPGA hardware.  Port 1 maps the host track(head) 0
;	starting at internal track 0,  Port 2 maps the host
;	track(head) 0 starting at internal track 4,  Port 3 maps
;	the host track(head) 0 starting at internal track 8,
;	and Port 4 maps the host track(head) 0 starting at
;	internal track 12.  The normal display of 'tracks
;	touched' is the internal mapping which corresponds to
;	the track caching used internally for the track data.
;	The external mapping, '2', always begins with track 0
;	and shows the physical track(head) accessed.
;
;	M[FMDBG] L[OGGING] W[TQUE] [N, [S]] - Show Write Queue Blocks
;	M[FMDBG] L[OGGING] R[DQUE] [N, [S]] - Show Read  Queue Blocks
;	M[FMDBG] L[OGGING] Q[UEUE] [N, [S]] - Show Read and Write Queue Blocks
;
;	  These commands show the read, write, or both queue elements
;	which show the operations by the host interface or the actions
;	performed on the attached ATA device.  The parameter N specifies
;	the number of operations to display and the parameter S specifies
;	the data to be shown: '1' - MFMtracks accessed by the host interface
;	or '2' - the tracks read or written on the attached ATA device.
;
;	  The following examples were produced on a system with two
;	8 head 1024 cylinder drives mounted on ports 1 and 3.  The
;	host disk commands were:
;
;	C:\>DIR C:
;	C:\>DIR D:
;	C:\>CHKDSK D:
;
;	Given the map option, M L M 1, and the logging command M L R 12 1 
;
;	                                             111111
;	 MFM I/O Queue    Mapped Tracks    0123456789012345  (Milliseconds)
;	  Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
;	  -11  R   0    1    1    40   8   ------11--------   24.0  3450.8
;	  -10  R   1    1    1     5   8   ---1111---------   20.7  3557.5
;	  - 9  R   0    3    2     3   8   ---------3------   57.9  3925.6
;	  - 8  R   1    3    2     1   8   ---------3333333   20.4  4076.7
;	  - 7  R   0    3    2     2   8   --------3-------   13.1  4754.9
;	  - 6  R   1    3    2     1   8   ---------------3   13.2  4823.6
;	  - 5  R   0    3    2     2   8   --------333-----   13.2  4870.9
;	  - 4  R   1    3    2     3   8   ---------3------   13.1  5114.1
;	  - 3  R   0    1    1     3   8   -1--------------   13.2  5241.9
;	  - 2  R   1    1    1     1   8   -1--------------   13.2  5340.2
;	  - 1  R   0    1    1     4   8   -----111--------   13.1  5439.9
;	    0  R   1    1    1     5   8   111-------------   13.1  5703.1
;
;	  The logging was done simultaneously with the M E S 12 process
;	shown previously.  The write logging will not be shown as no write
;	operations were performed.  Again the most recent sequence is 0
;	and the oldest operation is -11.  The columns are: -Q- indicates
;	reads (R), Bnk is the internal cache bank, Port is the MFM port
;	number, Part is associated partition, Cyl is the cylinder of the
;	partition being accessed, and Trks is the number of tracks
;	associated with the partition.  The M L R 12 1 selected the
;	'Tracks Touched' option which shows which tracks the host selected
;	while reading this cylinder (a track is the same as the selected head.)
;	The numbers displayed, 1 or 3, signify which port has been read.
;	The Seek time, in milliseconds, is the actual time required to
;	read the cylinder from the ATA device into the cylinder cache
;	memory.  This time is completely determined by the ATA drive seek
;	time plus the transfer time of 41 512 byte sectors into the cache.
;	The Time, in milliseconds, is a simple running time counter which
;	overflows after 6553.5 milliseconds.
;
;	  An alternate display shows the tracks read from the ATA interface
;	which is always a full cylinder: M L R 12 2
;
;	 MFM I/O Queue    Mapped Tracks    0123456789012345  (Milliseconds)
;	  Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
;	  -11  R   0    1    1    40   8   11111111--------   24.0  3450.8
;	  -10  R   1    1    1     5   8   11111111--------   20.7  3557.5
;	  - 9  R   0    3    2     3   8   --------33333333   57.9  3925.6
;	  - 8  R   1    3    2     1   8   --------33333333   20.4  4076.7
;	  - 7  R   0    3    2     2   8   --------33333333   13.1  4754.9
;	  - 6  R   1    3    2     1   8   --------33333333   13.2  4823.6
;	  - 5  R   0    3    2     2   8   --------33333333   13.2  4870.9
;	  - 4  R   1    3    2     3   8   --------33333333   13.1  5114.1
;	  - 3  R   0    1    1     3   8   11111111--------   13.2  5241.9
;	  - 2  R   1    1    1     1   8   11111111--------   13.2  5340.2
;	  - 1  R   0    1    1     4   8   11111111--------   13.1  5439.9
;	    0  R   1    1    1     5   8   11111111--------   13.1  5703.1
;
;	  The touched tracks shown above are for the 'mapped by port' option
;	which is how the FPGA hardware presents the MFM tracks(heads) to
;	the cylinder cache.  If the 'mapped by host' option, M L M 2, is
;	specified then the 'Trks[0:15] Touched' show the physical track(head)
;	as presented by the MFM host controller:
;
;	 MFM I/O Queue    Drive  Tracks    0123456789012345  (Milliseconds)
;	  Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
;	  -11  R   0    1    1    40   8   ------11--------   24.0  3450.8
;	  -10  R   1    1    1     5   8   ---1111---------   20.7  3557.5
;	  - 9  R   0    3    2     3   8   -3--------------   57.9  3925.6
;	  - 8  R   1    3    2     1   8   -3333333--------   20.4  4076.7
;	  - 7  R   0    3    2     2   8   3---------------   13.1  4754.9
;	  - 6  R   1    3    2     1   8   -------3--------   13.2  4823.6
;	  - 5  R   0    3    2     2   8   333-------------   13.2  4870.9
;	  - 4  R   1    3    2     3   8   -3--------------   13.1  5114.1
;	  - 3  R   0    1    1     3   8   -1--------------   13.2  5241.9
;	  - 2  R   1    1    1     1   8   -1--------------   13.2  5340.2
;	  - 1  R   0    1    1     4   8   -----111--------   13.1  5439.9
;	    0  R   1    1    1     5   8   111-------------   13.1  5703.1
;
;	or
;
;	 MFM I/O Queue    Drive  Tracks    0123456789012345  (Milliseconds)
;	  Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
;	  -11  R   0    1    1    40   8   11111111--------   24.0  3450.8
;	  -10  R   1    1    1     5   8   11111111--------   20.7  3557.5
;	  - 9  R   0    3    2     3   8   33333333--------   57.9  3925.6
;	  - 8  R   1    3    2     1   8   33333333--------   20.4  4076.7
;	  - 7  R   0    3    2     2   8   33333333--------   13.1  4754.9
;	  - 6  R   1    3    2     1   8   33333333--------   13.2  4823.6
;	  - 5  R   0    3    2     2   8   33333333--------   13.2  4870.9
;	  - 4  R   1    3    2     3   8   33333333--------   13.1  5114.1
;	  - 3  R   0    1    1     3   8   11111111--------   13.2  5241.9
;	  - 2  R   1    1    1     1   8   11111111--------   13.2  5340.2
;	  - 1  R   0    1    1     4   8   11111111--------   13.1  5439.9
;	    0  R   1    1    1     5   8   11111111--------   13.1  5703.1
;
;
;	M[FMDBG] M[PI] Opt N	- MFM 'Port Interrupt' Scan Times
;
;	  This command has two options: Opt = 1, Ex0 interrupt outer loop
;	time monitor which should show about 250 us., Opt = 2, Ex0 interrupt
;	inner loop time	monitor that must be less than 10 us. but should
;	be about 5 us.  The parameter N selects which pin to output the
;	signal on, 1 or 2.  A command without opt and N terminates the output.
;
;
;
;	M[FMDBG] W[BK]  N	- 'MFM Writeback' Processing Time
;
;	  This command shows the writeback processing time where
;	N selects which pin to output the signal on, 1 or 2.
;	A command without N will terminate the output.
;
;****************************************************************************
;
.ifdef _debug
	.list	(!,src)
;	debug.asm       Globals                 Defined
	.nlist

	.debug.globals	0
.else
	.list
	.title	Diagnostic Center

	.module	DEBUG

	.debug.globals	1

.ifne	mfm$dbg
;
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
	.list	(!)	; This Inhibits The Include File Pagination
	.include "ioreg.def"
	.list
;
;****************************************************************************
;
;  Externals By Inclusion
;
	.define	_macros
	.define	_mfm
	.define	_sp0_x
	.define _print
	.define	_btcs
	.define	_timers
	.define	_mondeb51
	.define	_mfmide
	.define	_dskcfg
	.define	_spchr
	.define	_aiconv

	.list	(!)	; This Inhibits The Include File Pagination
	.include "macros.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mfm.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "sp0_x.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "print.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "btcs.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "timers.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mondeb51.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "mfmide.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "dskcfg.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "spchr.asm"
	.list
	.list	(!)	; This Inhibits The Include File Pagination
	.include "aiconv.asm"
	.list
;
;****************************************************************************

	.page
	.sbttl	MFM$DBG Functions

;****************************************************************************
;
	.msg	^"*****  MFM Debugging Code Included  *****"

	; Command Table Entries

	.area	CmdTbl

	ljmp	mfmdbg

;
;****************************************************************************
;
	; Command List Entries 

	.area	CmdLst

	.ascii	/MFMDBG/	; debug testing
	.byte	cr

;
;****************************************************************************
;
	; Command Option List Entries

	.area	OptLst

	; Modifiers to "MFMDBG"

;	; M[FMDBG] C[OUNTERS] Option
;	dbg.db$cnt =: 1		* mfm$ide	; 1 => Debug, 0 => No Debug
;
;	; M[FMDBG] D[CT]
;	dbg.db$pct =: 1				; 1 => Debug, 0 => No Debug
;
;	; M[FMDBG] L[OGGING] Options
;	dbg.db$que =: 1		* mfm$ide	; 1 => Debug, 0 => No Debug
;	  dbg.db$skt =: 1	* dbg.db$que 	; 1 => Debug, 0 => No Debug
;	  dbg.db$tch =: 1	* dbg.db$que	; 1 => Debug, 0 => No Debug
;	  dbg.db$ide =: 1	* dbg.db$que	; 1 => Debug, 0 => No Debug
;
;	; M[FMDBG] E[X0] Option
;	dbg.db$chg =: 1		* mfm$ide	; 1 => Debug, 0 => No Debug
;
;	; M[MFDBG] M[CI] Options
;	dbg.Ex0$TstA =: 1	* mfm$ide	; 1 => Debug, 0 => No Debug
;	dbg.Ex0$TstB =: 1	* mfm$ide	; 1 => Debug, 0 => No Debug
;
;	; M[FMDBG] W[BK] Option
;	dbg.Wbk$TstA =: 1	* mfm$ide	; 1 => Debug, 0 => No Debug

mfmlst:
.ifne dbg.db$cnt
	.ascii	/COUNTERS/
	.byte	cr
.endif

.ifne dbg.db$pct
	.ascii	/PCT/
	.byte	cr
.endif

.ifne dbg.db$chg
	.ascii	/EX0/
	.byte	cr
.endif

.ifne dbg.db$que
	.ascii	/LOGGING/
	.byte	cr
.endif

.ifne dbg.Ex0$TstA | dbg.Ex0$TstB
	.ascii	/MPI/
	.byte	cr
.endif

.ifne dbg.Wbk$TstA
	.ascii	/WBK/
	.byte	cr
.endif

	.byte	lf		; end of list

	; Modifiers to "COUNTERS"

.ifne dbg.db$cnt
ctrlst:	.ascii	/ZERO/
	.byte	cr
	.byte	lf		; end of list
.endif

	; Modifiers to "EX0"

.ifne dbg.db$chg
ex0lst:	.ascii	/ON/
	.byte	cr
	.ascii	/OFF/
	.byte	cr
	.ascii	/STATES/
	.byte	cr
	.ascii	/ZERO/
	.byte	cr
	.byte	lf		; end of list
.endif

	; Modifiers to "LOGGING"

.ifne dbg.db$que
loglst:	.ascii	/ON/
	.byte	cr
	.ascii	/OFF/
	.byte	cr
	.ascii	/MAP/
	.byte	cr
	.ascii	/RDQUE/
	.byte	cr
	.ascii	/WTQUE/
	.byte	cr
	.ascii	/QUEUE/
	.byte	cr
	.ascii	/ZERO/
	.byte	cr
.endif

	.byte	lf		; end of list

;
;****************************************************************************
;
	; Extended Help String Pointers

	.area	X_Ptrs

	.word	$mfmdbg

;
;****************************************************************************
;
	; Extended Help Strings

	.area	X_Strs

$mfmdbg:
	.ascii	" M[FMDBG] Debugging Routines"
	.byte	cr,lf

.ifne dbg.db$cnt
	.ascii	"   C[OUNTERS]  Opt  : MFM/IDE Process Counters"
	.byte	cr,lf
	.ascii	"     Z[ERO]   : Zero Process Counters"
	.byte	cr,lf
	.ascii	"              : Blank Option Displays Counters"
	.byte	cr,lf
.endif

.ifne dbg.db$pct
	.ascii	"   P[CT]   : Port/Cylinder/Track Logging (Terminate With ^C)"
	.byte	cr,lf
.endif

.ifne dbg.db$chg
	.ascii	"   E[X0]  Opt    : Ex0 Interrupt LOGGING"
	.byte	cr,lf
	.ascii	"     ON       : Enable  Ex0 Interrupt Logging"
	.byte	cr,lf
	.ascii	"     OF[F]    : Disable Ex0 Interrupt Logging"
	.byte	cr,lf
	.ascii	"     S[TATES]  [N]      : Show Ex0 Interrupt Events"
	.byte	cr,lf
	.ascii	"       N    : Number Of Events To List (1 - 256)"
	.byte	cr,lf
	.ascii	"     Z[ERO]   : Zero All Events"
	.byte	cr,lf
.endif

.ifne dbg.db$que
	.ascii	"   L[OGGING]  Opt  : R/W Queue Logging"
	.byte	cr,lf
	.ascii	"     ON       : Enable  R/W Queue Logging"
	.byte	cr,lf
	.ascii	"     OF[F]    : Disable R/W Queue Logging"
	.byte	cr,lf
	.ascii	"     M[AP]  S : Track Mapping"
	.byte	cr,lf
	.ascii	"       S    : Selects The 'Trks Touched' Mapping"
	.byte	cr,lf
	.ascii	"         1  : Internal Mapping of Tracks By Port"
	.byte	cr,lf
	.ascii	"         2  : External Mapping of Tracks By Host"
	.byte	cr,lf
	.ascii	"     W[TQUE]  [N, [S]] : Show Write Queue Blocks"
	.byte	cr,lf
	.ascii	"     R[DQUE]  [N, [S]] : Show Read Queue Blocks"
	.byte	cr,lf
	.ascii	"     Q[UEUE]  [N, [S]] : Show Read/Write Queues Blocks"
	.byte	cr,lf
	.ascii	"       N    : Number Of Queue Blocks To List (1 - 64)"
	.byte	cr,lf
	.ascii	"       S    : Select Logged Data Type, Selection Is Persistant"
	.byte	cr,lf
	.ascii	"         1  : MFM Tracks Accessed (R/W) By Host"
	.byte	cr,lf
	.ascii	"         2  : MFM Tracks (R/W) From IDE Interface"
	.byte	cr,lf
	.ascii	"     Z[ERO]   : Zero All Read/Write Queue Blocks"
	.byte	cr,lf
.endif

.ifne dbg.Ex0$TstA | dbg.Ex0$TstB
	.ascii	"   M[PI]  Opt  N   : MFM 'Port Interrupt' Scan Times"
	.byte	cr,lf
	.ascii	"     Opt   1  : Ex0 Port Outer Loop Scan Time"
	.byte	cr,lf
	.ascii	"           2  : Ex0 Port Inner Loop Scan Time"
	.byte	cr,lf
	.ascii	"     N   1/2  : Strobe Pin X1/X2"
	.byte	cr,lf
	.ascii	"     Opt And N Blank Terminates Test"
	.byte	cr,lf
.endif

.ifne dbg.Wbk$TstA
	.ascii	"   W[BK]  N   : 'MFM Writeback' Processing Time"
	.byte	cr,lf
	.ascii	"     N   1/2  : Strobe Pin X1/X2"
	.byte	cr,lf
	.ascii	"     N   Blank Terminates Test"
	.byte	eot
.endif

;
;****************************************************************************

	.page
	.sbttl	Function Summary

;****************************************************************************
;
;	A Summary Of Functions
;
;	debug_init	- Startup Initialization
;
;    mfmdbg		- Command Dispatcher
;
;=>   m$ctr		- Display Ex0 Interrupt Process Types
;
;=>   m$pct		- Run Time Port/Cylinder/Track Watcher
;	pctsts		- Process Scanner
;	  prtout	- Partition/Port Printer
;	  cylout	- Cylinder Printer
;	  trkout	- Track Printer
;
;=>   m$ex0		- Ex0 SubCommand Dispatcher
;	ex0_on		- Enable Logging
;	ex0_of		- Disable Logging
;	ex0_st		- State Listing
;	  ex0nea	- Next Entry Address
;	  ex0pea	- Previous Entry Address
;	  ex0eoc	- End Of Changes Scanner
;	  ex0stp	- Setup Parameters
;	  ex0nxt	- Get Next Element In A Change Event
;	  ex0out	- Print Change Event Summary
;	  ex0nnn	- Output Numerical Values
;	  qyr$ex	- Change States Query
;	ex0_zr		- Zero Change Elements Buffer
;	ex0hlp		- Print Help Messages
;
;=>   m$pci		- Ex0 Interrupt Process Timing
;
;=>   m$log		- Queue Logging SubCommand Dispatcher
;	log_on		- Enable Logging
;	log_of		- Disable Logging
;	log_mp		- Head(Track) Mapping Select
;	log_rq		- Show Read Queue Log
;	  log_rb	- Parameter Printing For Read Queue Elements
;	log_wq		- Show Write Queue Log
;	  log_wb	- Write Bits Rotation
;	log_qq		- Show Read and Write Queue Log
;	log_zr		- Zero Queue Logging Buffer
;
;	  log_st	- Setup Queue Block Parameters
;	  log_nx	- Set Next Block Index
;	  log_bt	- Display Bit Pattern
;	    byt_bt	- Print Binary Bit String
;	    wrd_rt	- Word Bit Rotation
;	  log_qb	- Show Depth Of Queue Block
;	  m$hdr		- Print Parameter Logging Header
;	  m$addr	- Compute Queue Entry Address
;	  qry$qb	- Query Number Of Queue Blocks To Display
;	  qry$dt	- Query Logging Data Type
;
;=>  m$wbk		- Writeback Process Timing
;
;****************************************************************************

	.page
	.sbttl	MFM$DBG Functions

;****************************************************************************
;

	.area	Bits

ex$end:	.blkb	1	; Port End-Of-Event Flag
ex$bsy:	.blkb	1	; Port End-Of-Event Busy Flag
ex$wbk:	.blkb	1	; Port End-Of-Event WriteBack Active Flag
ex$cpy:	.blkb	1	; port End-Of-Event Copy Active Flag
ex$tim:	.blkb	1	; Port End-If-Event Time Stamp

dbgchg:	.blkb	1

maptrk:	.blkb	1	; clr - Mapped Tracks, set - Drive Tracks
hdrtyp:	.blkb	1	; clr - read only / read & write, set - write only
rotbit:	.blkb	1	; clr - no bit rotation, set - rotate bit positions
rotlft:	.blkb	1	; clr - rotate right (MSB => LSB), set - rotate left (LSB => MSB)

	.area	Idata

dbgprt:	.blkb	1	; Port
dbgcyl:	.blkb	2	; Cylinder
dbgtrk:	.blkb	1	; Track (Head)

;
;****************************************************************************
;
;	The LData Area
;

	.area	LData

	; Working Data

logdsp:	.blkb	1		; Logging Display Mode
logpnm:	.blkb	1		; Logging Port Number

;
;****************************************************************************

	.area	Debug

;****************************************************************************
;
; MFMDBG Command Dispatcher
;

mfmdbg:  mov	dptr,#mfmlst	; look for option in list
	lcall	fndlnm		; returns with list number
	lcall	comand		; now go for a match
	jz	mfmhlp		; list help if just a cr was typed
	jb	a.7,1$		; bad command if negative

	dec	a		; compute (a - 1) * 3
	mov	b,#3
	mul	ab		; a is product
	mov	dptr,#2$
	jmp	@a+dptr		; jump into jump table

1$:	ljmp	badsyn

	;1st level jump table

2$:	; first level subcommands
.iifne dbg.db$cnt			ljmp	m$ctr
.iifne dbg.db$pct			ljmp	m$pct
.iifne dbg.db$chg			ljmp	m$ex0
.iifne dbg.db$que			ljmp	m$log
.iifne dbg.Ex0$TstA|dbg.Ex0$TstB	ljmp	m$pci
.iifne dbg.Wbk$TstA			ljmp	m$wbk

mfmhlp:	mov	dptr,#$mfmdbg	; expanded help
	lcall	outstr		; string address in dptr
	ljmp	nomore

;
;****************************************************************************
;
; The MFM/IDE Display Process Counters
;
;bsycnt:	.blkb	2		; Ex0Int mfmbsy Process Count
;wbkcnt:	.blkb	2		; Ex0Int wrtbck Process Count
;cpycnt:	.blkb	2		; Ex0Int mfmcpy Process Count
;rdycnt:	.blkb	2		; Active Ex0Int Process Count
;nulcnt:	.blkb	2		; Ex0Int ?????? Process Count
;ovrcnt:	.blkb	2		; Ex0Int ovrflo buffer counter
;
.ifne dbg.db$cnt

m$ctr:	mov	dptr,#ctrlst	; look for option in list
	lcall	fndlnm		; returns with list number
	lcall	comand		; now go for a match
	jz	3$		; list counters if just a cr was typed
	jb	a.7,2$		; bad command if negative

	mov	b,#6*2		; 6 2-byte parameters
	mov	r0,#bsycnt
	clr	a
1$:	movx	@r0,a		; zero counters
	inc	r0
	djnz	b,1$
	ljmp	nomore
2$:	ljmp	badsyn

3$:	mov	r0,#bsycnt
	mov	r1,#6
	mov	dptr,#mctr$1
4$:	lcall	outstr
	inc	dptr
	push	dpl
	push	dph
	movx	a,@r0
	inc	r0
	mov	b,a
	movx	a,@r0
	inc	r0
	lcall	sp5chr
	lcall	docrlf
	pop	dph
	pop	dpl
	djnz	r1,4$
	ljmp	nomore

mctr$1:	.ascii	"  mfmbsy Ex0Int Process Count = "
	.byte	eot	
	.ascii	"  wrtbck Ex0Int Process Count = "
	.byte	eot	
	.ascii	"  mfmcpy Ex0Int Process Count = "
	.byte	eot
	.ascii	"  Active Ex0Int Process Count = "
	.byte	eot
	.ascii	"   NULL  Ex0Int Process Count = "
	.byte	eot	
	.ascii	"  duplct Ex0Int Process Count = "
	.byte	eot	

.endif	; dbg.db$cnt
;
;****************************************************************************
;
; The MFM Port/Cylinder/Track Activity Scanner
;
.ifne dbg.db$pct

m$pct:	.pshreg

1$:	mov	dptr,#mfmsts		; is a port active?
	mov	b,#0
2$:	movx	a,@dptr			; check ptactv bit
	jnb	mf_actv,3$		; if not - skip all
	djnz	b,2$			; ~190us wait to stabilize

	lcall	pctsts			; scan prt/cyl/trk for change

3$:	lcall	ctrl_c
	jnc	1$

	.popreg
	ljmp	nomore

	; Scan Port/Cylinder/Track For A Change

pctsts:	lcall	wchdog			; hit watch dog timer after wait

	clr	dbgchg			; initialize change flag
	mov	r1,#dbgprt		; previous port number
	mov	a,pr$chg		; get change
	mov	b,#0			; use 1st change in element
	jb	pr_stp1,1$		; stepped implies port 1
	inc	b
	jb	pr_stp2,1$		; stepped implies port 2
	inc	b
	jb	pr_stp3,1$		; stepped implies port 3
	inc	b
	jb	pr_stp4,1$		; stepped implies port 4
	sjmp	2$			; NULL entry
1$:	mov	a,@r1
	anl	a,#0x03			; mask port number
	mov	@r1,b			; update
	clr	c
	subb	a,b
	jz	2$			; port changed ?
	setb	dbgchg

2$:	mov	a,@r1			; port number
	anl	a,#0x03			; mask port number
	mov	b,#pr$siz		; port table size
	mul	ab			; offset to port table
	add	a,#pr1cyl		; address of port cylinder
	mov	r0,a
	mov	a,@r0
	inc	r1
	mov	b,@r1
	mov	@r1,a			; update
	cjne	a,b,3$			; MSB of cylinder changed ?
	sjmp	4$
3$:	setb	dbgchg

4$:	inc	r0
	mov	a,@r0
	inc	r1
	mov	b,@r1
	mov	@r1,a			; update
	cjne	a,b,5$			; LSB of cylinder changed ?
	sjmp	6$
5$:	setb	dbgchg

6$:	mov	dptr,#hdsts		; look at track
	movx	a,@dptr
	anl	a,#0x0F			; mask for tracks
	inc	r1
	mov	b,@r1
	mov	@r1,a			; save/update
	cjne	a,b,7$			; track changed ?
	sjmp	8$
7$:	setb	dbgchg

8$:	jnb	dbgchg,9$		; no change - skip

	lcall	prtout			; " PRT "
	lcall	cylout			; " CYL "
	lcall	trkout			; " TRK "
	lcall	docrlf

9$:	ret


;  display the number contained in [b] or [b,a]
;  in decimal radix with leading zeros suppressed
;
;  variables:
;  temp5 - temp8  - ascii output buffer
;
;****************************************************************************
;
	; output a 1 character number
	; leading spaces byte number

prtout:	mov	dptr,#1$		; " PRT "
	lcall	strout
	mov	r1,#dbgprt		; address of port number
	mov	a,@r1			; load port number
	anl	a,#0x03			; mask port number
	inc	a			; (0-3) => (1-4)
	mov	b,a			; position for character output
	ljmp	sp1chr

1$:	.asciz	" PRT "

	; output a 4 character number
	; leading spaces word number

cylout:	mov	dptr,#1$		; " CYL "
	lcall	strout
	mov	r1,#dbgcyl		; address of cylinder
	mov	b,@r1
	inc	r1
	mov	a,@r1
	ljmp	sp4chr

1$:	.asciz	" CYL "

	; output a 2 character
	; leading spaces byte number

trkout:	mov	dptr,#1$		; " TRK "
	lcall	strout
	mov	r1,#dbgtrk		; address of track
	mov	b,@r1
	ljmp	sp2chr

1$:	.asciz	" TRK "

.endif
;
;****************************************************************************
;
; The EX0 Interrupt Logging
;
.ifne dbg.db$chg

	; Some Definitions
	.define	$PORT	^/r2/	; Temporary Selected Port
	.define	$CHCNT	^/r3/	; Temporary Change Count
	.define	$DNCNT	^/r4/	; Temporary Down Count
	.define	$UPCNT	^/r5/	; Temporary Up Count
	.define	$LPCNT	^/r6/	; Temporary Loop Counter
	.define	$SBCNT	^/r7/	; Temporary Sub State Counter
;
m$ex0:	mov	dptr,#ex0lst	; look for option in list
	lcall	fndlnm		; returns with list number
	lcall	comand		; now go for a match
	jz	2$		; requires an option
	jb	a.7,2$		; bad command if negative

	dec	a		; compute (a - 1) * 3
	mov	b,#3
	mul	ab		; a is product
	mov	dptr,#1$
	jmp	@a+dptr		; jump into jump table

	; 2nd level jump table

1$:	ljmp	ex0_on
	ljmp	ex0_of
	ljmp	ex0_st
	ljmp	ex0_zr

2$:	ljmp	badsyn

ex0hlp:	mov	dptr,#$mfmdbg	; expanded help
	lcall	outstr		; string address in dptr
	ljmp	nomore

	;	          111111111122222222223333333333444444444455555555556
	;	0123456789012345678901234567890123456789012345678901234567890
	;	"   Seq   PORT PART UPCNT DNCNT BSY WBK CPY TIME(ms.)"
	;	"  -nn.m    -    -   +nnn  -nnn  -   -   -   ---"
ex0$1:	.ascii	"   Seq   PORT PART UPCNT DNCNT BSY WBK CPY TIME(ms.)"
	.byte	cr,lf,eot	
ex0$2:	.ascii	"  No Events Recorded"
	.byte	cr,lf,eot

ex7spc:	.ascii	" "
ex6spc:	.ascii	" "
ex5spc:	.ascii	" "
ex4spc:	.ascii	" "
ex3spc:	.ascii	" "
ex2spc:	.ascii	" "
ex1spc:	.ascii	" "
	.byte	eot
ex4pls:	.ascii	" "
ex3pls:	.ascii	" "
ex2pls:	.ascii	"  +"
	.byte	eot
ex4mns:	.ascii	" "
ex3mns:	.ascii	" "
ex2mns:	.ascii	"  -"
	.byte	eot

;
;****************************************************************************
;
;	Ex0 Logging ON/OFF
;
ex0_on:
	setb	i$enbl		; enable EX0 logging process
	mov	a,#1
	sjmp	1$

ex0_of = .
	clr	i$enbl		; disable EX0 logging process
	clr	a
;	sjmp	1$

1$:	mov	dptr,#t2$tsk
	lcall	st$tm2		; and enable/disable Ex0 logging
	ljmp	nomore
;
;****************************************************************************
;
;	Ex0 State Listing
;
ex0_st:	lcall	qry$ex
	jc	11$
	mov	j$cnt,a		; save state count
	lcall	ex0stp		; setup parameters
	jnz	1$		; found events
	mov	dptr,#ex0$2	; report no events
	lcall	outstr
	sjmp	10$

1$:	mov	dptr,#ex0$1	; output header
	lcall	outstr

	mov	b,#1		; move to first mfmchg element

2$:	clr	a		; clear temporary values
	mov	$PORT,a
	mov	$CHCNT,a
	mov	$DNCNT,a
	mov	$UPCNT,a
	mov	$SBCNT,a

3$:	lcall	ex0nxt		; get change element
	; pr4sts, pr3sts, pr2sts, and pr1sts are on the stack
	mov	$LPCNT,#4	; process the 4 ports

4$:	pop	a		; pr?sts
	mov	b,a		; save pr?sts
	jnb	pr_stp1,9$	; not this port
	mov	a,$PORT		; check if element is for the same port
	jz	5$		; port not yet set
	clr	c
	subb	a,$LPCNT	; compare
	jz	5$		; the same - skip

	lcall	ex0out

5$:	mov	$PORT,$LPCNT	; port selected
	mov	a,b		; pr?sts
	jb	pr_dir1,8$	; up - skip
	inc	$DNCNT
	sjmp	9$
8$:	inc	$UPCNT
;	sjmp	9$
9$:	djnz	$LPCNT,4$	; loop for all ports

	mov	b,#1
	jnb	ex$end,3$	; repeat for each change element

	setb	ex$tim		; output time stamp
	lcall	ex0out

	mov	b,#2
	djnz	j$cnt,2$	; repeat for each change event

	lcall	docrlf
10$:	ljmp	nomore
11$:	ljmp	badsyn
;
;****************************************************************************
;
;	Next Entry Address
;
ex0nea:	lcall	wchdog		; hit watch dog timer
	mov	dph,j$msb	; next element of change
	mov	dpl,j$lsb
	inc	dptr
	inc	dptr

	clr	c		; if past top of buffer
	mov	a,dpl		; reset to bottom of buffer
	subb	a,#<m2_blk+1024
	mov	a,dph
	subb	a,#>m2_blk+1024
	jc	1$
	mov	dpl,#<m2_blk
	mov	dph,#>m2_blk
1$:	mov	j$lsb,dpl
	mov	j$msb,dph
	ret
;
;****************************************************************************
;
;	Previous Entry Address
;
ex0pea:	lcall	wchdog		; hit watch dog timer
	clr	c		; if at lowest buffer address
	mov	a,#<m2_blk	; reset to top of buffer
	subb	a,j$lsb
	mov	a,#>m2_blk
	subb	a,j$msb
	jc	1$
	mov	j$msb,#>m2_blk+1024
	mov	j$lsb,#<m2_blk+1024
1$:	mov	a,j$lsb		; buffer address <= buffer address - 2
	add	a,#0xFE
	mov	j$lsb,a
	mov	dpl,a		; put LSB address into dpl
	mov	a,j$msb
	addc	a,#0xFF
	mov	j$msb,a
	mov	dph,a		; put MSB address into dph
	ret
;
;	Scan For End Of Changes Event
;
;	On Return:
;	  c = 0, a = prtsts, b = unused
;	  c = 1, a = 0x00 Is NULL Event
;	  c = 1, a = 0xFF Is End Of Event
;
ex0eoc:	lcall	ex0pea		; previous buffer address
	mov	a,j$lsb		; check buffer position
	cjne	a,i$lsb,1$
	mov	a,j$msb
	cjne	a,i$msb,1$
	clr	a		; report NULL state
	push	a		; after looping through
	push	a		; the complete buffer
	sjmp	2$
1$:	movx	a,@dptr		; 0xFFFF is end of change sequence
	push	a		; save 1st byte
	mov	b,a
	inc	dptr
	movx	a,@dptr		; 0x0000 is before change sequence
	push	a		; save 2nd byte
	orl	a,b
	jz	2$		; all bits 0 - before 1st change state
	cjne	a,#0xFF,3$	; all bits 1 - end of change sequence
2$:	setb	c		; a = 0x00 or a = 0xFF
	sjmp	4$
3$:	clr	c
;	sjmp	4$
4$:	pop	b		; 2nd byte
	pop	a		; 1st byte
	ret
;
;	Setup Parameters
;
;	On Return:
;	  a and j$cnt		Contain The Number Of Events Found (Upto The Input j$cnt)
;	  <j$msb:j$lsb>+2	Is The Beginning of change Element j$cnt
;
ex0stp:	clr	ea		; disable interrupts
	mov	j$msb,i$msb	; save last address
	mov	j$lsb,i$lsb
	setb	ea		; enable interrupts

	lcall	ex0eoc		; find end of changes or null entry
	jc	1$		; found event
	mov	j$cnt,#0	; no entries found
	ret

1$:	clr	a		; entry counter

2$:	inc	a		; update entry count
	push	a

3$:	lcall	ex0eoc		; find end of changes or null entry
	jnc	3$		; loop until found
	jnz	6$		; found end of event
				; else found NULL (or buffer end)
4$:	lcall	ex0nea		; scan forward
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jz	5$		; stop scan on NULL
	cjne	a,#0xFF,4$	; or termination

5$:	pop	a		; one less event
	dec	a
	sjmp	7$

6$:	pop	a
	cjne	a,j$cnt,2$	; j$cnt events - if not then loop

7$:	mov	j$cnt,a		; override input count
	ret	
;
; Called to get next element in a change event.
;
;	Enter with events to skip in b.
;
;	Returns 4 stacked bytes: pr1sts, pr2sts, pr3sts, and pr4sts
;	and returns the time stamp in bx (.1ms intervals)
;	Bit ex$end is set at end of the change event.
; 
ex0nxt:	lcall	ex0nea		; next element of change		
	djnz	b,ex0nxt

	movx	a,@dptr
	mov	ax,a		; ax <= prtsts
	inc	dptr
	movx	a,@dptr
	mov	bx,a		; time stamp
	inc	dptr

	clr	c		; if past top of buffer
	mov	a,dpl		; reset to bottom of buffer
	subb	a,#<m2_blk+1024
	mov	a,dph
	subb	a,#>m2_blk+1024
	jc	2$
	mov	dpl,#<m2_blk
	mov	dph,#>m2_blk

2$:	movx	a,@dptr
	clr	ex$end
	cjne	a,#0xFF,5$	; end of change ?
	setb	ex$end
	inc	dptr
	movx	a,@dptr
	clr	ex$bsy
	jb	a.0,3$
	setb	ex$bsy
3$:	clr	ex$wbk
	jb	a.1,4$
	setb	ex$wbk
4$:	clr	ex$cpy
	jb	a.2,5$
	setb	ex$cpy

5$:	pop	dph		; return address in dptr
	pop	dpl

	mov	b,#4

6$:	mov	a,ax		; prtsts byte
	anl	a,#0x03		; save stepped/direction for each port
	push	a		; save
	mov	a,ax		; rotate to next status bits
	rr	a
	rr	a
	mov	ax,a
	djnz	b,6$

	clr	a
	jmp	@a+dptr		; return
;
;	Output change Entry
;
	;	          111111111122222222223333333333444444444455555555556
	;	0123456789012345678901234567890123456789012345678901234567890
	;	"   Seq   PORT PART UPCNT DNCNT BSY WBK CPY TIME(ms.)"
	;	"  -nn.m    -    -   +nnn  -nnn  -   -   -   ---"
ex0out:	mov	a,j$cnt		; get count
	dec	a
	jz	1$
	mov	dptr,#ex2mns	; "  -" when j$cnt > 1
	sjmp	2$
1$:	mov	dptr,#ex3spc	; "   " when j$cnt = 1
;	sjmp	2$
2$:	lcall	outstr
	; -nn.m
	inc	$SBCNT		; update element counter
	mov	b,a
	lcall	sp2chr		; output nn (j$cnt - 1)
	mov	a,#'.
	lcall	outchr		; output '.'
	mov	b,$SBCNT
	lcall	sp1chr		; output m
	; PORT
	mov	dptr,#ex4spc	; spacing
	lcall	outstr
	mov	b,$PORT
	lcall	sp1chr		; output port number (1-4)
	; PART
	mov	dptr,#ex4spc	; spacing
	lcall	outstr
	mov	a,$PORT		; get PORT number
	dec	a		; make 0-3
	mov	b,#pr$siz	; compute address of partition byte
	mul	ab		; in the partition tables
	add	a,#pr$tbl+1
	mov	r0,a
	mov	b,@r0		; retrieve the partition number
	lcall	sp1chr		; output partition number
	; UPCNTS
	mov	a,$UPCNT
	jz	5$
	mov	dptr,#ex3pls
	lcall	outstr		; output "   +"
	lcall	ex0nnn		; output nnn
	sjmp	6$
5$:	mov	dptr,#ex7spc
	lcall	outstr		; output 7 spaces
	; DNCNTS
6$:	mov	a,$DNCNT
	jz	7$
	mov	dptr,#ex2mns
	lcall	outstr		; output "  -"
	lcall	ex0nnn		; output nnn
	sjmp	8$
7$:	mov	dptr,#ex6spc
	lcall	outstr		; output 6 spaces
	; BSY
8$:     mov	dptr,#ex2spc	; spacing
	lcall	outstr
	jnb	ex$bsy,9$
	mov	a,#'*
	sjmp	10$
9$:	mov	a,#spc
10$:	lcall	outchr
	; WBK
	mov	dptr,#ex3spc	; spacing
	lcall	outstr
	jnb	ex$wbk,11$
	mov	a,#'*
	sjmp	12$
11$:	mov	a,#spc
12$:	lcall	outchr
	; CPY
	mov	dptr,#ex3spc	; spacing
	lcall	outstr
	jnb	ex$cpy,13$
	mov	a,#'*
	sjmp	14$
13$:	mov	a,#spc
14$:	lcall	outchr
	; Finish Up
	jbc	ex$tim,15$
	lcall	docrlf
	ret
	; Time Stamp
15$:	mov	dptr,#ex3spc	; spacing
	lcall	outstr
	; output a 3 character decimal number
	; with leading spaces (<b:a>)
	mov	b,bx
	setb	i$xram
	mov	dptr,#temp5	; output buffer
	lcall	i$b$d		; word to decimal
	mov	b,#2		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#temp5	; output buffer
	lcall	SP0_MXT		; output string
	lcall	docrlf
	ret

ex0nnn:	mov	b,a
	cjne	a,#10,1$
1$:	jnc	2$
	lcall	sp1chr		; output 1 character
	mov	dptr,#ex2spc	; followed by 2 spaces
	sjmp	4$
2$:	cjne	a,#100,3$
3$:	jnc	5$
	lcall	sp2chr		; output 2 characters
	mov	dptr,#ex1spc	; followed by 1 space
4$:	lcall	outstr
	ret
5$:	lcall	sp3chr		; output 3 characters
	ret
;
;****************************************************************************
;
ex0_zr:	.stdst	#m2_blk		; zero m2_blk and m3_blk
	.stcnt	#-1024		; block of 1024 bytes
	lcall	zermem

	mov	i$msb,#>m2_blk	; Initialize change logging base address
	mov	i$lsb,#<m2_blk

	ljmp	nomore
;
;****************************************************************************
;
	; Ex0 change States Number Query
qry$ex:	lcall	get$nm		; get partition number
	jb	a.7,4$		; bad scan - invalid
	jz	2$
	.lb_rx	a,nbrhi		; check allowed
	jnz	4$		; too big - abort
	.lb_rx	a,nbrlo
	cjne	a,#65,1$	; compare to maximum
1$:	jnc	4$		; too big - abort
	jnz	3$
2$:	mov	a,#1		; 1 - 64
3$:	clr	c		; valid number return
	ret

4$:	setb	c		; invalid number return
	ret

.endif	; dbg.db$chg
;
;****************************************************************************
;
; The MFM 'Port' Interrupt Process Timing
;
.ifne dbg.Ex0$TstA | dbg.Ex0$TstB

m$pci:	lcall	number		; get test selection
	jb	a.7,3$		; bad syntax
	jnz	4$		; not blank

1$:	clr	Ex0$TstA	; Stop All Processes
	clr	Ex0$xbtA
	clr	Ex0$TstB
	clr	Ex0$xbtB
2$:	ljmp	nomore
3$:	ljmp	badsyn

4$:	.lb_rx	b,nbrlo		; load test selection
	push	b		; save
	lcall	number		; get strobe pin number
	pop	b		; restore
	jb	a.7,3$		; bad syntax
	jz	3$		; blank

	.lb_rx	a,nbrlo		; load the number
	xch	a,b		; a = test selection, b = pin number

	cjne	a,#1,7$		; Not Test 1 - skip
	mov	a,b		; Pin Selection
	cjne	a,#2,5$		; Not X2 - skip
	setb	Ex0$xbtA
	sjmp	6$
5$:	cjne	a,#1,3$		; Not X1 - Error
	clr	Ex0$xbtA
;	sjmp	6$
6$:	setb	Ex0$TstA	; Enable Option
	sjmp	2$		; finished

7$:	cjne	a,#2,10$	; Not Test 2 - skip
	mov	a,b		; Pin Selection
	cjne	a,#2,8$		; Not X2 - skip
	setb	Ex0$xbtB
	sjmp	9$
8$:	cjne	a,#1,3$		; Not X1 - Error
	clr	Ex0$xbtB
;	sjmp	9$
9$:	setb	Ex0$TstB
	sjmp	2$		; finished

10$:	sjmp	3$		; error

.endif	; dbg.Ex0$TstA | dbg.Ex0$TstB
;
;****************************************************************************
;
; The Show Parameters Function
;
.ifne dbg.db$que

m$log:	mov	dptr,#loglst	; look for option in list
	lcall	fndlnm		; returns with list number
	lcall	comand		; now go for a match
	jz	2$		; requires an option
	jb	a.7,2$		; bad command if negative

	dec	a		; compute (a - 1) * 3
	mov	b,#3
	mul	ab		; a is product
	mov	dptr,#1$
	jmp	@a+dptr		; jump into jump table

	; 2nd level jump table

1$:	ljmp	log_on
	ljmp	log_of
	ljmp	log_mp
	ljmp	log_rq
	ljmp	log_wq
	ljmp	log_qq
	ljmp	log_zq

2$:	ljmp	badsyn

	;	          1111111111222222222233333333334444444444555555555566666666667
	;	01234567890123456789012345678901234567890123456789012345678901234567890
	;	                                              111111
	;	                                    0123456789012345  (Milliseconds)
	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||___||||__||||||
mlog$1:	.ascii	"                                             111111"
	.byte	cr,lf,eot
mlog$2:	.ascii	" MFM I/O Queue    Mapped Tracks    0123456789012345"
	.byte	eot
mlog$3:	.ascii	" MFM I/O Queue    Drive  Tracks    0123456789012345"
	.byte	eot
mlog$4:	.ascii	"  (Milliseconds)"
	.byte	eot
mlog$5:	.ascii	"  Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched"
	.byte	eot
mlog$6:	.ascii	"  Seek   Time"
	.byte	eot
txt_r:	.ascii	"  R"
	.byte	eot
txt_w:	.ascii	"  W"
	.byte	eot
spcseq:	.ascii	"  -"
	.byte	eot
spcs_3:	.ascii	" "
spcs_2:	.ascii	"  "
	.byte	eot

mlog_x:	.ldptr	#mlog$x		; invalid argument
	lcall	outstr
	ljmp	nomore

mlog$x:	.ascii	" Invalid Argument"
	.byte	cr,lf,eot

;
;****************************************************************************
;
;	Parameter Logging Header
;
m$hdr:	mov	dptr,#mlog$1	; "MFM I/O Queue"
	lcall	outstr
	jb	maptrk,1$	; mapped / drive
	mov	dptr,#mlog$2	; mapped
	sjmp	2$
1$:	mov	dptr,#mlog$3	; drive
;	sjmp	2$
2$:	lcall	outstr
	jb	hdrtyp,3$
	mov	dptr,#mlog$4	; read only / read & write
	lcall	outstr
3$:	lcall	docrlf
	mov	dptr,#mlog$5
	lcall	outstr
	jb	hdrtyp,4$
	mov	dptr,#mlog$6	; read only / read & write
	lcall	outstr
4$:	lcall	docrlf
	ret
;
;****************************************************************************
;
; Computes Read/Write/Debug Parameter Address
;
; Parameter:
;	dptr	- Base Address
;
; Returns:
;	dptr	- Parameter Address
;
m$addr:	mov	r1,#qb$scn	; load block number
	movx	a,@r1
	mov	b,#qu$siz
	mul	ab		; compute offset
	add	a,dpl		; add base address
	mov	dpl,a
	mov	a,b
	addc	a,dph
	mov	dph,a		; debug parameter address in dptr
	ret

;
;****************************************************************************
;
;	Logging ON/OFF
;
log_on:
	setb	q$enbl		; enable logging process
	mov	a,#1
	sjmp	1$
log_of = .
	clr	q$enbl		; disable logging process
	clr	a
1$:	mov	dptr,#t2$tsk
	lcall	st$tm2		; and tasks
	ljmp	nomore
;
;****************************************************************************
;
	; Queue Blocks Number Query

qry$qb:	lcall	get$nm		; get queue blocks number
	jb	a.7,4$		; bad scan - invalid
	jz	3$
	.lb_rx	a,nbrhi		; check allowed
	jnz	4$		; too big - abort
	.lb_rx	a,nbrlo
	cjne	a,#65,1$	; compare to maximum
1$:	jnc	4$		; too big - abort
	jz	3$
2$:	dec	a		; 0 - 63
3$:	clr	c		; valid number return
	ret

4$:	setb	c		; invalid number return
	ret

;
;****************************************************************************
;
	; Queue Data Selection

qry$dt:	lcall	get$nm		; get data type number
	jb	a.7,3$		; bad scan - invalid
	jz	2$		; on blank - use current
	.lb_rx	a,nbrhi		; check allowed
	jnz	3$		; too big - abort
	.lb_rx	a,nbrlo
	jz	1$
	dec	a		; 0 - 1
	jz	1$
	cjne	a,#1,3$		; compare
1$:	.sb_rx	logdsp,a
2$:	clr	c		; valid number return
	ret

3$:	setb	c		; invalid number return
	ret

;
;****************************************************************************
;
	; Mapped / Drive Track Display

log_mp:	lcall	get$nm		; get number
	jb	a.7,2$		; bad scan - invalid
	jz	2$		; on blank - error
	.lb_rx	a,nbrhi		; check allowed
	jnz	2$		; too big - abort
	.lb_rx	a,nbrlo
	clr	maptrk		; Mapped Tracks Is Default
	jz	1$
	dec	a		; 0 - 1
	jz	1$
	cjne	a,#1,2$		; compare
	setb	maptrk		; Drive Track Mapping
1$:	ljmp	nomore
2$:	ljmp	mlog_x

;
;****************************************************************************
;
	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||___||||__||||||
log_rq:	lcall	qry$qb
	jc	3$
	lcall	log_st		; setup parameters
	push	b
	lcall	qry$dt
	pop	b
	jc	3$
	clr	hdrtyp		; read only / read & write
	lcall	m$hdr		; show header

1$:	push	b
	lcall	log_qb		; show queue block position
	mov	dptr,#txt_r	; queue element type = R
	lcall	outstr
	lcall	log_rb		; sho read queue block
	lcall	docrlf
	pop	b
	lcall	log_nx
	djnz	b,1$

	ljmp	nomore
3$:	ljmp	mlog_x


log_rb:	mov	dptr,#rdqblk
	lcall	log_rw

	mov	dptr,#spcs_3
	lcall	outstr

	.lb_rx	a,logdsp	; Display Mode
	;
	; Select Bit Data To Display and
	; Set Bit Rotation Requirements
	cjne	a,#1,1$
	mov	dptr,#db$prm.ird
	; .ird contains Drive Track values
	setb	rotbit		; default mode - Mapped Tracks
	setb	rotlft		; high bits <= low bits
	jnb	maptrk,2$
	clr	rotbit		; else - Drive Tracks
	sjmp	2$
;				; a != 1 and a != 2
1$:	mov	dptr,#db$prm.tch
	; .tch contains Mapped Track values
	clr	rotbit		; default mode - Mapped Tracks
	jnb	maptrk,2$
	setb	rotbit		; else - Drive Tracks
	clr	rotlft		; high bits => low bits
;	sjmp	3$
2$:	lcall	log_bt

	; special
	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||___||||__||||||
	mov	dptr,#spcs_2	; Seek Time
	lcall	outstr

	mov	dptr,#db$prm.skt
	lcall	m$addr

	movx	a,@dptr		; NOTE: original order <LSB:MSB>
	mov	b,a
	inc	dptr
	movx	a,@dptr
	xch	a,b

	; output a 4 character decimal number
	; with leading spaces (<b:a>)

	setb	i$xram
	mov	dptr,#temp5	; output buffer
	lcall	i$w$d		; word to decimal
	mov	b,#3		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#temp5+4	; last digit
	movx	a,@dptr		; insert decimal point
	mov	b,a
	mov	a,#'.
	movx	@dptr,a
	mov	a,b
	inc	dptr
	movx	@dptr,a
	mov	dptr,#temp5+1	; output buffer
	lcall	SP0_MXT		; output string

	; special
	;	   Seq -Q- Bnk Part  Cyl Trks QKS  Trks[0:15] Touched  Seek   Time
	;	 __-||__|___|___||__||||__||___|____||||||||||||||||___||||__||||||

	mov	dptr,#spcs_2	; Time
	lcall	outstr

	mov	dptr,#db$prm.ext
	lcall	m$addr

	movx	a,@dptr		; NOTE: original order <LSB:MSB>
	mov	b,a
	inc	dptr
	movx	a,@dptr
	xch	a,b

	; output a 5 character decimal number
	; with leading spaces (<b:a>)

	setb	i$xram
	mov	dptr,#temp5	; output buffer
	lcall	i$w$d		; word to decimal
	mov	b,#3		; max leading '0' characters to remove
	lcall	spcout
	mov	dptr,#temp5+4	; last digit
	movx	a,@dptr		; insert decimal point
	mov	b,a
	mov	a,#'.
	movx	@dptr,a
	mov	a,b
	inc	dptr
	movx	@dptr,a
	mov	dptr,#temp5	; output buffer
	lcall	SP0_MXT		; output string

	ret

;
;****************************************************************************
;
	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
log_wq:	lcall	qry$qb
	jc	2$
	lcall	log_st		; setup parameters
	push	b
	lcall	qry$dt
	pop	b
	jc	2$
	setb	hdrtyp		; write only
	lcall	m$hdr		; show header

1$:	push	b
	lcall	log_qb		; show queue block position
	mov	dptr,#txt_w	; queue element type = W
	lcall	outstr
	lcall	log_wb
	lcall	docrlf
	pop	b
	lcall	log_nx
	djnz	b,1$

	ljmp	nomore
2$:	ljmp	mlog_x


log_wb: mov	dptr,#wtqblk
	lcall	log_rw

	mov	dptr,#spcs_3
	lcall	outstr

	;
	; Select Bit Data To Display and
	; Set Bit Rotation Requirements
	cjne	a,#1,1$
	mov	dptr,#db$prm.iwt
	; .iwt contains Drive Track values
	setb	rotbit		; default mode - Mapped Tracks
	setb	rotlft		; high bits <= low bits
	jnb	maptrk,2$
	clr	rotbit		; else - Drive Tracks
	sjmp	2$

1$:	mov	dptr,#db$prm.twt
	; .twt contains Drive Track values
	setb	rotbit		; default mode - Mapped Tracks
	setb	rotlft		; high bits <= low bits
	jnb	maptrk,2$
	clr	rotbit		; else - Drive Tracks

2$:	lcall	log_bt
	ret

;
;****************************************************************************
;
	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched  Seek   Time
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||___||||__||||||
log_qq:	lcall	qry$qb
	jc	2$
	lcall	log_st		; setup parameters
	push	b
	lcall	qry$dt
	pop	b
	jc	2$
	clr	hdrtyp		; read / read & write
	lcall	m$hdr		; show header

1$:	push	b
	lcall	log_qb		; show queue block position
	mov	dptr,#txt_w	; queue element type = W
	lcall	outstr
	lcall	log_wb
	lcall	docrlf
	pop	b
	push	b
	lcall	log_qb		; show queue block position
	mov	dptr,#txt_r	; queue element type = R
	lcall	outstr
	lcall	log_rb
	lcall	docrlf
	pop	b
	lcall	log_nx
	djnz	b,1$

	ljmp	nomore
2$:	ljmp	mlog_x

;
;****************************************************************************
;
log_zq:	.stdst	#ioblk1		; zero ioblk1, ioblk2, and m1_blk
	.stcnt	#-1536		; block of 1536 bytes
	lcall	zermem

	ljmp	nomore
;
;****************************************************************************
;
log_st:	mov	b,a		; save block count
	.lb_rx	a,qb$blk
	inc	r1
	clr	c
	subb	a,b
	anl	a,#0x3F
	movx	@r1,a		; save in qb$scn
	inc	b		; loop counter
	ret

;
;****************************************************************************
;
log_nx:	.lb_rx	a,qb$scn	; next queue block
	inc	a
	anl	a,#0x3F
	movx	@r1,a
	ret

;
;****************************************************************************
;
	;  rd$que / wt$que Elements
	;
	;	.blkb	1		; Cache Bank: 0/1
	;	.blkb	1		; Partition Number
	;	.blkb	2		; Cylinder
	;	.blkb	1		; Tracks / Cylinder
	;	.blkb	1		; Options (Port Number)
	;
	;	.blkb	2		; Tracks Accessed (rd$que Only)
	;	--- or ---
	;	.blkb	2		; Track Written Bytes (wt$que Only)
	;
log_rw:	lcall	m$addr		; compute address

	push	dpl
	push	dph

	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
	mov	dptr,#spcs_3	; Cache Bank
	lcall	outstr
	pop	dph
	pop	dpl
	movx	a,@dptr
	jz	1$
	mov	a,#1
1$:	mov	b,a
	inc	dptr
	push	dpl
	push	dph
	lcall	sp1chr

	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
	mov	dptr,#spcs_3	; Port Number
	lcall	outstr
	pop	dph
	pop	dpl
	push	dpl		; save address
	push	dph
	inc	dptr		; skip Partition Number
	inc	dptr		; skip Cylinder
	inc	dptr
	inc	dptr		; skip Tracks/Cylinder
	movx	a,@dptr		; Options (Port Number)
	.sb_rx	logpnm,a	; save port number
	mov	b,a		; (1-4)
	lcall	sp2chr

	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
	mov	dptr,#spcs_3	; Partition Number
	lcall	outstr
	pop	dph
	pop	dpl
	movx	a,@dptr
	mov	b,a
	inc	dptr
	push	dpl
	push	dph
	lcall	sp2chr

	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
	mov	dptr,#spcs_2	; Cylinder
	lcall	outstr
	pop	dph
	pop	dpl
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	inc	dptr
	push	dpl
	push	dph
	lcall	sp4chr

	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
	mov	dptr,#spcs_2	; Tracks/Cylinder
	lcall	outstr
	pop	dph
	pop	dpl
	movx	a,@dptr
	mov	b,a
	inc	dptr
	push	dpl
	push	dph
	lcall	sp2chr
	pop	dph
	pop	dpl
	ret

;
;****************************************************************************
;
; Parameters:
;	dptr	- Base Scan Address
;	a	- Display Mode
;
log_bt:	.lb_rx	a,logpnm	; port number
	add	a,#'0
	mov	r0,a

	lcall	m$addr		; Parameter Address
	movx	a,@dptr		; LSB
	mov	r2,a
	inc	dptr
	movx	a,@dptr		; MSB
	mov	r3,a
	inc	dptr

	lcall	wrd_rt		; do required rotation

	mov	a,r2		; LSB
	lcall	byt_bt		; do 1st byte
	mov	a,r3		; MSB
;	fall through to byt_bt	; do 2nd byte

	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
byt_bt:	mov	b,#8
1$:	rrc	a
	push	a
	jc	2$
	mov	a,#'- 		; InActive Character
	sjmp	3$
2$:     mov	a,r0		; Active Character
;	sjmp	3$
3$:	lcall	chrout
	pop	a
	djnz	b,1$
	ret

	; Rotate Parameter
wrd_rt:	jnb	rotbit,5$	; rotate ?
	.lb_rx	a,logpnm	; port number
	jz	5$		; 0 - .opt not valid
	dec	a		; (1-4) => (0-3)
	jz	5$		; 0 - no rotation
	cjne	a,#4,1$		; must < 4
1$:	jnc	5$
	mov	b,#4
	mul	ab
	mov	b,a		; rotation count

	jb	rotlft,3$

	mov	a,r2		; rotate right
	rrc	a		; LS Bit
2$:	mov	a,r3
	rrc	a		; MSB
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	r2,a
	djnz	b,2$
	sjmp	5$

3$:	mov	a,r3		; rotate left
	rlc	a		; MS Bit
4$:	mov	a,r2		; LSB
	rlc	a
	mov	r2,a
	mov	a,r3		; MSB
	rlc	a
	mov	r3,a
	djnz	b,4$

5$:	ret

;
;****************************************************************************
;
	;	   Seq -Q- Bnk Port Part  Cyl Trks Trks[0:15] Touched
	;	 __-||__|___|____|___||__||||__||___||||||||||||||||
log_qb:	mov	a,b		; show depth of queue block
	dec	a
	push	b
	push	a
	jz	1$
	mov	dptr,#spcseq
	lcall	outstr
	pop	b
	lcall	sp2chr		; queue position
	pop	b
	ret

1$:	mov	dptr,#spcs_3
	lcall	outstr
	pop	b
	lcall	sp2chr		; queue position
	pop	b
	ret

.endif	; dbg.db$que
;
;****************************************************************************
;
; The 'MFM Write Back' Process Timing
;
.ifne dbg.Wbk$TstA

m$wbk:	lcall	number		; get strobe pin number
	jb	a.7,2$		; bad syntax
	jnz	3$		; not blank

	clr	Wbk$TstA	; Disable
	clr	Wbk$xbtA
1$:	ljmp	nomore
2$:	ljmp	badsyn

3$:     .lb_rx	a,nbrlo		; load pin select
	cjne	a,#1,4$		; Not X1 - skip
	clr	Wbk$xbtA
	sjmp	5$
4$:	cjne	a,#2,2$		; Not X2 - Error
	setb	Wbk$xbtA
;	sjmp	5$
5$:	setb	Wbk$TstA	; Enable
	sjmp	1$

.endif	; dbg.Wbk$TstA
;
;****************************************************************************

	.page
	.sbttl	Initialize All Things DEBUG

;****************************************************************************
;
debug_init:
	mov	a,#qu$tbl
	mov	r1,a		; base address
	mov	r2,#4		; 4 ports

	; Initialize Queue Block Table Pointers

1$:	mov	a,r1
	add	a,#db.tch
	mov	r0,a		; set .tch
	mov	@r0,#>ioblk1
	inc	r0
	mov	@r0,#<ioblk1

	mov	a,r1
	add	a,#db.ext
	mov	r0,a
	mov	r3,#4		; 4 addresses to load

2$:	mov	@r0,#>ioblk1	; .ext, .iwt, .ird, and .skt
	inc	r0
	mov	@r0,#<ioblk1
	inc	r0
	djnz	r3,2$

	mov	a,r1		; to next port
	add	a,#qu$siz
	mov	r1,a
	djnz	r2,1$

	; Initialize qb$blk number
	mov	dptr,#qb$blk
	mov	a,#-1		; first call increments to 0
	movx	@dptr,a

	; Initialize   Logging Base Address

	mov	i$msb,#>m2_blk
	mov	i$lsb,#<m2_blk

	; Initialize Timer 2

	.msg	^"*****    Timer 2 Set For 100 us.    *****"
	mov	dptr,#-2000
	lcall	t2$ini
	ret

;
;****************************************************************************

	.page
	.sbttl	DBGTST Table Entries

;****************************************************************************
;
	dbg$tst	=: 0	; Enable Function Testing/Debugging
;
;****************************************************************************
.ifne dbg$tst

	.msg	^"***** Function Testing/Debugging Code Included *****"

;****************************************************************************
;
	; Command Table Entries

	.area	CmdTbl

	ljmp	dbgtst

;
;****************************************************************************
;
	; Command List Entries 

	.area	CmdLst

	.ascii	/DBGTST/
	.byte	cr

;
;****************************************************************************
;
	; Command Option List Entries

	.area	OptLst

;
;****************************************************************************
;
	; Extended Help String Pointers

	.area	X_Ptrs

	.word	$dbgtst

;
;****************************************************************************
;
	; Extended Help Strings

	.area	X_Strs

$dbgtst:
	.ascii	"   DB[GTST]"
	.byte	cr,lf
	.ascii	"     DBGCFG Function Testing"
	.byte	cr,lf
	.byte	eot

;
;****************************************************************************
;
	.area	Debug
;
;****************************************************************************

	.page
	.sbttl	DBGTST Function Debugging

;****************************************************************************
;
; Function Testing
;

dbgtst:	lcall	dbfnc1
;
;****************************************************************************

	.page
	.sbttl	Test Functions

dbfnc1:
.ifne 1
	lcall	get$nm		; get a number
	jb	a.7,1$		; bad scan - invalid
	jz	1$
	.lb_rx	a,nbrlo

	lcall	ex0nnn		; output nnn
1$:	lcall	docrlf
.endif
	ljmp	nomore

.endif	; dbg$tst
;
;****************************************************************************

.endif	; mfm$dbg
.endif	; .else of _debug

	.end


