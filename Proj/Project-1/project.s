.data

.balign 4
code: .skip 12
.balign 4
guess: .skip 12
message_welcome:   .asciz "\n\n            M A S T E R M I N D ! ! !\n\nCreated by Dylan House, CIS-11-48598\n\nCrack the numerical code to win!\n\n===============================================\nGAME RULES:\n1. The code is 3 digits long, with each digit\n   being between the numbers 1 thru 7.\n2. You have 14 guesses to crack the code.\n===============================================\n\n"
message_turn:      .asciz "================================================\n                  Turn %d / 14\n================================================\n"
message_position:  .asciz "\n# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"
message_win:       .asciz "*************************************************\n*******************YOU WON!!*********************\n*************************************************\n"
message_lose:      .asciz "You lose! The correct code was %d %d %d\n\n"
message_playagain: .asciz "Do you want to play again? (Y/N)  "
format_guess:      .asciz "%d"
format_playagain:  .asciz " %c"

format_guess2: .asciz "%d %d %d"
guess1: .word 0
guess2: .word 0
guess3: .word 0

.text

game_main:
	push {lr}
	sub sp, sp, #12

	/* TEST BLOCK */
	mov r4, #1
	mov r5, #1
	mov r6, #1
	/* TEST BLOCK */

        /* RESET # CORRECT and # INCORRECT FOR THIS TURN */
        mov r9, #0
        mov r10, #0

	/* DISPLAY TURN NUM */
	ldr r0, addr_of_message_turn
	mov r1, r11
	bl printf

	get_guesses:
	/* GET 3 GUESSES FROM THE USER */
	ldr r0, addr_format_guess2
	mov r3, sp
	add r2, r3, #4
	add r1, r2, #4
	bl scanf

	/* LOAD EACH GUESS INTO A REGISTER FOR UPCOMING COMPARISONS */
	add r1, sp, #8
	ldr r1, [r1]
	add r2, sp, #4
	ldr r2, [r2]
	ldr r3, [sp]

	compare_guesses:
        /* COMPARE GUESS 1 WITH CODE 1*/
        /* INCREMENT # CORRECT or # INCORRECT DEPENDING ON CMP */
	cmp r1, r4
	addeq r9, #1
	addne r10, #1

	/* COMPARE GUESS 2 WITH CODE 2*/
	/* INCREMENT # CORRECT or # INCORRECT DEPENDING ON CMP */
	cmp r2, r5
	addeq r9, #1
	addne r10, #1

        /* COMPARE GUESS 1 WITH CODE 1*/
        /* INCREMENT # CORRECT or # INCORRECT DEPENDING ON CMP */
	cmp r3, r6
	addeq r9, #1
	addne r10, #1

	display_num_correct:
	/* DISPLAY # CORRECT and # INCORRECT */
	ldr r0, addr_of_message_position
	mov r1, r9
	mov r2, r10
	bl printf

	cmp r9, #3
	addeq r11, r11, #14

	/* INCREMENT TURN COUNTER */
	add r11, r11, #1

	add sp, sp, #12
	pop {pc}
	mov pc, lr

game_initialize:
	push {lr}

	mov r0, #0
	mov r1, #0
	mov r2, #7
	mov r3, #0 @ code 1
	mov r4, #0 @ code 2
	mov r5, #0 @ code 3
	mov r6, #0 @ guess 1
	mov r7, #0 @ guess 2
	mov r8, #0 @ guess 3
	mov r9, #0 @ correct counter
	mov r10, #0 @ incorrect counter
	mov r11, #1 @ turn counter
	mov r12, #'Y' @ play again?

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
@	ldr r0, addr_of_message_lose
@	mov r1, r3
@	mov r2, r4
@	mov r3, r5
@	bl printf
	/* TEST BLOCK */

@	pop {lr}
@	bx lr
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

win:
	pop {lr}
	add sp, sp, #12
	ldr r0, addr_of_message_win
	bl printf
	bl play_again
	@b end

lose:
	ldr r0, addr_of_message_lose
	bl printf
	bl play_again
	@b end

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

		
		
		bl play_again

	cmp r1, #'Y'
	beq doWhile_r12_eq_Y
	cmp r1, #'y'
	beq doWhile_r12_eq_Y

end:
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

addr_format_guess2: .word format_guess2
addr_guess1: .word guess1
addr_guess2: .word guess2
addr_guess3: .word guess3
