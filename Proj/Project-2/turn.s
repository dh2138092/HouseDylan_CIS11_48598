	.data
msgTurnCounter: .asciz "    Turn %d/8\n\n"
msgGuessStats:  .asciz "=================\n    # correct: %d\n  # incorrect: %d\n\n-----------------\n\n"
msgGetGuess:    .asciz " Enter code %d: "
guessFormat:    .asciz "%d"

	.text
	.global playTurn
playTurn:
	push {lr}

	bl resetGuessCounters
	bl displayTurnNumber
	bl getGuessesFromPlayer
	bl compareGuessWithCode
	bl setGuessCounters
	bl displayGuessStats
	bl incrementTotalCorrect
	bl incrementTurnCounter

	pop {pc}
	mov pc, lr

resetGuessCounters:
	push {lr}

	mov r0, #0

	ldr r1, =correctCounter
	str r0, [r1]

	ldr r1, =incorrectCounter
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

		ldr r0, =totalGuesses
		ldr r1, [r0]
		add r1, r1, #1
		str r1, [r0]

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

setGuessCounters:
	push {r4, lr}

	ldr r3, =correctCounter
	ldr r4, =incorrectCounter
	str r1, [r3]
	str r2, [r4]

	pop {r4, lr}
	mov pc, lr

displayGuessStats:
	push {lr}

	ldr r2, =incorrectCounter
	ldr r2, [r2]
	ldr r1, =correctCounter
	ldr r1, [r1]
	ldr r0, =msgGuessStats
	bl printf

	pop {pc}
	mov pc, lr

incrementTotalCorrect:
	push {lr}

	ldr r0, =totalCorrect
	ldr r0, [r0]
	ldr r1, =correctCounter
	ldr r1, [r1]

	add r0, r0, r1

	ldr r1, =totalCorrect
	str r0, [r1]

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
