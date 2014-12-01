	.text
	.global main
	.func main
main:
	push {lr}
	sub sp, sp, #24

	ldr r1, =value1
	vldr s14, [r1]
	vcvt.f64.f32 d0, s14

	ldr r1, =value2
	vldr s15, [r1]
	vcvt.f64.f32 d1, s15

	ldr r1, =value3
	vldr s16, [r1]
	vcvt.f64.f32 d2, s16

	ldr r0, =string
	vmov r2, r3, d0
	vstr d1, [sp, #+8]
	vstr d2, [sp, #+16]
	bl printf

	add sp, sp, #24
	pop {pc}
	mov pc, lr
@	mov r7, #1
@	swi 0

	.data
value1: .float 1.54321
value2: .float 5.1
value3: .float 3.2
string: .asciz "The FP values are %f and %f and %f\n"
