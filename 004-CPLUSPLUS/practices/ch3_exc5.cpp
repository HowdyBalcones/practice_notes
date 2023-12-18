#include "libs/std_lib_facilities.h"

int main() {

	double num1;
	double num2;
	double num3;

	cout << "Please enter 3 whole numbers.\n";
	cin >> num1 >> num2 >> num3;

	if(num1 == num2) {
		cout << "First and Second numbers are equal.\n";
	cout << num1 << " " << num2 << " " << num3 << "\n"; 
	}
	else if(num1 == num3) {
		cout << "First and Third numbers are equal.\n";
		cout << num1 << " " << num3 << " " << num2 << "\n";
	}
	else if(num2 == num3) {
		cout << "Second and Third numbers are equal.\n";
		cout << num1 << " " << num2 << " " << num3 << "\n";
	}
	else { 
		cout << num1 << " " << num2 << " " << num3 << "\n";
	}
}
