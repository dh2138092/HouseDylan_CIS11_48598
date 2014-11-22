.text
        .global main

main:
        push {lr}

	mov r0, #80          @@ r0 = fahrenheit, to be converted to celsius
	mov r2, r0           @@ r2 = r0, to remember the value to print it later
	mov r4, #0           @@ r4 = r4++, for the loop
	ldr r5, =100000000   @@ r5 = number of loops to perform

@       bl getInput

	@@ Loop convertFtoC r5 times to get a measurement of the functions running time

	loop:
        	bl convertFtoC
		mov r0, r2
		add r4, r4, #1
		cmp r4, r5
		blt loop

        bl printResult

        pop {pc}

exit:
        mov pc, lr

convertFtoC:
        push {lr}

        ldr r1, =0x8E38F
        sub r0, r0, #32      @@ F - 32 = A
        mul r0, r0, r1       @@ A * 5/9
        mov r0, r0, lsr#20

        mov r3, r0

        pop {pc}
        mov pc, lr

getInput:
	push {lr}
	sub sp, sp, #4

	@@ Get input, but only accept values 32 <= x <= 212

        do_while:
        	ldr r0, =message_in
        	bl printf

        	ldr r0, =scan
        	mov r1, sp
        	bl scanf

        	ldr r0, [sp]
        	cmp r0, #32
        	blt do_while
        	cmp r0, #212
        	bgt do_while

	mov r2, r0

	add sp, sp, #4
	pop {pc}
	mov pc, lr

printResult:
	push {lr}

	mov r1, r2
	mov r2, r3
	ldr r0, =message_out
	bl printf

	pop {pc}
	mov pc, lr

.data

message_in:
	.asciz "\nEnter a temperature 32 <= F <= 212: "
message_out:
	.asciz "\n%d F is ~%d C.\n\n"
scan:
	.asciz "%d"

