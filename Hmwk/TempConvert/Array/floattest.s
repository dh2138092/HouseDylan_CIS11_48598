.data

.align 8
fahrenheit_array:
.skip 368

.align 8
celcius_array:
.skip 368

factor:     .float 32.0
factor2:    .float 0.555555
start:      .float 32.0
pointer:    .float 0.0
increment:  .float 1.0
add4:       .float 4.0


.align 4
msg: .asciz "%f fahrenheit is %f celcius\n"

.text
init_array:
	push {lr}

	mov r2, #0
	ldr r3, =pointer
	ldr r4, =increment
	ldr r5, =add4
	ldr r6, =start
	vldr s13, [r3]
	vldr s14, [r4]
	vldr s15, [r5]
	vldr s16, [r6]

	loop:
		str s16, [s1, s13, lsl #3]

		vadd.f32 s13, s13, s14 
		vadd.f32 s16, s16, s15
		add r2, r2, #1
		cmp r2, r0
		ble loop

	pop {lr}
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
	vldr s1, =fahrenheit_array   /* second parameter: address of the array */
	bl init_array

	mov r0, #45
	ldr r1, =fahrenheit_array
	ldr r2, =celcius_array
	@bl fill_celcius

	mov r0, #45
	ldr r1, =fahrenheit_array
	ldr r2, =celcius_array
	@bl print_each_item

	pop {r4, lr}
	bx lr

addr_fahrenheit_array : .word fahrenheit_array
addr_celcius_array : .word celcius_array
addr_msg: .word msg
