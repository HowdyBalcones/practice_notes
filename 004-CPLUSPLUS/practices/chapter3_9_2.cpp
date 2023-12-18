#include "libs/std_lib_facilities.h"


// Example of narrowing conversions, where a value is passed to a type that is too small to hold its data. 

int main() {
	int a = 20000;
	char c = a;
	int b = c;
	if(a!=b)
		cout << "oops!:" <<a<<"!="<<b<<'\n';
	else
		cout << "Wow! We have large characters\n";
}
