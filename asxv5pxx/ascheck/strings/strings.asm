	.title	Testing String Functionality

	.ascii	//
	.asciz	//
	.ascis	//

	.ascii	/Hello World/
	.asciz	/Hello World/
	.ascis	/Hello World/

	.ascii	/Start/?Stop?
	.asciz	/Start/?Stop?
	.ascis	/Start/?Stop?

	.ascii	(13)
	.asciz	(13)
	.ascis	(13)

	.ascii	(13)(10)
	.asciz	(13)(10)
	.ascis	(13)(10)

	.ascii	/Hello World/(13)(10)/Goodbye World/(13)(10)
	.asciz	/Hello World/(13)(10)_Goodbye World_(13)(10)
	.ascis	/Hello World/(13)(10)"Goodbye World"(13)(10)

	.ascii	/Hello World/(13)(2*5)/Goodbye World/(10+3)(10)

	.end
