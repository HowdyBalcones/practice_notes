#include "libs/std_lib_facilities.h"

// This is a test to see what an uncaught error looks like

void thiserror(string s) {
	throw runtime_error(s);
}

double given_function() {
	double d = 0;
	cin >> d;
	if (!cin) thiserror("Couldn't read double in 'given_function()'");
	return 0;
}


int main() {
	try {
		given_function();
		return 0;
	}
	catch (int) {

	}	
	

}
