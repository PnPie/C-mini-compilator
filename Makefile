CC = gcc
CFLAGS = -W -g
LEX = lex
YACC = yacc

SRC_DIR = ./src
CFILE = lex.yy.c y.tab.c
PROGRAM = prog

all: $(CFILE)
	$(CC) $(CFLAGS) -o $(PROGRAM) $^

lex.yy.c: ${SRC_DIR}/lex.l y.tab.h
	$(LEX) $<

y.tab.c: ${SRC_DIR}/yacc.y
	$(YACC) -d $<

y.tab.h: ${SRC_DIR}/yacc.y

clean:
	rm $(CFILE) y.tab.h
