	.title Listing Tests For Macros
	.sbttl	Macro Listing Control External To The Macro

	.macro	tst	a,b,?c
;	 comment	; Enabled By (me)
c:	 .byte	a	; Enabled By (me)
;	 comment	; Enabled By (me)
	 .ascii	b	; Enabled By (me)
	.endm

; *****-----*****-----*****-----*****-----*****-----*****
1$:	.assume	1$		; Incorrect Byte Count
	.list
;	.list
;	Nothing From The Macro Will Be Listed
	tst	1,"Hello"

; *****-----*****-----*****-----*****-----*****-----*****
2$:	.assume 2$ - 1$ - 6	; Incorrect Byte Count
	.list	(!,err,loc,bin,cyc,lin,src,meb)
;	.list	(!,err,loc,bin,cyc,lin,src,meb)
;	Only Generated Binary Will Be Listed
	tst	2,"Hello"
	.nlist	(meb)

; *****-----*****-----*****-----*****-----*****-----*****
3$:	.assume 3$ - 2$ - 6	; Incorrect Byte Count
	.list	(!,err,loc,bin,cyc,lin,src,me)
;	.list	(!,err,loc,bin,cyc,lin,src,me)
	tst	3,"Hello"
	.nlist	(me)

; *****-----*****-----*****-----*****-----*****-----*****
4$:	.assume	4$ - 3$ - 6	; Incorrect Byte Count
	.list	(!,err,loc,bin,cyc,lin,src,me,meb)
;	.list	(!,err,loc,bin,cyc,lin,src,me,meb)
;		(meb) Is Superfluous
	tst	4,"Hello"
	.nlist	(me,meb)

; *****-----*****-----*****-----*****-----*****-----*****
5$:	.assume	5$ - 4$ - 6	; Incorrect Byte Count
	.list
;	.list
;	Nothing From The Macro Will Be Listed
	tst	5,"Hello"

; *****-----*****-----*****-----*****-----*****-----*****
6$:	.assume	6$ - 5$ - 6	; Incorrect Byte Count
	.list	(meb)
;	.list	(meb)
;	Only Generated Binary Will Be Listed
	tst	6,"Hello"
	.nlist	(meb)

; *****-----*****-----*****-----*****-----*****-----*****
7$:	.assume	7$ - 6$ - 6	; Incorrect Byte Count
	.list	(me)
;	.list	(me)
	tst	7,"Hello"
	.nlist	(me)

; *****-----*****-----*****-----*****-----*****-----*****
8$:	.assume	8$ - 7$ - 6	; Incorrect Byte Count
	.list	(me,meb)
;	.list	(me,meb)
;		(meb) Is Superfluous
	tst	8,"Hello"
	.nlist	(me,meb)

; *****-----*****-----*****-----*****-----*****-----*****
9$:	.assume	9$ - 8$ - 6	; Incorrect Byte Count
	.list
;	.list
;	Nothing From The Macro Will Be Listed
	tst	9,"Hello"

; *****-----*****-----*****-----*****-----*****-----*****
10$:	.assume	10$ - 9$ - 6	; Incorrect Byte Count
endt1:
; *****-----*****-----*****-----*****-----*****-----*****

	.sbttl	Macro Listing Control Internal To The Macro

	; Reset Listing To List All
	.nlist	(!)

	.macro	tst1	a,b,?c
;	 comment	; Enabled By (me)
c:	 .byte	a	; Enabled By (me)
;	 comment	; Enabled By (me)
	 .ascii	b	; Enabled By (me)
	.endm

; *****-----*****-----*****-----*****-----*****-----*****
1$:	.assume	1$ - endt1		; Incorrect Byte Count
	.list
	.nlist	(lin)			; Inhibit Line Number Listing
;	.list
;	Nothing From The Macro Will Be Listed
	tst1	1,"Hello"

; *****-----*****-----*****-----*****-----*****-----*****

	; Reset Listing To List All
	.nlist	(!)

	.macro	tst2	a,b,?c
	 .list	(meb)
;	 comment	; Enabled By (me)
c:	 .byte	a	; Enabled By (me)
;	 comment	; Enabled By (me)
	 .ascii	b	; Enabled By (me)
	.endm

; *****-----*****-----*****-----*****-----*****-----*****
2$:	.assume	2$ - 1$ - 6		; Incorrect Byte Count
	.list
	.nlist	(lin)			; Inhibit Line Number Listing
;	.list
;	.nlist	(lin)			; Inhibit Line Number Listing
;	Only Generated Binary Will Be Listed [internal (meb)]
	tst2	2,"Hello"

; *****-----*****-----*****-----*****-----*****-----*****

	; Reset Listing To List All
	.nlist	(!)

	.macro	tst3	a,b,?c
	 .list	(me)
;	 comment	; Enabled By (me)
c:	 .byte	a	; Enabled By (me)
;	 comment	; Enabled By (me)
	 .ascii	b	; Enabled By (me)
	.endm

; *****-----*****-----*****-----*****-----*****-----*****
3$:	.assume	3$ - 2$ - 6		; Incorrect Byte Count
	.list
	.nlist	(lin)			; Inhibit Line Number Listing
;	.list
;	.nlist	(lin)			; Inhibit Line Number Listing
;	General Listing [internal (me)]
	tst3	3,"Hello"

; *****-----*****-----*****-----*****-----*****-----*****

	; Reset Listing To List All
	.nlist	(!)

	.macro	tst4	a,b,?c
	 .list	(me,meb)
;	 comment	; Enabled By (me)
c:	 .byte	a	; Enabled By (me)
;	 comment	; Enabled By (me)
	 .ascii	b	; Enabled By (me)
	.endm

; *****-----*****-----*****-----*****-----*****-----*****
4$:	.assume	4$ - 3$ - 6		; Incorrect Byte Count
	.list
	.nlist	(lin)			; Inhibit Line Number Listing
;	.list
;	.nlist	(lin)			; Inhibit Line Number Listing
;	General Listing [internal (me,meb)] (meb) is superfluous
	tst4	4,"Hello"

; *****-----*****-----*****-----*****-----*****-----*****


	.end
