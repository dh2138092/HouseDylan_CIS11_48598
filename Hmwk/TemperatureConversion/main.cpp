#include <iostream>
using namespace std;

void divMod(int&, int&, int&);
void scaleLeft(int&, int&, int&);
void addSub(int&, int&, int&, int&);
void scaleRight(int&, int&, int&);

void convertFtoC(int &, int &, int &, int &);

int main(int argv, char *argc[]) 
{
	int r0 = 0,
		r1 = 0,    // Divisor - ((F - 32) * 5) / r2
		r2 = 9,    // Dividend - where r2 = 9
		r4 = 0;    // User input - fahrenheit

	convertFtoC(r0, r1, r2, r4);

	cout << "\n" << r4 << " F is " << r0 << " C.\n\n";

	return 0;
}

void convertFtoC(int &r0, int &r1, int &r2, int &r4)
{
	do {
		cout << "Enter a temperature 32 <= F <= 212: ";
		cin >> r4;
	} while (r4 < 32 || r4 > 212);

	r1 = (r4 - 32) * 5;

	divMod(r2, r0, r1);
}

void scaleLeft(int &r1, int &r3, int &r2)
{
	do {
		r3 <<= 1;   // Scale factor
		r2 <<= 1;   // Subtraction factor
	} while (r1 >= r2);
	r3 >>= 1;       // Scale factor back
	r2 >>= 1;       // Scale subtraction factor back
}

void scaleRight(int &r1, int &r3, int &r2)
{
	do {
		r3 >>= 1;   // Division counter
		r2 >>= 1;   // Mod/Remainder subtraction
	} while (r1 < r2);
}

void addSub(int &r3, int &r2, int &r0, int &r1)
{
	do {
		r0 += r3;                // Count the subtracted scale factor
		r1 -= r2;                // Subtract the scaled mod
		scaleRight(r1, r3, r2);  // Keep scaling right until < remainder
	} while (r3 >= 1);           // Loop until division is complete
}

void divMod(int &r2, int &r0, int &r1)
{
	//Determine the quotient and remainder
	r0 = 0;
	int r3 = 1;

	if (r1 >= r2)
	{
		scaleLeft(r1, r3, r2);
		addSub(r3, r2, r0, r1);
	}
}