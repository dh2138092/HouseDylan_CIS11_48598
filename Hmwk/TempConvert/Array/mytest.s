.data

.align 4
fahrenheit_array:
.skip 184

.align 4
celcius_array:
.skip 184

factor:     .word 0x8e38f

.align 4
msg: .asciz "%d fahrenheit is %d celcius\n"

.text
init_array:
	push {r4, r5, lr}

	mov r4, #0      @@ Array address incrementer
	mov r5, #32     @@ Starting temperature

	loop:
		str r5, [r1, r4, lsl #2]
		add r4, r4, #1
		add r5, r5, #4

		cmp r4, r0
		ble loop

	pop {r4, r5, lr}
	bx lr

convert:
        @@ Convert fahrenheit to celsius

	push {lr}

@       ldr r1, =fahrenheit  @@  8 bits
        ldr r3, =factor      @@ 20 bits, << 20
@       ldr r1, [r1]
        ldr r3, [r3]

        sub r1, r1, #32      @@ xBit  8, BP -1
        mul r1, r1, r3       @@ xBit 28, BP -21
        mov r2, r1, lsr#20   @@ xBit  8, BP -1

	pop {pc}
	mov pc, lr

fill_celcius:
	push {lr}

	mov r4, #0     @@ Array address pointer
	mov r6, r0     @@ #45, or the total number of temperatures we are going to convert
	mov r7, r1     @@ Address of array of 45 fahrenheit temperatures
	mov r8, r2     @@ Adddress of array of 45 celcius temperatures

	b compare
	fill:
		ldr r1, [r7, r4, lsl#2]      @@ Load r1 with value at r7[r4]
		bl convert                   @@ r2 <- r1 converted to celcius
		str r2, [r8, r4, lsl#2]      @@ Store r2 into r8[r4]
		add r4, r4, #1               @@ Increment address pointer
	compare:
		cmp r4, r6                   @@ Is r4 >= 45?
		ble fill                     @@ Yes, then continue converting & filling

	pop {pc}
	mov pc, lr

print_each_item:
	push {r4, r5, r6, r7, r8, lr}

	mov r4, #0
	mov r6, r0
	mov r7, r1
	mov r8, r2

	b check
	print_items:
		ldr r3, [r8, r4, lsl #2]
		ldr r5, [r7, r4, lsl #2]

		ldr r0, addr_msg
		mov r1, r5
		mov r2, r3
		bl printf

	str r3, [r8, r4, lsl #2]
	str r5, [r7, r4, lsl #2]
	add r4, r4, #1
	check:
		cmp r4, r6      @@ Compare r4 with 45
		ble print_items

	pop {r4, r5, r6, r7, r8, lr}
	bx lr

	.global main
main:
	push {r4, lr}

	mov r0, #45                    /* first_parameter: highest temperature */
	ldr r1, addr_fahrenheit_array   /* second parameter: address of the array */
	bl init_array

	mov r0, #45
	ldr r1, addr_fahrenheit_array
	ldr r2, addr_celcius_array
	bl fill_celcius

	mov r0, #45
	ldr r1, addr_fahrenheit_array
	ldr r2, addr_celcius_array
	bl print_each_item

	pop {r4, lr}
	bx lr

addr_fahrenheit_array : .word fahrenheit_array
addr_celcius_array : .word celcius_array
addr_msg: .word msg
