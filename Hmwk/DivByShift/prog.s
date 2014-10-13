/*
	Dylan House
	Cis-11-48598
	Mark Lehr
*/
	.data

.balign 4
message1 : .asciz "Type in a dividend: "

.balign 4
message2 : .asciz "Type in a divisor: "

.balign 4
message3 : .asciz "%d divided by %d equals %d with remainder "

.balign 4
message4 : .asciz "%d\n"

.balign 4
scan_pattern : .asciz "%d"

.balign 4
dividend_read : .word 0

.balign 4
divisor_read : .word 0

.balign 4
return : .word 0

.balign 4
return2 : .word 0

	.text

divide:
	ldr r1, address_of_return2
	str lr, [r1]
	@ r2 is dividend (a) provided by the user
	@ r3 is divisor (b) provided by the user
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
	ldr lr, address_of_return2
	ldr lr, [lr]
	bx lr
address_of_return2 : .word return2

	.global main
main:
	ldr r1, address_of_return
	str lr, [r1]

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

	/* FIX THESE */
	@mov r4, r7 @ a%b is stored
	mov r3, r6 @ a/b is stored
	ldr r2, address_of_divisor_read
	ldr r2, [r2]
	ldr r1, address_of_dividend_read
	ldr r1, [r1]
	ldr r0, address_of_message3
	bl printf

	mov r1, r7
	ldr r0, address_of_message4
	bl printf

	ldr lr, address_of_return
	ldr lr, [lr]
	bx lr
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message4 : .word message4
address_of_scan_pattern : .word scan_pattern
address_of_dividend_read : .word dividend_read
address_of_divisor_read : .word divisor_read
address_of_return : .word return

	.global printf
	.global scanf
