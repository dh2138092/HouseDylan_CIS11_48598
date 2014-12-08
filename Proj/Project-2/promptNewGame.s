	.data

msgPlayAgain:  .asciz "Do you want to play again? (Y/N)  "
fmtPlayAgain:  .asciz " %c"
newline:       .asciz "\n"

	.text

	.global promptNewGame
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
