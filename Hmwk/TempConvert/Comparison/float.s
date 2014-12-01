	.text
	.global main
	.func main
main:
	sub sp, sp, #16

	ldr r0, =fahrenheit
	ldr r1, =factor
	ldr r2, =factor2
	vldr s14, [r0]
	vldr s15, [r1]
	vldr s16, [r2]

	vsub.f32 s0, s15, s14
	vmul.f32 s0, s0, s16

	vcvt.f64.f32 d0, s14
	vcvt.f64.f32 d1, s0

	ldr r0, =msg
	vmov r2, r3, d0
	vstr d1, [sp]
	bl printf

	add sp, sp, #16
	mov r7, #1
	swi 0

	.data
fahrenheit: .float 212
factor:     .float 32
factor2:     .float 0.555555
msg: .asciz "\nNumbers: %f %f\n"
