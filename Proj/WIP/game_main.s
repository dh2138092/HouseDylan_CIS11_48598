	.data
message_turn:      .asciz "\n\n                  Turn %d / 14\n================================================\n"
message_position:  .asciz "\n# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"
format_guess: .asciz "%d"

.align 4
arrayOfGuesses: .skip 16

.align 4
numberGuessedCorrectly: .word 0

.align 4
numberGuessedIncorrectly: .word 0

.align 4
turnCounter: .word 0

restartGame: .asciz " %c"


	.text
	.global game_main
game_main:
	push {lr}
	sub sp, sp, #4

	@@ r5 <- arrayOfCodes from game_init.s

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Reset number correct & incorrect counters every turn @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	reset_counters:
		mov r0, #0
		ldr r1, =numberGuessedCorrectly
		str r0, [r1]
		ldr r1, =numberGuessedIncorrectly
		str r0, [r1]

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Display the turn number @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	display_turn_number:
		ldr r1, =turnCounter
		ldr r1, [r1]
		ldr r0, addr_of_message_turn
		bl printf

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Get 3 guesses from the user @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	ldr r0, =format_guess
	mov r4, #0
	b get_compare
	get_guesses:
		ldr r2, =arrayOfGuesses
		str sp, [r2, r4, lsl #2]
		bl scanf

		add r4, r4, #1
		get_compare:
			cmp r4, #3
			ble get_guesses

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Compare user guesses to the 3 randomly generated codes @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	mov r0, #0		@@ Memory address pointer
	mov r1, #0		@@ Guessed correctly counter
	mov r2, #0		@@ Guessed incorrecty counter
	mov r3, #0		@@ Holds value of arrayOfCodes[i]
	mov r4, #0		@@ Holds value of arrayOfGuesses[i]
	@@ r5 <- =arrayOfCodes from game_init.s
	ldr r6, =arrayOfGuesses
	ldr r7, =numberGuessedCorrectly
	ldr r8, =numberGuessedIncorrectly
	compare_guesses:
		ldr r3, [r5, r0, lsl #2]
		ldr r4, [r6, r0, lsl #2]

		cmp r3, r4
		addeq r1, #1
		addne r2, #1
		str r1, [r7]
		str r2, [r8]

			@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			@@ End current game if guessed correctly >= 3 @@
			@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

			cmp r7, #3
			bge end_game

		add r0, r0, #1
		compare_compare:
			cmp r0, #3
			ble compare_guesses

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Display # of guesses that are correct & incorrect @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	display_num_correct:
		ldr r0, addr_of_message_position
		ldr r1, [r7]
		ldr r2, [r8]
		bl printf

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Increment turn counter by 1 @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	increment_turn:
		ldr r1, =turnCounter
		ldr r0, [r1]
		add r0, r0, #1
		str r0, [r1]

end_game:
	add sp, sp, #4

	pop {pc}
	mov pc, lr

addr_of_message_turn:      .word message_turn
addr_of_message_position:  .word message_position
