#include "libs/std_lib_facilities.h"

bool isHigher(const string& prompt) {
	string userInput;
	cout << prompt;
	cin >> userInput;
	if (userInput == "yes" || userInput == "y" || userInput == "Y") 
	{
		return true;
	} else {
		return false;
	}
}

int main() 
{

	int low = 1;
	int high = 100;
	int guess;

	cout << "Think of a number between " << low << " and " << high << ".\n";

	while (low < high) {
		guess = low + (high - low) / 2;
		if (isHigher("Is your number higher than " + to_string(guess) + "? (y/n) ")) {
			low = guess + 1;
	} else {
			high = guess;
	}
	cout << "Your number is: " << low << "\n";
	return 0;
	}
}
