#include "libs/std_lib_facilities.h"
#include <cmath>
// program should take input for a quadratic equation and be able to solve it. 

double square(double x) 
{
return (x*x);
}

double solveQuadratic(double a, double b, double c)
{
// this should perform the quadratic formula on entered values
	
double x1 = 0;
double x2 = 0;
double discriminant;

// solve for the discriminant 
discriminant = square(b) - 4*(a*c);
cout <<  "\nDiscriminant: " << discriminant << '\n';

// if the discriminant is less than 0, then the parabola doesn't cross the x-axis
if (discriminant <= 0) error("Negative Discriminant", discriminant);
// solve for x1 -- here the positive solution
x1 = ((b*-1) + sqrt(discriminant)) / (2*a);
// cout << x1 << '\n';

// solve for x2 -- here the negative solution
x2 = ((b*-1) - sqrt(discriminant)) / (2*a);
// cout << x2 << '\n';

cout << "Your Equation: " << a << "x^2 + " << b << "x + " << c << " = 0" << '\n'; 
cout << "\nPositive Solution: " << x1 << '\n' << "Negative Solution: " << x2 << '\n';

	return 0;
}

int main() 
{

	double a;
	double b;
	double c;

	cout << "Please enter A - B - C in the Quadratic Equation: " << '\n';
	cin >> a >> b >> c;

	solveQuadratic(a, b, c);

}
