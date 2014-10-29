#include <iostream>
#include <ctime>
#include <string>

using namespace std;

int main(int argc,  char* argv[])
{
	int aiPos1 = 0, aiPos2 = 0, aiPos3 = 0, 
		userPos1 = 0, userPos2 = 0, userPos3 = 0,
		correctPosCount = 0, wrongPosCount = 0, randomSeed = 0;

	srand((unsigned int)time(NULL));
	randomSeed = rand() % 1000;

	aiPos1 = (randomSeed + 320687236) % 7;
	aiPos2 = (randomSeed + 462172233) % 7;
	aiPos3 = (randomSeed + 987427223) % 7;

	cout << aiPos1 << " " << aiPos2 << " " << aiPos3 << "\n\n";  // TEST LINE

	do {
			correctPosCount = 0;
			wrongPosCount = 0;

			cin >> userPos1;
			cin >> userPos2;
			cin >> userPos3;

			if (userPos1 == aiPos1)
				correctPosCount++;
			else
				wrongPosCount++;

			if (userPos2 == aiPos2)
				correctPosCount++;
			else
				wrongPosCount++;

			if (userPos3 == aiPos3)
				correctPosCount++;
			else
				wrongPosCount++;

			cout << "\nCP: " << correctPosCount << "\nWP: " << wrongPosCount << "\n\n";

	} while(correctPosCount != 3 && wrongPosCount != 0);



	return 0;
}
