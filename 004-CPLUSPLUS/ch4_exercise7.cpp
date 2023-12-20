#include "libs/std_lib_facilities.h"

int convertNumber (const string& userInput) {
	if (userInput == "One" || userInput == "one") {
		return  1; 
	} else if (userInput == "Two" || userInput == "two") {
		return  2;
	} else if (userInput == "Three" || userInput == "three") {
		return  3;		
	} else if (userInput == "Four" || userInput == "four") {
		return  4;
	} else if (userInput == "Five" || userInput == "five") {
		return  5;
	} else if (userInput == "Six" || userInput == "six") {
		return  6;
	} else if (userInput == "Seven" || userInput == "seven") {
		return  7;
	} else if (userInput == "Eight" || userInput == "eight") {
		return  8;
	} else if (userInput == "Nine" || userInput == "nine") {
		return  9;
	} 

//	if (userInput == "1") {
//		cout << "One" << '\n';
//	} else if (userInput == "2"){
//		cout << "Two" << '\n';
//	} else if (userInput == "3") {
//		cout << "Three" << '\n';
//	} else if (userInput == "4") {
//		cout << "Four" << '\n';
//	} else if (userInput == "5") {
//		cout << "Five" << '\n';
//	} else if (userInput == "6") {
//		cout << "Six" << '\n';
//	} else if (userInput == "7") {
//		cout << "Seven" << '\n';
//	} else if (userInput == "8") {
//		cout << "Eight" << '\n';
//	} else if (userInput == "9") {
//		cout << "Nine" << '\n';
//	}
	return 0;
}



int main() {

	string convertedUserX;
	string convertedUserY;
	int userX = 0;
	int userY = 0;
	char opps = 0;
	cout << "Enter your math problem as: X operator Y \n";


	while (cin >> convertedUserX >> opps >> convertedUserY) {
		userX = convertNumber(convertedUserX);	
		userY = convertNumber(convertedUserY);

		if (opps == '+') {
			cout << "The sum of " << userX << " and " << userY << " is "
			<< userX + userY << '\n' << "-----------\n";	
		}

		if (opps == '-') {
			cout << "The difference of " << userX << " and " << userY << " is "
			<< userX - userY << '\n' << "-----------\n";
		} 

		if (opps == '*') {
			cout << "The product of " << userX << " and " << userY << " is "
			<< userX * userY << '\n' << "-----------\n";
		} 

		if (opps == '/') {
			cout << "The quotient of " << userX << " and " << userY << " is "
			<< userX / userY << '\n' << "-----------\n";
		} 
	}



}
