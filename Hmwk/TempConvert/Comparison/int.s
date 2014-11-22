.data

fahrenheit: .word 212
factor:     .word 0x8e38f
msg: .asciz "\n%d F is %d C\n\n"

.text
convertFtoC:
        @@ Convert fahrenheit to celsius

	push {lr}

        ldr r1, =fahrenheit
        ldr r3, =factor
        ldr r1, [r1]
        ldr r3, [r3]

        sub r1, r1, #32
        mul r1, r1, r3
        mov r2, r1, lsr#20

	pop {pc}
	mov pc, lr

print:
        @@ Print message

	push {lr}

        ldr r1, =fahrenheit
        ldr r1, [r1]
        ldr r0, =msg
        bl printf

	pop {pc}
	mov pc, lr

	.global main

main:
	push {lr}

	mov r0, #1          @@ r0 = resrved for printf message
	mov r1, #1          @@ r1 = fahrenheit
	mov r2, #1          @@ r2 = celsius
	mov r3, #1          @@ r3 = multiplication factor - 5/9 << 20 bits
	mov r4, #0          @@ r4 = r4++, for the loop
	ldr r5, =50000000  @@ r5 = number of loops to perform

	loop:
		bl convertFtoC
		add r4, r4, #1
		cmp r4, r5
		blt loop

	bl print

	pop {pc}

exit:
	mov pc, lr
