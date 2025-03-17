%{
#include <stdio.h>
#include "parser.tab.h"
%}

%option noyywrap 
%option yylineno

ESPECIALCHAR [";:()\[\]{}=+\-*/%<>&|~"]
ALLCHAR (.)
NUM             [0-9]
LETRA           [a-zA-Z]
INT             [#]{NUM}+
CHAR            [']{ALLCHAR}[']
STRING          ["]{ALLCHAR}*["]
IDENTIFIER      [a-zA-Z_][a-zA-Z0-9_]*

%% 
char    { return KW_CHAR; }
int     { return KW_INT; }
if      { return KW_IF; }
else    { return KW_ELSE; }
while   { return KW_WHILE; }
read    { return KW_READ; }
print   { return KW_PRINT; }
return  { return KW_RETURN; }

{INT}           { return KW_INT; }  // Alterado: # seguido de números agora é KW_INT
{CHAR}          { return LIT_CHAR; }
{STRING}        { return LIT_STRING; }
{ESPECIALCHAR}  { return yytext[0]; }
{IDENTIFIER}    { return TK_IDENTIFIER; }  // Reconhece identificadores (ex: test)

"//".*          { /* Ignorar comentários de linha */ }
"/*"            { // Ignorar comentário de bloco
                    int c;
                    while ((c = input()) != 0) { // Ler até o final do arquivo (EOF)
                        if (c == '*' && input() == '/') break; // Encontrou o fim do comentário
                    }
                }

[ \t\n]+        { /* Ignorar espaços em branco, tabs e novas linhas */ }
.               { return TOKEN_ERROR; }

%%