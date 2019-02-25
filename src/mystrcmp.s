	.globl mystrcmp
mystrcmp:
	lbz 5, 0(3)
	lbz 6, 0(4)
	cmpd 7, 5, 6
	bne 7, .notequal
	cmpdi 7, 5, 0
	bne 7, .add
	li 3, 0
	extsw. 3, 3
	blr
.add:
	addi 3, 3, 1
	addi 4, 4, 1
	b mystrcmp
.notequal:
	sub 3, 5, 6
	extsw. 3, 3
	blr
