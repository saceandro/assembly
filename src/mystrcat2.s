	.globl mystrcat
mystrcat:			# r3に文字列s1の先頭文字へのポインタが、r4に文字列s2の先頭文字へのポインタが入った状態で呼ばれる。
	li 5, 0			# r5をs1の先頭から何文字目かのカウンタとし、初めは0とする。
.loop1:				# s1の先頭から、ヌル文字までのループ処理
	lbzx 6, 3, 5		# s1のr5文字目を、r6にロード
	cmpdi 7, 6, 0		# r6がヌル文字かどうか
	beq 7, .loop2		# r6がヌル文字ならば、.loop2へ分岐
	addi 5, 5, 1		# カウンタを1増やす
	b .loop1		# loop1を繰り返す
.loop2:				# s2の先頭から、ヌル文字までのループ処理
	lbz 6, 0(4)		# s2の文字をr6にロード
	stbx 6, 3, 5		# r6の下1byteをr3とr5の和のアドレスのメモリに格納。つまり、s2の文字を、s1の末尾にコピーしている。
	cmpdi 7, 6, 0		# r6がヌル文字かどうか
	beqlr 7			# r6がヌル文字ならば、LR分岐で呼び出し元に戻る。
	addi 4, 4, 1		# r6がヌル文字でなければ、s2の次の文字に移る。
	addi 5, 5, 1		# r6がヌル文字でなければ、r5を1増やす
	b .loop2		# loop2を繰り返す
