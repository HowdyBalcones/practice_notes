#include "libs/std_lib_facilities.h"

int main() {
	cout << "Please enter a floating point value: ";
	int n;
	cin >> n;
	cout << "n == "<< n
		<< "\nn+1 == " << n+1
		<< "\nthree times n == "<<3*n
		<< "\ntwice n == " << n+n
		<< "\nhalf of n == " << n/2
		<< "\nn modulo 3 == " << n%3
		<< "\nn squared == " << n*n
		<< "\nsquare root of n == " << sqrt(n)
		<< '\n';
}
