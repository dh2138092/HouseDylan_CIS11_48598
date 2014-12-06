	.data
msgWelcome:   .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n\n***********************************************\n\nGAME RULES:\n\n1. The code is 3 digits long, with each digit\n   being between the numbers 0 thru 7.\n\n2. You have 14 guesses to crack the code.\n\n3. Enter one number at a time.\n\n***********************************************\n\n"
msgWin:       .asciz "*************************************************\n*******************YOU WON!!*********************\n*************************************************\n\n"
msgLose:      .asciz "You lose! The correct code was %d %d %d\n\n"

	.text
	.global main
main:
	push {lr}

	ldr r0, =msgWelcome
	bl printf

	playGame:
		bl initGame

		nextTurn:
			bl playTurn

			ldr r0, =numberGuessedCorrectly
			ldr r0, [r0]
			cmp r0, #3
			bge gameWon

			ldr r0, =turnCounter
			ldr r0, [r0]
			cmp r0, #15
			blt nextTurn

			b gameLost

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
		bl askToPlayAgain

		cmp r1, #'Y'
		beq playGame
		cmp r1, #'y'
		beq playGame

endGame:
	pop {pc}
	mov pc, lr
