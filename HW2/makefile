all:	clean y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c -lfl -o test

y.tab.c:
	bison -y -d B062040027.y

lex.yy.c:
	flex B062040027.l

clean:
	rm -f B062040027 lex.yy.c y.tab.c y.tab.h
