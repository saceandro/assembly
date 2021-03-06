	.align 2
	.globl mystrcmp2
mystrcmp2:
	mflr 0			# リンクレジスタ(LR)の内容を、r0に格納する。
	std 0, 16(1)		# r0(LRの内容になっている)を、スタックポインタ(SP)+16のメモリに退避する。
	std 14, -16(1)		# SP-16のメモリは、後にmystrcmp2スタックの不揮発性レジスタ保存領域となるので、不揮発性レジスタr14の値を、その場所に退避しておく。
	std 15, -8(1)		# SP-8のメモリは、後にmystrcmp2スタックの不揮発性レジスタ保存領域となるので、不揮発性レジスタr15の値を、その場所に退避しておく。
	stdu 1, -128(1)		# SPの内容を、SP-128のメモリに格納し、更にSPの値を、SP-128で置き換える。これにより、mystrcmp2用に、128byteのスタック領域が確保される。
	addi 14, 3, -1		# 第一引数の文字列str1の先頭文字へのポインタが入ったr3(揮発性)が、mystrlenで書き換えられてもよいように、先ほど準備したr14に保存(後のために1引いておく)。
	addi 15, 4, -1		# 第二引数の文字列str2の先頭文字へのポインタが入ったr4(揮発性)が、mystrlenで書き換えられてもよいように、先ほど準備したr15に保存(後のために1引いておく)。
	bl mystrlen		# mystrlenへ分岐。r3に、str1の長さが入った状態で戻ってくる。
	nop			# リンカが命令を差し挟む可能性があるので、入れておく。
	add 4, 14, 3
	addi 4, 4, 1		# r4を、str1の終端文字のメモリアドレスにする。
.loop:				# str1とstr2の文字に違いが出る(str2が先に終端文字に達した場合も含む)か、あるいはstr1の終端文字までループ
	lbzu 6, 1(14)		# str1の次の文字を、r6にロードし、r14にそのメモリアドレスを格納
	lbzu 7, 1(15)		# str2の次の文字を、r7にロードし、r15にそのメモリアドレスを格納
	subf. 3, 7, 6		# r6-r7を、r3に格納して、r3と0の大小を比較
	bne 0, .last		# r3が0でなければ、r3がstrcmp2の返すべき値であるので、.lastへ分岐
	subf. 3, 14, 4		# r4-r14を、r3に格納して、r3と0の大小を比較。r3=0であれば、終端文字まで一致したことになるので、そのまま返す値となっている。
	bgt 0, .loop		# r4>r14であれば、まだstr1の終端文字まで達してないので、ループ処理。
.last:				# 復帰処理
	extsw 3, 3		# 返り値はint型であるため、r3の下32bitを符号拡張
	addi 1, 1, 128		# SPの値を、128だけ増やす(元のアドレスに戻す)。
	ld 0, 16(1)		# SP+16のアドレスにあるメモリの内容(64bit)を、r0にロードする。そこには、関数先頭で退避しておいたLRの値が入っている。
	mtlr 0			# LRを、r0で置き換える。つまり、LRを元の内容に復帰する。LRは、mystrlenからmystrcmp2へ戻るための内容になっているため、ここでLRを復帰しておかないと、mystrcmp2の呼びだし元に戻れない。
	ld 14, -16(1)		# SP-16(関数の初めの方で、r14を退避しておいた場所)のメモリの内容を、r14に格納する。不揮発性レジスタの復帰処理。
	ld 15, -8(1)		# SP-8(関数の初めの方で、r15を退避しておいた場所)のメモリの内容を、r15に格納する。不揮発性レジスタの復帰処理。
	blr			# mystrcmp2の呼び出し元へLR分岐
