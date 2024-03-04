#include "libs/std_lib_facilities.h"

int area(int length, int width)
// calculate area of a rectangle
// pre-conditions: length and width are positive
// post-conditions: returns a positive value that is the area

{
	if (length <= 0 || width <= 0) error("area() pre-condition failed");
	int a = length*width;
	if (a <= 0) error("area() post-condition failed");
	return a;	
}

int main() {

	cout << area(1,1)*area(-1,-1) << '\n';

}
