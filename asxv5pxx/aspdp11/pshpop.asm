	.title Area Push/Pop Testing

	.area A	(rel,con)

A1:	.word .

	.psharea
	.area B	(rel,con)

B1:	.word .

	.area C (rel,con)

C1:	.word .

	.poparea

A2:	.word .


	.rept 16.
	.psharea
	.endm

	.rept 16.
	.poparea
	.endm

	.rept 17.
	.psharea
	.endm

	.rept 17.
	.poparea
	.endm


	