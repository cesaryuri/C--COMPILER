@echo off

echo Compilando o scanner...
flex scanner.l

echo Compilando o main e o lex.yy.c ...
gcc lex.yy.c main.c -o scanner

echo Executando o scanner...
.\scanner.exe

echo Limpando terminal...
cd clear

exit