#include <iostream>
#include "../flex_bison/sample.tab.h"
#include "../flex_bison/location.hh"

extern FILE* yyin;

void yy::parser::error(const yy::location&loc, std::string const& err)
{
	std::cout << "It's one of the bad ones... " << err << ", loc: " << loc << std::endl;
}
int main()
{
	std::string filename = "test.twi";
	std::string scriptsFolder = "scripts/";
	if (fopen_s(&yyin, (scriptsFolder + filename).c_str(), "r") != 0)
	{
		std::cout << "could not open file [" << scriptsFolder + filename << "]" << std::endl;
	}

	yy::parser parser;
	parser.parse();

	if (yyin)
		fclose(yyin);

	return 0;
}