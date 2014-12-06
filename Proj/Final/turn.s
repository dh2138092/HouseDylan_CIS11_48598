	.data
msgTurnCounter: .asciz "\n\n                  Turn %d / 14\n================================================\n"
msgGuessStats:  .asciz "\n# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"
msgGetGuess:    .asciz "Enter code %d: "
guessFormat:    .asciz "%d"

	.text
	.global playTurn
playTurn:
	push {lr}

	bl resetCounters
	bl displayTurnNumber
	bl getGuessesFromPlayer
	bl compareGuessWithCode
	bl setCorrectAndIncorrectCounters
	bl displayGuessStats
	bl incrementTurnCounter

	pop {pc}
	mov pc, lr

resetCounters:
	push {lr}

	mov r0, #0
	ldr r1, =numberGuessedCorrectly
	str r0, [r1]
	ldr r1, =numberGuessedIncorrectly
	str r0, [r1]

	pop {pc}
	mov pc, lr

displayTurnNumber:
	push {lr}

	ldr r1, =turnCounter
	ldr r1, [r1]
	ldr r0, =msgTurnCounter
	bl printf

	pop {pc}
	mov pc, lr

getGuessesFromPlayer:
	push {r4, r5, lr}

	sub sp, sp, #4
	mov r4, #0		@@ Memory address pointer for array
	mov r5, #1		@@ For the %d in msgGetGuess

	getGuess:
		ldr r0, =msgGetGuess
		mov r1, r5
		bl printf

		ldr r0, =guessFormat
		mov r1, sp
		bl scanf

		ldr r0, =arrayOfGuesses
		ldr r1, [sp]
		str r1, [r0, r4, lsl #2]

		add r5, r5, #1
		add r4, r4, #1

		cmp r4, #3
		blt getGuess

	add sp, sp, #4

	pop {r4, r5, pc}
	mov pc, lr

compareGuessWithCode:
	push {r4, r5, r6, lr}

	mov r0, #0			@@ Memory address pointer
	mov r1, #0			@@ Guessed correctly counter
	mov r2, #0			@@ Guessed incorrecty counter
	mov r3, #0			@@ Holds value of arrayOfCodes[i]
	mov r4, #0			@@ Holds value of arrayOfGuesses[i]
	ldr r5, =arrayOfCodes
	ldr r6, =arrayOfGuesses
	compare:
		ldr r3, [r5, r0, lsl #2]
		ldr r4, [r6, r0, lsl #2]

		cmp r3, r4
		addeq r1, #1
		addne r2, #1

		add r0, r0, #1

		cmp r0, #3
		blt compare

	pop {r4, r5, r6, lr}
	mov pc, lr

setCorrectAndIncorrectCounters:
	push {r4, r5, lr}

	ldr r3, =numberGuessedCorrectly
	ldr r4, =numberGuessedIncorrectly
	str r1, [r3]
	str r2, [r4]

	ldr r0, =totalCorrect
	ldr r5, [r0]
	add r5, r5, r1
	str r5, [r0]

	pop {r4, r5, lr}
	mov pc, lr

displayGuessStats:
	push {lr}

	ldr r0, =msgGuessStats
	bl printf

	pop {pc}
	mov pc, lr

incrementTurnCounter:
	push {lr}

	ldr r0, =turnCounter
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]

	pop {pc}
	mov pc, lr
