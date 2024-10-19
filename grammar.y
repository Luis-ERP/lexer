%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
%}

%token COMMENT FLOATDCL INTDCL PRINT ASSIGN PLUS MINUS TIMES AMONG INUM FNUM ID UNKNOWN
%union {
    int ival;
    float fval;
}

%%

program:
    | program line
    ;

line:
    COMMENT               {  }
    | FLOATDCL            { printf("FLOATDCL\n"); }
    | INTDCL              { printf("INTDCL\n"); }
    | PRINT               { printf("PRINT\n"); }
    | assignment
    | expr
    ;

assignment:
    ID ASSIGN expr        { printf("Assign: %c = %d\n", $1, $3); }
    ;

expr:
    expr PLUS expr        { $$ = $1 + $3; }
    | expr MINUS expr     { $$ = $1 - $3; }
    | expr TIMES expr     { $$ = $1 * $3; }
    | expr AMONG expr     { $$ = $1 / $3; }
    | INUM                { $$ = $1; }
    | FNUM                { $$ = (int)$1; }
    | ID                  { $$ = $1; }
    ;

%%

int main(void) {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
