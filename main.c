#include <stdio.h>
#include "parser.tab.h"

extern int yylex();
extern int yylineno;

int isrunningstatus = 0;

int getLineNumber(void) {
    printf("Total de linhas lidas: %d\n", yylineno);
    return yylineno;  
}

// Função de verificação de execução
int isRunning(void){
    if (yylex() != EOF) {
        isrunningstatus = 1;
    } else {isrunningstatus = 0;}

    printf("isRunning: %d\n", isrunningstatus);
    return isrunningstatus;
}

int main(int argc, char *argv[]) {
    int token;

    while ((token = yylex()) != EOF) {    
       
        switch (token) {
            case KW_CHAR:
                printf("KW_CHAR: %d\n", token);
                break;
            case KW_INT:
                printf("KW_INT: %d\n", token);
                break;
            case KW_IF:
                printf("KW_IF: %d\n", token);
                break;
            case KW_THEN:
                printf("KW_THEN: %d\n", token);
                break;
            case KW_ELSE:
                printf("KW_ELSE: %d\n", token);
                break;
            case KW_WHILE:
                printf("KW_WHILE: %d\n", token);
                break;
            case KW_READ:
                printf("KW_READ: %d\n", token);
                break;
            case KW_PRINT:
                printf("KW_PRINT: %d\n", token);
                break;
            case KW_RETURN:
                printf("KW_RETURN: %d\n", token);
                break;
            case TK_IDENTIFIER:
                printf("TK_IDENTIFIER: %d\n", token);
                break;
            case LIT_INT:
                printf("LIT_INT: %d\n", token);
                break;
            case LIT_CHAR:
                printf("LIT_CHAR: %d\n", token);
                break;
            case LIT_STRING:
                printf("LIT_STRING: %d\n", token);
                break;
            case TK_ERROR:
                printf("TOKEN_ERROR: %d\n", token);
                break;
            case ',':
                printf("COMMA: %d\n", token);
                break;
            case ';':
                printf("SEMICOLON: %d\n", token);
                break;
            case ':':
                printf("COLON: %d\n", token);
                break;
            case '(':
                printf("LEFT_PAREN: %d\n", token);
                break;
            case ')':
                printf("RIGHT_PAREN: %d\n", token);
                break;
            case '[':
                printf("LEFT_BRACKET: %d\n", token);
                break;
            case ']':
                printf("RIGHT_BRACKET: %d\n", token);
                break;
            case '{':
                printf("LEFT_BRACE: %d\n", token);
                break;
            case '}':
                printf("RIGHT_BRACE: %d\n", token);
                break;
            case '=':
                printf("EQUAL: %d\n", token);
                break;
            case '+':
                printf("PLUS: %d\n", token);
                break;
            case '-':
                printf("MINUS: %d\n", token);
                break;
            case '*':
                printf("MULTIPLY: %d\n", token);
                break;
            case '/':
                printf("DIVIDE: %d\n", token);
                break;
            case '%':
                printf("MODULO: %d\n", token);
                break;
            case '<':
                printf("LESS_THAN: %d\n", token);
                break;
            case '>':
                printf("GREATER_THAN: %d\n", token);
                break;
            case '&':
                printf("AMPERSAND: %d\n", token);
                break;
            case '|':
                printf("PIPE: %d\n", token);
                break;
            case '~':
                printf("TILDE: %d\n", token);
                break;
            case 291:
                printf("Comentario do tipo // ==>  %d\n", token);
                break;
            case 292:    
                printf("Comentario do tipo /**... **/ ==>  %d\n", token);
                break;
            case 293:
                printf("Palavra reservada: %d\n", token);
                break;
            default:
                printf("Token desconhecido\n");
                break;
        }


        getLineNumber();
    }
    

    return 0;
}
