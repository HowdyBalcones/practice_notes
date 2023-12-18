#include "libs/std_lib_facilities.h"

int main() {

	constexpr  double koner_per_dollar = 0.091;
	constexpr double yen_per_dollar = 0.0068;
	constexpr double pound_per_dollar = 1.26;
	constexpr double dollar = 1;
	double user_value = 0;
	char unit = 0;

	cout << "Please enter amount of dollars followed by the currency you are converting to: \n";
	cout << "Currency types are -- y, k, p, d \n\n";
	cin >> user_value >> unit;

	switch(unit) {
		case 'y':
			cout << user_value << " dollars == " << user_value/yen_per_dollar << " yen \n";
			break;
		case 'k':
			cout << user_value << " dollars == " << user_value/koner_per_dollar << " koner \n";
			break;
		case 'p':
			cout << user_value << " dollars == " << user_value/pound_per_dollar << " pound \n";
			break;
		case 'd':
			cout << user_value << " yen == " << yen_per_dollar*user_value << " dollar \n";
			cout << user_value << " koner  == " << koner_per_dollar*user_value << " dollar \n";
			cout << user_value << " pound == " << pound_per_dollar*user_value << " dollar \n";
			break;
		default:
			cout << "That is an unknown currency exchange.\n";
			break;
	}
}
