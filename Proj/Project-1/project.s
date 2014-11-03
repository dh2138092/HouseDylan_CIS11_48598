.data

message_welcome:   .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n\n***********************************************\n\nGAME RULES:\n\n1. The code is 3 digits long, with each digit\n   being between the numbers 1 thru 7.\n\n2. You have 14 guesses to crack the code.\n\n3. Enter one number at a time.\n\n***********************************************\n\n"
message_win:       .asciz "*************************************************\n*******************YOU WON!!*********************\n*************************************************\n\n"
message_lose:      .asciz "You lose! The correct code was %d %d %d\n\n"

.text

.global main
main:
	push {lr}

	ldr r0, addr_of_message_welcome
	bl printf

	doWhile_r12_eq_Y:
		bl game_initialize

		doWhile_r11_lt_15:
			bl game_main
		cmp r11, #15
		blt doWhile_r11_lt_15

		cmp r9, #3    /* Use the # correct count to determine if round won or lost */
		bge win
		blt lose
		win:
			ldr r0, addr_of_message_win
			b game_over
		lose:
			ldr r0, addr_of_message_lose
			/* Prepare to printf secret code */
		        mov r1, r4
                	mov r2, r5
                	mov r3, r6
			b game_over

	game_over:
		bl printf
		bl play_again

		cmp r1, #'Y'
		beq doWhile_r12_eq_Y
		cmp r1, #'y'
		beq doWhile_r12_eq_Y

end:
	pop {pc}
	mov pc, lr

addr_of_message_welcome:   .word message_welcome
addr_of_message_win:       .word message_win
addr_of_message_lose:      .word message_lose
