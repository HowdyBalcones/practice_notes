#include "libs/std_lib_facilities.h"

int main() 
{

	string name;
	string score;
	vector<string> listNames;
	vector<string> listScores;
	while (cin >> name >> score) {
		// exit code, return 1 if you want to exit apparently
		if (name == "NoName" && score == "0") return 1;
		
		// while you're giving input, push the input onto each vector
		listNames.push_back(name);
		listScores.push_back(score);
		cout << '\n';	

		// this is for listing the names as we go, checking name list for various things
		for(int i = 0; i < listNames.size(); ++i) {
			if (i != 0 && name == listNames[i-1]) error("Duplicate name in listNames") ;  
			cout << listNames[i] << " " << listScores[i] << '\n';
		}

	}
	return 0;
}
