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
STRING          ["]{ALLCHAR}+["]
IDENTIFIER      [a-zA-Z]*[LETRA0-9]*


%% 
char    { return KW_CHAR; }
int     { return KW_INT; }
if      { return KW_IF; }
else    { return KW_ELSE; }
then    { return KW_THEN; }
while   { return KW_WHILE; }
read    { return KW_READ; }
print   { return KW_PRINT; }
return  { return KW_RETURN; }
main    { return KW_MAIN;}

{INT}           {return LIT_INT;}
{CHAR}          {return LIT_CHAR;}
{STRING}        {return LIT_STRING;}
{ESPECIALCHAR}  {return yytext[0];}
{IDENTIFIER}    {return TK_IDENTIFIER;}


"//".*      { 
              return TK_SCOMENT;  
            }

"/**"   { // reconhecer comentario
            while (1) {
                int c = input();
                if (c == '*' && input() == '*' && input() == '/') break;
                if (c == 0) break; // EOF
            }
            return TK_MCOMENT;
        }


[[:space:]]+    {/* Ignorar espaços em branco */}
.               { return TK_ERROR; }

%%