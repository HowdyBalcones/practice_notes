#include "libs/std_lib_facilities.h"

// int main() {
// 	int i = 0;
// 	while (i<100) {
// 		cout << i << '\t' << pow(i, 2) << '\n';
// 		++i;
// 	}
// }

// int main() {
// 	char b = ('a'+1);
// 	int i = 0;
// 	while(i<=10) {
// 		cout << b << "\t" << i << "\n";   
// 		++i;
// 	}
// }

// int main() {
// 
// 	// for (int i = 0; i<100; ++i) {
// 	for (int i = 0; i<100; i+=2) {
// 		cout << i << '\t' << pow(i, 2) << "\n";
// 	}
// }

// int main() { 					// this is the program that shows char ASCII values
// 	for (char c = '0'; c <= 'z'; ++c) {
// 		cout << c << "\t" << +c << "\n";
// 	        cout << "----------------" << "\n";
// 	}
// 	cout << endl;
// 	return 0;
// 
// }

// void print_square(int v) {
// 	cout << v << '\t' << v*v << '\n';
// }
// 
// int main() {
// 	for (int i = 0; i<100; ++i) {
// 		print_square(i);
// 	}
// }

// int square (int x) {
// 	return x*x;
// }
// int main() {
// 	cout << "Enter a number to be squared: \n";
// 	cin >> y;
// 
// 	cout << square(2) << '\n';
// 	cout << square(10) << '\n';
// }




// int square2 (int y, int t) {
// 	int i;
// 	for (i = 0; i <= y; ++i ) {
// 		int t = 1;
// 		int z = t + y;
// 		t = z;
// 		cout << i << '\t' << t << '\n';
// 	} 
// 	return 0;  
// }
// int main() {
// 	
// 	int y;
// 	int t;
// 	
// 	cout << "Please input a number to square! \n";
// 	cin >> y;
// 	square2(y,t=0);
// }

int square2(int x) {
	int result = 0; 		// container for final result of square
	for (int i = 0; i < x; ++i) { 	// iterator, up to value of x
		cout << i << '\t' << result << '\n';
		result += x; 		// add result and x for each loop
	}
	return result;			// return result after loop completes
}

int main() {
	int number;
	cout << "Please input a number to square: \n";
	cin >> number;
	cout << "Your number to square is: " << number << "\n\n";
	int squared = square2(number); // call square2 function, pass in number as parameter x
	
	cout << "\n";
	cout << "Square of: " << number << " is " << squared << ".\n"; 
}
