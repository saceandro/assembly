	.align 2
	.globl maxof3
maxof3:
	mflr 0			; リンクレジスタ(LR)の内容を、r0に格納する。
	std 0, 16(1)		; r0(LRの内容になっている)を、スタックポインタ(SP)+16のメモリに退避する。
	std 14, -16(1)		; SP-16のメモリは、後にmaxof3スタックの不揮発性レジスタ保存領域となるので、不揮発性レジスタr14の値を、その場所に退避しておく。
	stdu 1, -112(1)		; SPの内容を、SP-112のメモリに格納し、更にSPの値を、SP-112で置き換える。これにより、maxof3用に、48+64 = 112byteの、最低限のスタックが確保される。
	mr 14, 5		; 3番目の引数が入っているr5は揮発性レジスタなので、maxof2内で書き換えられても大丈夫なように、r5を先ほど用意したr14にコピーする。
	bl maxof2		; maxof2関数に分岐(r3に第一引数、r4に第二引数が入った状態で渡される)。
	nop			; リンカが命令を差し挟む可能性があるので、入れておく。
	mr 4, 14		; maxof2関数の返り値(第一引数と第二引数の最大値)はr3に入っている。r4に第三引数を与えてmaxof2に渡すため、先ほどr5の内容をコピーしておいたr14を、r4にコピーする。
	bl maxof2		; maxof2関数に分岐(返り値はr3に入り、これは3つの引数の最大値となるため、そのままmaxof3の返り値になる。)
	nop			;
	addi 1, 1, 112		; SPの値を、112だけ増やす(元のアドレスに戻す)。
	ld 0, 16(1)		; SP+16のアドレスにあるメモリの内容(64bit)を、r0にロードする。そこには、関数先頭で退避しておいたLRの値が入っている。
	mtlr 0			; LRを、r0で置き換える。つまり、LRを元の内容に復帰する。LRは、maxof2からmaxof3へ戻るための内容になっているため、ここでLRを復帰しておかないと、maxof3の呼びだし元に戻れない。
	ld 14, -16(1)		; SP-16(関数の初めの方で、r14を退避しておいた場所)のメモリの内容を、r14に格納する。つまり、不揮発性レジスタの復帰処理。
	blr			; maxof3の呼び出し元に分岐