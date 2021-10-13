%{
#include "y.tab.h"
#include <stdio.h>
#include<string.h>
int lineNum = 1;
int charNum = 1;
extern char* err;
%}

integer [-]*[0-9]+
float ([-]*[0-9]+\.[0-9]+)|([-]*[0-9]+[\.]*[0-9]*[eE][+-][0-9]*[f]*)
Type "boolean"|"char"|"int"|"float"|"String"|"void"
id [^ 0-9\n\t\^\#\+\-\*\/\%\=\!\>\<\,\:\;\(\)\[\]\{\}\"\'\b\f][a-zA-Z0-9_$]*
comment (\/\*([^\*]|\*+[^\*\/])*\*+\/)
comment2 \/\/.*
string \"[^\n\"\\]*\"|\"[^\n\"\\]*\\[\"\']+[^\n\"\\]*\"
space [ \t]

%%
\. {
    printf("%s", yytext);
    charNum += yyleng;
    return POINT;
}
"print" {
     printf("%s", yytext);
     charNum += yyleng;
     return PRINT;
}
"read" {
     printf("%s", yytext);
     charNum += yyleng;
     return READ;
}
"++" {
     printf("%s", yytext);
     charNum += yyleng;
     return PP;
}
"--" {
     printf("%s", yytext);
     charNum += yyleng;
     return MM;
}
"return" {
     printf("%s", yytext);
     charNum += yyleng;
     return RETURN;
}
"if" {
     printf("%s", yytext);
     charNum += yyleng;
     return IF;
}
"else" {
     printf("%s", yytext);
     charNum += yyleng;
     return ELSE;
}
"for" {
     printf("%s", yytext);
     charNum += yyleng;
     return FOR;
}
"while" {
     printf("%s", yytext);
     charNum += yyleng;
     return WHILE;
}
"class" {
     printf("%s", yytext);
     charNum += yyleng;
     return CLASS;
}
"static" {
     printf("%s", yytext);
     charNum += yyleng;
     return STATIC;
}
"new" {
     printf("%s", yytext);
     charNum += yyleng;
     return NEW;
}
"final" {
     printf("%s", yytext);
     charNum += yyleng;
     return FINAL;
}
"public" {
     printf("%s", yytext);
     charNum += yyleng;
     return PUBLIC;
}
"protected" {
     printf("%s", yytext);
     charNum += yyleng;
     return PROTECTED;
}
"private" {
     printf("%s", yytext);
     charNum += yyleng;
     return PRIVATE;
}
{string} {
    printf("%s", yytext);
    charNum += yyleng;
    return STRING;
}
{integer} {
    printf("%s", yytext);
    charNum += yyleng;
    return INTEGER;
}
{float} {
    printf("%s", yytext);
    charNum += yyleng;
    return FLOAT;
}
{Type} {
    printf("%s", yytext);
    charNum += yyleng;
    return TYPE;
}
{id} {
    //printf("\n---[LEX]---");
    printf("%s", yytext);
    charNum += yyleng;
    yylval.stringVal = yytext;
    return ID;
}
{comment} {
           char *line = "\n";
           char *pch;
           int o = 1;
           pch = strtok(yytext, line);
           while (pch != NULL){
             if(o==1)
                 printf("%s", pch);
             else
                 printf("\nLine %d: %s", lineNum, pch);
             o++;
             lineNum++;
             pch = strtok(NULL, line);
           }
        charNum += yyleng;
        lineNum--;
	return COMMENT;
}
{comment2} {
        printf("%s", yytext);
        charNum += yyleng;
	return COMMENT;
}
"<" {
    printf("%s", yytext);
    charNum += yyleng;
    return SMALL;
}
">" {
    printf("%s", yytext);
    charNum += yyleng;
    return BIG;
}
"<=" {
    printf("%s", yytext);
    charNum += yyleng;
    return SMALLEQ;
}
">=" {
    printf("%s", yytext);
    charNum += yyleng;
    return BIGEQ;
}
"==" {
    printf("%s", yytext);
    charNum += yyleng;
    return EE;
}
"!=" {
    printf("%s", yytext);
    charNum += yyleng;
    return NE;
}
\; {
    printf("%s", yytext);
    charNum += yyleng;
    return END;
}
\= {
    printf("%s", yytext);
    charNum += yyleng;
    return EQ;
}
\, {
    printf("%s", yytext);
    charNum += yyleng;
    return COMMA;
}
\+ {
    printf("%s", yytext);
    charNum += yyleng;
    return PLUS;
}
\- {
    printf("%s", yytext);
    charNum += yyleng;
    return MINUS;
}
\* {
    printf("%s", yytext);
    charNum += yyleng;
    return MUL;
}
\/ {
    printf("%s", yytext);
    charNum += yyleng;
    return DIV;
}
\( {
    printf("%s", yytext);
    charNum += yyleng;
    return LP;
}
\) {
    printf("%s", yytext);
    charNum += yyleng;
    return RP;
}
\[ {
    printf("%s", yytext);
    charNum += yyleng;
    return LB;
}
\] {
    printf("%s", yytext);
    charNum += yyleng;
    return RB;
}
\{ {
    printf("%s", yytext);
    charNum += yyleng;
    return LC;
}
\} {
    printf("%s", yytext);
    charNum += yyleng;
    return RC;
}
{space} {
    printf("%s", yytext);
    charNum++;
}
\n {
    lineNum++;
    charNum = 1;
    return NEWLINE;
}
%%
