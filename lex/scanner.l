%{
#include <stdio.h>
#include "token.h"
%}

%option noyywrap


%% 

NUM     [0-9]
LETRA   [a-zA-Z]
INT     \#{NUM}+
CHAR    \'({LETRA}|{NUM})\'
STRING  \"({LETRA}|{NUM})+\"


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

","     { return yytext[0]; }
";"     { return yytext[0]; }
":"     { return yytext[0]; }
"("     { return yytext[0]; }
")"     { return yytext[0]; }
"["     { return yytext[0]; }
"]"     { return yytext[0]; }
"{"     { return yytext[0]; }
"}"     { return yytext[0]; }
"="     { return yytext[0]; }
"+"     { return yytext[0]; }
"-"     { return yytext[0]; }
"*"     { return yytext[0]; }
"/"     { return yytext[0]; }
"%"     { return yytext[0]; }
"<"     { return yytext[0]; }
">"     { return yytext[0]; }
"&"     { return yytext[0]; }
"|"     { return yytext[0]; }
"~"     { return yytext[0]; }

%%