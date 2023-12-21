#include "libs/std_lib_facilities.h"

string opponentPlays (char pick) {
	vector<string>randomPlay{"Rock", "Paper", "Scissors", "Scissors", "Rock", "Rock", "Paper", "Scissors", "Paper", "Paper", "Scissors", "Rock", "Scissors", "Scissors", "Rock", "Paper", "Rock", "Scissors", "Rock", "Paper", "Paper", "Rock", "Scissors", "Scissors", "Paper"};

	int rounds = 0;
	
	if (pick == a || pick == b || pick == c) {
		rounds += 1;
		return randomPlay[rounds];
	}	

	return 0;	
} 

int main() {
	// rock paper scissors 
	char pick;

	string rock = "Rock";
	string paper  = "Paper";
	string scissors = "Scissors";

	cout << "Pick a: Rock, b: Paper, c: Scissors" << "\n";
	
	while (cin >> pick) {
	switch(pick) {
		case 'a':
			cout << "Your pick was: " << rock << "\n";

			break;
		case 'b':
			cout << "Your pick was: " << scissors << "\n";
			break;
		case 'c':
			cout << "Your pick was: " << paper << "\n";
			break;

		}
	}
}
