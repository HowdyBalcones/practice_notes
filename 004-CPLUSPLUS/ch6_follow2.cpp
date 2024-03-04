#include "libs/std_lib_facilities.h"


class Token {
	public:
		char kind;
		double value;
};

vector<Token>tok;

// read characters and compose tokens
// use cin
Token get_token()
{
	
}

// deal with *,/, and %
// calls primary() and get_token()
char term()
{
	return 0;
}


// deal with + and - 
// calls term() and get_token()
double expression()
{
	double left = expression();
	Token t = get_token();
	switch (t.kind) {
		case '+':
			return left + term();
		case '-':
			return left - term();
		default:
			return left;
	}
}



// deals with numbers and parentheses
// calls expression() and get_token()
string primary()
{
	return 0;
}

int main()
{

}
