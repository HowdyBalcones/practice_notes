#include "libs/std_lib_facilities.h"
#include <iostream>
#include <vector>
#include <algorithm>


double calcMedian(vector<double>& nums) {
	sort(nums);

	if (nums.size()%2 == 0) {
		return (nums[nums.size() / 2 - 1] + nums[nums.size() / 2]) / 2.0;
	} else { 
		return nums[nums.size()/2];
	}	
}


int main() {
	vector<double>numbers = {1.6, 2.2, 3.1, 4.9, 5.4, 6.9};

	sort(numbers);

	double median = calcMedian(numbers);
	cout << "The median is: " << median << endl;
	return 0;
}

// we are trying to calculate a true median. 
// Need to find if  the vector is even or odd
// if even, we need to find the middle two values 
// then we find the median between those two values
// that is the median value of the vector if even
// otherwise use the method above
