#include "libs/std_lib_facilities.h"

int main() {
	double distanceMiles = 1;
	double distanceKilometers = 1;

	cout << "Enter your distance in miles: \n";
	cin >> distanceMiles;
	distanceKilometers = distanceMiles * 1.609;
	cout << "You have traveled " << distanceKilometers << " kilometers.\n";

}
