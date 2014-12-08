	.data

msgStats:      .asciz "You made %d correct guesses out of %d total guesses.\n\n"
msgAvgCorrect: .asciz "You got an average of %d%% correct guesses that game.\n\n"

	.text

	.global printAvgCorrect
printAvgCorrect:
        push {lr}

        @@ Print game stats

        ldr r0, =msgStats
        ldr r1, =totalCorrect
        ldr r1, [r1]
        ldr r2, =totalGuesses
        ldr r2, [r2]
        bl printf

        @@ Calculate avg correct guesses for game

        @@ Convert total correct guesses to f32

        ldr r0, =totalCorrect
        ldr r0, [r0]
        vmov s12, r0
        vcvt.f32.s32 s13, s12

        @@ Convert total guesses to f32

        ldr r0, =totalGuesses
        ldr r0, [r0]
        vmov s14, r0
        vcvt.f32.s32 s15, s14

        @@ Convert scale factor 100 to f32

        mov r0, #100
        vmov s16, r0
        vcvt.f32.s32 s17, s16

        @@ Divide and multiply f32 values

        vdiv.f32 s0, s13, s15
        vmul.f32 s1, s17, s0

        @@ Convert calculated value to integer for printf

        vcvt.s32.f32 s0, s1

        @@ Print average correct

        vmov r1, s0
        ldr r0, =msgAvgCorrect
        bl printf

        pop {pc}
        mov pc, lr
