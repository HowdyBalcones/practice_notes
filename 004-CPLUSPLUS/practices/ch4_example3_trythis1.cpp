#include "libs/std_lib_facilities.h"

int main() {

	constexpr double koner_per_dollar = 0.091;
       	constexpr double yen_per_dollar = 0.0068;
	constexpr double pound_per_dollar = 1.26;
	constexpr double dollar = 1;
	double user_value = 0;
	char unit = 0;
	

	cout << "Please enter amount of dollars followed by exchange currency type\n";
	cout << "Currency types -- y, k, p \n\n";

	cin >> user_value >> unit;

	if (unit == 'y')
		cout << user_value << " dollars == " << user_value/yen_per_dollar << " yen \n";
	else if (unit == 'k')
		cout << user_value << " dollars == " << user_value/koner_per_dollar << " koner \n";
	else if (unit == 'p')
 		cout << user_value << " dollars == " << user_value/pound_per_dollar << " pound \n";
	else 
		cout << "Please enter a valid exchange currency: y, k, p\n";

}
