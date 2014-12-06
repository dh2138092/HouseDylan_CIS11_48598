	.data
message_turn:      .asciz "\n\n                  Turn %d / 14\n================================================\n"
message_position:  .asciz "\n# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"

	.text
	.global playTurn
playTurn:
	push {lr}

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Reset number correct & incorrect variables every turn @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

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

	mov r4, #0
	b get_compare
	get_guesses:
		sub sp, sp, #4

		ldr r0, =guessFormat
		mov r1, sp
		bl scanf

		ldr r0, =arrayOfGuesses
		ldr r1, [sp]
		str r1, [r0, r4, lsl #2]

@		ldr r1, [r0, r4, lsl #2]
@               ldr r0, =print
@               bl printf

		add sp, sp, #4

		add r4, r4, #1
		get_compare:
			cmp r4, #3
			blt get_guesses

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Compare user guesses to the 3 randomly generated codes @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	mov r0, #0		@@ Memory address pointer
	mov r1, #0		@@ Guessed correctly counter
	mov r2, #0		@@ Guessed incorrecty counter
	mov r3, #0		@@ Holds value of arrayOfCodes[i]
	mov r4, #0		@@ Holds value of arrayOfGuesses[i]
	ldr r5, =arrayOfCodes
	ldr r6, =arrayOfGuesses
	compare_guesses:
		ldr r3, [r5, r0, lsl #2]
		ldr r4, [r6, r0, lsl #2]

		cmp r3, r4
		addeq r1, #1
		addne r2, #1

		add r0, r0, #1
		compare_compare:
			cmp r0, #3
			blt compare_guesses

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Set guessed correct & incorrect variables @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	ldr r3, =numberGuessedCorrectly
	ldr r4, =numberGuessedIncorrectly
	str r1, [r3]
	str r2, [r4]

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Display # of guesses that are correct & incorrect @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	display_num_correct:
		ldr r0, addr_of_message_position
		bl printf

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Increment turn counter by 1 @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	increment_turn:
		ldr r0, =turnCounter
		ldr r1, [r0]
		add r1, r1, #1
		str r1, [r0]

	pop {pc}
	mov pc, lr

addr_of_message_turn:      .word message_turn
addr_of_message_position:  .word message_position
