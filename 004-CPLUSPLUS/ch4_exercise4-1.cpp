#include "libs/std_lib_facilities.h"

bool isHigher (const string& userInput) {

	if (userInput == "y" || userInput == "Y" || userInput == "yes" || userInput == "Yes") {
		return true;
	} else if (userInput == "n" || userInput == "N" || userInput == "no" || userInput == "No") {
		return false;
	} else {
		cout << "Invalid Input!: " << userInput << '\n';
		return 0;
	}
	
}

int main () {
	
	int low = 1;
	int high = 100;
	int playerNumber;
	
	int pGuess = low + (high - low) / 2;
	string userInput;


	cout << "Please enter a number between 1 and 100 -- " << '\n';
	cin >> playerNumber;
	
	cout << "Is your number higher than " << pGuess << " ? -- y/n \n";
	
	while (cin >> userInput) {
	bool response = isHigher(userInput);
	
	// This will adjust the guess based on higher than or lower than
	if (response == true && pGuess != low) {
	low = pGuess;
	pGuess = low + (high - low) / 2;
	cout << "Is your number higher than " << pGuess << "? \n";

	} else if (response == false && pGuess != low ) {
	high = pGuess;
	pGuess = low + (high - low) / 2;
	cout << "Is your number higher than " << pGuess << "? \n";
	
	} 
       
	if ( pGuess == low) {
		bool finalGuess = false;	
		if (pGuess == low && finalGuess == false) {
		cout << "Is your number " << pGuess + 1 << " ? -- y/n\n";
		finalGuess = true;
		}
		
		if ( response == true && finalGuess == true) {
		cout << "Your number is " << pGuess + 1 << " ! \n" << "Guessing Game Exiting...\n";
		} 
	}
	}
}
