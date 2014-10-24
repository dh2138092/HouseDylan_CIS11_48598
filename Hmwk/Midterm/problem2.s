.data
message1  : .asciz "Available packages from ISP Corp.\n\n1)  $30 per month, 11 hours access.  Additional hours\nare $3 up to 22 hours then $6 for all additional\nhours.\n2)  $35 per month, 22 hours access.  Additional hours\nare $2 up to 44 hours then $4 for each\nhour above this limit.\n3)  $40 per month, 33 hours access.  Additional hours\nare $1 up to 66 hours then $2 for each\nhour above this limit.\n\nPlease choose your package and enter the number\nof hours you will use our services for...\n"
message2  : .asciz "You bill for this cycle is $%d"
selection : .ascii "  \n "
format    : .asciz "%d"

.text

	.global main
main:
	push {lr}

	ldr r0, address_of_message1
	bl printf

	read_character:
	mov r7, #3
	mov r0, #0
	mov r2, #1
	ldr r1, =selection
	swi 0

	print_character:
	mov r7, #4
	mov r0, #1
	mov r2, #3
	ldr r1, =selection
	swi 0

@	ldr r0, address_of_format

	pop {lr}
	bx lr
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_format   : .word format
	.global printf
	.global scanf
