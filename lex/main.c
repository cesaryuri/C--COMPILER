#include <stdio.h>
#include "token.h"

// Declaração da função yylex gerada pelo Flex
extern int yylex();

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
            case TOKEN_ERROR:
                printf("TOKEN_ERROR: %d\n", token);
                break;
            case ',':
                printf("COMMA\n");
                break;
            case ';':
                printf("SEMICOLON\n");
                break;
            case ':':
                printf("COLON\n");
                break;
            case '(':
                printf("LEFT_PAREN\n");
                break;
            case ')':
                printf("RIGHT_PAREN\n");
                break;
            case '[':
                printf("LEFT_BRACKET\n");
                break;
            case ']':
                printf("RIGHT_BRACKET\n");
                break;
            case '{':
                printf("LEFT_BRACE\n");
                break;
            case '}':
                printf("RIGHT_BRACE\n");
                break;
            case '=':
                printf("EQUAL\n");
                break;
            case '+':
                printf("PLUS\n");
                break;
            case '-':
                printf("MINUS\n");
                break;
            case '*':
                printf("MULTIPLY\n");
                break;
            case '/':
                printf("DIVIDE\n");
                break;
            case '%':
                printf("MODULO\n");
                break;
            case '<':
                printf("LESS_THAN\n");
                break;
            case '>':
                printf("GREATER_THAN\n");
                break;
            case '&':
                printf("AMPERSAND\n");
                break;
            case '|':
                printf("PIPE\n");
                break;
            case '~':
                printf("TILDE\n");
                break;
            default:
                printf("Token desconhecido\n");
                break;
        }
    }
}
