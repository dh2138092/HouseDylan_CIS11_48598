.data

message_in:  .asciz "\nEnter a temperature 32 <= F <= 212: "
message_out: .asciz "\n%d F is ~%d C.\n\n"
scan:        .asciz "%d"

.text

get_input:
	push {lr}
	sub sp, sp, #4

	/* Get input, but only accept values 32 <= x <= 212 */
        do_while:
        	ldr r0, addr_msg_in
        	bl printf

        	ldr r0, addr_scan
        	mov r1, sp
        	bl scanf

        	ldr r0, [sp]
        	cmp r0, #32
        	blt do_while
        	cmp r0, #212
        	bgt do_while

        mov r4, r0           @ since r0 thru r3 are used in another function, we need to save the input
        		     @ in r4 so that we can print out this value at the end of the program

	add sp, sp, #4
	pop {pc}
	mov pc, lr

print_result:
	push {lr}

        mov r1, r4            @ r1 is the user's input in fahrenheit
        mov r2, r0            @ r0 is the user's input converted to celsius
        ldr r0, addr_msg_out
        bl printf

	pop {pc}
	mov pc, lr

	.global main
main:
	push {lr}

	bl get_input

	bl convert_F_to_C

	bl print_result

	pop {pc}
	mov pc, lr

addr_msg_in:  .word message_in
addr_msg_out: .word message_out
addr_scan:    .word scan
