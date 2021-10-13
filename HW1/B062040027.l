%{
#include<stdio.h>
#include<string.h>
unsigned charCount = 1, idCount = 0, lineCount = 1;
char* tempYYtext;
int lookup(char* s);
int insert(char* s);
void dump();
%}

symbol [\,\:\;\(\)\[\]\{\}]
operator [\+\-\*\/\%\=\!\>\<]|"++"|"--"|"=="|"&&"|"||"|"<="|">="|"!="
reserved_word "boolean"|"break"|"byte"|"case"|"char"|"catch"|"class"|"const"|"continue"|"default"|"do"|"double"|"else"|"extends"|"false"|"final"|"finally"|"float"|"for"|"if"|"implements"|"int"|"long"|"main"|"new"|"print"|"private"|"protected"|"public"|"return"|"short"|"static"|"string"|"switch"|"this"|"true"|"try"|"void"|"while"

id [^ 0-9\n\t\^\#\+\-\*\/\%\=\!\>\<\,\:\;\(\)\[\]\{\}\"\'\b\f][a-zA-Z0-9_$]*
idErr [^ \n\t\+\-\*\/\%\=\!\>\<\,\:\;\(\)\[\]\{\}\"\'\b\f]+[a-zA-Z_$]+[0-9]*

integer [-]*[0-9]+
float ([-]*[0-9]+\.[0-9]+)|([-]*[0-9]+[\.]*[0-9]*[eE][+-][0-9]*[f]*)

string \"[^\n\"\\]*\"|\"[^\n\"\\]*\\[\"\']+[^\n\"\\]*\"
stringErr \"[^\n\"]*|\'[^\n]*\'

space [ \t]
eolErr [^\;\{\}\) ]\n
eol \n
comment \/\/[^\n]*|\/\*[^`]*\*\/

%%

{symbol} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{operator} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"operator\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{reserved_word} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved word\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{id} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
	//Symbol table
	if(lookup(yytext) == -1){
		insert(yytext);
	}
}
{idErr} {
	printf("Line: %d, 1st char: %d,ID Error:\"%s\"\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{integer} {
	printf("Line: %d, 1st char: %d, \"%s\" is an \"integer\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{float} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"float\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{string} {
	//先刪除yytext前後的雙引號
	int k, l;
	l = strlen(yytext);
	for(k = 0; k < l; k++){
		yytext[k] = yytext[k+1];
	}
	yytext[k-2] = '\0';

	//再刪除跳脫字元
	int i, j, len;
	len = strlen(yytext);
	for(i = 0; i < len; i++){
		if(yytext[i] == '\\'){
			for(j = i; j < len; j++){
				yytext[j] = yytext[j+1];
			}
			yytext[j]='\0';
		}
	}
	printf("Line: %d, 1st char: %d, \"%s\" is a \"string\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{stringErr} {
	printf("Line: %d, 1st char: %d, String Error:\"%s\".\n", lineCount, charCount, yytext);
	charCount += yyleng;
}
{space} {
	charCount++;
}
{eol} {
	lineCount++;
	charCount = 1;
}
{eolErr} {
	if(yytext[strlen(yytext)-2]!='\n')
		printf("Error: forget \';\' after %c\n",yytext[strlen(yytext)-2]);
	else
		lineCount++;
	lineCount++;
	charCount = 1;
}
{comment} {
	printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\".\n", lineCount, charCount, yytext);
	//計算/**/之間有多少個\n 以計算正確的lineCount
	int i;
	for(i = 0; i < strlen(yytext); i++){
		if( yytext[i] == '\n')
			lineCount++;
	}
	charCount = 1;
}

%%
	struct symbol{
		char id[100];
		int index;
	};
	
	struct symbol hashTable[100];
	int len = 0;
	
	int main(){
		yylex();
		printf("The symbol table contains:\n");
		dump();
		return 0;
	}

	int lookup(char* s){
		int i;
		if(len == 0)
			return -1;
		for(i = 0; i < len; i++){
			if(strcmp(hashTable[i].id, s) == 0)
				return hashTable[i].index;
		}
		return -1;
	}
	int insert(char* s){
		strcpy(hashTable[len].id, s);
		hashTable[len].index = len;
		len++;
		return len-1;
	}
	void dump(){
		int i;
		for(i = 0; i < len; i++){
			printf("%s\n", hashTable[i].id);
		}
	}
