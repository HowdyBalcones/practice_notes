#include "libs/std_lib_facilities.h"

int main() 
{
	double userX = 0;
	double userY = 0;
	char opps = 0;
	cout << "Enter your math problem as: X operator Y \n";
	while (cin >> userX >> opps >> userY) {
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
