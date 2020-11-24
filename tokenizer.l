%{
	#include<stdio.h>
	#include<string.h>
%}
%option noyywrap
ident [_a-zA-Z][a-zA-Z0-9]*
intnum   [+-]?[0-9]+.?[0-9]*
stringvalue   [a-zA-Z0-9]
sdelim   [|]
%%
onyesha {printf("keyword %s\n",yytext);}
true    {printf("boolean %s\n",yytext);}
false   {printf("boolean %s\n",yytext);}
{sdelim}+ {printf("delimiters %s\n",yytext);}
{ident} {printf("identifier %s\n",yytext);}
{intnum}  {printf("number value %f\n",atof(yytext));}
"+"     {printf("operator %s\n",yytext);}
"-"     {printf("operator %s\n",yytext);}
"/"     {printf("operator %s\n",yytext);}
"*"     {printf("operator %s\n",yytext);}
"%"     {printf("operator %s\n",yytext);}
"#"     {printf("variable symbol %s\n",yytext);}
"="      {printf("operator %s\n",yytext);}
"\n"     {printf("endline %s\n",yytext);}
" "      {printf("space %s\n",yytext);}
.        {printf("invalid input %s\n",yytext);}
%%
int main(int argc, char *argv[]) {
  yyin = fopen(argv[1], "r");
  yylex();
  fclose(yyin);
  return 0;
}