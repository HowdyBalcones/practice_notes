#include "libs/std_lib_facilities.h"

class Bad_area{};

void error(string s) {
	throw runtime_error(s);
}

int area (int length, int width) {
	if (length<=0 || width <= 0) throw Bad_area{}; 
	return length*width;
}

int framed_area(int x, int y) {

constexpr int frame_width = 2;
//if (x-frame_width<=0 || y-frame_width<=0)
//	error("non positive area() argument called by framed_area()");
return area(x-frame_width, y-frame_width);

}

int f( int x, int y, int z ) {

	int totalArea = area(x,y);
	// if(totalArea <= 0) error("non-positive area");
	int framedArea = framed_area(x,z);
	int framedArea2 = framed_area(y,z);
	double ratio = double(totalArea)/(framedArea + framedArea2);
	cout << 
	"Total Area: "	<< totalArea << '\n' 
	<< "Framed Area Vertical: " << framedArea << '\n' 
	<< "Framed Area Horizontal: "	<< framedArea2 << '\n' 
	<< "Picture Area by Framed Area: "	<< ratio << '\n';
	return 0;
}

int main() {

	int width = 4;
	int length = 3;
	int height = 3;

	try {
	//	int x = -1;
	//	int y = 2;
	//	int z = 4;

	//	int totalArea = area(x,y);
	//	int framedArea = framed_area(x,z);
	//	int framedArea2 = framed_area(y,z);
	//	double ratio = totalArea/framedArea2;
	
		area(width, length);
		f(width, length, height);
	}

	catch(Bad_area) {
		cout << "Oops! bad arguments to area()\n";
	} 
	catch(runtime_error& e) {
		cerr << "runtime error: " << e.what() << '\n';
		keep_window_open();
		return 1;
	}


	//	cout << f(width, length, height) << '\n';
	//	f(width, length, height);
}
