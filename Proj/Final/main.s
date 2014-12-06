	.data
msgWelcome:   .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n\n***********************************************\n\nGAME RULES:\n\n1. The code is 3 digits long, with each digit\n   being between the numbers 0 thru 7.\n\n2. You have 14 guesses to crack the code.\n\n3. Enter one number at a time.\n\n***********************************************\n\n"
msgWin:       .asciz "*************************************************\n*******************YOU WON!!*********************\n*************************************************\n\n"
msgLose:      .asciz "You lose! The correct code was %d %d %d\n\n"
msgAvgCorrect: .asciz "You got an average of %f (percent) correct guesses that game.\n"
msgPlayAgain: .asciz "Do you want to play again? (Y/N)  "
fmtPlayAgain: .asciz " %c"

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
		bl promptNewGame

	        cmp r0, #'Y'
	        beq playGame
	        cmp r0, #'y'
        	beq playGame


exit:
	pop {r4, pc}
	mov pc, lr

promptNewGame:
	push {lr}
	sub sp, sp, #4

	ldr r0, =msgPlayAgain
	bl printf

	ldr r0, =fmtPlayAgain
	mov r1, sp
	bl scanf

	ldr r0, [sp]

	add sp, sp, #4
	pop {pc}
	mov pc, lr
