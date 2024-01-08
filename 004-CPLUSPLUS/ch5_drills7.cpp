#include "libs/std_lib_facilities.h"

int main() 
// These are errors we are correcting. pg. 200 
{
	try {
		// cout << "Success!\n";
		// cout << "Success!\n";
		// cout << "Success!" << '\n'; 
		// cout << "success" << '\n';
		// int res = 7; vector<int> v(10); v[5] = res; cout << "Success!\n";
		// int cond = 0; if(cond == 0) cout << "Success!\n"; else cout <<"Fail!\n";
		// bool c = true; if (c) cout << "Success!\n"; else cout << "Fail!\n";
		// string s = "ape"; string c = "aardvark"; if (s>c) cout << "Success!\n";
		// string s = "fool"; if (s=="fool") cout << "Success!\n";
		// string s = "fool"; if (s=="fool") cout << "Success!\n";
		// string s = "fool"; if (s == "fool") cout << "Success!\n";
		// vector<char> v(5); for (int i=0; i<v.size(); ++i) cout << "Success!\n";
		// vector<char> v(5); for (int i=0; i<=v.size(); ++i) cout << "Success!\n";
		// string s = "Success!\n"; for (int i=0; i<20; ++i) cout << s[i];
		// if (true) cout << "Success!\n"; else cout << "Fail!\n";
		// int x = 2000; int c = x; if (c==2000) cout << "Success!\n";
		// string s = "Success!\n"; for (int i=0; i<10; ++i) cout << s[i];
		// vector<int> v(5); for (int i=0; i<=v.size(); ++i) cout << "Success!\n";
		int i=0; int j=9; vector<int> vec(0); while (cin >> i) vec.push_back(i); ++i; if (vec.size()<j) cout << "Success!\n"; else 
		keep_window_open();
		return 0;
	}
	catch (exception& e) {
		cerr << "error: " << e.what() << '\n';
		keep_window_open();
		return 1;
	}
	catch(...) {
		cerr << "Oops: unknown exception!\n";
		keep_window_open();
		return 2;
	}
}
