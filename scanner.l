%{
#include <stdio.h>
%}

%%
[0-9]+  { printf("Número: %s\n", yytext); }
[a-zA-Z]+  { printf("Palavra: %s\n", yytext); }
\n  { /* Ignorar novas linhas */ }
.   { printf("Caractere desconhecido: %s\n", yytext); }
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}