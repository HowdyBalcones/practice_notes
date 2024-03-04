#include "libs/std_lib_facilities.h"

int area(int length, int width) {
	if (length<=0) error("non-positive length");
	if (width<=0) error("non-positive width");

	// another style would be 
	// if (length<=0 || width<=0) return -1;
	// would return -1 on an error condition

	int calcArea = length*width;
	return calcArea;
}

int main() {
	int length;
	int width;
	int area(int length, int width);

	cout << "Enter length and then width, separated by a space: " << '\n';
	cin >> length >> width;

	cout << area(length, width) << '\n';
}
