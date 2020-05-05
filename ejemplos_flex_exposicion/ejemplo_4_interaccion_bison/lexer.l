snazzle.l
%{
    #include <cstdio>
    #include "parser.tab.h"  /*Para obtener los tipos de tokens de bison*/
    extern "C" int yylex();
%}
%%
[ \t\n]             ;
[0-9]+\.[0-9]+      {yylval.fval = atof(yytext); return FLOAT;   }
[0-9]+              {yylval.ival = atoi(yytext); return INT;     }
[a-zA-Z0-9]+        {
                        // Tenemos que eliminar yytext porque Flex lo cambiará para el próximo token. 
                        // Tenga en cuenta que esta memoria debe liberarse en algún lugar, por eso llamamos 
                        // free () arriba en la sección Bison. (Aparte: usamos free () en lugar de
                        // delete porque strdup es una función C que usa malloc, no una función C++
                        // que usa new.) 
                        yylval.sval = strdup(yytext);
                        return STRING;
                    }
%%