#include "libs/std_lib_facilities.h"

// exceptions for input
// make a function to throw runtime_error and pass it an argument
void thisError(string s) {
	throw runtime_error(s);
}

// this is the example function we're checking
double given_function() {
	double d = 0;
	cin >> d;
	if (!cin) thisError("Couldn't Read double in given_function()");
	return 0;
}

int main() {
// Here we try the test function, catching runtime_error which should come from our error() function inside given_function()
// Worth noting, out_of_range is not a runtime_error, they are handled separately

	try {
		given_function();
		return 0;
	}	

	catch(runtime_error& e) {
		cerr << "runtime error: " << e.what() << '\n';
		keep_window_open();
		return 1;
	}

	catch(exception& e) {
		cerr << "error: " << e.what() << '\n';
		keep_window_open();
		return 1;
	}

	catch(...) {
		cerr << "Oops: Unknown exception!\n";
		keep_window_open();
		return 2;
	}

// use this if you need to pass error() multiple pieces of information
// void error(string1, string2)
// {
// throw runtime_error(s1+s2);
// }

//	double d = 0;
//	cin >> d;
//
//	if (cin) {
//		// This will test if cin is legit
//		cout << "This is what you entered: " << d << '\n';
//	} else {
//		// If something failed do this
//		cout << "Error !" << '\n';
//	}

}
