#include <iostream>
#include <ctime>
#include <string>

using namespace std;

int main(int argc, char* argv[])
{
	int code1 = 0, code2 = 0, code3 = 0,
		guess1 = 0, guess2 = 0, guess3 = 0,
		numCorrect = 0, numWrong = 0,
		turnNumber = 0;
	char playAgain = 'Y';



	do {

		srand((unsigned int)time(NULL));
		code1 = (rand() + 3266) % 7;
		code2 = (rand() + 487809620) % 7;
		code3 = (rand() + 9811454) % 7;
		turnNumber = 1;

		cout << code1 << " " << code2 << " " << code3 << "\n\n"; // TEST

		do {

			numCorrect = 0;
			numWrong = 0;

			cin >> guess1;
			if (guess1 == code1) numCorrect++;
			else numWrong++;

			cin >> guess2;
			if (guess2 == code2) numCorrect++;
			else numWrong++;

			cin >> guess3;
			if (guess3 == code3) numCorrect++;
			else numWrong++;

			cout << "\nCP: " << numCorrect << "\nWP: " << numWrong << "\n\n";

			turnNumber++;

		} while (numCorrect != 3 && numWrong != 0 || turnNumber != 14);

		std::cout << "Play again? (Y or N)   ";
		cin.ignore(1, '\n');
		playAgain = getchar();
		cin.ignore(1, '\n');

	} while (playAgain == 'Y' || playAgain == 'y');

	return 0;
}
