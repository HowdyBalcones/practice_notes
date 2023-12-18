#include "libs/std_lib_facilities.h" 

int main() {
	double penny = 0.01;
	double nickel = 0.05;
	double dime = 0.10;
        double quarter = 0.25;
	double half_dollar = 0.50;
	double dollar = 1.00;
	
	double entryPenny;
	double entryNickel;
	double entryDime;
	double entryQuarter;
	double entryHalf_Dollar;
	double entryDollar;

	cout << "Please enter the amount of your coins: \nORDERED AS:  penny, nickel, dime, quarter, half_dollar, dollar\n";
	cin >> entryPenny >> entryNickel >> entryDime >> entryQuarter >> entryHalf_Dollar >> entryDollar;
	
	cout << "\n";
	cout << "The values of your change are listed below\n";
	
	if (entryPenny == 1) {
	cout << "Penny:\t\t" << penny * entryPenny << "\n";
	} else {
	cout << "Pennies:\t" << penny * entryPenny << "\n";
	}
	cout << "Nickels:\t" << nickel * entryNickel << "\n"; 
	cout << "Dime:\t\t" << dime * entryDime << "\n";
	cout << "Quarter:\t" << quarter * entryQuarter << "\n";
	cout << "Half Dollars:\t" << half_dollar * entryHalf_Dollar << "\n";
	cout << "Dollars:\t" << dollar * entryDollar << "\n";	

}
