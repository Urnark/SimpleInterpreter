#pragma once

#include "../flex_bison/location.hh"
#include <string>
#include <iostream>

namespace twice
{
	class Loc : public yy::location
	{
	private:
		std::string _filepath;
	public:
		Loc();
		Loc(std::string* filename, const std::string& filepath);
		int bline() const;
		int bcolumn() const;
		int eline() const;
		int ecolumn() const;
		std::string filename() const;
		std::string filepath() const;

		friend std::ostream& operator<<(std::ostream& stream, const twice::Loc& loc);
	};

	template<class T>
	class Token
	{
	public:
		twice::Loc loc;
		T data;
		Token() {};
		Token(twice::Loc location, T d) : loc(location), data(d) {};
	};
}