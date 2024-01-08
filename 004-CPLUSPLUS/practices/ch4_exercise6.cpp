#include "libs/std_lib_facilities.h"

int convertNumber (const string& userInput) {
	if (userInput == "One") {
		cout << 1 << '\n'; 
	} else if (userInput == "Two") {
		cout << 2 << '\n';
	} else if (userInput == "Three") {
		cout << 3 << '\n';		
	} else if (userInput == "Four") {
		cout << 4 << '\n';
	} else if (userInput == "Five") {
		cout << 5 << '\n';
	} else if (userInput == "Six") {
		cout << 6 << '\n';
	} else if (userInput == "Seven") {
		cout << 7 << '\n';
	} else if (userInput == "Eight") {
		cout << 8 << '\n';
	} else if (userInput == "Nine") {
		cout << 9 << '\n';
	} 

	if (userInput == "1") {
		cout << "One" << '\n';
	} else if (userInput == "2"){
		cout << "Two" << '\n';
	} else if (userInput == "3") {
		cout << "Three" << '\n';
	} else if (userInput == "4") {
		cout << "Four" << '\n';
	} else if (userInput == "5") {
		cout << "Five" << '\n';
	} else if (userInput == "6") {
		cout << "Six" << '\n';
	} else if (userInput == "7") {
		cout << "Seven" << '\n';
	} else if (userInput == "8") {
		cout << "Eight" << '\n';
	} else if (userInput == "9") {
		cout << "Nine" << '\n';
	}
	return 0;
}

int main() {
const vector<string>spelledNumbers = {"One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"};
	
	string userInput;
	while (cin >> userInput) {
		convertNumber(userInput);
	}


//	for (int i = 0; i < spelledNumbers.size(); ++i) {
//		string temp = spelledNumbers[i];
//		convertNumber(temp);		
//	}
}
