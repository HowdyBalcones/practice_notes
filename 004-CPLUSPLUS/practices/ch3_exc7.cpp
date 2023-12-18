#include "libs/std_lib_facilities.h"

int main() {

	int userNum1;

	cout << "Please enter a single number: \n";
	cin >> userNum1;

	if (userNum1 % 2 != 0 ) {
		cout << "The number " << userNum1 << " is an odd number.\n";
	} else {
		cout << "The number " << userNum1 << " is an even number.\n";
	}
}
