.data
message1 : .asciz "
                   Available packages from ISP Corp.\n\n
                   1)  $30 per month, 11 hours access.  Additional hours\n
                       are $3 up to 22 hours then $6 for all additional\n
                       hours.\n
                   2)  $35 per month, 22 hours access.  Additional hours\n
                       are $2 up to 44 hours then $4 for each\n
                       hour above this limit.\n
                   3)  $40 per month, 33 hours access.  Additional hours\n
                       are $1 up to 66 hours then $2 for each\n
                       hour above this limit.\n\n
                   Please choose your package and enter the number\n
                   of hours you will use our services for...\n"
.text

	.global main
main:
	push {lr}

	ldr r0, address_of_message1
	bl printf

	pop {lr}
	bx lr
address_of_message1 : .word message1

	.global printf
	.global scanf
