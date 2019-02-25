	.globl mystrcat
mystrcat:
	li 5, 0
.loop1:
	lbzx 6, 3, 5
	cmpdi 7, 6, 0
	beq 7, .loop2
	addi 5, 5, 1
	b .loop1
.loop2:
	lbz 6, 0(4)
	cmpdi 7, 6, 0
	beq 7, .last
	stbx 6, 3, 5
	addi 4, 4, 1
	addi 5, 5, 1
	b .loop2
.last:
	stbx 6, 3, 5
	blr
