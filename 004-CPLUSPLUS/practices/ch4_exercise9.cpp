#include "../libs/std_lib_facilities.h"

string whoWins (char &pick, string &player2) {

	string oppVict = "Your opponent is victorious!\n";
	string playerVict = "You are victorious! Bathe in your enemies tears!\n";
	string draw = "Twas a tie! Another go; for Honor!\n";

	if (pick == 'a' && player2 == "Paper") {
		cout << oppVict; 
	} else if (pick == 'a' && player2 == "Rock") {
		cout << draw;
	} else if (pick == 'a' && player2 == "Scissors") {
		cout << playerVict;
	}	

	if (pick == 'b' && player2 == "Paper") {
		cout << draw;
	} else if (pick == 'b' && player2 == "Rock") {
		cout << playerVict;
	} else if (pick == 'b' && player2 == "Scissors") {
		cout << oppVict;
	}

	if (pick == 'c' && player2 == "Paper") {
		cout << playerVict;
	} else if (pick == 'c' && player2 == "Rock") {
		cout << oppVict;
	} else if (pick == 'c' && player2 == "Scissors") {
		cout << draw;
	}

	return "\nReady to play again?\n";
}

string opponentPlays (char &pick) {
	vector<string>randomPlay{"Rock", "Paper", "Scissors", "Scissors", "Rock", "Rock", "Paper", "Scissors", "Paper", "Paper", "Scissors", "Rock", "Scissors", "Scissors", "Rock", "Paper", "Rock", "Scissors", "Rock", "Paper", "Paper", "Rock", "Scissors", "Scissors", "Paper"};

	static int rounds = 0;

	if (pick == 'a' || pick == 'b' || pick == 'c') {
		rounds = rounds + 1;
	}	
	string player2 = randomPlay[rounds];
	return player2;	
} 

int main() {
	// rock paper scissors 
	char pick;

	string rock = "Rock";
	string paper  = "Paper";
	string scissors = "Scissors";

	cout << "Pick a: Rock, b: Paper, c: Scissors" << "\n";
	
	while (cin >> pick) {
	string	player2 = opponentPlays(pick);

	switch(pick) {
		case 'a':
			cout << "Your pick was: " << rock << "\n";
			cout << "Your opponent played: " << player2 << '\n';
			cout << whoWins(pick, player2) << '\n';
			break;
		case 'b':
			cout << "Your pick was: " << paper << "\n";
			cout << "Your opponent played: " << player2 << '\n';
			cout << whoWins(pick, player2) << '\n';
			break;
		case 'c':
			cout << "Your pick was: " << scissors << "\n";
			cout << "Your opponent played: " << player2 << '\n';
			cout << whoWins(pick, player2) << '\n';
			break;

		}
	}
}
