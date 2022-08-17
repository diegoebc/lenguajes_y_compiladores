## Script para Unix
flex Lexico.l
echo "FLEX compilo el lexico del archivo Lexico.l (se creo un archivo lex.yy.c)"
bison -dyv Sintactico.y
echo "BISON compilo el sintactico del archivo Sintactico.y (se crearon los archivos y.tab.c, y.tab.h, y.output)"
gcc lex.yy.c y.tab.c -o compilado
echo "C compilo el archivo los archivos lex.yy.c, y.tab.c (se creo un ejecutable compilado.exe)"
./compilado.exe prueba.txt
echo "Se completo la ejecucion del analizador lexico y sintactico sobre el archivo prueba.txt"
rm lex.yy.c
rm y.tab.c
rm y.tab.h
rm compilado 
echo "Se eliminaron los archivos generados \"lex.yy.c\", \"y.tab.c\", \"y.tab.h\", \"compilado.exe\""