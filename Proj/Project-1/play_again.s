.data
message_playagain: .asciz "Do you want to play again? (Y/N)  "
format_playagain:  .asciz " %c"

.text
.global play_again
play_again:
	push {lr}
	sub sp, sp, #4

	ldr r0, addr_of_message_playagain
	bl printf

	ldr r0, addr_of_format_playagain
	mov r1, sp
	bl scanf

	ldr r1, [sp]

	add sp, sp, #4
	pop {pc}
	mov pc, lr

addr_of_message_playagain: .word message_playagain
addr_of_format_playagain:  .word format_playagain
