#include "libs/std_lib_facilities.h"

double calcMedian(vector<double>& distances) {
	sort(distances);
	if (distances.size()%2 == 0) {
		return (distances[distances.size() / 2 - 1] + distances[distances.size() / 2]) / 2.0;
	} else {
		return distances[distances.size()/2];
	}
}


int main () {
	vector<double> distances;
	double sum = 0;

	cout << "Please enter a series of random distances: \n";
	for (double distance; cin >> distance;)
		distances.push_back(distance);
	cout << "Distances listed are: \n";
	
	// call the calMedian function
	double median =	calcMedian(distances);
	
	for (int i = 0; i < distances.size(); ++i) {
		sum += distances[i];
		cout << distances[i] << '\n';
	}
	

	cout << "Sum of distances: " << sum << '\n';
	cout << "Smallest Distance: " << distances[0] << '\n'; 
	cout << "Largest Distance: " << distances[distances.size()-1] << '\n';
	cout << "Median of Distances: " << median << '\n';

}

