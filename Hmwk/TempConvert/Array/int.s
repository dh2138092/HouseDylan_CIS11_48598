	.data

@@ Converting fahrenheit temperatures from 32 to 212 into centigrade
@@ 212 - 32 = 180 / increments of 4 = 45 temperatures
@@ Each temperature value is 4 bytes, so
@@ 45 * 4 = 180 + 4 = skip 184

.align 4
fahrenheit_array:
.skip 184

.align 4
celcius_array:
.skip 184

.align 4
factor: .word 0x8e38f

.align 4
msg: .asciz "%d fahrenheit is %d celcius\n"

	.text

@@ Initialize array of n fahrenheit values
init_fahrenheit_array:
	push {r4, r5, lr}

	mov r4, #0      @@ Array address incrementer
	mov r5, #32     @@ Starting temperature

	loop:
		str r5, [r1, r4, lsl #2]
		add r4, r4, #1
		add r5, r5, #4

		cmp r4, r0
		ble loop

	pop {r4, r5, pc}
	mov pc, lr

@@ Convert fahrenheit value to centigrade value
@@ Input:  r1 <- fahrenheit value
@@ Output: r2 <- centigrade value
convert_F_to_C:
	push {lr}

        ldr r3, =factor      @@ 20 bits, << 20
        ldr r3, [r3]

        sub r1, r1, #32      @@ xBit  8, BP -1
        mul r1, r1, r3       @@ xBit 28, BP -21
        mov r2, r1, lsr#20   @@ xBit  8, BP -1

	pop {pc}
	mov pc, lr

@@ Fill array with n celcius values
fill_celcius_array:
	push {lr}

	mov r4, #0     @@ Array address pointer
	mov r6, r0     @@ #45, or the total number of temperatures we are going to convert
	mov r7, r1     @@ Address of array of 45 fahrenheit temperatures
	mov r8, r2     @@ Adddress of array of 45 celcius temperatures

	b fill_compare
	fill_block:
		ldr r1, [r7, r4, lsl#2]		@@ Load r1 with value at r7[r4]
		bl convert_F_to_C
		str r2, [r8, r4, lsl#2]		@@ Store r2 into r8[r4]

		add r4, r4, #1
		fill_compare:
			cmp r4, r6
			ble fill_block

	pop {pc}
	mov pc, lr

@@ Print n lines of temperatures
print_temperatures:
	push {r4, r5, r6, r7, lr}

	mov r4, #0
	mov r5, r0
	mov r6, r1
	mov r7, r2

	b print_compare
	print_line:
		ldr r2, [r7, r4, lsl #2]
		ldr r1, [r6, r4, lsl #2]
		ldr r0, addr_msg
		bl printf

		add r4, r4, #1
		print_compare:
			cmp r4, r5
			ble print_line

	pop {r4, r5, r6, r7, pc}
	mov pc, lr

	.global main
main:
	push {r4, lr}

	@@ Recall that #45 is the num of temperatures we are going to convert

	mov r0, #45
	ldr r1, addr_fahrenheit_array
	bl init_fahrenheit_array

	mov r0, #45
	ldr r1, addr_fahrenheit_array
	ldr r2, addr_celcius_array
	bl fill_celcius_array

	mov r0, #45
	ldr r1, addr_fahrenheit_array
	ldr r2, addr_celcius_array
	bl print_temperatures

	pop {r4, pc}

exit:
	mov pc, lr

addr_fahrenheit_array: .word fahrenheit_array
addr_celcius_array:    .word celcius_array
addr_msg:              .word msg
