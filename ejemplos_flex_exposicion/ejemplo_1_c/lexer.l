/*La seccion de definicion tiene una variable a la que se puede acceder dentro de yylex() y main()*/
%{ 
int count = 0; 
%} 
/*No definimos nuestra propia funcion yywrap()*/
%option noyywrap
/*La sección de reglas tiene tres reglas, la primera regla coincide con letras mayúsculas*/
/*La segunda regla coincide con cualquier carácter excepto la nueva línea*/
/*La tercera regla no toma datos después de ingresar*/

/*Dos variables importantes*/
/*yytext que almacena la cadena que ha coincidido con un patrón.*/
/*La otra es la variable yyleng que indica la longitud de la cadena a la que apunta yytext.*/
%% 
[A-Z] 		{
				printf("Letra Capital: %s\n", yytext); 
				count++;
			} 
.	 		{	
				printf("Letra no Capital: %s\n", yytext);
			} 
\n 			{
				return 0;
			} 
%% 

/*La seccion de codigo imprime el numero de letras mayusculas presentes en la entrada dada*/

int main()
{ 
	yylex();	//Funcion principal de flex que ejecuta la seccion de reglas
	printf("Numero de letras capitales: %d\n", count); 
	return 0; 
} 