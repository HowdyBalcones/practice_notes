#include "libs/std_lib_facilities.h"

int main()
{
	// These test for narrowing errors, though that seems as if it would be simple enough to identify 
	// narrow_cast<type>(); will throw on initialization

	// int x1 = narrow_cast<int>(2.9); // throws
	int x2 = narrow_cast<int>(2.0); // OK
	// char c1 = narrow_cast<char>(1066); // throws
	char c2 = narrow_cast<char>(85); // OK

	try {
	//	cout << x1 << '\n';
		cout << x2 << '\n';
	//	cout << c1 << '\n';
		cout << c2 << '\n';
	}
	catch (runtime_error) {
		cout << "Hello I am a runtime_error of some kind !";
	}	
}
