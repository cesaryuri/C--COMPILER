%{
#include <stdio.h>
#include "token.h"
%}

%option noyywrap 

ESPECIALCHAR [";:()\[\]{}=+\-*/%<>&|~"]

ALLCHAR (.)
NUM     [0-9]
LETRA   [a-zA-Z]
INT     [#]{NUM}+
CHAR    [']{ALLCHAR}[']
STRING   ["]{ALLCHAR}+["]
IDENTIFIER [a-zA-Z]*[0-9]*


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
main    { printf("Palavra reservada de tipo %s\n", yytext); }

{INT}           {return LIT_INT;}
{CHAR}          {return LIT_CHAR;}
{STRING}        {return LIT_STRING;}
{ESPECIALCHAR}  {return yytext[0];}
{IDENTIFIER}    {return TK_IDENTIFIER;}

[ \t\n\r]+      {/* Ignorar espaços em branco */}

.               { return TOKEN_ERROR; }

%%