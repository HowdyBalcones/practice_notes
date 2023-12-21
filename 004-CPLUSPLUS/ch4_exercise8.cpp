#include "libs/std_lib_facilities.h"

double numberOfGrains(int square) {

square = square - 1;
double previousGrains;
double currentGrains = 0;
double totalGrains = 0;

vector<double>board;

	for (int i = 0; i <= square; ++i) {
	int currentSquare = i + 1;
		
	if (i == 0) {
		previousGrains = 1;
		currentGrains = 1;
	}  else {
		previousGrains = board[i - 1];
		currentGrains = previousGrains * 2;	
	}

	board.push_back(currentGrains);
	totalGrains += currentGrains; 
	
	cout << "We are on square: " << currentSquare << "\t" << board[i] << '\n';
	cout << "Current Grain on Square: " << currentGrains << '\n';
	cout << "Previous Grains: " << previousGrains << '\n';
	cout << "Total Grains on Board: " << totalGrains << "\n\n";

	if (currentGrains >= 1000000000 && currentGrains <= 2000000000) {
			cout << "Grains over 1000000000 at square: " << currentSquare  << "\n\n";
		} else if (currentGrains >= 1000000 && currentGrains <= 2000000) {
			cout << "Grains over 1000000 at square: " << currentSquare << "\n\n";
		} else if (currentGrains >= 1000 && currentGrains <= 2000) {
			cout << "Grains over 1000 at square: " << currentSquare << "\n\n";
		}
	}

	return currentGrains;
}



int main() {
	

	int userInput = 0;
	cout << "Enter the number of squares filled on the board: 1 -- 64 \n";
	cin >> userInput;

	numberOfGrains(userInput);
}
