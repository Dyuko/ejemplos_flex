%{                          /*Abre delimitador, codigos C que seran directamente copiados*/
  #include <iostream>       /*Para acceder a cout*/
  using namespace std;      /*Para acceder a cout*/
  extern "C" int yylex();   /*Declarar la funcion de flex que llamaremos mas adelante*/
%}                          /*Cierra delimitador*/
/*No buscar la funcion yywrap*/    
%option noyywrap                   
%%                          /*Termina la seccion de control, empieza la de token*/
[ \t\n]         ;
[0-9]+\.[0-9]+  { cout << "Encontrado un numero punto flotante:" << yytext << endl; }
[0-9]+          { cout << "Encontrado un entero:" << yytext << endl; }
[a-zA-Z0-9]+    { cout << "Encontrado una cadena: " << yytext << endl; }
%%                          /*Termina la segunda seccion, empieza la tercera*/
/*Exclusivo para el codigo C, a diferencia de la seccion de control no hay "%{ y %}"*/
int main(int, char**) {         
  // lex through the input:
  while (yylex());
}