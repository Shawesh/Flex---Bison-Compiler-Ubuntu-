%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// binary tree struct
typedef struct TreeNode{
  char* data;
  struct TreeNode *left, *right;
} TreeNode;

// binary tree functions declerations
TreeNode* makeNode(char*, TreeNode*, TreeNode*);
void print_preorder(TreeNode*, int);
void print_inorder(TreeNode*, int);
void delTree(TreeNode*);

extern int yylex();
extern int yylineno;
extern char *yytext;

int yyerror(const char *msg);

%}

%union {
  char* string;
  struct TreeNode* TreeNode;
}

%token <string> CHARACTER STRING
%token <string> LP RP LB RB LC RC ABS
%token <string> COLON SEMI COMMA DOT S_QUOTE D_QUOTE ADDRESS DEREFERENCE
%token <string> ASSIGN PLUS_OP MINUS_OP MULTIPLY_OP DIV_OP MOD_OP
%token <string> NOT_OP LT_OP GT_OP LE_OP GE_OP EQ_OP NE_OP AND_OP OR_OP
%token <string> IF ELSE WHILE BOOL_TRUE BOOL_FALSE
%token <string> VAR FUNCTION RETURN NULL_PTR
%token <string> TYPE TYPE_STRING INTEGER IDENTIFIER

%type <TreeNode> TYP ID DEREF INT CHAR STR BOOL_TYPE FUNC_CALL PAR_EXP SIZE_OF
%type <TreeNode> STR_INDEX PTR EXP MULT_EXP LHS ASSIGNMENT MULT_ID VARS PARAMS MULT_PARAMS
%type <TreeNode> RETURN_STATEMENT COND WHILE_STATEMENT STATEMENT MULT_STATEMENT
%type <TreeNode> BLOCK BLOCK_W_RETURN FUNC MULTI_FUN PROGRAM S

%left LT_OP GT_OP LE_OP GE_OP EQ_OP NE_OP
%left AND_OP OR_OP

%left PLUS_OP MINUS_OP
%left MULTIPLY_OP DIV_OP MOD_OP

%precedence NEG   /* negation--unary minus */

%left NOT_OP
%left DEREFERENCE

%%

S : PROGRAM { print_preorder($1,0); }
  ;

PROGRAM : MULTI_FUN { $$ = makeNode("Program",$1,NULL); }
        ;

MULTI_FUN : MULTI_FUN FUNC { $$ = makeNode("Multi Functions", $1, $2); }
           | FUNC { $$ = $1; }
           ;

FUNC : FUNCTION ID LP MULT_PARAMS RP RETURN TYP BLOCK_W_RETURN {
 TreeNode* input = makeNode("INPUT", $2, $4);
 TreeNode* output = makeNode("OUTPUT", $7, $8);

 $$ = makeNode("FUNCTION",input,output);
}
     | FUNCTION ID LP RP RETURN TYP BLOCK_W_RETURN {
 TreeNode* input = makeNode("INPUT", $2, NULL);
 TreeNode* output = makeNode("OUTPUT", $6, $7);

 $$ = makeNode("FUNCTION",input,output);
}
     ;


BLOCK_W_RETURN : LC MULT_STATEMENT RETURN_STATEMENT RC {$$ = makeNode("BLOCK WITH RETURN",$2,$3);}
               | LC RETURN_STATEMENT RC {$$ = makeNode("BLOCK WITH RETURN",NULL,$2);}
               ;

BLOCK : LC MULT_STATEMENT RC {$$ = makeNode("BLOCK",$2,NULL);}
      | LC RC {$$ = makeNode("EMPTY BLOCK",NULL,NULL);}
      ;

MULT_STATEMENT : MULT_STATEMENT STATEMENT { $$ = makeNode("MULTI STATEMENT", $1,$2); }
                | STATEMENT { $$ = $1 ; }
                ;
STATEMENT : ASSIGNMENT SEMI { $$ = makeNode("STATEMENT", $1, NULL); }
          | VARS SEMI { $$ = makeNode("STATEMENT", $1, NULL); }
          | COND { $$ = makeNode("STATEMENT", $1, NULL); }
          | WHILE_STATEMENT { $$ = makeNode("STATEMENT", $1, NULL); }
          | BLOCK { $$ = makeNode("STATEMENT", $1, NULL); }
          | FUNC { $$ = makeNode("STATEMENT", $1, NULL); }
          ;

WHILE_STATEMENT : WHILE LP EXP RP BLOCK {$$ = makeNode("WHILE STATEMENT",$3,$5); }
                ;

COND : IF LP EXP RP BLOCK {$$ = makeNode("IF CONDITION",$3,$5); }
     | IF LP EXP RP BLOCK ELSE BLOCK { $$ = makeNode("IF ELSE CONDITION", $3, makeNode("TRUE / FALSE", $5, $7));}
     ;

RETURN_STATEMENT : RETURN EXP SEMI { $$ = makeNode("RETURN STATEMENT",$2,NULL);}
                 ;

MULT_PARAMS : MULT_PARAMS SEMI PARAMS { $$ = makeNode("MULTIPLE TYPES", $1, $3); }
           | PARAMS { $$ = $1; }
           ;

PARAMS : MULT_ID COLON TYP { $$ = makeNode("PARAMETER",$1 ,$3); }
       ;

VARS : VAR MULT_ID COLON TYP { $$ = makeNode("VARIABLES",$2 ,$4); }
     | VAR MULT_ID COLON TYPE_STRING LB INT RB { $$ = makeNode("VARIABLES",$2 ,makeNode("STRING",$6,NULL)); }
     ;

MULT_ID : MULT_ID COMMA ID { $$ = makeNode("MULTIPLE IDENTIFIERS", $1, $3); }
        | ID { $$ = $1; }
        ;

ASSIGNMENT : LHS ASSIGN EXP { $$ = makeNode("ASSIGNMENT", $1, $3); }
           | LHS ASSIGN STR { $$ = makeNode("STRING ASSIGNMENT", $1, $3);}
           | LHS ASSIGN PTR { $$ = makeNode("POINTER ASSIGNMENT", $1, $3);}
           | LHS ASSIGN NULL_PTR {$$ = makeNode("NULL POINTER ASSIGNMENT", $1, makeNode("NULL POINTER",NULL,NULL)); }
           ;

LHS : ID { $$ = makeNode("ASSIGNMENT TARGET: VARIABLE", $1, NULL); }
    | STR_INDEX { $$ = makeNode("ASSIGNMENT TARGET: STRING", $1, NULL); }
    | DEREF { $$ = makeNode("ASSIGNMENT TARGET: DEREFERENCE", $1, NULL); }
    ;

MULT_EXP : MULT_EXP COMMA EXP { $$ = makeNode("Multiple Expressions",$1,$3); }
         | EXP { $$ = $1; }
         ;

EXP : ID { $$ = makeNode("IDENTIFIER", $1, NULL); }
    | INT {$$ = makeNode("INTEGER", $1, NULL); }
    | CHAR {$$ = makeNode("CHARACTER", $1, NULL); }
    | STR_INDEX {$$ = $1; }
    | BOOL_TYPE { $$ = makeNode("BOOLEAN", $1, NULL); }
    | DEREFERENCE EXP {$$ = makeNode("DEREFERENCE", $2, NULL); }
    | FUNC_CALL { $$ = $1; }
    | PAR_EXP { $$ = $1; }
    | SIZE_OF { $$ = $1; }
    | NOT_OP EXP { $$ = makeNode("!", $2, NULL); }
    | MINUS_OP EXP %prec NEG { $$ = makeNode("NEGATIVE", $2, NULL); }
    | EXP PLUS_OP EXP { $$ = makeNode("+",$1,$3); }
    | EXP MINUS_OP EXP { $$ = makeNode("-",$1,$3); }
    | EXP MULTIPLY_OP EXP { $$ = makeNode("*",$1,$3); }
    | EXP DIV_OP EXP { $$ = makeNode("/",$1,$3); }
    | EXP MOD_OP EXP { $$ = makeNode("%",$1,$3); }
    | EXP LT_OP EXP { $$ = makeNode("<",$1,$3); }
    | EXP GT_OP EXP { $$ = makeNode(">",$1,$3); }
    | EXP LE_OP EXP { $$ = makeNode("<=",$1,$3); }
    | EXP GE_OP EXP { $$ = makeNode(">=",$1,$3); }
    | EXP EQ_OP EXP { $$ = makeNode("==",$1,$3); }
    | EXP NE_OP EXP { $$ = makeNode("!=",$1,$3); }
    | EXP AND_OP EXP { $$ = makeNode("&&",$1,$3); }
    | EXP OR_OP EXP { $$ = makeNode("||",$1,$3); }
    | PTR LT_OP PTR { $$ = makeNode("<",$1,$3); }
    | PTR GT_OP PTR { $$ = makeNode(">",$1,$3); }
    | PTR LE_OP PTR { $$ = makeNode("<=",$1,$3); }
    | PTR GE_OP PTR { $$ = makeNode(">=",$1,$3); }
    | PTR EQ_OP PTR { $$ = makeNode("==",$1,$3); }
    | PTR NE_OP PTR { $$ = makeNode("!=",$1,$3); }
    | PTR AND_OP PTR { $$ = makeNode("&&",$1,$3); }
    | PTR OR_OP PTR { $$ = makeNode("||",$1,$3); }
    ;

PTR : ADDRESS ID { $$ = makeNode("POINTER", $2, NULL); }
    | ADDRESS STR_INDEX { $$ = makeNode("POINTER", $2, NULL); }
    ;

STR_INDEX : ID LB EXP RB { $$ = makeNode("STRING INDEX", $1, $3) ;}
          ;

SIZE_OF : ABS ID ABS { $$ = makeNode("SIZE OF",$2,NULL); }
        | ABS STR ABS { $$ = makeNode("SIZE OF",$2,NULL); }
        ;

PAR_EXP : LP EXP RP { $$ = makeNode("PARANTHESES EXPRESSION",$2,NULL); }
        ;

FUNC_CALL : ID LP MULT_EXP RP { $$ = makeNode("Function Call",$1, $3); }
          | ID LP RP { $$ = makeNode("Function Call No Params",$1, NULL); }
          ;

BOOL_TYPE : BOOL_TRUE { $$ = makeNode("true", NULL, NULL); }
          | BOOL_FALSE { $$ = makeNode("false", NULL, NULL); }
          ;

STR : STRING { $$ = makeNode("STRING CONSTANT",makeNode($1,NULL,NULL),NULL); }
    ;

CHAR : CHARACTER  { $$ = makeNode($1,NULL,NULL); }
     ;

INT : INTEGER { $$ = makeNode($1, NULL, NULL); }

DEREF : DEREFERENCE ID { $$ = makeNode("DEREFERENCE", $2, NULL); }
      ;

ID : IDENTIFIER { $$ = makeNode($1, NULL, NULL); }
   ;

TYP : TYPE { $$ = makeNode($1, NULL, NULL); }
    ;
%%

int yyerror(const char *msg)
{
	fflush(stdout);
	fprintf(stderr, "Error: %s at line %d\n", msg,yylineno);
	fprintf(stderr, "Parser does not expect '%s'\n",yytext);
}

int main() {
  yyparse();
  return 0;
}

TreeNode* makeNode(char* token, TreeNode* left, TreeNode* right){
  TreeNode* new_node = (TreeNode*)malloc(sizeof(TreeNode));

  new_node->data = strdup(token);
  new_node->left = left;
  new_node->right = right;

  return new_node;
}

void print_preorder(TreeNode* tree,int indent)
{
    int i;
    if (tree)
    {
        for(i = 0; i < indent; i++){
          printf("   |");
        }
        printf("-> %s\n",tree->data);
        print_preorder(tree->left, indent+1);
        print_preorder(tree->right, indent+1);
    }
}

void print_inorder(TreeNode* tree, int indent)
{
    int i;
    if (tree)
    {
        print_inorder(tree->left, indent+1);
        for(i = 0; i < indent; i++){
          printf(" | ");
        }
        printf("%s\n",tree->data);
        print_inorder(tree->right, indent+1);
    }
}

void delTree(TreeNode* tree)
{
    if (tree)
    {
        delTree(tree->left);
        delTree(tree->right);
        free(tree);
    }
}
