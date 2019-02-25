	.align 2
	.globl inner
inner:				# r3,r4に各々ベクトルx,yが入った状態で呼ばれる。
	li 5,0			# ベクトルの要素を数えるカウンタとして、また、f1を0.0で初期化する準備として、r5に0を格納。
	std 5,-16(1)		# スタックを利用して、SP-16のメモリにr5(64bit整数0)を格納する。
	stdu 1,-16(1)		# SPの内容を、SP-16のメモリに格納し、更にSPの値を、SP-16で置き換える。これにより、8+8(アライメントのためのパディング) = 16byteのスタックが確保される。
	lfd 1,-16(1)		# 上で格納したものを、浮動小数(double)としてf1にロードする。これにより、f1は0.0で初期化される。
	li 0,4			# r0に4を格納。
	mtctr 0			# カウンタレジスタ(CTR)を、4にする。
.loop:
	lfdx 2,3,5		# ベクトルxの(r5/8)番目の要素を、f2にロードする。
	lfdx 3,4,5		# ベクトルyの(r5/8)番目の要素を、f3にロードする。
	fmadd 1,2,3,1		# f2 * f3 + f1 を、f1に格納。つまり、f1に、f2 * f3を加える。
	addi 5,5,8		# ベクトルの要素を数えるカウンタr5を、8増やす。(x,yは、64bit(8byte)整数配列であるから。)
	bdnz .loop		# CTRを1減らして、0でなければ、.loopに分岐してループ処理。
	addi 1,1,16		# SPの値を、元の値に戻す。
	blr			# 呼び出し元に分岐。返り値f1には、xとyの内積が入っている。
