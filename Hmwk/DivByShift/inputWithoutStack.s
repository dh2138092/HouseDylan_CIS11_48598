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
dividend_read : .word 0
divisor_read : .word 0

.text

divide:
	push {lr}
	/* r2 is dividend (a) provided by the user */
	/* r3 is divisor (b) provided by the user */
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
	pop {lr}
	bx lr

	.global main
main:
	push {lr}
	/* Print "Type a dividend: " */
	ldr r0, address_of_message1
	bl printf

	/* Get user input for the dividend a */
	ldr r0, address_of_scan_pattern
	ldr r1, address_of_dividend_read
	bl scanf

	/* Print "Type a divisor: " */
	ldr r0, address_of_message2
	bl printf

	/* Get user input for the divisor b */
	ldr r0, address_of_scan_pattern
	ldr r1, address_of_divisor_read
	bl scanf

	/* Get a/b and a%b */
	ldr r0, address_of_dividend_read
	ldr r2, [r0]
	ldr r0, address_of_divisor_read
	ldr r3, [r0]
	bl divide

	mov r3, r6 /* a/b is stored here */
	ldr r2, address_of_divisor_read
	ldr r2, [r2]
	ldr r1, address_of_dividend_read
	ldr r1, [r1]
	ldr r0, address_of_message3
	bl printf

	mov r1, r7
	ldr r0, address_of_message4
	bl printf

	pop {lr}
	bx lr
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message4 : .word message4
address_of_scan_pattern : .word scan_pattern
address_of_dividend_read : .word dividend_read
address_of_divisor_read : .word divisor_read

	.global printf
	.global scanf
