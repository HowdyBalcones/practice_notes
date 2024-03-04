#include "libs/std_lib_facilities.h"

class Bad_temp{};

double ctok(double celsius)	// converts celsius to kelvin
{
	if (celsius <= -273.15) throw Bad_temp{};
	int kelvin = celsius + 273.15;
	return kelvin;
}

int main() 
{
	try {
	double celsius;

	cout << "Please enter a value for temp in Celsius: " << '\n';
	cin >> celsius;
	double kelvin = ctok(celsius);
	cout << "Your temperature in kelvin: " << kelvin << '\n';
	} 
	catch (Bad_temp) {
	cout << "Your temp is below absolute zero!" << '\n';
	}
}

