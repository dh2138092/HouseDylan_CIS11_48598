.data

.balign 4
code: .skip 12
.balign 4
guess: .skip 12
message_welcome:   .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n===============================================\nGAME RULES:\n1. The code is 3 digits long, with each digit\n   being between the numbers 1 thru 7.\n2. You have 14 guesses to crack the code.\n===============================================\n\n"
message_turn:      .asciz "================================================\n                  Turn %d / 14\n================================================\n"
message_position:  .asciz "# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"
message_win:       .asciz "*************************************************\n*******************YOU WON!!*********************\n*************************************************\n"
message_lose:      .asciz "You lose! The correct code was %d %d %d\n\n"
message_playagain: .asciz "Do you want to play again? (Y/N)  "
format_guess:      .asciz "%d %d %d"
format_playagain:  .asciz "%c"

.text

initialize_game:
	push {lr}

	mov r0, #0
	mov r1, #0
	mov r2, #7
	mov r4, #3

	bl time
	bl srand
	bl rand
	mov r1, r0, ASR #1

	bl divMod
	mov r3, r1

	mov r2, #7
	add r1, #58
	bl divMod
	mov r4, r1

	mov r2, #7
	add r1, #24
	bl divMod
	mov r5, r1

	/* TEST BLOCK */
	ldr r0, addr_of_message_lose
	mov r1, r3
	mov r2, r4
	mov r3, r5
	bl printf
	/* TEST BLOCK */

	pop {lr}
	bx lr

	.global main
main:
	push {lr}
	sub sp, sp, #12

@	ldr r3, addr_of_code
@	ldr r4, addr_of_guess

	ldr r0, addr_of_message_welcome
	bl printf

	bl initialize_game

end:
	add sp, sp, #12
	pop {pc}
	mov pc, lr

addr_of_code:              .word code
addr_of_guess:             .word guess
addr_of_message_welcome:   .word message_welcome
addr_of_message_turn:      .word message_turn
addr_of_message_position:  .word message_position
addr_of_message_win:       .word message_win
addr_of_message_lose:      .word message_lose
addr_of_message_playagain: .word message_playagain
addr_of_format_guess:      .word format_guess
addr_of_format_playagain:  .word format_playagain
