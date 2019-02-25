	.globl mystrcmp
mystrcmp:			# r3に文字列str1の先頭文字へのポインタが、r4に文字列str2の先頭文字へのポインタが入った状態で呼ばれる。
	mr 5, 3			# 文字列str1の先頭文字へのポインタを、r5に保存する。
	li 8, 0			# r8を先頭から何文字目かを数えるカウンタとして使用し、初めは0とする。
.loop:				# 以下ループ処理
	lbzx 6, 4, 8		# r6に、str2のr8文字目をロード
	lbzx 7, 5, 8		# r7に、str1のr8文字目をロード
	sub 3, 7, 6		# r7とr6との差をr3に格納
	extsw. 3, 3		# 返り値はint型であるため、r3の下32bitを符号拡張
	cmpwi 7, 3, 0		# r3が0かどうか、つまりr7とr6が等しいかどうかを、r7に格納
	bnelr 7			# r3が0でないならば、文字が一致しなかったということなので、そのままr3を返り値とする。
	cmpwi 7, 6, 0		# r3が0ならば、文字が一致したということであるので、その文字がヌル文字かどうかを調べる。
	beqlr 7			# 一致した文字がヌル文字であれば、r3(0)を返り値とする。
	addi 8, 8, 1		# 一致した文字がヌル文字でなければ、更につぎの文字を比較するため、カウンタr8を1増やす。
	b .loop			# .loopへ分岐
