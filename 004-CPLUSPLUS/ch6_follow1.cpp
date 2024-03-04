#include "libs/std_lib_facilities.h"

// take input, run calculator() on input
// calculator should take two arguments: double number and char math symbol
//

class Bad_symbol{};

double calculator(double lNumber, double rNumber, char symbol)
{
//		if (symbol == '+') {
//			cout << (lNumber + rNumber) << '\n';
//		} else if (symbol == '-') {
//			cout << (lNumber - rNumber) << '\n';
//		} else if (symbol == '*') {
//			cout << (lNumber * rNumber) << '\n';
//		} else if (symbol == '/') {
//			cout << (lNumber / rNumber) << '\n';
//		} else {
//			throw Bad_symbol{};
//		}

	

return 0;
}

class Token {
	public:
		char kind;
		double value;
};

int main() 
{
	int lNumber = 0;
	int rNumber;
	char symbol;
	
	cout << "Please enter + - * / for your operator." << '\n';
	cout << "add x to end the expression (2 + 2x): " << '\n';

	cin >> lNumber;
	if (!cin) error("no second operand");
	for (;cin>>symbol;) {
		if (symbol!='x') cin >> rNumber;
		if (!cin) error("no second operand");
		switch(symbol) {
			case '+':
				lNumber += rNumber;
				break;
			case '-':
				lNumber -= rNumber;
				break;
			case '*':
				lNumber *= rNumber;
				break;
			case '/':
				lNumber /= rNumber;
				break;
			default:
				cout << "Result: " << lNumber << '\n';
				return 0;
		}
	}
error("Bad Expression");
//		cin >> lNumber >> symbol >> rNumber;
//		try {
//			calculator(lNumber, rNumber, symbol);
//		}
//		catch(Bad_symbol) {
//			cout << "Bad Symbol:" << '\n';
//		}


}
