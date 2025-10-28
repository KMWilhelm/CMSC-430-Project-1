/* Name: Katrina Wilhelm
 *  Date: 10/26/2025
 *  CMSC 430 Project 1
 *  This file contains flex input file
 *  
 */


%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		("//".*|--.*)\n
line		[\n]
id  [A-Za-z]([A-Za-z0-9]|_[A-Za-z0-9]|__([A-Za-z0-9]))*
digit		[0-9]
dec		{digit}+
hex         \#[0-9A-Fa-f]+
char    \'([^\\'\n]|\\[btnrf])\'
punc		[\(\),:;]
real    [0-9]*\.[0-9]+([eE][+-]?[0-9]+)?
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }
"+"|"-"		{ ECHO; return(ADDOP); }
"*"|"/"		{ ECHO; return(MULOP); }
"%"     { ECHO; return(REMOP); }
"^"		{ ECHO; return(EXPOP); }
"~"		{ ECHO; return(NEGOP); }
"&"		{ ECHO; return(ANDOP); }
"<"		{ ECHO; return(RELOP); }
"=>"		{ ECHO; return(ARROW); }
"|"			{ ECHO; return(OROP); }
"!"			{ ECHO; return(NOTOP); }
"<"|">"|">="|"<="|"="|"/="	{ ECHO; return(RELOP); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of		{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		{ ECHO; return(WHEN); }
else		{ ECHO; return(ELSE); }
elsif		{ ECHO; return(ELSIF); }
endfold		{ ECHO; return(ENDFOLD); }
endif		{ ECHO; return(ENDIF); }
fold		{ ECHO; return(FOLD); }
if			{ ECHO; return(IF); }
left		{ ECHO; return(LEFT); }
real		{ ECHO; return(REAL); }
right		{ ECHO; return(RIGHT); }
then		{ ECHO; return(THEN); }


{id}		{ ECHO; return(IDENTIFIER);}
{hex}       { ECHO; return(INT_LITERAL); }
{dec}		{ ECHO; return(INT_LITERAL); }
{char}		{ ECHO; return(CHAR_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.			{ ECHO; appendError(LEXICAL, yytext); }
{real}      { ECHO; return(REAL_LITERAL); }

%%

int main() {
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token) {
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}