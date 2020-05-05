/*La seccion de definicion tiene una variable a la que se puede acceder dentro de yylex() y main()*/
%{ 
int count = 0; 
%} 
/*yywrap() se llama por lex cuando se agota la entrada(o en EOF) yywrap predeterminado siempre devuelve 1*/
/*No definimos nuestra propia funcion yywrap()*/
%option noyywrap
/*La sección de reglas tiene tres reglas, la primera regla coincide con letras mayúsculas*/
/*La segunda regla coincide con cualquier carácter excepto la nueva línea*/
/*La tercera regla no toma datos después de ingresar*/

/*Dos variables importantes*/
/*yytext: un bufer que contiene los caracteres de entrada que realmente coinciden con el patron, es decir lexema. */
/*yyleng: que indica la longitud de la cadena a la que apunta yytext.*/
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
	/*yylex() implica el punto de entrada principal para lex, 
	lee el flujo de entradas, genera tokens, devuelve cero al final del flujo de entradas
	Se llama para invocar al lexer, y cada vez que se llama yylex(), el escaner continua procesando
	desde donde se quedo por ultima vez*/
	yylex();	
	printf("Numero de letras capitales: %d\n", count); 
	return 0; 
} 