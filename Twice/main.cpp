#include <iostream>
#include "sample.tab.h"

extern FILE* yyin;

void yy::parser::error(std::string const& err)
{
	std::cout << "It's one of the bad ones... " << err << std::endl;
}
int main()
{
	yy::parser parser;
	parser.parse();

	return 0;
}