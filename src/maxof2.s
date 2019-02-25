	.align 2
	.global maxof2
maxof2:	
	cmpd 5,3,4
	bgelr 5
	mr 3,4
	blr
