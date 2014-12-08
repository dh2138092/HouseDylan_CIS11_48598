	.data

	.global arrayOfCodes
.align 4
arrayOfCodes: .skip 16

	.global arrayOfGuesses
.align 4
arrayOfGuesses: .skip 16

	.global correctCounter
.align 4
correctCounter: .word 0

	.global incorrectCounter
.align 4
incorrectCounter: .word 0

	.global turnCounter
.align 4
turnCounter: .word 0

	.global totalGuesses
.align 4
totalGuesses: .word 0

	.global totalCorrect
.align 4
totalCorrect: .word 0

printCodes: .asciz "\n    <DEMO: The code is %d %d %d>\n\n"

	.text

	.global initGame
initGame:
	push {lr}

	mov r0, #0
	bl time
	bl srand

	bl fillCodeArray
	bl initTurnCounter
	bl initTotalGuesses
	bl initTotalCorrect
	bl testPrint

	pop {pc}
	mov pc, lr

fillCodeArray:
	push {r4, r5, lr}

	ldr r5, =arrayOfCodes
	mov r4, #0
	generateCode:
		bl rand

		mov r1, r0, asr #1		@@ In case random return is negative
		mov r2, #8			@@ rand()%8 <- divMod

		bl divMod

		str r1, [r5, r4, lsl #2]	@@ Store random number in code array

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

initTotalGuesses:
	push {lr}

	mov r0, #0
	ldr r1, =totalGuesses
	str r0, [r1]

	pop {pc}
	mov pc, lr

initTotalCorrect:
	push {lr}

	mov r0, #0
	ldr r1, =totalCorrect
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
