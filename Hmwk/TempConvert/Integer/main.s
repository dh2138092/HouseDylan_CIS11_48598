.text
        .global main

main:
        push {lr}

	mov r0, #80
	mov r2, r0
	mov r4, #0
	ldr r5, =100000000

@       bl getInput

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

        sub r0, r0, #32
        ldr r1, =0x8E38F
        mul r0, r0, r1
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

