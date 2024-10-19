all: tokenizer

tokenizer: lex.yy.c y.tab.c y.tab.h
	gcc -o tokenizer y.tab.c lex.yy.c -ll

lex.yy.c: tokens.l y.tab.h
	lex tokens.l

y.tab.c y.tab.h: tokens.y
	yacc -d tokens.y

clean:
	rm -f lex.yy.c y.tab.c y.tab.h tokenizer