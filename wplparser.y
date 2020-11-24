%{

   #include<stdio.h>
   #include<stdlib.h>
   #define YYINITDEPTH=400000;
   #include"variabletab.h"
   #include<string.h>
    extern int yyparse(void);
    extern void yyerror(char const*);
    extern int yylex();
   void insertvar (char* vari,float val, char* cvalue);
   char* is_declared(char* v);
   char* is_initialized(char* v);
   float getintval(char* vv);
   char* getstringval(char* sv);
   void update(char* vr,int val, char* cval);
   FILE *yyin;
	
%}
%union
{
	float number;
	char* id;
	char* string;
}
%define parse.error verbose
%define parse.lac full
%token  plus minus multi mod divide hash eko onyesha endline delim  space 
%token  <id> identifier
%token <number> number
%token <string> true
%token <string> false

%left plus minus divide multi mod hash eko
%left identifier number onyesha true false endline delim 

%start program
%type <string> line
%type <string> printing
%type <string> assignment
%type <number> expression
%type <string> declaration
%type <string> outp
%type <id> string



%%

 program:line
        |line program       {}
        ; 
 line:declaration    {}
      |assignment    {}
      |printing     {}
      |endline      {}
      ;

 declaration:hash identifier endline     {
                                        if(strcmp(is_declared($2),"false")==0){
                                        insertvar($2,0,"NULL");
                                        }
                                        else{
                                        printf("variable already declared %s",$2);
                                        }
                                        } 
                                       ;
 |hash identifier eko expression endline         {
                                        if(strcmp(is_declared($2),"false")==0){insertvar($2,$4,"NULL");}
                                        else{printf("variable already declared"); }
                                                      
                                        }
 |hash identifier eko string endline         {
                                        if(strcmp(is_declared($2),"false")==0){insertvar($2,0,$4);}
                                        else{printf("variable already declared"); }
                                                      
                                        }

      ;
             
 
 printing:onyesha space expression endline                                  {printf("%f",$3);}
         |onyesha space string space plus space expression endline          {printf("%s%f",$3,$7);}
         |onyesha space string endline                                      {printf("%s",$3);}
        
        ;
 assignment:identifier eko expression endline          {
                                                        if(strcmp(is_declared($1),"true")==0){
                                                        update($1,$3,"NULL");
                                                        }
                                                        else{
                                                        printf("variable not declared %s");
                                                        }
                                                        }
         |identifier eko string endline               {
                                                        if(is_declared($1)=="true"){
                                                        update($1,0,$3);
                                                        }
                                                        else{
                                                        printf("variable not declared %s");
                                                        }

                                                         }

        |identifier plus plus endline                         {
                                                         if((strcmp(is_declared($1),"true")==0) && (strcmp(is_initialized($1),"true")==0)){
                                                         float v=getintval($1); float v2=v++; update($1,v2,"NULL"); 
                                                         }
                                                         else{
                                                         printf("variable not declared or not initialized %s");
                                                         }
                                                         }
        |identifier minus minus  endline                      {
                                                        if(is_declared($1)=="true" && is_initialized($1)=="true"){
                                                        float t=getintval($1); float t2=t--; update($1,t2,"NULL");
                                                         }
                                                        else{
                                                        printf("variable not declared or not initialized");
                                                        }
                                                        }
        ;

 expression:number                                       {$$=$1;} 
           |expression plus  expression                  {$$=$1+$3;}
           |expression minus expression                  {$$=$1-$3;}
           |expression multi expression                  {$$=$1*$3;}
           |expression divide expression                 {$$=$1/$3;}
           |expression mod   expression                  {$$=(int)$1%(int)$3;}
           |identifier                                 {
                                                         if(strcmp(is_initialized($1),"true")==0){
                                                          $$=getintval($1)||getstringval($1);
                                                          }
                                                          else{
                                                          printf("variable not declared or not initialized");}
                                                          }
           
           ;  

 string:delim outp delim                      {$$=$2;}
        ;
  outp:identifier space outp                        {  $$=strcat(strcat($1," "),$3);    }    
        |identifier                           {$$=$1;}
        |true                                 {$$=$1;}
        |false                                {$$=$1;}

%%
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }
int main(int argc, char *argv[]) {
  yyin = fopen(argv[1], "r");
  yyparse();
  fclose(yyin);
  return 0;
}