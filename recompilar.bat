@echo off

echo Compilando o scanner...
flex scanner.l
bison -d parser.y

echo Compilando o main e o lex.yy.c ...
gcc lex.yy.c main.c -o scanner
gcc lex.yy.c parser.tab.c -o compilador

echo Executando o scanner...
.\scanner.exe
.\compilador

echo Limpando terminal...
cd clear

exit