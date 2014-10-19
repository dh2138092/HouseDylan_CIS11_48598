/*
	Dylan House
	CIS-11-48598
	Mark Lehr
*/

.data

message1 : .asciz "Type in a dividend: "
message2 : .asciz "Type in a divisor: "
message3 : .asciz "%d divided by %d equals %d "
message4 : .asciz "with remainder %d\n"
scan_pattern : .asciz "%d"

.text

divide:
	stmdb sp!, {lr}
	/* r2 DIVIDEND */
	/* r3 DIVISOR */
	mov r3, #5 /* TEMP TEST */
	mov r4, #1	@ divisor scale
	mov r5, r3	@ b*r4
	mov r6, #0	@ a/b, quotient OUTPUT
	mov r7, r2	@ a%b, remainder OUTPUT
	cmp r7, r3      @ compare a and b
	bge shift_left
	b end
shift_left:
	mov r4, r4, lsl #1	@ a.k.a multiply by 2
	mov r5, r5, lsl #1	@ a.k.a multiply by 2
	cmp r7, r5
	bgt shift_left
	bge shift_right
shift_right:
	mov r4, r4, lsr #1
	mov r5, r5, lsr #1
	add r6, r6, r4
	sub r7, r7, r5
end:
	ldmia sp!, {lr}
	bx lr

	.global main
main:
	push {lr}                   /* Push lr onto the top of the stack */
	sub sp, sp, #4                    /* Make room for our 4 byte input integer in the stack, to be used twice */
                                          /* Twice, one for DIVIDEND, and the other for our DIVISOR */
	/* Get the dividend */
	ldr r0, address_of_message1
	bl printf                         /* Print "Type a dividend: " */
	ldr r0, address_of_scan_pattern
	mov r1, sp                        /* Set the top of the stack as our second parameter in scanf */
	bl scanf
	ldr r2, [sp]                      /* Load the input <DIVIDEND> into r2 */

	/* Get the divisor */
	ldr r0, address_of_message2
@	bl printf                         /* Print "Type a divisor: " */
	ldr r0, address_of_scan_pattern
	mov r1, sp                        /* Set the top of the stack as our second parameter in scanf */
@	bl scanf
	ldr r3, [sp]                      /* Load the input <DIVISOR> into r3 */

	bl divide                         /* Get QUOTIENT and REMAINDER */

	ldr r0, address_of_message3
	mov r1, r2                        /* Move DIVIDEND into r1 */
	mov r2, r3                        /* Move DIVISOR into r2 */
	mov r3, r6                        /* Move QUOTIENT into r3 */
	bl printf

	mov r1, r7                        /* Move REMAINDER into r1 */
	ldr r0, address_of_message4
	bl printf

	add sp, sp, #+4                   /* Discard the last integer that was read by scanf */
	pull {lr}                   /* Pop the top of the stack and put it into lr */
	bx lr
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message4 : .word message4
address_of_scan_pattern : .word scan_pattern

	.global printf
	.global scanf
