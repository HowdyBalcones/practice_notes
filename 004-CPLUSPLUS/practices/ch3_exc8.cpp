#include "libs/std_lib_facilities.h"

int main() {
	
	string userNumber1;
	cout << "Please write out a number; as in one, two, three, etc.\n";
	
	cin >> userNumber1;
	if (userNumber1 == "one" || userNumber1 == "One") {
		cout << "Your number " << userNumber1 << " is also -- 1\n";
	} else if (userNumber1 == "two" || userNumber1 == "Two") {
		cout << "Your number " << userNumber1 << " is also -- 2\n";
	} else if (userNumber1 == "three" || userNumber1 == "Three") {
		cout << "Your number " << userNumber1 << " is also -- 3\n";
	} else if (userNumber1 == "four" || userNumber1 == "Four") {
		cout << "Your number " << userNumber1 << " is also -- 4\n";
	} else {
		cout << "What the fuck is that?\n";
	}
}
