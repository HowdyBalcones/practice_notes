#include "libs/std_lib_facilities.h"

int main() {

	double d =0; // make a double
	double u{12.1245};
	int u2{u};
	while(cin>>d){ // this means while there is keyboard input

		int i = d; // try to squeeze d into i
		char c = i; // try to put int into char
		int i2 = c; // try to put char back into int
		cout << "d==" << d 
			<< "i=="<< i
			<< "i2=="<< i2
			<< " char("<< c << ")\n"
			<< " what? -- " << u << u2 << "\n";
	}

}
