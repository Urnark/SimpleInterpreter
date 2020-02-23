%skeleton "lalr1.cc" 
%require "3.2"
%defines
%define api.value.type variant
%define api.token.constructor

%code requires {
}

%code{
    #include <string>
    #define YY_DECL yy::parser::symbol_type yylex()
    YY_DECL;

    extern yy::location location;
}

%token
  ENDOF 0 "end of file"
;

%token <std::string> IDENTIFIER NEWLINE
%token <double> NUM

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
  NUM                                                         { std::cout << "number: " << yy::location() << ", " << $1 << std::endl; }
  | IDENTIFIER                                                { std::cout << "identifier: " << $1 << std::endl; }
  ;

%%