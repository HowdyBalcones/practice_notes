#include "libs/std_lib_facilities.h"

int main() {

	string operation;
	int num1;
	int num2;

	cout << "Please enter an operation followed by two numbers: \n";
	cin >> operation >> num1 >> num2;

	if (operation == "+") {
		cout << num1 + num2 << "\n";
	} else if (operation == "-") {
		cout << num1 - num2 << "\n";
	} else if (operation == "*") {
		cout << num1 * num2 << "\n";
	} else if (operation == "/") {
		cout << num1 / num2 << "\n";
	} else {
		cout << operation << " IS AN UNKNOWN OPERATION" << "\n";
	}
}
