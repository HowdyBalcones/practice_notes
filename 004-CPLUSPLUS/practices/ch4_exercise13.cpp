#include "libs/std_lib_facilities.h"


// This is a program to calculate quadratic equations
// ax^2 + bx + c = 0

double square(double number = 0) {
	double squared = number * number;
	return squared;
}

double giveQuadratic(double a = 0, double b = 0, double c = 0, double x = 0, double xSquared = 0, double result1 = 0, double result2 = 0) {

	cout << "Enter your x value: " << '\n';
	cin >> x;
		

	xSquared = square(x);
	cout << "Your square is: " << xSquared * -1 << '\n';
	return xSquared;
}

int main() {
	double a = 0;
	double b = 0;
	double c = 0;
	double x = 0;
	double xSquared = 0;
	double result1 = 0;
	double result2 = 0;
	

	giveQuadratic(x);

}
