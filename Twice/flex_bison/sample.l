%top{
#include "sample.tab.h"
#include "../src/helper.h"
#include <string>
#define YY_DECL yy::parser::symbol_type yylex()

twice::Loc* curLoc;

const yy::location& next_column(int count = 1);
const yy::location& next_line(int count = 1);

void flex_error(const twice::Loc& loc, const std::string& text);
}

%option noyywrap nounput batch noinput

WORD [a-zA-Z][a-zA-Z0-9]*
NUM ([0-9]*)|([0-9]*\.[0-9]+)

BLANK [ \t]
NL [\n\r]

TEXT [^"\\\n]*
%%

{WORD}+                                  { return yy::parser::make_IDENTIFIER(twice::Token<std::string>(*curLoc, yytext), next_column(yyleng)); }
{NUM}+                                   { return yy::parser::make_NUM(twice::Token<double>(*curLoc, std::stod(yytext)),next_column(yyleng)); }
{NL}                                     { return yy::parser::make_NEWLINE(twice::Token<std::string>(*curLoc, yytext), next_line()); }
{BLANK}+                                 { next_column(yyleng); }

.                                        { next_column(yyleng); flex_error(*curLoc, yytext); }
<<EOF>>                                  { return yy::parser::make_ENDOF(next_line()); }
%%

const yy::location& next_column(int count)
{
    curLoc->step();
    curLoc->columns(count);
    return *dynamic_cast<yy::location*>(curLoc);
}

const yy::location& next_line(int count)
{
    curLoc->step();
    curLoc->lines(count);
    return *dynamic_cast<yy::location*>(curLoc);
}

void flex_error(const twice::Loc& loc, const std::string& text)
{
	std::cout << loc << ": " << "ERROR: Unrecognized character '" << text << "'" << std::endl;
}