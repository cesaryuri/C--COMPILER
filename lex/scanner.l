%{
#include <stdio.h>
#include "token.h"
int linecount = 0;
%}

%option noyywrap 

ESPECIALCHAR [";:()\[\]{}=+\-*/%<>&|~"]

ALLCHAR (.)
NUM             [0-9]
LETRA           [a-zA-Z]
INT             [#]{NUM}+
CHAR            [']{ALLCHAR}[']
STRING          ["]{ALLCHAR}+["]
IDENTIFIER      [a-zA-Z]*[0-9]*
COMMENTS  ([//]{ALLCHAR}+)|([/**]{ALLCHAR}+[**/])
IDFLINE     [\n][[:space:]]+



%% 
{IDFLINE} {
    //identificador de linhas  int getLineNumber(void)
    linecount++;}


char    { return KW_CHAR; }
int     { return KW_INT; }
if      { return KW_IF; }
else    { return KW_ELSE; }
then    { return KW_THEN; }
while   { return KW_WHILE; }
read    { return KW_READ; }
print   { return KW_PRINT; }
return  { return KW_RETURN; }
main    { printf("Palavra reservada: %s\n", yytext);}


{INT}           {return LIT_INT;}
{CHAR}          {return LIT_CHAR;}
{STRING}        {return LIT_STRING;}
{ESPECIALCHAR}  {return yytext[0];}
{IDENTIFIER}    {return TK_IDENTIFIER;}



"//".*         { printf("Comentario do tipo // ==>  %s\n", yytext); }

"/**"   { // reconhecer comentario
            while (1) {
                int c = input();
                if (c == '*' && input() == '*' && input() == '/') break;
                if (c == 0) break; // EOF
            }
            printf("Comentario do tipo /**...**/ \n");
        }


[[:space:]]+    {/* Ignorar espaços em branco */}
.               { return TOKEN_ERROR; }


"int getLineNumber(void)" {//exibir linhas

    printf("Quantidade de linhas: %d\n", linecount);
    linecount = 0;
}


%%