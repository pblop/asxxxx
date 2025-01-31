	.byte	0x00				; inctst.asm
.nlist
	.include	"inc0a"			; inctst.asm
	.include	".\inc1\inc1a"		; inctst.asm
	.include	".\inc2\inc2a"		; inctst.asm
	.include	".\inc3\inc3a"		; inctst.asm
.list
;	.include	".\inc1\inc1"		;   inc1.asm
						;     inc0a.asm
						;     inc1a.asm
.nlist
	.include	".\inc1\inc1"		; inctst.asm
.list
;	.include	".\inc2\inc2"		;   inc2.asm						;   inc2.asm
						;     inc0a.asm
						;     inc1a.asm
						;     inc2a.asm
						;     inc1.asm
						;       inc0a.asm
						;       inc1a.asm
.nlist
	.include	".\inc2\inc2"		; inctst.asm
.list
;	.include	".\inc3\inc3"		;   inc3.asm
						;     inc0a.asm
						;     inc1a.asm
						;     inc2a.asm
						;     inc3a.asm
						;     inc1.asm
						;       inc0a.asm
						;       inc1a.asm
						;     inc2.asm
						;       inc0a.asm
						;       inc1a.asm
						;       inc2a.asm
						;       inc1.asm
						;         inc0a.asm
						;         inc1a.asm
.nlist
	.include	".\inc3\inc3"		; inctst.asm

