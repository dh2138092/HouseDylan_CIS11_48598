	.data
msgWelcome:    .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n\n***********************************************\n\nGAME RULES:\n\n1. The code is 3 digits long, with each digit\n   being between the numbers 0 thru 7.\n\n2. You have 8 guesses to crack the code.\n\n3. Enter one number at a time.\n\n		Good luck!\n\n***********************************************\n\n"
msgWin:        .asciz "You win!!\n\n"
msgLose:       .asciz "You lose! The correct code was %d %d %d\n\n"
msgAvgCorrect: .asciz "You got an average of %d%% correct guesses that game.\n\n"
msgPlayAgain:  .asciz "Do you want to play again? (Y/N)  "
fmtPlayAgain:  .asciz " %c"
msgStats:      .asciz "You made %d correct guesses out of %d total guesses.\n\n"
newline:       .asciz "\n"

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

printAvgCorrect:
	push {lr}

	@@ Print game stats

	ldr r0, =msgStats
	ldr r1, =totalCorrect
	ldr r1, [r1]
	ldr r2, =totalGuesses
	ldr r2, [r2]
	bl printf

	@@ Calculate avg correct guesses for game

	@@ Convert total correct guesses to f64

	ldr r0, =totalCorrect
	ldr r0, [r0]
	vmov s12, r0
	vcvt.f32.s32 s13, s12

	@@ Convert total guesses to f64

	ldr r0, =totalGuesses
	ldr r0, [r0]
	vmov s14, r0
	vcvt.f32.s32 s15, s14

	@@ Convert scale factor 100 to f64

        mov r0, #100
        vmov s16, r0
        vcvt.f32.s32 s17, s16

	@@ Divide and multiply f64 values

	vdiv.f32 s0, s13, s15
	vmul.f32 s1, s17, s0

	@@ Convert calculated value to integer for printf

	vcvt.s32.f32 s0, s1

	@@ Print average correct

	vmov r1, s0
	ldr r0, =msgAvgCorrect
	bl printf

	pop {pc}
	mov pc, lr

promptNewGame:
	push {r4, lr}
	sub sp, sp, #4

	ldr r0, =msgPlayAgain
	bl printf

	ldr r0, =fmtPlayAgain
	mov r1, sp
	bl scanf

	ldr r0, [sp]

	@ldr r0, =newline
	@bl printf

	add sp, sp, #4
	pop {r4, pc}
	mov pc, lr
