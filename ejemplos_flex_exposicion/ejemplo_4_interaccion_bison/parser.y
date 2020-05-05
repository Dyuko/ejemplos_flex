/*Lo primero que tenemos que hacer en nuestro analizador es definir los tokens de terminal*/
/*Para nosotros son ints, floats, strings, como se vera a continuacion*/
/*Aunque es Flex el que se da cuenta y devuelve los tokens por tipo, la definicion se hace aqui*/
/*Ademas, el archivo main se coloca aqui*/
%{
  #include <cstdio>
  #include <iostream>
  using namespace std;

  /*Declarar las cosas de Flex que Bison necesita saber*/
  extern "C" int yylex();
  /*yyparse lee tokens, ejecuta acciones y finalmente regresa */
  /*cuando encuentra un fin de entrada o un error de sintaxis irrecuperable*/
  /*es generado por bison*/
  extern int yyparse();
  /*nuestro archivo de entrada*/     
  extern FILE *yyin;
 
  void yyerror(const char *s);
%}

/*Bison funciona fundamentalmente pidiendo a flex que obtenga el siguiente token
que devuelve como un objeto de tipo "yystype". 
Por defecto "yystype" es un tipo de "int"
Los tokens pueden ser de cualquier tipo anulando el typedef predeterminado de yystype 
convirtiendolos en una union de C en su lugar
Las uniones contienen todos los tipos de datos que Flex podría devolver
Esto significa que podemos devolver ints, floats, strings limpiamente
*/

/*Bison implementara este mecanismo con la directiva %union*/
%union {
  int ival;
  float fval;
  char* sval;
}

/*Defina los tipos de token de simbolo terminal que se va a usar,
en mayuscula por convencion, y asocie cada uno con un campo de %union*/
%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING

/*esta es la gramatica que analizara bison
aqui solo un ejemplo para mostrar en la pantalla lo que bison obtiene de flex*/

/*  $1 seria el primer elemento de la regla
    $2 seria el segundo elemento de la regla*/
%%
snazzle:
  snazzle INT {
      cout << "bison found an int: " << $2 << endl;
    }
  | snazzle FLOAT {
      cout << "bison found a float: " << $2 << endl;
    }
  | snazzle STRING {
      cout << "bison found a string: " << $2 << endl; free($2);
    }
  | INT {
      cout << "bison found an int_: " << $1 << endl;
    }
  | FLOAT {
      cout << "bison found a float_: " << $1 << endl;
    }
  | STRING {
      cout << "bison found a string_: " << $1 << endl; free($1);
    }
  ;
%%

int main(int, char**) {
    /*Abrir el archivo*/
    FILE *myfile = fopen("entrada", "r");
    /*Verificar si el archivo se abrio correctamente*/
    if (!myfile) {
        cout << "No se pudo abrir el archivo entrada" << endl;
        return -1;
    }
    /*Establecer como archivo de entrada*/
    yyin = myfile;
    /*Analizar la entrada*/
    yyparse();
}

void yyerror(const char *s) {
  cout << "EEK, parse error!  Message: " << s << endl;
  /*Error*/
  exit(-1);
}