	.text
	.global main
	.func main
main:
	sub sp, sp, #16

	mov r3, #0
	ldr r4, =50000000

	loop:
		ldr r0, =fahrenheit
		ldr r1, =factor
		ldr r2, =factor2
		vldr s14, [r0]
		vldr s15, [r1]
		vldr s16, [r2]

		vsub.f32 s12, s14, s15
		vmul.f32 s12, s12, s16

		vcvt.f64.f32 d0, s14
		vcvt.f64.f32 d1, s12

		add r3, r3, #1
		cmp r3, r4
		blt loop

	ldr r0, =msg
	vmov r2, r3, d0
	vstr d1, [sp]
	bl printf

	ldr r0, =msg2
	ldr r1, =50000000
	bl printf

	add sp, sp, #16

exit:
	mov r7, #1
	swi 0

	.data
fahrenheit: .float 212
factor:     .float 32
factor2:     .float 0.555555
msg: .asciz "\nConverting by floats...\n\n%f F is %f C\n"
msg2: .asciz "Looped %d times\n\n"
