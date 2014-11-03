.data

message_welcome:   .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n\n***********************************************\n\nGAME RULES:\n\n1. The code is 3 digits long, with each digit\n   being between the numbers 1 thru 7.\n\n2. You have 14 guesses to crack the code.\n\n3. Enter one number at a time.\n\n***********************************************\n\n"
message_turn:      .asciz "\n\n                  Turn %d / 14\n================================================\n"
message_position:  .asciz "\n# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"
message_win:       .asciz "*************************************************\n*******************YOU WON!!*********************\n*************************************************\n\n"
message_lose:      .asciz "You lose! The correct code was %d %d %d\n\n"
message_playagain: .asciz "Do you want to play again? (Y/N)  "
format_guesses:    .asciz "%d %d %d"
format_playagain:  .asciz " %c"

.text

game_main:
	push {lr}
	sub sp, sp, #12

	@ r0 is for printf and scanf
	@ r1 is user's first guess
	@ r2 is user's second guess
	@ r3 is user's third guess

	reset_counters:
        mov r9, #0
        mov r10, #0

	display_turn_number:
	ldr r0, addr_of_message_turn
	mov r1, r11
	bl printf

	get_guesses:
	ldr r0, addr_of_format_guesses
	mov r3, sp
	add r2, r3, #4
	add r1, r2, #4
	bl scanf

	load_guesses:
	add r1, sp, #8
	ldr r1, [r1]
	add r2, sp, #4
	ldr r2, [r2]
	ldr r3, [sp]

	compare_guesses:
	cmp r1, r4
	addeq r9, #1
	addne r10, #1

	cmp r2, r5
	addeq r9, #1
	addne r10, #1

	cmp r3, r6
	addeq r9, #1
	addne r10, #1

	display_num_correct:
	ldr r0, addr_of_message_position
	mov r1, r9
	mov r2, r10
	bl printf

	cmp r9, #3
	addeq r11, r11, #14    /* Add enough to make sure the turn counter is >= 15 to end the round */

	increment_turn:
	add r11, r11, #1

	add sp, sp, #12
	pop {pc}
	mov pc, lr

game_initialize:
	push {lr}

	mov r0, #0                   /* r0 for time(r0) */
	mov r1, #0                   /* r1 = remainder */
	mov r2, #7                   /* r2 for randomNum % r2 */

	mov r4, #0 @ code 1
	mov r5, #0 @ code 2
	mov r6, #0 @ code 3
	mov r9, #0 @ correct counter
	mov r10, #0 @ incorrect counter
	mov r11, #1 @ turn counter
	mov r12, #'Y' @ play again?

	mov r0, #0
	bl time
	bl srand
	bl rand

	generate_1:
	mov r1, r0, ASR #1
	mov r2, #7
	bl divMod
	mov r4, r1

	generate_2:
        mov r1, r0, ASR #2
	mov r3, #3
 	mul r1, r1, r3
        mov r2, #7
	bl divMod
	mov r5, r1

	generate_3:
        mov r1, r0, ASR #3
        mov r3, #4
        mul r1, r1, r3
        mov r2, #7
	bl divMod
	mov r6, r1

	pop {pc}
	mov pc, lr

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
addr_of_message_turn:      .word message_turn
addr_of_message_position:  .word message_position
addr_of_message_win:       .word message_win
addr_of_message_lose:      .word message_lose
addr_of_message_playagain: .word message_playagain
addr_of_format_guesses:    .word format_guesses
addr_of_format_playagain:  .word format_playagain
