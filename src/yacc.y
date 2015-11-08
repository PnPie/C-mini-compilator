%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

/* on définit une liste chainée pour stocker les appels(nom de fonction) */
typedef struct maillon* liste;
struct maillon{
    char* fun_name;
    liste suivant;
};

/* vérifier si cette fonciton est déjà appelée */
int existe(char* fun_nom);
void ajoute(char*);
void ajoute_etoile(char*);

/* créer une liste à stocker */
liste l = NULL;

/* pointeur vers le fichier passé en argument */
FILE* yyin;

void yyerror(char *);
%}

/* pour envoyer les données de type char* */
%union{
    char* str;
}

%token PROGRAM PBEGIN VAR ARRAY OF ASSIGNMENT END AND OR NOT COLON WHILE DO IF THEN ELSE INTEGER BOOLEAN NEW EQUAL NOTEQUAL GE GT LE LT LBRAC RBRAC LPAREN RPAREN FUNCTION PROCEDURE DIGSEQ REALNUMBER
%left PLUS MINUS
%left MUL DIV
%token<str> IDENTIFIER
%nonassoc SEMICOLON DOT COMMA
%type<str> identifier

%%

program :
 PROGRAM block DOT 
;

block :
 variable precedure_function_part statement_part
;


/*------------ la partie de déclaration de variable --------------*/
variable :
 VAR variable_declaration_list semicolon
|
;

variable_declaration_list :
 variable_declaration_list semicolon variable_declaration
|variable_declaration
;

variable_declaration :
 identifier_list COLON type
;

identifier_list :
 identifier_list comma identifier
|identifier
;

type :
 INTEGER
|BOOLEAN
|ARRAY OF type
;

/*------------ la partie de déclaration de fonction/procedure --------------*/
precedure_function_part :
 proc_func_list {ajoute_etoile("program");} /* on commence par ajouter la fonction "program" comme une fonction appelante */
|
;

proc_func_list :
 proc_func_list proc_func_keyword proc_func_content SEMICOLON
|proc_func_keyword proc_func_content SEMICOLON
;

proc_func_keyword:
 PROCEDURE
|FUNCTION
;

proc_func_content :
 proc_content
|func_content
;

/* un procedure */
proc_content :
 procedure_heading semicolon procedure_block
;

procedure_heading :
 identifier LPAREN RPAREN {ajoute_etoile($1);} /* ajoute comme un procedure appelante */
|identifier parameter_list {ajoute_etoile($1);} /* ajoute comme un procedure appelante */
;

parameter_list :
 LPAREN parameter_list_section RPAREN
;

parameter_list_section :
 parameter_list_section semicolon parameter_section
|parameter_section
;

parameter_section :
 value_parameter_specification
;

value_parameter_specification :
 identifier_list COLON type
;

procedure_block :
 block
;

/* une function */
func_content :
 function_heading semicolon function_block
;

function_heading : 
 identifier LPAREN RPAREN COLON type {ajoute_etoile($1);} /* ajoute comme une fonction appelante */
|identifier parameter_list COLON type {ajoute_etoile($1);} /* ajoute comme une fonction appelante */
;

function_block : block ;


/*------------ la partie de déclaration de statement --------------*/
statement_part :
 PBEGIN statement_sequence END
;

statement_sequence :
 statement_sequence semicolon statement
|statement 
;

statement :
 assignment_statement
|procedure_statement
|statement_part
|if_statement
|while_statement
|
;

assignment_statement :
 variable_access ASSIGNMENT expression
;

variable_access :
 identifier
|indexed_variable
;

indexed_variable :
 variable_access LBRAC index_expression_list RBRAC
;

index_expression_list :
 index_expression_list comma index_expression
|index_expression
;

index_expression :
 expression
;

while_statement :
 WHILE expression DO statement
;

if_statement :
 IF expression THEN statement ELSE statement
;

/* appel de procedure */
procedure_statement :
 identifier params {ajoute($1);} /* on ajoute le procedure appelé dans la liste chainée */
;

params :
 LPAREN actual_parameter_list RPAREN
;

actual_parameter_list :
 actual_parameter_list comma actual_parameter
|actual_parameter
;

actual_parameter : 
 expression
|
;

expression :
 expr
|expr logop expr
;

expr :
 simple_expression
|expr compare_operator simple_expression
;

simple_expression :
 term
|simple_expression addop term
;

term :
 factor
|term mulop factor
;

factor :
 MINUS factor
|exponentiation
;

exponentiation :
 primary
|NEW ARRAY OF type LBRAC expression RBRAC
;

primary :
 variable_access
|unsigned_number
|function_designator
|LPAREN expression RPAREN
|NOT primary
;

unsigned_number :
 unsigned_integer 
|unsigned_real
;

unsigned_integer :
 DIGSEQ
;

unsigned_real :
 REALNUMBER
;

/* appel de fonction */
function_designator :
 identifier params {ajoute($1);} /* on ajoute la fonction appelée dans la liste chainée */
;

addop:
 PLUS
|MINUS
;

mulop :
 DIV
|MUL
;

logop:
 AND
|OR
;

compare_operator :
 EQUAL
|NOTEQUAL
|LT
|GT
|LE
|GE
;

identifier :
 IDENTIFIER {$$=$1;}
;

semicolon :
 SEMICOLON
;

comma :
 COMMA
;

%%

/* vérifier si cette fonciton est déjà appelée dans la fonciton appelante */
int existe(char* s){
    liste tmp = l;
    while(tmp!=NULL && tmp->fun_name[0]!='*'){
        if(strcmp(tmp->fun_name,s)==0)
          return 1;
        tmp = tmp->suivant;
    }
    return 0;
}

/* ajouter une fonction appelée dans la liste */
void ajoute(char* s){
    if(!existe(s)){
        liste new_l = malloc(sizeof(struct maillon));
        new_l->fun_name = malloc(sizeof(char));
        sprintf(new_l->fun_name,"%s",s);
        new_l->suivant = l;
        l = new_l;
    }
}

/*
ajouter une fonction appelante dans la liste
on met une étoile devant la fonction appelante (ex. *program)
*/
void ajoute_etoile(char* s){
    liste new_l = malloc(sizeof(struct maillon));
    new_l->fun_name = malloc(sizeof(char));
    sprintf(new_l->fun_name,"*%s",s);
    new_l->suivant = l;
    l = new_l;
}

/* retourner la prochaine fonction appelante(avec etoile) */
liste next_noeud(liste li){
    liste tmp = li->suivant;
    while(tmp!=NULL){
        if(tmp->fun_name[0]=='*')
          return tmp;
        tmp=tmp->suivant;
    }
    return NULL;
}

void print_call_graph(){
    printf("digraph call_graph {\n");

    liste noeud = next_noeud(l);
    printf("\t%s;\n",noeud->fun_name+1);

    liste tmp = l;
    while(noeud){
        while(tmp!=noeud){
            if(tmp->fun_name[0]=='*'){
                tmp=tmp->suivant;
                continue;
            }
            printf("\t%s -> %s;\n",noeud->fun_name+1,tmp->fun_name);
            tmp=tmp->suivant;
        }
        noeud=next_noeud(noeud);
    }

    printf("}\n");
}


int main(int argc,char** argv){
    if(argc!=2){
        fprintf(stderr,"Veuillez saisir le nom de fichier comme parametre(ex:./prog bignum.p)\n");
        exit(1);
    }
    yyin = fopen(argv[1],"r");
    yyparse();
    print_call_graph();
    return 0;
}
