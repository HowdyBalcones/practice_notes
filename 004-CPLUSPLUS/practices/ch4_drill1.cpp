#include "libs/std_lib_facilities.h"

// // This is actually drills 1, 2, 3, 4, 5, 6, 7, 
// int main() {
// 	double v1 = 0;
// 	double v2 = 0;
// 	double i = 0;
// 
// 	while (cin >> v1 >> v2) {
// 		if (v1 > v2)
// 			cout << "The larger value is: " << v1 << '\n'
// 			<< "The smaller value is: " << v2 << '\n';
// 		else if (v2 > v1) {
// 			cout << "The larger value is: " << v2 << '\n'
// 			<< "The smaller value is: " << v1 << '\n';	
// 		} else if (v1 == v2) {
// 			cout << "Both " << v1 << " and " << v2 << " are equal.\n";
// 		} 
// 			       
// 		if (v1 <= v2+0.01 && v1 >= v2-0.01) {
// 			cout << "The numbers are within 0.01 units.\n";
// 		} else if (v2 <= v1+0.01 && v2 >= v1-0.01) {
// 			cout << "The numbers are within 0.01 units.\n";
// 		}
// 	}
// 	       
// }

int main() {
	
	double uInput = 0;
	double rememberLast = 0;
	double counter = 0;
	double largest = 0;
	double lowest = 0;
	double smaller = 0;
	double sum = 0;
	double converted = 0;

	vector<double> list = {};
	
	constexpr double m = 1;
	constexpr double cm = m/100;
	constexpr double in = cm*2.54;
	constexpr double ft = in*12;

	string unit = "";

	while (cin >> uInput >> unit) {
		
		if (unit == "cm" || unit == "in" || unit == "ft" || unit == "m") {
							// parent if statement 
							// ensure the units are correct
		++counter;
	//	cout << "" << uInput*unit << '\n';
							// iterate the counter
		if (unit == "cm") {
			converted = uInput*cm;
			cout << "You entered: " << converted << " meters.\n";
		} else if (unit == "m") { 
			converted = uInput*m;
			cout << "You entered: " << converted << " meters.\n";		
		} else if (unit == "in") {
			converted = uInput*in;
			cout << "You entered: " << converted << " meters.\n";
		} else if (unit == "ft") {
			converted = uInput*ft;
			cout << "You entered: " << converted << " meters.\n";
		} 
		
		uInput = converted; 			// we convert the input at this point to meters

		list.push_back(converted);		// push converted input onto vector

		if (uInput > largest) {
			largest = uInput;
			cout << "This number is the largest entered so far: " << uInput << unit << '\n'; 
		} else if (uInput < largest) {
			smaller = uInput;
			cout << "This number is smaller than the largest so far: " << smaller << unit << '\n';	
		}
	       
		if (lowest == 0 || uInput < lowest) {
			lowest = uInput;
			cout << "This number is the smallest so far: " << lowest << " meters" << '\n';
		}

		sum += uInput;	
		
		cout << "This is the lowest value so far: " << lowest << " meters" << '\n';
		cout << "This is the largest value so far: " << largest << " meters" << '\n';
		cout << "This is the sum of entered values: " << sum << " meters" << '\n';
		cout << "You have entered: " << counter << " values.\n";
		sort (list);
		for (double i : list) {
			cout << "All of the values so far: " << i << '\n';
		}
		
		} else { 
		cout << "Please enter a valid unit! -- cm, m, in, ft \n";
		}
	}
}

// we need to clarify the variables with better naming 
// we need to count number of times values have been entered with a new variable
// need a variable for the least of the values entered so far
// we need to accurately sum the values after each entry
// figure out the units conversion problem
