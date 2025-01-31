	.title	Macro Recursion

	.debug	(mcr,rpt)

	.macro	recurs	A,B,C
	  .list	(mel)
	  D = A-1
	  E = B+1
	  F = C-1
	  .word	A,B,C
	  .ifne A
	    recurs	\D,\E,\F
	  .endif
	  .word	A,B,C
	.endm


	recurs	\5,\10,\20


