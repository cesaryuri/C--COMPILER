%{
#include <stdio.h>
#include "token.h"

// Protótipos de funções
void yyerror(const char *s);
int yylex(void);
extern int yylineno;  // Importa yylineno do lexer
%}

%token KW_CHAR
%token KW_INT
%token KW_IF
%token KW_THEN
%token KW_ELSE
%token KW_WHILE
%token KW_READ
%token KW_PRINT
%token KW_RETURN
%token TK_IDENTIFIER
%token LIT_INT
%token LIT_CHAR
%token LIT_STRING
%token TOKEN_ERROR

%left '+' '-'
%left '*' '/'
%left '&' '|'
%left '~'

%%

program:
    function
    ;

function:
    KW_INT TK_IDENTIFIER '(' ')' '{' statements '}'
    ;

statements:
    statement
    | statements statement
    ;

statement:
    declaration ';'
    | assignment ';'
    | if_statement
    | while_statement
    | return_statement ';'
    ;

declaration:
    type TK_IDENTIFIER
    ;

type:
    KW_INT
    | KW_CHAR
    ;

assignment:
    TK_IDENTIFIER '=' expression
    ;

if_statement:
    KW_IF '(' expression ')' '{' statements '}' KW_ELSE '{' statements '}'
    ;

while_statement:
    KW_WHILE '(' expression ')' '{' statements '}'
    ;

return_statement:
    KW_RETURN expression
    ;

expression:
    LIT_INT
    | LIT_CHAR
    | LIT_STRING
    | TK_IDENTIFIER
    | expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | expression '&' expression
    | expression '|' expression
    | '~' expression
    | '(' expression ')'
    ;

%%

int main(int argc, char **argv) {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe na linha %d: %s\n", yylineno, s);
}