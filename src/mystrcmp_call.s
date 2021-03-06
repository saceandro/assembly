	.align 2
	.globl mystrcmp2
mystrcmp2:
	mflr 0			# リンクレジスタ(LR)の内容を、r0に格納する。
	std 0, 16(1)		# r0(LRの内容になっている)を、スタックポインタ(SP)+16のメモリに退避する。
	std 14, -16(1)		# SP-16のメモリは、後にmystrcmp2スタックの不揮発性レジスタ保存領域となるので、不揮発性レジスタr14の値を、その場所に退避しておく。
	std 15, -8(1)		# SP-8のメモリは、後にmystrcmp2スタックの不揮発性レジスタ保存領域となるので、不揮発性レジスタr15の値を、その場所に退避しておく。
	stdu 1, -128(1)		# SPの内容を、SP-128のメモリに格納し、更にSPの値を、SP-128で置き換える。これにより、mystrcmp2用に、128byteのスタック領域が確保される。
	mr 14, 3		# 第一引数の文字列str1の先頭文字へのポインタが入ったr3(揮発性)が、mystrlenで書き換えられてもよいように、先ほど準備したr14にコピー。
	mr 15, 4		# 第二引数の文字列str2の先頭文字へのポインタが入ったr4(揮発性)が、mystrlenで書き換えられてもよいように、先ほど準備したr15にコピー。
	mr 3, 4			# str2の長さを求めるため、r4をr3にコピーしてmystrlenに渡す。
	bl mystrlen		# mystrlenへ分岐。r3に、str2の長さが入った状態で戻ってくる。
	nop			# リンカが命令を差し挟む可能性があるので、入れておく。
	mr 4, 3			# str2の長さをr4にコピー
	li 5, 0			# r5を、先頭からの文字数のカウンタとして用いるため、0で初期化。
.loop:				# str1とstr2の文字に違いが出る(str1が先に終端文字に達した場合も含む)か、あるいはstr2の終端文字に辿り着くまでループ
	cmpd 6, 4, 5		# r4とr5を比較。
	beq 6, .nxt		# r4=r5ならは、str2の終端文字に到達したので、.nxtへ分岐
	lbzx 6, 5, 14		# str1のr5文字目を、r6にロード
	lbzx 7, 5, 15		# str2のr5文字目を、r7にロード
	sub 3, 6, 7		# r6-r7を、r3に格納
	cmpwi 6, 3, 0		# r3と0を比較
	bne 6, .last		# r3が0でなければ、r3がstrcmp2の返すべき値であるので、.lastへ分岐
	addi 5, 5, 1		# r3が0のとき、次の文字を比較する必要があるため、r5を1増やす。
	b .loop			# ループ処理
.nxt:				# ここにジャンプしてきたときには、str2は終端文字(0)になっている。
	lbzx 3, 5, 14		# str1が終端文字に達していなければ、その文字は正の値をもつ。もしstr1も終端文字に達していれば、その文字の値は0である。いずれにせよ、str1の文字を返せば、mystrcmp2の返り値として正しい。
.last:				# 復帰処理
	addi 1, 1, 128		# SPの値を、128だけ増やす(元のアドレスに戻す)。
	ld 0, 16(1)		# SP+16のアドレスにあるメモリの内容(64bit)を、r0にロードする。そこには、関数先頭で退避しておいたLRの値が入っている。
	mtlr 0			# LRを、r0で置き換える。つまり、LRを元の内容に復帰する。LRは、mystrlenからmystrcmp2へ戻るための内容になっているため、ここでLRを復帰しておかないと、mystrcmp2の呼びだし元に戻れない。
	ld 14, -16(1)		# SP-16(関数の初めの方で、r14を退避しておいた場所)のメモリの内容を、r14に格納する。不揮発性レジスタの復帰処理。
	ld 15, -8(1)		# SP-8(関数の初めの方で、r15を退避しておいた場所)のメモリの内容を、r15に格納する。不揮発性レジスタの復帰処理。
	blr			# mystrcmp2の呼び出し元へLR分岐
