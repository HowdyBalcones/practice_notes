#include "libs/std_lib_facilities.h"

int main() {
	vector<double>temps;
	for (double temp; cin>>temp;)
		temps.push_back(temp);
	int i = 0;
	
	for (i = 0; i < temps.size(); ++i) {
		cout << temps[i] << '\n';
	}
	double sum = 0;
	for (double x : temps) sum += x;
	cout << "Average Temperature: " << sum/temps.size() << '\n';
	
	sort(temps);
	cout << "Median Temperature: " << temps[temps.size()/2] << '\n';


	return 0;
}
