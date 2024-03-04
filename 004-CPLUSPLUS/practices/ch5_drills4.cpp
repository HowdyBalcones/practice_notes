#include "libs/std_lib_facilities.h"

int main() 
{
	// input any key to give High, Low, and Avg
	// This program is designed to break so beware
	vector<double> temps;
	for (double temp; cin >> temp;)
		temps.push_back(temp);

	static	double sum = 0;
	static	double high_temp = 0;
	static 	double low_temp = 0;

	for (int x : temps)
	{
		if (x > high_temp) high_temp = x;
		if (x < low_temp) low_temp = x;
		sum += x;
	}

	cout << "High temperature: " << high_temp << '\n';
	cout << "Low temperature: " << low_temp << '\n';
	cout << "Average temperature: " << sum/temps.size() << '\n';


}
