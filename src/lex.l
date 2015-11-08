%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *);
int line_no = 1;
%}

%%

"program"  return(PROGRAM);
"begin"   return(PBEGIN);
"end"   return(END);
"var"   return(VAR);
"integer"   return(INTEGER);
"boolean"   return(BOOLEAN);
"new"   return NEW;
"array"   return(ARRAY);
"of"    return(OF);
"function" return(FUNCTION);
"procedure" return(PROCEDURE);
"and"   return(AND);
"or"    return(OR);
"not"   return(NOT);
"while"   return(WHILE);
"do"    return(DO);
"if"    return(IF);
"then"   return(THEN);
"else"   return(ELSE);

[a-zA-Z]([a-zA-Z0-9])* {yylval.str=strdup(yytext);return(IDENTIFIER);}

":="    return(ASSIGNMENT);
":"    return(COLON);
","    return(COMMA);
[0-9]+    return(DIGSEQ);
"."    return(DOT);
"="    return(EQUAL);
">="    return(GE);
">"    return(GT);
"["    return(LBRAC);
"<="    return(LE);
"("    return(LPAREN);
"<"    return(LT);
"-"    return(MINUS);
"<>"    return(NOTEQUAL);
"+"    return(PLUS);
"]"    return(RBRAC);
[0-9]+"."[0-9]+   return(REALNUMBER);
")"    return(RPAREN);
";"    return(SEMICOLON);
"/"    return(DIV);
"*"    return(MUL);

"{"    { register int c;
    while ((c = input()))
    {
        if (c == '}')
          break;
        else if (c=='\n')
          line_no++;
        else if (c == 0)
          commenteof();
    }
}

[ \t\f]    ;

\n    line_no++;

.    { fprintf (stderr,
            "'%c' (0%o): illegal charcter at line %d\n",
            yytext[0], yytext[0], line_no);
}

%%
commenteof()
{
    fprintf (stderr, "unexpected EOF inside comment at line %d\n",
                line_no);
    exit (1);
}

void yyerror(char *s){
    printf("yyerror:%s at line %d\n",s,line_no);
}

int yywrap ()
{
    return (1);
}
