	.list	(me)

	; MACRO With Dummy Arguments

.macro	TBL     name,   dev="NL",blk=0,flg=3
        .word	blk
        .word   flg
'name:	.asciz  dev
        .even
.endm

	; Invoke Multiple Times

        TBL  NL

        TBL  DY  dev="DY0"

        TBL  RL  dev="RL3",blk=20.

        TBL  DU  dev="DU1",blk=1,flg=7

