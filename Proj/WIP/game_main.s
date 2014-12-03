	.data
message_turn:      .asciz "\n\n                  Turn %d / 14\n================================================\n"
message_position:  .asciz "\n# in Correct Position        # in Wrong Position\n---------------------        -------------------\n          %d                           %d\n\n"
format_guess: .asciz "%d"

	.text
	.global game_main
game_main:
	push {lr}
	sub sp, sp, #4

	reset_counters:
        mov r9, #0
        mov r10, #0

	display_turn_number:
	ldr r0, addr_of_message_turn
	mov r1, r11			@@ r11 <- turn number, see game_init.s
	bl printf

	b get_compare
	get_guesses:
		mov r4, #0
		ldr r6, =guesses	@@ Load guess array

		ldr r0, =format_guess
		str sp, [r6, r4, lsl #2]
		bl scanf

		add r4, r4, #1
		get_compare:
			cmp r4, #3
			ble get_guesses

	compare_guesses:
		mov r4, #0
		ldr r5, =codes

		ldr r1, [r5, r4, lsl #2]
		ldr r2, [r6, r4, lsl #2]

		cmp r1, r2
		addeq r9, #1
		addne r10, #1

		add r4, r4, #1
		compare_compare:
			cmp r4, #3
			ble compare_guesses

	display_num_correct:
		ldr r0, addr_of_message_position
		mov r1, r9
		mov r2, r10
		bl printf

		cmp r9, #3
		addeq r11, r11, #14    /* Add enough to make sure the turn counter is >= 15 to end the round */

	increment_turn:
		add r11, r11, #1

	add sp, sp, #4

	pop {pc}
	mov pc, lr

addr_of_message_turn:      .word message_turn
addr_of_message_position:  .word message_position
