	.data

.balign 4
message1: .asciz "Type in a dividend: "

.balign 4
message2: .asciz "Type in a divisor: "

.balign 4
message3: .asciz "%d / %d = %d with remainder %d\n"

.balign 4
scan_patter: .asciz "%d"

.balign 4
dividend_read: .word 0

.balign 4
divisor_read: .word 0

.balign 4
return: .word 0

.balign 4
return2: .word 0

	.text

divide:
	mov r2, #23     @ a, dividend INPUT / OUTPUT
	mov r3, #5      @ b, divisor INPUT / OUTPUT
	mov r4, #1	@ divisor scale
	mov r5, r3	@ b*r4
	mov r0, #0	@ a/b, quotient OUTPUT
	mov r1, r2	@ a%b, remainder OUTPUT
	cmp r1, r3
	bge shift_left
	b end
shift_left:
	mov r4, r4, lsl #1	@ a.k.a multiply by 2
	mov r5, r5, lsl #1	@ a.k.a multiply by 2
	cmp r1, r5
	bgt shift_left
	bge shift_right
shift_right:
	mov r4, r4, lsr #1
	mov r5, r5, lsr #1
	add r0, r0, r4
	sub r1, r1, r5
end:
	mov r7, #1
	swi 0
	bx lr
address_of_return2: .word return2

	.global main
main:
	ldr r6, address_of_return
	str lr, [r6]

	ldr r7, address_of_message1
	bl printf

	ldr r7, address_of_scan_pattern
	ldr r2, address_of_dividend_read
	bl scanf

	ldr r7, address_of_message2
	bl printf

	ldr r7, address_of_scan_pattern
	ldr r3, address_of_divisor_read
	bl scanf
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_scan_pattern: .word scan_pattern
address_of_dividend_read: .word dividend_read
address_of_divisor_read: .word divisor_read
address_of_return: .word return

	.global printf
	.global scanf
