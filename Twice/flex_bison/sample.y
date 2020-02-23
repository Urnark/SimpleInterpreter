%skeleton "lalr1.cc" 
%require "3.2"
%defines
%define api.value.type variant
%define api.token.constructor

%code requires {
  #include "../src/helper.h"
}

%code{
    #include <string>
    #define YY_DECL yy::parser::symbol_type yylex()
    YY_DECL;

    extern twice::Loc* curLoc;
}

%token
  ENDOF 0 "end of file"
;

%token <twice::Token<std::string>> IDENTIFIER NEWLINE
%token <twice::Token<double>> NUM

%start start
%type <std::string> stream optline stmt expr

%locations

%%
start: stream                                                 { }
  ;

stream: optline                                               { }
  | stream NEWLINE optline                                    { }
  ;

optline: /*empty*/                                            { }
  | stmt                                                      { }
  ;

stmt:
  expr                                                        { }
  ;

expr:
  NUM                                                         { std::cout << "number: " << curLoc->bline() << ", " << $1.loc << " | " << $1.data << std::endl; }
  | IDENTIFIER                                                { std::cout << "identifier: " << $1.data << std::endl; }
  ;

%%