%{
    #include <stdio.h>
    #include <string.h>
    #include <math.h>
    int yylex();
    void yyerror(char *s);
    char msg[256];
    char err[256];
    extern int lineNum;
    extern int charNum;
    //確認重複宣告所用的的東西
    //檢查hashtable中相同的scope中有沒有相同的id
    int lookup(int s, int sc);	
    //將scope值和id插入hashtable中
    int insert(int s, int sc);
    //scop計算"{"的數量
    int scop = 0;
    struct symbol{
    	int id;
    	int scope;
    	int index;
    };
    struct symbol hashTable[100];
    int len = 0;
    //確認if else的配對
    int if_check = 0;

%}
%union{
    char* stringVal;
} 
%type <stringVal> ID
%token ID TYPE INTEGER FLOAT  VOID COMMENT STRING
%token STATIC NEW FINAL PUBLIC PROTECTED PRIVATE CLASS RETURN
%token WHILE FOR IF ELSE PRINT READ
%left PLUS MINUS MUL DIV LP RP LB RB LC RC//+-*/()[]{}
%left EQ COMMA SMALL BIG SMALLEQ BIGEQ EE NE PP MM POINT
%token NEWLINE END

%%
//每行程式碼分為註解、程式（規格書的那些）、錯誤
lines: 
     | newline
     | lines COMMENT newline
     | lines program newline
     | error  NEWLINE { 
                //在這輸出syntax. error(為了讓lex先把整行程式碼輸出完畢 再輸出error)
                printf("%s", err);
                printf("\nLine %d: ", lineNum);
      }
;
newline: NEWLINE { printf("\nLine %d: ", lineNum); }
;

//規格書的那些
program: 
       | basic
       | class 
       | method_declaration
       | simple
       | method
       | condition
       | loop
       | return
       | lc
       | rc
;
end: 
   | END
;
left: 
    | lc
;
right:
     | rc
;
//利用scope、if_else的計算 確保宣告不重複、if else配對
//遇到“{” scope值+2
lc: LC { scop+=2; }
;
//遇到“}” scope值-1 if_check-1
rc: RC { scop--; if_check--; }
;


	// 2.1 data types and declarations
basic: TYPE IDlist_1 end
     | STATIC TYPE IDlist_1 end
     | TYPE LB RB ID EQ NEW TYPE index end
     | FINAL TYPE IDlist_2 end
;
const_expr:
	  | EQ expression
;
ID_1: ID { 
         //如果hashtable中相同的scope沒有相同的id 則插入id到hash table
         if( lookup($1[0], scop) == -1 )
	      insert($1[0], scop);
	    else
             //若有相同id 則語法錯誤
	     yyerror("Duplicate declare");
      } const_expr
;
IDlist_1: ID_1
        | IDlist_1 COMMA IDlist_1
;
index: LB INTEGER RB
;
ID_2: ID EQ expression
;
IDlist_2: ID_2
        | IDlist_2 COMMA IDlist_2
;

	// 2.1.2 class and object
class: CLASS ID left right
     | ID ID EQ NEW ID LP RP END
;

	// 2.2 methods
method_declaration: TYPE ID LP M_args RP left right
                  | method_modifier TYPE ID LP M_args RP left right
;
method_modifier: PUBLIC 
               | PROTECTED 
               | PRIVATE 
;
M_args:
      | M_arg
;
M_arg: TYPE ID
     | M_arg COMMA M_arg
;

	//2.3.2 Simple
simple: name EQ expression end
      | PRINT LP print_argument RP end
      | READ LP name RP end
      | name PP end
      | name MM end
      | expression end
;
print_argument: pob
              | print_argument PLUS pob
;
pob: ob
   | STRING 
;
name: ID
    | ID POINT ID
;
expression: expression PLUS term
          | expression MINUS term
          | term
;
term: term MUL factor
    | term DIV factor
    | factor
;
factor: ob
      | group
      | PrefixOp ID
      | ob PostfixOp
      | method
;
ob: ID
  | number
  | ID LB INTEGER RB
;
number: INTEGER 
      | FLOAT 
;
group: LP expression RP
;
PrefixOp: PostfixOp
         | PLUS
         | MINUS
;
PostfixOp: PP
         | MM
;
method: name LP arguments RP end
;
arguments: 
         | arguments COMMA arguments
         | expression
;


	//2.3.3 conditional
condition: IF { if_check++; } LP boolean_expr RP left
         | ELSE { if_check--;
                  //如果if_check的計算結果不為0 則語法錯誤
                  if(if_check!=0)
                      yyerror("ifelse");
           } left
;
boolean_expr: expression Infixop expression
	    | expression
;
Infixop: EE 
       | NE 
       | SMALL 
       | BIG 
       | SMALLEQ 
       | BIGEQ 
;

	//2.3.4 Loop
loop: WHILE LP boolean_expr RP left
    | FOR LP ForInitOpt end boolean_expr end ForUpdateOpt RP left
;
ForInitOpt: ob EQ expression
          | TYPE ID EQ expression
;
ForUpdateOpt: ob PP
            | ob MM
;

	//2.3.5 return
return: RETURN expression end
;

%%

int main(){
    printf("Line %d: ", lineNum);
    yyparse();
    printf("\n");
    return 0;
}

void yyerror(char* s) {
    memset(err, 0, 256);
    
    if(strcmp(s,"Duplicate declare") == 0){
        //重複宣告
        sprintf(err, "\nLine %d, 1st char: %d, a duplicate identifier", lineNum, charNum);
        printf("%s", err);
    }else if(strcmp(s,"ifelse") == 0){
        //if else沒配對成功
        sprintf(err, "\nLine %d, 1st char: %d, a syntax error", lineNum, charNum);
        printf("%s", err);
    }else{
        //少了; ,
        sprintf(err, "\nLine %d, 1st char: %d, a syntax error", lineNum, charNum);
    }
};

int lookup(int s, int  sc){
	int i;
	if(len == 0)
		return -1;
	for(i = 0; i <  len; i++){
		if(hashTable[i].id == s && hashTable[i].scope == sc)
			return hashTable[i].index;
	}
	return -1;
}
int insert(int s, int sc){
	hashTable[len].id = s;
	hashTable[len].scope = sc;
	hashTable[len].index = len;
	len++;
	return len-1;
}
