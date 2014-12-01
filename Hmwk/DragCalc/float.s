.data

half:             .float 0.5
rho:              .float 0.00237
velocity:         .float 200
pi:               .float 3.141592
radius:           .float 6
conv:             .float 0.006944
dragCoeffecient:  .float 0.4
scalar:           .float 32
message: .asciz "\nFloat Dynamic Pressure = %f lbs/ft^2\nCross-Sectional Area x 32 = %f ft^2\nFloat Drag x 32 = %f lbs\n\n"

.text

	.global main
main:
	sub sp, sp, #24

	@@ Calculate dynamic pressure -> s0

	ldr r3, =half
	ldr r4, =rho
	ldr r5, =velocity
	vldr s13, [r3]
        vldr s14, [r4]
	vldr s15, [r5]

	vmov s0, s13
	vmul.f32 s0, s0, s14
	vmul.f32 s0, s0, s15
	vmul.f32 s0, s0, s15

	@@ Calculate cross-sectional area -> s2

	ldr r4, =pi
	ldr r5, =radius
	ldr r6, =conv
	vldr s14, [r4]
	vldr s15, [r5]
	vldr s16, [r6]

	vmov s2, s14
	vmul.f32 s2, s2, s15
	vmul.f32 s2, s2, s15
	vmul.f32 s2, s2, s16

	@@ Calculate drag -> s4

	ldr r4, =dragCoeffecient
	vldr s14, [r4]

	vmul.f32 s4, s0, s2
	vmul.f32 s4, s4, s14

	@@ Convert single-precision to double-precision to printf results

	ldr r0, =scalar
	vldr s14, [r0]
	vmul.f32 s2, s2, s14

	vcvt.f64.f32 d0, s0
	vcvt.f64.f32 d1, s2
	vcvt.f64.f32 d2, s4

	@@ Print out results

	ldr r0, =message
	vmov r2, r3, d0
	vstr d1, [sp]
	vstr d2, [sp, #+8]
	bl printf

	add sp, sp, #24

exit:
	mov r7, #1
	swi 0
