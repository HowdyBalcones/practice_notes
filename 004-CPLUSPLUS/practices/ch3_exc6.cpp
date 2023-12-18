#include "libs/std_lib_facilities.h"

int main() {

	string word1;
	string word2;
	string word3;

	cout << "Please enter three words: \n";
	cin >> word1 >> word2 >> word3;

	if (word1 > word2) {
		swap(word1, word2);
	}
	if (word2 > word3) {
		swap(word2, word3);
	}
	if (word1 > word2) {
		swap(word1, word2);
	}

	cout << word1 << ", " << word2 << ", " << word3 << "\n";

}
