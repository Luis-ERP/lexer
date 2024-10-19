%{
#include "y.tab.h"
#include <stdio.h>
%}

%%

" "             ;
"//".*          { return COMMENT; }
"f"             { return FLOATDCL; }
"i"             { return INTDCL; }
"p"             { return PRINT; }
"="             { return ASSIGN; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return TIMES; }
"/"             { return AMONG; }
[0-9]+\.[0-9]+  { yylval.fval = atof(yytext); return FNUM; }
[0-9]+          { yylval.ival = atoi(yytext); return INUM; }
[a-zA-Z]        { return ID; }
.               { return UNKNOWN; }

%%

int yywrap(void) {
    return 1;
}
