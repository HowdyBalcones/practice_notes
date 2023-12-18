#include "libs/std_lib_facilities.h"

int main() {

	cout << "Enter the name of the person you want to write to, then your newest friend.\n";
	string first_name;
	string new_friend;
	char friend_sex=0;
	double friend_age;

	cin >> first_name >> new_friend; // accept input from user
	cout << "What is your friends gender?\nEnter M for male, F for female, or T for anything else.\n\n";
	cin >> friend_sex;
	cout << "What is your friends age? Enter a number:";
	cin >> friend_age;
	if(friend_age>110 || friend_age<0) 
		simple_error("You're kidding!");

	cout << "\nDear, " << first_name << "\n";
	cout << "We hope this email finds you well " << first_name << ".\n\n";
	cout << "Have you spoken with " << new_friend << " recently?\n";
	if(friend_sex=='M') 
		cout << "If you see " << new_friend << " will you ask him to call me?\n";
	else if(friend_sex=='F')
		cout << "If you see " << new_friend << " will you ask her to call me?\n";
	else cout  << "If you see " << new_friend << " will you ask them to call me?\n";
	cout << "I hear " << new_friend << " is having a birthday and they are " << friend_age << " years old.\n";

	if(friend_age < 12) 
		cout << "Next year " << new_friend << " age will be " << friend_age+1 << "\n\n";
	if(friend_age == 17) 
		cout << "Next year you will be able to participate in our token Democracy!\n\n";
	if(friend_age > 70 && friend_age < 110)
		cout << "Since we don't have unions in our country you are probably still working!\n\n";
	cout << "Yours sincerely, \n\n Camden\n";

}
