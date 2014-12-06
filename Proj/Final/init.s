	.data
	.global print
printCodes: .asciz "%d %d %d\n"

	.global arrayOfCodes
.align 4
arrayOfCodes: .skip 16

	.global arrayOfGuesses
.align 4
arrayOfGuesses: .skip 16

	.global numberGuessedCorrectly
.align 4
numberGuessedCorrectly: .word 0

	.global numberGuessedIncorrectly
.align 4
numberGuessedIncorrectly: .word 0

	.global turnCounter
.align 4
turnCounter: .word 1

	.text
	.global initGame
initGame:
	push {lr}

	mov r0, #0
	bl time
	bl srand
	bl rand

	bl fillCodeArray
	bl initTurnCounter
	bl testPrint

	pop {pc}
	mov pc, lr

fillCodeArray:
	push {r4, r5, lr}

	ldr r5, =arrayOfCodes
	mov r4, #0

	generateCode:
		mov r1, r0, asr #1
		add r3, r3, #1
		mul r1, r1, r3
		mov r2, #8
		bl divMod			@@ In: r1/r2 @@ Out: r0 <- a/b, r1 <- a%b
		str r1, [r5, r4, lsl #2]

		add r4, r4, #1
		cmp r4, #3
		ble generateCode

	pop {r4, r5, lr}
	mov pc, lr

initTurnCounter:
	push {lr}

	mov r0, #1
        ldr r1, =turnCounter
        str r0, [r1]

	pop {pc}
	mov pc, lr

testPrint:
	push {r4, lr}

        ldr r4, =arrayOfCodes
        ldr r3, [r4, #8]
        ldr r2, [r4, #4]
        ldr r1, [r4, #0]
        ldr r0, =printCodes
	bl printf

	pop {r4, pc}
	mov pc, lr
