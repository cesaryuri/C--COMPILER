%{
#include <stdio.h>
#include "parser.tab.h"

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
%token KW_MAIN
%token TK_IDENTIFIER
%token LIT_INT
%token LIT_CHAR
%token LIT_STRING
%token TK_ERROR
%token TK_SCOMENT
%token TK_MCOMENT

%left "||"
%left "&&"
%right "~"
%left '>' '<'
%left '+' '-'
%left '*' '/'
%left '[' ']'
%left '{' '}'
%left '(' ')'
%left '"' 
%%

program:
    LISTA_COMANDOS
    ;

LISTA_COMANDOS:
    LISTA_COMANDOS COMANDO
    | 
    ;

COMANDO:
    CMD_IF
    | CMD_WHILE
    | CMD_PRINT ';' 
    | CMD_READ ';' 
    | CMD_FUNC 
    | ATT_ID ';' 
    | DECL ';' 
    | BLOCO
    | FUNC_DECL
    | COMENT
    ;

CMD_IF:
    KW_IF E KW_THEN BLOCO
    | KW_IF E KW_THEN BLOCO KW_ELSE BLOCO
    ;

CMD_WHILE:
    KW_WHILE E BLOCO
    ;

CMD_FUNC:
    TIPO TK_IDENTIFIER '(' LISTA_E ')' BLOCO
    | TK_IDENTIFIER '(' ')' BLOCO
    ;

FUNC_DECL:
    TIPO TK_IDENTIFIER '(' LISTA_DECL ')' BLOCO 
    | KW_INT KW_MAIN '(' LISTA_DECL ')' BLOCO 
    ;

CMD_PRINT:
    KW_PRINT LIT_STRING
    ;

CMD_READ:
    KW_READ TK_IDENTIFIER
    ;

COMENT:
    TK_SCOMENT
    | TK_MCOMENT

ATT_ID:
    TK_IDENTIFIER '=' E
    | TK_IDENTIFIER '[' E ']' '=' E
    ;

DECL:
    TIPO TK_IDENTIFIER
    | TIPO TK_IDENTIFIER '=' E
    | TIPO TK_IDENTIFIER '[' E ']'
    | TIPO TK_IDENTIFIER '[' E ']' '=' '{' LISTA_E '}'
    ;

LISTA_E:
    E
    | E ',' LISTA_E
    ;

LISTA_DECL:
    TIPO TK_IDENTIFIER ',' LISTA_DECL
    | TIPO TK_IDENTIFIER
    | 
    ;

BLOCO:
    '{' LISTA_COMANDOS '}'
    ;

E:  E '>' E
    | E '<' E
    | E '+' E
    | E '-' E
    | E '*' E
    | E '/' E
    | E "||" E
    | E "&&" E
    | "~" E
    | T
    ;

T:
    "true"
    | "false"
    | F
    ;

F:
    LIT_INT
    | LIT_CHAR
    | LIT_STRING
    | TK_IDENTIFIER
    | '(' E ')'
    |'(' E '=' E ')'
    | TK_IDENTIFIER '[' E ']'
    ;

TIPO:
    KW_INT
    | KW_CHAR
    ;

%%

int main(int argc, char **argv) {
    yyparse();
    printf("Análise concluída com sucesso!\n");
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro de sintaxe na linha %d: %s\n", yylineno , s);
}