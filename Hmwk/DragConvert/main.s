.data

rho:             .word 0x9b5       @@ 12 bits, << 20
velocity:        .word 0xc8        @@  8 bits
pi:              .word 0x3243f7    @@ 24 bits, << 20
radius:          .word 0x6         @@  4 bits
conv:            .word 0x1c7       @@ 12 bits, << 16
dragCoeffecient: .word 0x666       @@ 12 bits, << 12

message: .asciz "\nInteger Dynamic Pressure = %d lbs\nCross-Sectional Area x 32 = %d ft^2\nInteger Drag x 32 = %d lbs\n\n"

.text

	.global main
main:
	push {lr}

	mov r0, #1    @@ Reserved for printf msg
	mov r1, #1    @@ r1 = dynamic pressure
	mov r2, #1    @@ r2 = cross-sectional area
	mov r3, #1    @@ r3 = drag
	mov r4, #1    @@ variable multiplication factor - rho, pi, dragCoeffecient
	mov r5, #1    @@ variable multiplication factor - velocity, radius
	mov r6, #1    @@ variable multiplication factor - conv

	@@ Calculate dynamic pressure -> r1

	ldr r4, =rho        	  @@ 12 bits, << 20
	ldr r5, =velocity  	  @@  8 bits
	ldr r4, [r4]
	ldr r5, [r5]

	mov r1, #1         	  @@ xBit  1, BP -1
	mul r1, r1, r4     	  @@ xBit 12, BP -21
	mul r1, r1, r5     	  @@ xBit 20, BP -21
	mul r1, r1, r5      	  @@ xBit 28, BP -21
	mov r1, r1, lsr#12 	  @@ xBit 16, BP -9

	@@ Calculate cross-sectional area -> r2

	ldr r4, =pi        	  @@ 24 bits, << 20
	ldr r5, =radius           @@  4 bits
	ldr r6, =conv             @@ 12 bits, << 16
	ldr r4, [r4]
	ldr r5, [r5]
	ldr r6, [r6]

	mov r2, r4                @@ xBit 24, BP -20
	mul r2, r2, r5            @@ xBit 28, BP -20
	mul r2, r2, r5            @@ xBit 32, BP -20
	mov r2, r2, lsr#12        @@ xBit 20, BP -8
	mul r2, r2, r6            @@ xBit 32, BP -24
	mov r2, r2, lsr#16        @@ xBit 16, BP -8

	@@ Calculate drag -> r3

	ldr r4, =dragCoeffecient  @@ 12 bits, << 12
	ldr r4, [r4]

	mul r3, r1, r2            @@ xBit 32, BP -17
	mov r3, r3, lsr#12        @@ xBit 20, BP -5
	mul r3, r3, r4            @@ xBit 32, BP -17

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
