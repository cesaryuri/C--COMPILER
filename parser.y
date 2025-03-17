%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Prototipos de funcoes
void yyerror(const char *s);
int yylex(void);
extern int yylineno;

int error_count = 0;

typedef struct {
    char *type; // "int" ou "char"
} TypeInfo;

#define YYSTYPE TypeInfo
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
    | FUNC_DECL
    | COMENT
    | error ';'  // TK de sinc
    | error '}'  // TK de sinc
    ;

CMD_IF:
    KW_IF E KW_THEN BLOCO
    | KW_IF E KW_THEN BLOCO KW_ELSE BLOCO %prec KW_ELSE
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
    ;

ATT_ID:
    TK_IDENTIFIER '=' E
    {
        if (strcmp($3.type, "int") != 0) {
            yyerror("Atribuicao invalida: tipo esperado 'int'");
        }
    }
    | TK_IDENTIFIER '[' E ']' '=' E
    {
        if (strcmp($3.type, "int") != 0 || strcmp($6.type, "int") != 0) {
            yyerror("Indice ou valor invalido: tipo esperado 'int'");
        }
    }
    ;

DECL:
    TIPO TK_IDENTIFIER
    {
        $$.type = strdup($1.type); // tipo da variavel
    }
    | TIPO TK_IDENTIFIER '=' E
    {
        if (strcmp($1.type, $4.type) != 0) {
            yyerror("Declaracao invalida: tipos incompativeis");
        }
        $$.type = strdup($1.type);
    }
    | TIPO TK_IDENTIFIER '[' E ']'
    {
        if (strcmp($4.type, "int") != 0) {
            yyerror("Indice de array deve ser 'int'");
        }
        $$.type = strdup($1.type);
    }
    | TIPO TK_IDENTIFIER '[' E ']' '=' '{' LISTA_E '}'
    {
        if (strcmp($4.type, "int") != 0) {
            yyerror("Indice de array deve ser 'int'");
        }
        $$.type = strdup($1.type);
    }
    ;

LISTA_E:
    E
    {
        $$.type = strdup($1.type);
    }
    | E ',' LISTA_E
    {
        $$.type = strdup($1.type);
    }
    ;

LISTA_DECL:
    TIPO TK_IDENTIFIER ',' LISTA_DECL
    {
        $$.type = strdup($1.type);
    }
    | TIPO TK_IDENTIFIER
    {
        $$.type = strdup($1.type);
    }
    | 
    ;

BLOCO:
    '{' LISTA_COMANDOS '}'
    ;

E:  E '>' E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '>' requer operandos 'int'");
            $$.type = strdup("int"); // Continua com tipo int para recuperacao
        } else {
            $$.type = strdup("int");
        }
    }
    | E '<' E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '<' requer operandos 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '+' E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '+' requer operandos 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '-' E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '-' requer operandos 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '*' E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '*' requer operandos 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '/' E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '/' requer operandos 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E "||" E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '||' requer operandos 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E "&&" E
    {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operacao '&&' requer operandos 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | "~" E
    {
        if (strcmp($2.type, "int") != 0) {
            yyerror("Operacao '~' requer operando 'int'");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | T
    {
        $$.type = strdup($1.type);
    }
    ;

T:
    "true"  { $$.type = strdup("int"); }
    | "false" { $$.type = strdup("int"); }
    | F
    {
        $$.type = strdup($1.type);
    }
    ;

F:
    LIT_INT { $$.type = strdup("int"); }
    | LIT_CHAR { $$.type = strdup("char"); }
    | LIT_STRING { $$.type = strdup("string"); }
    | TK_IDENTIFIER { $$.type = strdup("int"); } //  int por padrao (simplificacao)
    | '(' E ')' { $$.type = strdup($2.type); }
    | '(' E '=' E ')' 
    {
        if (strcmp($2.type, $4.type) != 0) {
            yyerror("Atribuicao em expressao: tipos incompativeis");
        }
        $$.type = strdup($2.type);
    }
    | TK_IDENTIFIER '[' E ']'
    {
        if (strcmp($3.type, "int") != 0) {
            yyerror("Indice de array deve ser 'int'");
        }
        $$.type = strdup("int"); // int para o array (simplificacao)
    }
    ;

TIPO:
    KW_INT { $$.type = strdup("int"); }
    | KW_CHAR { $$.type = strdup("char"); }
    ;

%%

int main(int argc, char **argv) {
    yyparse();
    printf("Analise concluida com %d erros.\n", error_count);
    return 0;
}

void yyerror(const char *s) {
    error_count++;
    fprintf(stderr, "Erro na linha %d: %s\n", yylineno, s);
}