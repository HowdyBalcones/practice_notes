#include "libs/std_lib_facilities.h"
#include <vector>

int main() {

vector<int> v= {1,2,3,4,5,6};
vector<int> v2(6);
vector<int> v3;

int i = 0;
int vSize = v[v.size()-1];


v3.push_back(99);
v3.push_back(999);
v3.push_back(1111);

for (i = 0; i < vSize; ++i) {			// traditional for loop over array
	cout << v[i] << '\n';
}

for (int x : v2)				// This is a C++11 extension, less flexible, it means loop over vector range.
	cout << x << '\n';


cout << v3[0] << '\n';

return 0;
}
