#include "libs/std_lib_facilities.h"





bool checkResponse(string &userInput) {
	

	if (userInput == "yes" || userInput == "y" || userInput == "Y") {
		return true;
	} else if (userInput == "no" || userInput == "n" || userInput == "N") {
		return false;
	} else {
		cout << "Invalid input. Please enter yes or no or JAIL.\n";
		return false;
	}
}


int main() {
	
	vector<double> randomNumbers;
	
	double userNumber = 0;
	string userInput;
	bool higher = false;
	bool lower = false;


	cout << "Please enter a number between 1 and 100\n" << "This program will try to guess your number. Answer Y or N\n";
	cin >> userNumber;
	
	if ( userNumber > 100 || userNumber < 1 ) {
		cout << "Error: Follow Directions or 45 year JAIL! \n";
	}	

	cout << "Is your number greater than 50?\n";
	cin >> userInput;
	
	bool userResponse = checkResponse(userInput);


	if (userResponse == true) {
		cout << "Is your number greater than 75?" << '\n';
		cin >> userInput;	
		userResponse = checkResponse(userInput);
			if (userResponse == true) {
				cout << "Is your number greater than 87?" << '\n';
				cin >> userInput;
				userResponse = checkResponse(userInput);
					if (userResponse == true) {
						cout  << "Is your number greater than 93?" << '\n';
						cin >> userInput;
						userResponse = checkResponse(userInput);
						if (userResponse == true) {
							cout << "Is your number "
						}
					}
		} else if (userResponse == false) {
			cout << "Is your number 50 or 75?" << '\n';
		}

	} else if (userResponse == false) {
		cout << "Is your number greater than 25?" << '\n';
		cin >> userInput;
	}

//	if (userResponse == true) {
//		cout << "Is your number greater than 87?" << '\n';
//	} else {
//		cout << "Is your number greater than 12?" << '\n';
//	}
//
//	cin >> userInput;	
//	userResponse = checkResponse(userInput);
//
//	if (userResponse == true) {
//		cout << ""
//	}
	

		

	cout << "Your number is: " << userNumber << '\n';
}
