	.data
msgPlayAgain: .asciz "Do you want to play again? (Y/N)  "
fmtPlayAgain: .asciz " %c"

	.text
.global askToPlayAgain
askToPlayAgain:
	push {lr}
	sub sp, sp, #4

	ldr r0, =msgPlayAgain
	bl printf

	ldr r0, =fmtPlayAgain
	mov r1, sp
	bl scanf

	ldr r1, [sp]

	add sp, sp, #4
	pop {pc}
	mov pc, lr
