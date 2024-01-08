#include "libs/std_lib_facilities.h"



 string calcMedian(vector<string>& wordsList) {
	// if wordslist is even, then append both strings with a comma and space between
	
 	if (wordsList.size()%2 == 0) {
		// return two middle elements of vector
 		return (wordsList[wordsList.size() / 2 - 1] + ", " + wordsList[wordsList.size() / 2]);
 	} else { 
		// otherwise return the single middle element (odd)
		return wordsList[wordsList.size()/2];
 	}
 }


// These give the min and max for the vector.
string giveMin(vector<string>& wordsList) {
	return wordsList[0];
}

string giveMax(vector<string>& wordsList) {
	return wordsList[wordsList.size() - 1];
}


string giveMode(vector<string>& wordsList) {
	if (wordsList.empty()) return ""; // handle empty list
	
	// still need to implement bimodal output

	vector<string>biModal;
		int previous = 0;
		int next = 0;
		double previousCounter = 0;
		string mode = " ";
		double mostCounted = 0;
		int numberOfUnique = 0;
	for (int i = 0; i < wordsList.size(); ++i) {
		
		// this sets up the next and previous variables for 0 in the vector. 
		// without this the i - 1 will throw an error, hence next. 	
		if (i == 0) {
			next = i + 1;
		} 
		if (i >= 1) {
			previous = i - 1;
		}
		
		// use next here to look ahead
		if (wordsList[i] == wordsList[next] && i == 0) {
			previousCounter += 1;

		}
		// previous here to look behind
		if (wordsList[i] == wordsList[previous]) { 
			previousCounter += 1;
		} else {
			numberOfUnique += 1;
		}	
	       
		// if the word is not repeated but repetitions are
		// greater than current greatest, update greatest
		if (previousCounter > mostCounted) {
			mostCounted = previousCounter;
			mode = wordsList[i];
		} 	
		
		// if the words don't match, then restart counter
		if (wordsList[i] != wordsList[previous]) { 
			previousCounter = 1;
		}

	//	cout << wordsList[i] << '\n';
	//	cout << previousCounter << '\n';
	//	cout << "How many times the mode is repeated: " << mostCounted << '\n';
	//	cout << "This is the mode: " << mode << '\n';
	//	cout << "Number of unique entries: " << numberOfUnique << '\n';

	}

	return mode;
}



int main() {
	vector<string>wordsList = {"Testing", "Words", "List","List" ,"AAA", "BBB", "CCC", "aaa", "bbb","ccc", "ccc", "YUP"};
	cout << "Mode of list: " << giveMode(wordsList) << '\n';	
	cout << "Max of list: " << giveMax(wordsList) << '\n';
	cout << "Min of list: " << giveMin(wordsList) << '\n';
	cout << "Median of list: " << calcMedian(wordsList) << '\n';
}
