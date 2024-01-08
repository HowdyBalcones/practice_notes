#include "libs/std_lib_facilities.h"

int SieveOfEratosthenes(int range) {
	
	// create vector of booleans set to range

	vector<int> prime(range+1, 1);

	// go through the primes vector starting at 2 -- interesting math rule here
	// if range has no prime divisors less than or equal to √range, then range is prime.
	for (int p = 2; p <= sqrt(range); ++p) {
		
		if (prime[p] == 1) {
			for (int i = p * p; i <= range; i += p) {
				prime[i] = 0;	
			}
		}
	}

	for (int p = 2; p <= range; ++p) {
		if (prime[p] == 1)
			cout << p << " ";
	}

	cout << '\n';
	return 0;
} 

int main() {

	int range = 0;	
	cout << "Please pick a whole number and I'll find how many primes are between it and 2" << '\n';	
	cin >> range;

	SieveOfEratosthenes(range);
	return 0;


}
