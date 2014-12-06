	.data
message_welcome:   .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n\n***********************************************\n\nGAME RULES:\n\n1. The code is 3 digits long, with each digit\n   being between the numbers 1 thru 7.\n\n2. You have 14 guesses to crack the code.\n\n3. Enter one number at a time.\n\n***********************************************\n\n"
message_win:       .asciz "*************************************************\n*******************YOU WON!!*********************\n*************************************************\n\n"
message_lose:      .asciz "You lose! The correct code was %d %d %d\n\n"

	.text
	.global main
main:
	push {lr}

	ldr r0, addr_of_message_welcome
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
		ldr r0, addr_of_message_win
		b gameOver

	gameLost:
		ldr r0, addr_of_message_lose
		ldr r4, =arrayOfCodes
		ldr r1, [r4, #0]
		ldr r2, [r4, #4]
		ldr r3, [r4, #8]
@	        mov r1, r4
@              	mov r2, r5
@              	mov r3, r6
		b gameOver

	gameOver:
		bl printf
		bl play_again

		cmp r1, #'Y'
		beq playGame
		cmp r1, #'y'
		beq playGame

endGame:
	pop {pc}
	mov pc, lr

addr_of_message_welcome:   .word message_welcome
addr_of_message_win:       .word message_win
addr_of_message_lose:      .word message_lose
