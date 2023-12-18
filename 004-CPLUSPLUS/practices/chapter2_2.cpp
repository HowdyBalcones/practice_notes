#include "libs/std_lib_facilities.h"

int main(){
	cout<<"PLEASE ENTER YOUR FIRST AND LAST NAME\n";
	string first;
	string second;
	int third;
	
	cin >> first >> second >> third; // this is reading in your variables from user input, white space FS
	
	double fourth=third*12; // here we make a fourth variable, age in months, using the 3rd variable input
	string fifth=second+first;

	cout << "Hello, " << first << " " << second << '\n';
	cout << "You are " << third << " years old.\n" ;
	cout << "You are " << fourth << " months old.\n";
	cout << "Your names backward are " << fifth << "\n";
}
