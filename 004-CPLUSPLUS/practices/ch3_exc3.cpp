#include "libs/std_lib_facilities.h"

int main() {
	int val1;
	int val2;

	cout << "Please enter two whole numbers: \n";
	cin >> val1 >> val2;
	
	if(val1 > val2)
		cout << val1 << " is greater than " << val2 << "\n";
	else
		cout << val2 << " is greater than " << val1 << "\n";

	cout << "Difference:\t" << val1 - val2 << "\n";
	cout << "Product:\t" << val1 * val2 << "\n";
	cout << "Ratio:\t" << val1/val2 << "\n";


}
