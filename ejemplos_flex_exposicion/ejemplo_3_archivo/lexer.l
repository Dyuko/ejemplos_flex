%{
  #include <iostream>
  using namespace std;
  extern "C" int yylex();
%}
%%
[ \t\n]          ;
[0-9]+\.[0-9]+   { cout << "Encontrado un numero punto flotante:" << yytext << endl; }
[0-9]+           { cout << "Encontrado un entero:" << yytext << endl; }
[a-zA-Z0-9]+     { cout << "Encontrado una cadena: " << yytext << endl; }
.                ;
%%
/*Observar que se agrega . a la seccion de tokens, y no se hace nada*/

/*yyin : el puntero de flujo de entrada (es decir, apunta a un archivo de entrada que se va a escanear o tokenizar), 
sin embargo, la entrada predeterminada de main () es stdin.*/
int main(int, char**) {
  
  /*Abrimos el archivo de entrada*/
  FILE *myfile = fopen("entrada", "r");
  /*Verificamos que se haya abierto correctamente*/
  if (!myfile) {
    cout << "No se pudo abrir el archivo entrada" << endl;
    return -1;
  }
  /*Modificamos yyin para reemplazar stdin de forma predeterminada*/
  yyin = myfile;    /*yylex lee del archivo almacenado en la variable yyin*/
  
  //Durante la entrada 
  yylex();   /*Cada vez que su programa llama a yylex, devuelve el siguiente token */
}