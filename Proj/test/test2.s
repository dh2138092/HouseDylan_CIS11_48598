.data
string: .asciz "Float value: %f\n"
.text
.global main
main:
	push {lr}

	mov r0, #16
	vmov s0, r0
	vcvt.f64.u32 d0, s0

	ldr r0, =string
	vmov r2, r3, d0
	bl printf

	mov r0, #46
	vmov s2, r0
	vcvt.f64.u32 d2, s2

        ldr r0, =string
        vmov r2, r3, d2
        bl printf

	vdiv.f64 d3, d0, d2

	ldr r0, =string
	vmov r2, r3, d3
	bl printf

	pop {pc}
	mov pc, lr
