	.align 2
	.globl mulmat
mulmat:				# r3, r4, r5に、各々c(aとbの乗算の結果を格納する配列), a, bが入った状態で呼ばれる。
	li 6, 0			# i*4
.loop1:
	li 7, 0			# j
.loop2:
	li 8, 0			# k
	std 8, -8(1)		# スタックを利用して、SP-8のメモリに64bit整数0(r8)を格納する。
	lfd 1, -8(1)		# 上で格納したものを、64bit浮動小数としてf1にロードする。f1 <- 0.0
.loop3:
	add 10, 6, 8		# i*4+k
	lfdx 2, 4, 10		# f2 <- a[i*4+k]
	mulli 9, 8, 4		# k*4
	add 10, 9, 7		# k*4+j
	lfdx 3, 5, 10		# f3 <- b[k*4+j]
	fmadd 1, 2, 3, 1	# f1 <- a[i*4+k] * b[k*4+j] + f1
	addi 8, 8, 8		# k++
	cmpdi 8, 32
	bne 0, .loop3		# kのループ(.loop3)が4周するまで、ループ処理を行う。
	add 10, 6, 7		# i*4+j
	stfdx 1, 3, 10		# f1 -> c[i*4+j]
	addi 7, 7, 8		# j++
	cmpdi 7, 32
	bne 0, .loop2		# jのループ(.loop2)が4周するまで、ループ処理を行う。
	addi 6, 6, 32		# i++
	cmpdi 6, 128
	bne 0, .loop1		# iのループ(.loop1)が4周するまで、ループ処理を行う。
	blr
