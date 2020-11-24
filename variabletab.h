#include <stdio.h>
#include <stdlib.h>
struct compmem
{
	char* var;
	float value;
	char* charvalue;
	struct compmem *next;
};
typedef struct compmem *myvar;
struct compmem* head;
void insertvar (char* vari,float val, char* cvalue)
{
 struct compmem* idtemp=(struct compmem*)malloc(sizeof(struct compmem));
 idtemp->var=vari;	
 idtemp->value=val;
 idtemp->charvalue=cvalue;
 idtemp->next=head;
 head=idtemp;
}
char* is_declared(char* v)
{
	struct compmem* go=head;
	char* res="false";
	while(go!=NULL)
	{
		if(strcmp(go->var,v)==0){
			res="true";
		}
		else
		{
			res="false";
		}
		go=go->next;
	}
	return res;
}
char* is_initialized(char* v)
{
	struct compmem* init=head;
	char* res="false";
	while(init!=NULL)
	{
		if(strcmp(init->var,v)==0)
		{
			
	      if((init->value!=0) || strcmp(init->charvalue,"NULL")!=0){
			res="true";
		  }
		else
		{
			res="false";
		}
		break;
	}else{
		res="false";
	}
		init=init->next;	
	}

	return res;
}
float getintval(char* vv)
{
  	struct compmem* get=head;
	float intval;
	while(get!=NULL)
	{
		if(strcmp(get->var,vv)==0){
			
			  intval=get->value;
			  
		}
	
		get=get->next;

	     
	}
	return intval;	
}
char* getstringval(char* sv)
{
  struct compmem* sget=head;
	char* sval;
	while(sget!=NULL)
	{
		if(strcmp(sget->var,sv)==0){
			  if(!strcmp(sget->charvalue,NULL))
			  {
			  sval=sget->charvalue;
	          }
			
		}
		else
		{
		sval=NULL;
		}
		sget=sget->next;
	}
	return sval;	
}
void update(char* vr,int val, char* cval)
{
 	struct compmem* update=head;
	while(update!=NULL)
	{
		if(strcmp(update->var,vr)==0){
		update->value=val;
		update->charvalue=cval;	
		}

		update=update->next;
	}	
}

