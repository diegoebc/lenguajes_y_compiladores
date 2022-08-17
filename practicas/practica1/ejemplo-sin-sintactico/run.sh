flex lexico.l
gcc lex.yy.c -o compilado
./compilado fuente.txt

rm -f compilado
rm -f lex.yy.c