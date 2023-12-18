#include "libs/std_lib_facilities.h"

int main() {

	vector<string>words;			// the words vector
	for(string temp; cin >> temp;)		// for loop to add strings to words, accepts input until metacharacter
		words.push_back(temp);		// add to vector
	cout<<"Number of words: " << words.size() << '\n';
	sort(words);

	for (int i = 0; i < words.size(); ++i)
		if (i==0 || words[i-1]!=words[i])
			cout << words[i] << "\n";
}
