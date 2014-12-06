/* Here is my testing code */
.data
msg1: .asciz "Enter an integer:"
msg2: .asciz "The integer you enter is: %d\n"
msg3: .asciz "The floating number is: %f\n"
scan_format: .asciz "%d"
integer: .word 0
dividend: .word 15

.text
.global main
main:
        ldr r0, =msg1
        bl printf
        ldr r0, =scan_format
        ldr r1, addr_integer
        bl scanf
 
        ldr r0, =msg2
        ldr r1, addr_integer
        ldr r1, [r1]
        bl printf
 
        ldr r0, addr_integer
        ldr r1, [r0] /* load register1 the content of address */
        vmov s13, r1 /* bit copy from integer register1 to s13 */
        vcvt.f32.s32 s14, s13 /* Converts s13 signed integer value to a single-precision value and stores it in s14 */
        vcvt.f64.f32 d0, s14

	ldr r0, =dividend
	ldr r0, [r0]
	vmov s16, r0
	vcvt.f32.s32 s17, s16
	vcvt.f64.f32 d1, s17

	vdiv.f64 d2, d1, d0

        ldr r0, =msg3
        vmov r2, r3, d2
        bl printf
        mov r7, #1
        swi 0
addr_integer: .word integer
.global printf
.global scanf
