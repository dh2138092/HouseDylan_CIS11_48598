	.data
msgWelcome:    .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n\n***********************************************\n\nGAME RULES:\n\n1. The code is 3 digits long, with each digit\n   being between the numbers 0 thru 7.\n\n2. You have 8 guesses to crack the code.\n\n3. Enter one number at a time.\n\n		Good luck!\n\n***********************************************\n\n"
msgWin:        .asciz "You win!!\n\n"
msgLose:       .asciz "You lose! The correct code was %d %d %d\n\n"

	.text
	.global main
main:
	push {r4, lr}

	ldr r0, =msgWelcome
	bl printf

	playGame:
		bl initGame

		nextTurn:
			bl playTurn

			ldr r0, =correctCounter
			ldr r0, [r0]
			cmp r0, #3
			bge gameWon			@@ correctCounter == number of codes

			ldr r0, =turnCounter
			ldr r0, [r0]
			cmp r0, #9
			blt nextTurn 			@@ turnCounter < number of allowable turns

			b gameLost			@@ turnCounter > number of allowable turns

		gameWon:
			ldr r0, =msgWin
			b gameOver

		gameLost:
			ldr r0, =msgLose
			ldr r4, =arrayOfCodes
			ldr r1, [r4, #0]
			ldr r2, [r4, #4]
			ldr r3, [r4, #8]
			b gameOver

		gameOver:
			bl printf
			bl printAvgCorrect
			bl promptNewGame

	        	cmp r0, #'Y'
	        	beq playGame
	        	cmp r0, #'y'
        		beq playGame


exit:
	pop {r4, pc}
	mov pc, lr
