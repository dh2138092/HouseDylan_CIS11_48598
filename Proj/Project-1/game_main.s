.data
message_turn:      .asciz "\n\n                  Turn %d / 14\n================================================\n"
format_guesses:    .asciz "%d %d %d"
message_position:  .asciz "\n# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"

.text
.global game_main
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

addr_of_message_turn:      .word message_turn
addr_of_message_position:  .word message_position
addr_of_format_guesses:    .word format_guesses
