#include "libs/std_lib_facilities.h"




int takeInput(string name, string score) 
{
	vector<string> listNames;
	vector<string> listScores;
	vector<string> listMatchNames;
	vector<string> listMatchScores;


	while (cin >> name >> score) {
		if (name == "NoName" && score == "0") return 1;
		listNames.push_back(name);
		listScores.push_back(score);
		cout << '\n';
	}
	return 0;
}

int main() 
{

	string name;
	string score;
	vector<string> listNames;
	vector<string> listScores;
	vector<string> listMatchNames;
	vector<string> listMatchScores;

	while (cin >> name >> score) {
		// exit code, return 1 if you want to exit apparently
		if (name == "NoName" && score == "0") break;
		
		// while you're giving input, push the input onto each vector
		listNames.push_back(name);
		listScores.push_back(score);
		cout << '\n';	

		// this is for listing the names as we go, checking name list for various things
		for(int j = 0; j < listNames.size() - 1; ++j) {
			if (j != 0 && name == listNames[j]) {
			listMatchNames.push_back(name);
			listMatchScores.push_back(score);
			} 
		}
	}

	// Display matches
	if (!listMatchNames.empty()) {
		cout << "Matches: " << '\n';
		for (int i = 0; i < listMatchNames.size(); ++i) {
			cout << listMatchNames[i] << " " << listMatchScores[i] << '\n';
		} 
	} else {
		cout << "No matching names found." << '\n';
	}
	
	if (!listMatchScores.empty()) {
		cout << "Matching Scores: " << '\n';
		for (int i = 0; i < listMatchScores.size(); ++i) {
			cout << listMatchScores[i] << " " << listMatchNames[i] << '\n';
		}
	} else {
		cout << "No matching scores found." << '\n';
	}
	return 0;
}
