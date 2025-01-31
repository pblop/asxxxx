	.title	AS68K Assembler Test

	.nlist
	.include "bldt68k.mac"
	.list

	.68020			; Select 68020 Processor
	.68882			; Select 68882 Floating Point Co-Processor
	.enabl	(alt)		; Allow Alternate Instructions

	.nlist
	$Error = 0
	$All = 1

	.S_TYP1.  = $All + 1	; ABCD, SBCD, ADDX, SUBX
	.S_TYP2.  = $All + 1	; ADD, AND, OR, SUB
	.S_TYP3.  = $All + 1	; ADDA, CMPA, SUBA
	.S_TYP4.  = $All + 1	; ADDI, ANDI, CMPI, EORI, ORI, SUBI
	.S_TYP5.  = $All + 1	; ADDQ, SUBQ
	.S_TYP6.  = $All + 1	; DIVS, DIVU, MULS, MULU
	.S_TYP7.  = $All + 1	; CLR, NEG, NEGX, NOT, TST
	.S_TYP8.  = $All + 1	; JMP, JSR, LEA, PEA
	.S_TYP9.  = $All + 1	; NBCD, TAS
	.S_SHFT.  = $All + 1	; ASL, ASR, LSL, LSR, ROL, ROR, ROXL, ROXL
	.S_BCC.   = $All + 0	; BRA, BSR, BHI, BLS, BCC, BCS, BNE, BEQ
				; BVC, BVS, BPL, BMI, BGE, BLT, BGT, BLE
	.S_DBCC.  = $All + 0	; DBT,  DBF,  DBHI, DBLC, DBCC, DBCS, DBNE, DBEQ
				; DBVC, DBVS, DBPL, DBMI, DBGE, DBLT, DBGT, DBLE, DBRA
	.S_SCC.   = $All + 0	; ST,  SF,  SHI, SLS, SCC, SCS, SNE, SEQ
				; SVC, SVS, SPL, SMI, SGE, SLT, SGT, SLE, SHS, SLO
	.S_BIT.   = $All + 0	; BCHG, BCLR, BSET, BTST
	.S_MOVE.  = $All + 1	; MOVE
	.S_MOVEA. = $All + 0	; MOVEA
	.S_MOVEM. = $All + 0	; MOVEM
	.S_MOVEP. = $All + 0	; MOVEP
	.S_MOVEQ. = $All + 0	; MOVEQ
	.S_CHK.   = $All + 0	; CHK
	.S_CMP.   = $All + 0	; CMP
	.S_CMPM.  = $All + 0	; CMPM
	.S_EOR.   = $All + 0	; EOR
	.S_EXG.   = $All + 0	; EXG
	.S_EXT.   = $All + 0	; EXT, EXTB (68020)
	.S_LINK.  = $All + 0	; LINK
	.S_STOP.  = $All + 0	; STOP, RTD (68020)
	.S_SWAP.  = $All + 0	; SWAP
	.S_TRAP.  = $All + 0	; TRAP
	.S_UNLK.  = $All + 0	; UNLK
	.S_INH.   = $All + 0	; ILLEGAL, NOP, RESET, RTE, RTR, RTS, TRAPV

	.B_XPC.   = $All + 0	; External Branching Tests

	; Only 68010/68020 Instructions

	.S_MOVEC. = $All + 0	; MOVEC
	.S_MOVES. = $All + 0	; MOVES

	; Only 68020 Instructions

	.S_BF.    = $All + 0	; BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST
	.S_BKPT.  = $All + 0	; BKPT
	.S_CALLM. = $All + 0	; CALLM
	.S_CAS.   = $All + 0	; CAS
	.S_CAS2.  = $All + 0	; CAS2
	.S_CHK2.  = $All + 0	; CHK2, CMP2
	.S_PKUK.  = $All + 0	; PACK, UNPK
	.S_RTM.   = $All + 0	; RTM
	.S_TRPC.  = $All + 0	; TRAPcc

	; 68881/68882 Floating Point Instructions

	.F_TYP1.  = $All + 0	; FINT, FSINH, FINTRZ, FSQRT, FLOGNP1, FETOXM1, FTANH, FATAN, FASIN, FATANH
				; FSIN, FTAN, FETOX, FTWOTOX, FTENTOX, FLOGN, FLOG10, FLOG2, FABS, FCOSH
				; FNEG, FCOS, FACOS, FGETEXP, FGETMAN, FDIV
	.F_TYP2.  = $All + 0	; FMOD, FADD, FMUL, FSGLDIV, FREM, FSCALE, FSGLMUL, FSUB,  FCMP
	.F_SNCS.  = $All + 0	; FSINCOS
	.F_TST.   = $All + 0	; FTST
	.F_MOV.   = $All + 0	; FMOVE
	.F_MVCR.  = $All + 0	; FMOVECR
	.F_MOVM.  = $All + 0	; FMOVEM
	.F_SCC.   = $All + 0	; FScc
	.F_DCC.   = $All + 0	; FDBcc
	.F_TCC.   = $All + 0	; FTRAPcc
	.F_NOP.   = $All + 0	; FNOP
	.F_BCC.   = $All + 0	; FBcc
	.F_SVRS.  = $All + 0	; FSAVE, FRESTORE

	.FB_XPC.  = $All + 0	; FBcc External Branching Tests
	.FDB_XPC. = $All + 0	; FDBcc External Branching Tests

	.FLOAT.   = $All + 0	; Floating Point Constants

	; Internal Checks

	.AMCHK.   =      + 0	; Diagnostic Addressing Mode Checks
	.SRCCHK.  = $All + 1	; Exhaustive Source Addressing Checks

	; Instruction Tests

	.ifne .AMCHK.
	  .list
	  .page
	.sbttl	Addressing Mode Checks
	  .nlist
1$:	AMCHK	$Error
	.endif

	.ifne .S_TYP1.
	  .list
	  .page
	.sbttl	Type S_TYP1 Instructions: ABCD, SBCD, ADDX, SUBX
	  .nlist
2$:	S_TYP1	$Error
	.endif

	.ifne .S_TYP2.
	  .list
	  .page
	.sbttl	Type S_TYP2 Instructions: ADD, AND, OR, SUB
	  .nlist
3$:	S_TYP2	$Error
	.endif

	.ifne .S_TYP3.
	  .list
	  .page
	.sbttl	Type S_TYP3 Instructions: ADDA, CMPA, SUBA
	  .nlist
4$:	S_TYP3	$Error
	.endif

	.ifne .S_TYP4.
	  .list
	  .page
	.sbttl	Type S_TYP4 Instructions: ADDI, ANDI, CMPI, EORI, ORI, SUBI
  	  .nlist
5$:	S_TYP4	$Error
	.endif

	.ifne .S_TYP5.
	  .list
	  .page
	.sbttl	Type S_TYP5 Instructions: ADDQ, SUBQ
	  .nlist
6$:	S_TYP5	$Error
	.endif

	.ifne .S_TYP6.
	  .list
	  .page
	.sbttl	Type S_TYP6 Instructions: CHK, CMP, DIVS, DIVU, MULS, MULU
    	  .nlist
7$:	S_TYP6	$Error
	.endif

	.ifne .S_TYP7.
	  .list
	  .page
	.sbttl	Type S_TYP7 Instructions: CLR, NEG, NEGX, NOT, TST
	  .nlist
8$:	S_TYP7	$Error
	.endif

	.ifne .S_TYP8.
	  .list
	  .page
	.sbttl	Type S_TYP8 Instructions: JMP, JSR, LEA, PEA
	  .nlist
9$:	S_TYP8	$Error
	.endif

	.ifne .S_TYP9.
	  .list
	  .page
	.sbttl	Type S_TYP9 Instructions: NBCD, TAS
	  .nlist
10$:	S_TYP9	$Error
	.endif

	.ifne .S_SHFT.
	  .list
	  .page
	.sbttl	Type S_SHFT Instructions: ASL, ASR, LSL, LSR, ROL, ROR, ROXL, ROXL
	  .nlist
11$:	S_SHFT	$Error
	.endif

	.ifne .S_BCC.
	  .list
	  .page
	.sbttl	Type S_BCC Instructions: BRA, BSR, Plus Conditional Branches
	  .nlist
12$:	S_BCC	$Error
	.endif

	.ifne .S_DBCC.
	  .list
	  .page
	.sbttl	Type S_DBCC Instructions: DBT, DBF, Plus Conditional Branches
	  .nlist
13$:	S_DBCC	$Error
	.endif

	.ifne .S_SCC.
	  .list
	  .page
	.sbttl	Type S_SCC Instructions: ST, SF, Plus Conditional Branches
	  .nlist
14$:	S_SCC	$Error
	.endif

	.ifne .S_BIT.
	  .list
	  .page
	.sbttl	Type S_BIT Instructions: BCHG, BCLR, BSET, BTST
	  .nlist
15$:	S_BIT	$Error
	.endif

	.ifne .S_MOVE.
	  .list
	  .page
	.sbttl	Type S_MOVE Instructions: MOVE
	  .nlist
16$:	S_MOVE	$Error
	.endif

	.ifne .S_MOVEA.
	  .list
	  .page
	.sbttl	Type S_MOVEA Instructions: MOVEA
	  .nlist
17$:	S_MOVEA	$Error
	.endif

	.ifne .S_MOVEM.
	  .list
	  .page
	.sbttl	Type S_MOVEM Instructions: MOVEM
	  .nlist
18$:	S_MOVEM	$Error
	.endif

	.ifne .S_MOVEP.
	  .list
	  .page
	.sbttl	Type S_MOVEP Instructions: MOVEP
	  .nlist
19$:	S_MOVEP	$Error
	.endif

	.ifne .S_MOVEQ.
	  .list
	  .page
	.sbttl	Type S_MOVEQ Instructions: MOVEQ
	  .nlist
20$:	S_MOVEQ	$Error
	.endif

	.ifne .S_CHK.
	  .list
	  .page
	.sbttl	Type S_CHK Instructions: CHK
	  .nlist
21$:	S_CHK	$Error
	.endif

	.ifne .S_CMP.
	  .list
	  .page
	.sbttl	Type S_CMP Instructions: CMP
	  .nlist
22$:	S_CMP	$Error
	.endif

	.ifne .S_CMPM.
	  .list
	  .page
	.sbttl	Type S_CMPM Instructions: CMPM
	  .nlist
23$:	S_CMPM	$Error
	.endif

	.ifne .S_EOR.
	  .list
	  .page
	.sbttl	Type S_EOR Instructions: EOR
	  .nlist
24$:	S_EOR	$Error
	.endif

	.ifne .S_EXG.
	  .list
	  .page
	.sbttl	Type S_EXG Instructions: EXG
	  .nlist
25$:	S_EXG	$Error
	.endif

	.ifne .S_EXT.
	  .list
	  .page
	.sbttl	Type S_EXT Instructions: EXT
	  .nlist
26$:	S_EXT	$Error
	.endif

	.ifne .S_LINK.
	  .list
	  .page
	.sbttl	Type S_LINK Instructions: LINK
	  .nlist
27$:	S_LINK	$Error
	.endif

	.ifne .S_STOP.
	  .list
	  .page
	.sbttl	Type S_STOP Instructions: STOP
 	  .nlist
28$:	S_STOP	$Error
	.endif

	.ifne .S_SWAP.
	  .list
	  .page
	.sbttl	Type S_SWAP Instructions: SWAP
	  .nlist
29$:	S_SWAP	$Error
	.endif

	.ifne .S_TRAP.
	  .list
	  .page
	.sbttl	Type S_TRAP Instructions: TRAP
	  .nlist
30$:	S_TRAP	$Error
	.endif

	.ifne .S_UNLK.
	  .list
	  .page
	.sbttl	Type S_UNLK Instructions: UNLK
	  .nlist
31$:	S_UNLK	$Error
	.endif

	.ifne .S_INH.
	  .list
	  .page
	.sbttl	Type S_INH Instructions: ILLEGAL, NOP, RESET, RTE, RTR, RTA, TRAPV
	  .nlist
32$:	S_INH	$Error
	.endif

	; Only 68010/68020 Instructions

	.ifne .S_MOVEC.
	  .list
	  .page
	.sbttl	Type S_MOVEC Instructions: MOVEC
	  .nlist
33$:	S_MOVEC	$Error
	.endif

	.ifne .S_MOVES.
	  .list
	  .page
	.sbttl	Type S_MOVES Instructions: MOVES
	  .nlist
34$:	S_MOVES	$Error
	.endif

	; Only 68020 Instructions

	.ifne .S_BF.
	  .list
	  .page
	.sbttl	Type S_BF Instructions: BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST
	  .nlist
35$:	S_BF	$Error
	.endif

	.ifne .S_BKPT.
	  .list
	  .page
	.sbttl	Type S_BKPT Instructions: BKPT
	  .nlist
36$:	S_BKPT	$Error
	.endif

	.ifne .S_CALLM.
	  .list
	  .page
	.sbttl	Type S_CALLM Instructions: CALLM
	  .nlist
37$:	S_CALLM	$Error
	.endif

	.ifne .S_CAS.
	  .list
	  .page
	.sbttl	Type S_CAS Instructions: CAS
	  .nlist
38$:	S_CAS	$Error
	.endif

	.ifne .S_CAS2.
	  .list
	  .page
	.sbttl	Type S_CAS2 Instructions: CAS2
	  .nlist
39$:	S_CAS2	$Error
	.endif

	.ifne .S_CHK2.
	  .list
	  .page
	.sbttl	Type S_CHK2 Instructions: CHK2, CMP2
	  .nlist
40$:	S_CHK2	$Error
	.endif

	.ifne .S_PKUK.
	  .list
	  .page
	.sbttl	Type S_PKUK Instructions: PACK, UNPK
	  .nlist
41$:	S_PKUK	$Error
	.endif

	.ifne .S_RTM.
	  .list
	  .page
	.sbttl	Type S_RTM Instructions: RTM
	  .nlist
43$:	S_RTM	$Error
	.endif

	.ifne .S_TRPC.
	  .list
	  .page
	.sbttl	Type S_TRPC Instructions: TRAPcc
	  .nlist
44$:	S_TRPC	$Error
	.endif

	; 68881/68882 Floating Point Instructions

	.ifne .F_TYP1.
	  .list
	  .page
	.sbttl	Type F_TYP1 Instructions: FABS, ...
	  .nlist
45$:	F_TYP1	$Error
	.endif

	.ifne .F_TYP2.
	  .list
	  .page
	.sbttl	Type F_TYP2 Instructions: FMOD, ...
	  .nlist
46$:	F_TYP2	$Error
	.endif

	.ifne .F_SNCS.
	  .list
	  .page
	.sbttl	Type F_SNCS Instructions: FSINCOS
	  .nlist
48$:	F_SNCS	$Error
	.endif

	.ifne .F_TST.
	  .list
	  .page
	.sbttl	Type F_TST Instructions: FTST
	  .nlist
49$:	F_TST	$Error
	.endif

	.ifne .F_MOV.
	  .list
	  .page
	.sbttl	Type F_MOV Instructions: FMOVE
	  .nlist
50$:	F_MOV	$Error
	.endif

	.ifne .F_MVCR.
	  .list
	  .page
	.sbttl	Type F_MVCR Instructions: FMOVECR
	  .nlist
51$:	F_MVCR	$Error
	.endif

	.ifne .F_MOVM.
	  .list
	  .page
	.sbttl	Type F_MOVM Instructions: FMOVEM
	  .nlist
52$:	F_MOVM	$Error
	.endif

	.ifne .F_SCC.
	  .list
	  .page
	.sbttl	Type F_SCC Instructions: FScc, ...
	  .nlist
53$:	F_SCC	$Error
	.endif

	.ifne .F_DCC.
	  .list
	  .page
	.sbttl	Type F_DCC Instructions: FDBcc, ...
	  .nlist
54$:	F_DCC	$Error
	.endif

	.ifne .F_TCC.
	  .list
	  .page
	.sbttl	Type F_TCC Instructions: FTcc, ...
	  .nlist
55$:	F_TCC	$Error
	.endif

	.ifne .F_NOP.
	  .list
	  .page
	.sbttl	Type F_NOP Instructions: FNOP
	  .nlist
56$:	F_NOP	$Error
	.endif

	.ifne .F_BCC.
	  .list
	  .page
	.sbttl	Type F_BCC Instructions: FBCC, ...
	  .nlist
57$:	F_BCC	$Error
	.endif

	.ifne .F_SVRS.
	  .list
	  .page
	.sbttl	Type F_SVRS Instructions: FSAVE, FRESTORE
	  .nlist
58$:	F_SVRS	$Error
	.endif

	.ifne .FLOAT.
	  .list
	  .page
	.sbttl	Floating Point Constants
	  .nlist
59$:	FLOAT
	.endif

	.ifne .SRCCHK.
	  .list
	  .page
	.sbttl	Source Addressing Mode Checks
	  .nlist
60$:	SRCCHK
	.endif

	.ifne .B_XPC.
	  .list
	  .page
	.sbttl	Branch External Addressing
	  .nlist
61$:	B_XPC	$Error
	.endif

	.ifne .FB_XPC.
	  .list
	  .page
	.sbttl	FBcc Branch External Addressing
	  .nlist
62$:	FB_XPC	$Error
	.endif

	.ifne .FDB_XPC.
	  .list
	  .page
	.sbttl	FDBcc Branch External Addressing
	  .nlist
63$:	FDB_XPC	$Error
	.endif

	LIST
	.end
