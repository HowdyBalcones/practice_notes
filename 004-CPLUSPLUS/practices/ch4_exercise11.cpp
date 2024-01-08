#include "libs/std_lib_facilities.h"


double giveMode(vector<double>& nums) {
	sort(nums);
		double previous = 0;
		double previousCounter = 0;
		double mode = 0;
		double mostCounted = 0;
		vector<double>biModal;

	for (int i = 0; i <= nums.size(); ++i) {
		
		if (i == 1) {
			previous = i - 1;
		}
		
		if (nums[i] == nums[previous]) {
			previousCounter += 1;
		} 
	       
		if (previousCounter > mostCounted) {
			mostCounted = previousCounter;
			mode = nums[i];
		} else if (previousCounter == mostCounted) {
			biModal.push_back(mode);
			biModal.push_back(previousCounter);
		}

		if (nums[i] != nums[previous]) {
			previousCounter = 1;
		}


		cout << nums[i] << '\n';
		cout << "This is the most counted: " << mostCounted << '\n';
		cout << "This is the mode: " << mode << '\n';

	}

	return 0;
} 

int main() {
	vector<double>nums = {5,2,4,17,18,2,2,2.1,2.2,4.1,4.1,6.7,9,9,9};
	giveMode(nums);
}
