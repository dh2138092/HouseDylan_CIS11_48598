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

	cout << "            M A S T E R M I N D ! ! !\n\n"
		 << "Created by Dylan House, CIS-11-48598\n\n"
		 << "Crack the numerical code to win!\n\n"
		 << "===============================================\n"
		 << "GAME RULES : \n"
		 << "1. The code is 3 digits long, with each digit\n"
		 << "being between the numbers 1 thru 7.\n"
		 << "2. You have 14 guesses to crack the code.\n"
		 << "===============================================\n\n";


	do {

		// INITIALIZE NEW GAME
		srand((unsigned int)time(NULL));
		code1 = (rand() + 3266) % 7;
		code2 = (rand() + 487809620) % 7;
		code3 = (rand() + 9811454) % 7;
		turnNumber = 1;

		cout << code1 << " " << code2 << " " << code3 << "\n\n"; // TEST

		do {
			cout << "================================================\n"
				<< "                  Turn " << turnNumber << " / 14\n"
				<< "================================================\n";

			// Reset guess counters per each turn
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

			if (numCorrect == 3)
				break;

			cout << "\n# in Correct Position        # in Wrong Position\n"
				 << "---------------------        -------------------\n"
				 << "          " << numCorrect << "                           " << numWrong << "\n\n";

			// Increment turn counter
			turnNumber++;

		} while (turnNumber != 15);

		if (turnNumber == 15)
			cout << "You lose! The correct combo was " << code1 << " " << code2 << " " << code3 << "\n\n";
		else
			cout << "*************************************************\n"
			     << "*******************YOU WON!!*********************\n"
			     << "*************************************************\n";

		cout << "Play again? (Y or N)   ";
		cin.ignore(1, '\n');
		playAgain = getchar();
		cin.ignore(1, '\n');
		cout << "\n\n";

	} while (playAgain == 'Y' || playAgain == 'y');

	return 0;
}
