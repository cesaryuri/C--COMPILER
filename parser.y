%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
extern int yylineno;

int error_count = 0;

typedef struct {
    char *type;
} TypeInfo;

#define YYSTYPE TypeInfo
%}

%token KW_CHAR KW_INT KW_IF KW_THEN KW_ELSE KW_WHILE KW_READ KW_PRINT KW_RETURN KW_MAIN
%token TK_IDENTIFIER LIT_INT LIT_CHAR LIT_STRING TK_ERROR TK_SCOMENT TK_MCOMENT

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

program: LISTA_COMANDOS;

LISTA_COMANDOS:
    LISTA_COMANDOS COMANDO
    | /* vazio */
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
    | error ';' { yyerror("Invalid command"); yyerrok; }
    ;

CMD_IF:
    KW_IF E KW_THEN BLOCO
    | KW_IF E KW_THEN BLOCO KW_ELSE BLOCO
    ;

CMD_WHILE: KW_WHILE E BLOCO;

CMD_FUNC:
    TIPO TK_IDENTIFIER '(' LISTA_E ')' BLOCO
    | TK_IDENTIFIER '(' ')' BLOCO
    ;

FUNC_DECL:
    TIPO TK_IDENTIFIER '(' LISTA_DECL ')' BLOCO
    | KW_INT KW_MAIN '(' LISTA_DECL ')' BLOCO
    ;

CMD_PRINT: KW_PRINT LIT_STRING;

CMD_READ: KW_READ TK_IDENTIFIER;

COMENT: TK_SCOMENT | TK_MCOMENT;

ATT_ID:
    TK_IDENTIFIER '=' E {
        if (strcmp($3.type, "int") != 0) {
            yyerror("Invalid assignment: expected type 'int'");
        }
    }
    | TK_IDENTIFIER '[' E ']' '=' E {
        if (strcmp($3.type, "int") != 0 || strcmp($6.type, "int") != 0) {
            yyerror("Invalid index or value: expected type 'int'");
        }
    }
    ;

DECL:
    TIPO TK_IDENTIFIER { $$.type = strdup($1.type); }
    | TIPO TK_IDENTIFIER '=' E {
        if (strcmp($1.type, $4.type) != 0) {
            yyerror("Invalid declaration: incompatible types");
        }
        $$.type = strdup($1.type);
    }
    | TIPO TK_IDENTIFIER '[' E ']' {
        if (strcmp($4.type, "int") != 0) {
            yyerror("Array index must be 'int'");
        }
        $$.type = strdup($1.type);
    }
    | TIPO TK_IDENTIFIER '[' E ']' '=' '{' LISTA_E '}' {
        if (strcmp($4.type, "int") != 0) {
            yyerror("Array index must be 'int'");
        }
        $$.type = strdup($1.type);
    }
    ;

LISTA_E:
    E { $$.type = strdup($1.type); }
    | E ',' LISTA_E { $$.type = strdup($1.type); }
    ;

LISTA_DECL:
    TIPO TK_IDENTIFIER ',' LISTA_DECL { $$.type = strdup($1.type); }
    | TIPO TK_IDENTIFIER { $$.type = strdup($1.type); }
    | /* vazio */
    ;

BLOCO: '{' LISTA_COMANDOS '}';

E:
    E '>' E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '>' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '<' E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '<' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '+' E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '+' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '-' E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '-' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '*' E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '*' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E '/' E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '/' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E "||" E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '||' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | E "&&" E {
        if (strcmp($1.type, "int") != 0 || strcmp($3.type, "int") != 0) {
            yyerror("Operation '&&' requires 'int' operands");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | "~" E {
        if (strcmp($2.type, "int") != 0) {
            yyerror("Operation '~' requires 'int' operand");
            $$.type = strdup("int");
        } else {
            $$.type = strdup("int");
        }
    }
    | T { $$.type = strdup($1.type); }
    | error { yyerror("Invalid expression"); yyerrok; $$.type = strdup("int"); }
    ;

T:
    "true" { $$.type = strdup("int"); }
    | "false" { $$.type = strdup("int"); }
    | F { $$.type = strdup($1.type); }
    ;

F:
    LIT_INT { $$.type = strdup("int"); }
    | LIT_CHAR { $$.type = strdup("char"); }
    | LIT_STRING { $$.type = strdup("string"); }
    | TK_IDENTIFIER { $$.type = strdup("int"); }
    | '(' E ')' { $$.type = strdup($2.type); }
    | '(' E '=' E ')' {
        if (strcmp($2.type, $4.type) != 0) {
            yyerror("Assignment in expression: incompatible types");
        }
        $$.type = strdup($2.type);
    }
    | TK_IDENTIFIER '[' E ']' {
        if (strcmp($3.type, "int") != 0) {
            yyerror("Array index must be 'int'");
        }
        $$.type = strdup("int");
    }
    ;

TIPO:
    KW_INT { $$.type = strdup("int"); }
    | KW_CHAR { $$.type = strdup("char"); }
    ;

%%

int main(int argc, char **argv) {
    yyparse();
    printf("Analysis completed with %d errors.\n", error_count);
    return 0;
}

void yyerror(const char *s) {
    error_count++;
    fprintf(stderr, "Error at line %d: %s\n", yylineno, s);
}