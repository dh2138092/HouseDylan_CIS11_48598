.data

rho:             .word 0x9b5
velocity:        .byte 200
pi:              .word 0x3243f7
radius:          .word 6
conv:            .word 0x1c7
dragCoeffecient: .word 0x666

message: .asciz "\nInteger Dynamic Pressure = %d lbs\nCross-Sectional Area x 32 = %d ft^2\nInteger Drag x 32 = %d lbs\n\n"

.text

	.global main
main:
	push {lr}

	mov r0, #1    @@ Reserved for printf msg
	mov r1, #1    @@ r1 = dynamic pressure
	mov r2, #1    @@ r2 = cross-sectional area
	mov r3, #1    @@ r3 = drag
	mov r4, #1    @@ variable multiplication factor

	@@ Calculate dynamic pressure -> r1

	mov r1, #1          @@ xBit  1, BP -1
	ldr r4, =0x9B5                          @@ 12 bits, << 20
	mul r1, r1, r4      @@ xBit 12, BP -21
	ldr r4, =200                            @@  8 bits
	mul r1, r1, r4      @@ xBit 20, BP -21
	mul r1, r1, r4      @@ xBit 28, BP -21
	mov r1, r1, lsr#12  @@ xBit 16, BP -9

	@@ Calculate cross-sectional area -> r2

	ldr r2, =0x3243f7   @@ xBit 24, BP -20  @@ 24 bits, << 20
	ldr r4, =6                              @@  4 bits
	mul r2, r2, r4      @@ xBit 28, BP -20
	mul r2, r2, r4      @@ xBit 32, BP -20
	mov r2, r2, lsr#12  @@ xBit 20, BP -8
	ldr r4, =0x1C7                          @@ 12 bits, << 16
	mul r2, r2, r4      @@ xBit 32, BP -24
	mov r2, r2, lsr#16  @@ xBit 16, BP -8

	@@ Calculate drag -> r3

	mul r3, r1, r2      @@ xBit 32, BP -17
	mov r3, r3, lsr#12  @@ xBit 20, BP -5
	ldr r4, =0x666                          @@ 12 bits, << 12
	mul r3, r3, r4      @@ xBit 32, BP -17

	@@ Left-shift calculations to get correct and final values

	mov r1, r1, lsr#9
	mov r2, r2, lsr#3
	mov r3, r3, lsr#12

	@@ Print out results

	ldr r0, =message
	bl printf

	pop {pc}

exit:
	mov pc, lr
