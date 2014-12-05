	.data
	.global guessFormat
guessFormat: .asciz "%d"

	.global print
print: .asciz "%d\n"

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

	.global restartGame
restartGame: .asciz " %c"

	.text
	.global init
init:
	push {lr}

	mov r0, #0                   /* r0 for time(r0) */
	mov r1, #0                   /* r1 = remainder */
	mov r2, #7                   /* r2 for randomNum % r2 */
	mov r3, #1

	bl time		@@ time(r0)
	bl srand	@@ Seed random num generator
	bl rand		@@ r0 <- Random num

	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@@ Fill codes array with 3 random digits each 0 <= x < 8 @@
	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	init_codes:
		ldr r6, =arrayOfCodes	@@ Array of 3 codes
		mov r4, #0		@@ Memory address pointer

		b init_compare
		init_loop:
			mov r1, r0, asr #1
			add r3, r3, #1
			mul r1, r1, r3
			mov r2, #7
			bl divMod			@@ In: r1/r2 @@ Out: r0 <- a/b, r1 <- a%b
			str r1, [r6, r4, lsl #2]

			add r4, r4, #1
			init_compare:
				cmp r4, #3
				ble init_loop

	@@ Test section

	mov r4, #0
	 while:
		ldr r6, =arrayOfCodes
		ldr r1, [r6, r4, lsl #2]
		ldr r0, =print
		bl printf

                add r4, r4, #1
                cmp r4, #3
                blt while

	pop {pc}
	mov pc, lr
