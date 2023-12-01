#include "libs/std_lib_facilities.h"

int main() {
	cout << "Please enter your first name (followed by 'enter'):\n";
	string first_name;	// DEFINITION: first_name is a variable of type string
	cin >> first_name;	// TAKE INPUT: read characters into first_name
	cout << "Hello, "<<first_name<<"!\n" ;  
}
