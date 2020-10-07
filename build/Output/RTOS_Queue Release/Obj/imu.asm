	.cpu cortex-m7
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"imu.c"
	.text
	.section	.text.ImuInit,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuInit
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuInit, %function
ImuInit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5}
	ldr	r3, .L4
	mov	r4, #1065353216
	ldr	r2, .L4+4
	ldr	r1, .L4+8
	ldr	r5, .L4+12
	str	r1, [r2]	@ float
	str	r4, [r3]	@ float
	movs	r3, #0
	ldr	r4, .L4+16
	ldr	r1, .L4+20
	ldr	r2, .L4+24
	str	r3, [r5]	@ float
	str	r3, [r4]	@ float
	str	r3, [r1]	@ float
	str	r0, [r2]
	pop	{r4, r5}
	bx	lr
.L5:
	.align	2
.L4:
	.word	.LANCHOR1
	.word	.LANCHOR0
	.word	1036831949
	.word	.LANCHOR2
	.word	.LANCHOR3
	.word	.LANCHOR4
	.word	.LANCHOR5
	.size	ImuInit, .-ImuInit
	.section	.text.ImuSetSampleRate,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuSetSampleRate
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuSetSampleRate, %function
ImuSetSampleRate:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r0, .L7
	vmov	s15, r0	@ int
	vmov.f32	s13, #1.0e+0
	ldr	r3, .L11
	movs	r0, #1
	vcvt.f32.s32	s14, s15
	vdiv.f32	s15, s13, s14
	vstr.32	s15, [r3]
.L7:
	ldr	r3, .L11+4
	str	r0, [r3]
	bx	lr
.L12:
	.align	2
.L11:
	.word	.LANCHOR6
	.word	.LANCHOR7
	.size	ImuSetSampleRate, .-ImuSetSampleRate
	.section	.text.ImuUpdateAcclGyro,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuUpdateAcclGyro
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuUpdateAcclGyro, %function
ImuUpdateAcclGyro:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L23
	vldr.32	s11, [r0]
	ldr	r3, [r3]
	vldr.32	s9, [r0, #4]
	vldr.32	s8, [r0, #8]
	vldr.32	s15, [r0, #12]
	vldr.32	s13, [r0, #20]
	push	{r4, r5}
	vpush.64	{d8, d9, d10, d11, d12, d13}
	sub	sp, sp, #8
	vldr.32	s17, [r0, #16]
	str	r1, [sp, #4]
	cmp	r3, #0
	beq	.L14
	ldr	r3, .L23+4
	vldr.32	s3, [r3]
.L15:
	vldr.32	s12, .L23+8
	vcmp.f32	s15, #0
	ldr	r1, .L23+12
	vmov.f32	s1, #5.0e-1
	ldr	r0, .L23+16
	vmul.f32	s9, s9, s12
	vmul.f32	s8, s8, s12
	vldr.32	s10, [r1]
	vldr.32	s14, [r0]
	vmul.f32	s11, s11, s12
	ldr	r4, .L23+20
	vnmul.f32	s4, s9, s10
	vmul.f32	s2, s10, s8
	ldr	r2, .L23+24
	vnmul.f32	s5, s8, s14
	vldr.32	s7, [r4]
	vmul.f32	s6, s14, s9
	vldr.32	s12, [r2]
	vfms.f32	s4, s14, s11
	vfma.f32	s2, s7, s11
	vfma.f32	s5, s7, s9
	vfma.f32	s6, s7, s8
	vneg.f32	s0, s12
	vmrs	APSR_nzcv, FPSCR
	vcmp.f32	s17, #0
	vfma.f32	s4, s0, s8
	vfma.f32	s2, s0, s9
	it	ne
	movne	r3, #1
	vfma.f32	s5, s12, s11
	it	eq
	moveq	r3, #0
	vfms.f32	s6, s10, s11
	vmrs	APSR_nzcv, FPSCR
	vmul.f32	s4, s4, s1
	it	ne
	movne	r3, #1
	vmul.f32	s2, s2, s1
	vmul.f32	s5, s5, s1
	vmul.f32	s6, s6, s1
	cbnz	r3, .L18
	vcmp.f32	s13, #0
	vmrs	APSR_nzcv, FPSCR
	beq	.L16
.L18:
	vmul.f32	s9, s17, s17
	ldr	r5, .L23+28
	ldr	r3, .L23+32
	vmov.f32	s16, #5.0e-1
	vldr.32	s0, [r5]
	vmov.f32	s1, #1.5e+0
	vfma.f32	s9, s15, s15
	vmov.f32	s19, #4.0e+0
	vmov.f32	s26, s1
	vadd.f32	s8, s12, s12
	vmul.f32	s20, s14, s19
	vmul.f32	s24, s12, s12
	vfma.f32	s9, s13, s13
	vadd.f32	s25, s7, s7
	vmul.f32	s23, s7, s7
	vmul.f32	s18, s10, s19
	vmov.f32	s21, #8.0e+0
	vmul.f32	s23, s23, s19
	vmov	r5, s9	@ int
	vmul.f32	s22, s9, s16
	vneg.f32	s0, s0
	sub	r5, r3, r5, asr #1
	vmov	s9, r5	@ int
	vmul.f32	s11, s22, s9
	vfms.f32	s26, s9, s11
	vmul.f32	s11, s14, s14
	vmul.f32	s26, s26, s9
	vmov.f32	s9, s1
	vmul.f32	s22, s22, s26
	vfms.f32	s9, s26, s22
	vmul.f32	s22, s14, s21
	vmul.f32	s21, s10, s21
	vmul.f32	s9, s9, s26
	vmov.f32	s26, s8
	vmul.f32	s15, s15, s9
	vnmul.f32	s17, s9, s17
	vmul.f32	s13, s13, s9
	vnmul.f32	s8, s8, s15
	vmul.f32	s9, s15, s25
	vfma.f32	s8, s20, s24
	vfma.f32	s9, s10, s23
	vfma.f32	s8, s14, s23
	vfma.f32	s9, s18, s24
	vadd.f32	s23, s10, s10
	vmul.f32	s24, s7, s19
	vfma.f32	s8, s17, s25
	vfma.f32	s9, s17, s26
	vmul.f32	s25, s10, s10
	vmul.f32	s26, s15, s23
	vsub.f32	s8, s8, s20
	vsub.f32	s9, s9, s18
	vfma.f32	s26, s24, s25
	vfma.f32	s8, s22, s11
	vfma.f32	s9, s21, s11
	vfma.f32	s8, s22, s25
	vmov.f32	s22, s26
	vfma.f32	s9, s21, s25
	vmul.f32	s21, s25, s19
	vfma.f32	s22, s24, s11
	vadd.f32	s24, s14, s14
	vfma.f32	s8, s13, s20
	vmul.f32	s19, s11, s19
	vfma.f32	s9, s13, s18
	vnmul.f32	s11, s24, s15
	vmov.f32	s15, s22
	vmov.f32	s18, s1
	vfma.f32	s11, s12, s19
	vfma.f32	s15, s17, s24
	vmov.f32	s13, s9
	vmul.f32	s9, s8, s8
	vfma.f32	s11, s12, s21
	vfma.f32	s9, s15, s15
	vfma.f32	s11, s17, s23
	vfma.f32	s9, s13, s13
	vfma.f32	s9, s11, s11
	vmov	r5, s9	@ int
	vmul.f32	s16, s9, s16
	sub	r3, r3, r5, asr #1
	vmov	s9, r3	@ int
	vmul.f32	s17, s16, s9
	vfms.f32	s18, s9, s17
	vmul.f32	s9, s18, s9
	vmul.f32	s16, s16, s9
	vfms.f32	s1, s9, s16
	vmul.f32	s1, s1, s9
	vmul.f32	s15, s15, s1
	vmul.f32	s8, s8, s1
	vmul.f32	s13, s13, s1
	vmul.f32	s11, s11, s1
	vfma.f32	s4, s0, s15
	vfma.f32	s2, s0, s8
	vfma.f32	s5, s0, s13
	vfma.f32	s6, s0, s11
.L16:
	vfma.f32	s14, s2, s3
	ldr	r3, .L23+32
	vmov.f32	s13, s7
	vmov.f32	s15, s10
	vfma.f32	s12, s6, s3
	vfma.f32	s13, s4, s3
	vfma.f32	s15, s5, s3
	vmul.f32	s10, s14, s14
	vmov.f32	s9, #5.0e-1
	vmov.f32	s11, #1.5e+0
	vfma.f32	s10, s13, s13
	vmov.f32	s7, s11
	vfma.f32	s10, s15, s15
	vfma.f32	s10, s12, s12
	vmov	r5, s10	@ int
	vmul.f32	s9, s10, s9
	sub	r3, r3, r5, asr #1
	vmov	s8, r3	@ int
	vmul.f32	s10, s9, s8
	vfms.f32	s7, s8, s10
	vmul.f32	s10, s7, s8
	vmul.f32	s9, s9, s10
	vfms.f32	s11, s10, s9
	vmul.f32	s11, s11, s10
	vmul.f32	s13, s13, s11
	vmul.f32	s14, s14, s11
	vmul.f32	s15, s15, s11
	vmul.f32	s12, s12, s11
	vstr.32	s13, [r4]
	vstr.32	s14, [r0]
	vstr.32	s15, [r1]
	vstr.32	s12, [r2]
	add	sp, sp, #8
	@ sp needed
	vldm	sp!, {d8-d13}
	pop	{r4, r5}
	bx	lr
.L14:
	vmov	s14, r1	@ int
	vldr.32	s12, .L23+36
	vcvt.f32.s32	s14, s14
	vdiv.f32	s3, s14, s12
	b	.L15
.L24:
	.align	2
.L23:
	.word	.LANCHOR7
	.word	.LANCHOR6
	.word	1016003129
	.word	.LANCHOR3
	.word	.LANCHOR2
	.word	.LANCHOR1
	.word	.LANCHOR4
	.word	.LANCHOR0
	.word	1597463007
	.word	1148846080
	.size	ImuUpdateAcclGyro, .-ImuUpdateAcclGyro
	.section	.text.ImuUpdate,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuUpdate
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuUpdate, %function
ImuUpdate:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r2, .L38
	push	{r4, r5, r6, r7, r8, lr}
	ldr	r2, [r2]
	vpush.64	{d8, d9, d10, d11, d12, d13, d14, d15}
	sub	sp, sp, #64
	str	r1, [sp]
	cmp	r2, #0
	beq	.L36
	ldr	r2, .L38+4
	mov	r3, r0
	ldr	r2, [r2]
	cmp	r2, #0
	bne	.L37
	vmov	s15, r1	@ int
	vldr.32	s14, .L38+8
	vcvt.f32.s32	s15, s15
	vdiv.f32	s28, s15, s14
.L28:
	vldr.32	s11, .L38+12
	vldr.32	s13, [r3, #4]
	vldr.32	s12, [r3, #8]
	ldr	r6, .L38+16
	ldr	r7, .L38+20
	vmul.f32	s12, s12, s11
	vmul.f32	s13, s13, s11
	vldr.32	s18, [r6]
	vldr.32	s15, [r7]
	vmov.f32	s4, #5.0e-1
	vldr.32	s14, [r3]
	vmul.f32	s8, s18, s12
	ldr	r8, .L38+36
	vnmul.f32	s6, s13, s18
	vmul.f32	s14, s14, s11
	ldr	r5, .L38+24
	vneg.f32	s5, s15
	vldr.32	s16, [r8]
	vnmul.f32	s10, s12, s15
	vldr.32	s19, [r5]
	vfma.f32	s8, s16, s14
	vldr.32	s30, [r3, #12]
	vmul.f32	s11, s15, s13
	vldr.32	s31, [r3, #16]
	vfma.f32	s6, s5, s14
	vneg.f32	s9, s19
	vfma.f32	s11, s16, s12
	vfma.f32	s10, s16, s13
	vneg.f32	s7, s18
	vcmp.f32	s30, #0
	vfma.f32	s6, s9, s12
	vmov.f32	s12, s8
	vldr.32	s8, [r3, #20]
	vfma.f32	s11, s7, s14
	vmrs	APSR_nzcv, FPSCR
	vfma.f32	s12, s9, s13
	vmov.f32	s13, s10
	vcmp.f32	s31, #0
	ite	ne
	movne	r2, #1
	moveq	r2, #0
	vfma.f32	s13, s19, s14
	vmov.f32	s14, s11
	vmrs	APSR_nzcv, FPSCR
	vmul.f32	s11, s6, s4
	vmul.f32	s12, s12, s4
	vmul.f32	s14, s14, s4
	it	ne
	movne	r2, #1
	vmul.f32	s13, s13, s4
	vstr.32	s11, [sp]
	vstr.32	s12, [sp, #4]
	vstr.32	s14, [sp, #12]
	vstr.32	s13, [sp, #8]
	cbnz	r2, .L31
	vcmp.f32	s8, #0
	vmrs	APSR_nzcv, FPSCR
	beq	.L29
.L31:
	vldr.32	s25, [r3, #28]
	vmul.f32	s13, s31, s31
	vldr.32	s26, [r3, #24]
	vmov.f32	s22, #1.5e+0
	vmul.f32	s14, s25, s25
	vldr.32	s24, [r3, #32]
	ldr	r4, .L38+28
	vfma.f32	s13, s30, s30
	vstr.32	s9, [sp, #60]	@ int
	vmov.f32	s9, #5.0e-1
	vfma.f32	s14, s26, s26
	vstr.32	s7, [sp, #56]	@ int
	vadd.f32	s12, s15, s15
	vstr.32	s8, [sp, #52]	@ int
	vmul.f32	s20, s15, s15
	vmul.f32	s23, s15, s19
	vmul.f32	s21, s15, s16
	vstr.32	s12, [sp, #32]	@ int
	vfma.f32	s13, s8, s8
	vfma.f32	s14, s24, s24
	vmul.f32	s8, s15, s18
	vmov.f32	s7, s22
	vadd.f32	s29, s16, s16
	vmul.f32	s4, s16, s16
	vstr.32	s8, [sp, #20]
	vmov.f32	s2, s22
	vmov	r3, s14	@ int
	vmul.f32	s10, s14, s9
	vmul.f32	s27, s18, s18
	vstr.32	s4, [sp, #44]	@ int
	sub	r3, r4, r3, asr #1
	vadd.f32	s11, s18, s18
	vmul.f32	s6, s19, s19
	vmov	s14, r3	@ int
	vmov	r3, s13	@ int
	vmul.f32	s13, s13, s9
	vstr.32	s11, [sp, #28]	@ int
	vmul.f32	s15, s10, s14
	sub	r3, r4, r3, asr #1
	vstr.32	s6, [sp, #24]	@ int
	vmov	s3, r3	@ int
	vfms.f32	s7, s14, s15
	vmov.f32	s15, s7
	vadd.f32	s7, s19, s19
	vmul.f32	s14, s15, s14
	vmov.f32	s15, s22
	vstr.32	s7, [sp, #16]
	vmul.f32	s10, s10, s14
	vfms.f32	s15, s14, s10
	vmul.f32	s10, s13, s3
	vfms.f32	s2, s3, s10
	vmul.f32	s14, s15, s14
	vmul.f32	s25, s25, s14
	vmul.f32	s26, s26, s14
	vmul.f32	s24, s24, s14
	vmul.f32	s15, s25, s4
	vmul.f32	s1, s29, s26
	vmul.f32	s17, s29, s25
	vmul.f32	s0, s29, s24
	vfma.f32	s15, s19, s1
	vstr.32	s1, [sp, #48]	@ int
	vnmul.f32	s14, s17, s19
	vmov.f32	s10, s2
	vmul.f32	s2, s12, s26
	vfma.f32	s14, s26, s4
	vmul.f32	s10, s10, s3
	vfma.f32	s15, s5, s0
	vstr.32	s2, [sp, #40]	@ int
	vneg.f32	s5, s25
	vmul.f32	s13, s13, s10
	vmov.f32	s3, s22
	vfma.f32	s14, s18, s0
	vmul.f32	s0, s12, s25
	vfma.f32	s15, s18, s2
	vfms.f32	s3, s10, s13
	vmul.f32	s13, s12, s24
	vfma.f32	s14, s26, s20
	vfma.f32	s15, s5, s20
	vmul.f32	s10, s3, s10
	vmul.f32	s3, s24, s11
	vfma.f32	s14, s18, s0
	vstr.32	s10, [sp, #36]	@ int
	vfma.f32	s15, s25, s27
	vfma.f32	s14, s19, s13
	vneg.f32	s13, s26
	vfma.f32	s15, s19, s3
	vfma.f32	s14, s13, s27
	vfma.f32	s15, s5, s6
	vfma.f32	s14, s13, s6
	vmul.f32	s0, s15, s15
	vfma.f32	s0, s14, s14
	bl	sqrtf
	vldr.32	s15, [r7]
	vldr.32	s13, [r6]
	vneg.f32	s3, s24
	vmul.f32	s17, s15, s17
	vldr.32	s1, [sp, #48]	@ int
	vldr.32	s4, [sp, #44]	@ int
	vmov.f32	s12, #5.0e-1
	vldr.32	s14, [sp, #20]
	vfms.f32	s17, s1, s13
	vldr.32	s9, [sp, #60]	@ int
	vldr.32	s2, [sp, #40]	@ int
	vmov.f32	s1, s23
	vfma.f32	s14, s9, s16
	vldr.32	s9, [r5]
	vldr.32	s11, [sp, #28]	@ int
	vldr.32	s7, [sp, #56]	@ int
	vfma.f32	s1, s18, s16
	vldr.32	s10, [sp, #36]	@ int
	vfma.f32	s17, s24, s4
	vldr.32	s6, [sp, #24]	@ int
	vmul.f32	s4, s25, s11
	vldr.32	s8, [sp, #52]	@ int
	vstr.32	s14, [sp, #20]
	vadd.f32	s14, s21, s21
	vfma.f32	s21, s18, s19
	ldr	r3, .L38+32
	vmov.f32	s18, s13
	vfma.f32	s14, s19, s11
	vldr.32	s5, [r3]
	vfma.f32	s17, s9, s2
	vmov.f32	s2, s23
	vadd.f32	s23, s23, s23
	vmov.f32	s19, s9
	vfma.f32	s2, s7, s16
	vldr.32	s16, [r8]
	vfma.f32	s23, s7, s29
	vfma.f32	s17, s3, s20
	vmov.f32	s7, #2.0e+0
	vfms.f32	s14, s31, s10
	vneg.f32	s5, s5
	vfms.f32	s23, s30, s10
	vfma.f32	s17, s9, s4
	vmov.f32	s4, #1.0e+0
	vfms.f32	s4, s20, s7
	vsub.f32	s20, s12, s20
	vfma.f32	s17, s3, s27
	vmov.f32	s3, #4.0e+0
	vsub.f32	s20, s20, s27
	vfms.f32	s4, s27, s7
	vsub.f32	s27, s12, s27
	vldr.32	s12, [sp, #32]	@ int
	vfma.f32	s17, s24, s6
	vmul.f32	s7, s29, s14
	vsub.f32	s6, s27, s6
	vldr.32	s27, [sp, #20]
	vfms.f32	s4, s8, s10
	vldr.32	s10, [sp, #16]
	vmul.f32	s8, s12, s14
	vfma.f32	s7, s23, s10
	vmul.f32	s2, s2, s17
	vmul.f32	s21, s21, s17
	vmul.f32	s10, s14, s10
	vfma.f32	s2, s6, s0
	vnmul.f32	s6, s3, s15
	vfma.f32	s21, s27, s0
	vfms.f32	s10, s29, s23
	vfma.f32	s7, s6, s4
	vmul.f32	s27, s13, s0
	vmul.f32	s20, s20, s17
	vadd.f32	s6, s0, s0
	vsub.f32	s26, s2, s26
	vmul.f32	s3, s13, s3
	vmul.f32	s2, s9, s17
	vfms.f32	s8, s11, s23
	vneg.f32	s6, s6
	vfma.f32	s20, s1, s0
	vmov.f32	s30, s27
	vmul.f32	s1, s15, s17
	vsub.f32	s21, s21, s25
	vmul.f32	s31, s13, s17
	vfms.f32	s10, s4, s3
	vfma.f32	s7, s26, s2
	vfma.f32	s30, s16, s17
	vadd.f32	s29, s17, s17
	vneg.f32	s3, s0
	vmul.f32	s4, s13, s6
	vmov.f32	s25, s1
	b	.L39
.L40:
	.align	2
.L38:
	.word	.LANCHOR5
	.word	.LANCHOR7
	.word	1148846080
	.word	1016003129
	.word	.LANCHOR3
	.word	.LANCHOR2
	.word	.LANCHOR4
	.word	1597463007
	.word	.LANCHOR0
	.word	.LANCHOR1
.L39:
	vfms.f32	s8, s31, s26
	vfms.f32	s4, s16, s17
	vfma.f32	s25, s9, s3
	vnmul.f32	s17, s29, s15
	vmul.f32	s14, s14, s11
	vfma.f32	s7, s21, s30
	vfma.f32	s17, s9, s0
	vsub.f32	s20, s20, s24
	vfma.f32	s14, s12, s23
	vfma.f32	s8, s25, s21
	vmul.f32	s12, s15, s0
	vfma.f32	s10, s26, s4
	vfma.f32	s1, s9, s6
	vfma.f32	s7, s20, s17
	vadd.f32	s2, s2, s12
	vnmul.f32	s13, s29, s13
	vfma.f32	s8, s27, s20
	vfma.f32	s10, s21, s2
	vfma.f32	s13, s16, s0
	vmul.f32	s11, s7, s7
	vfma.f32	s31, s3, s16
	vfma.f32	s14, s26, s1
	vfma.f32	s11, s8, s8
	vmov.f32	s9, s22
	vfma.f32	s10, s20, s13
	vmov.f32	s13, #5.0e-1
	vfma.f32	s14, s21, s31
	vfma.f32	s11, s10, s10
	vfma.f32	s14, s20, s12
	vmov.f32	s12, s11
	vfma.f32	s12, s14, s14
	vmov	r3, s12	@ int
	vmul.f32	s13, s12, s13
	sub	r3, r4, r3, asr #1
	vmov	s12, r3	@ int
	vmul.f32	s11, s13, s12
	vfms.f32	s9, s12, s11
	vmul.f32	s12, s9, s12
	vmul.f32	s13, s13, s12
	vfms.f32	s22, s12, s13
	vmul.f32	s22, s22, s12
	vmul.f32	s8, s8, s22
	vmul.f32	s7, s7, s22
	vmul.f32	s10, s10, s22
	vmul.f32	s22, s14, s22
	vldr.32	s14, [sp]
	vfma.f32	s14, s5, s8
	vstr.32	s14, [sp]
	vldr.32	s14, [sp, #4]
	vfma.f32	s14, s5, s7
	vstr.32	s14, [sp, #4]
	vldr.32	s14, [sp, #8]
	vfma.f32	s14, s5, s10
	vstr.32	s14, [sp, #8]
	vldr.32	s14, [sp, #12]
	vfma.f32	s14, s5, s22
	vstr.32	s14, [sp, #12]
.L29:
	vldr.32	s14, [sp, #4]
	vmov.f32	s12, #5.0e-1
	ldr	r3, .L41
	vfma.f32	s15, s14, s28
	vldr.32	s14, [sp]
	vfma.f32	s16, s14, s28
	vldr.32	s14, [sp, #8]
	vfma.f32	s18, s14, s28
	vldr.32	s14, [sp, #12]
	vmul.f32	s13, s15, s15
	vfma.f32	s19, s14, s28
	vmov.f32	s14, #1.5e+0
	vfma.f32	s13, s16, s16
	vmov.f32	s10, s14
	vfma.f32	s13, s18, s18
	vfma.f32	s13, s19, s19
	vmov	r2, s13	@ int
	vmul.f32	s12, s13, s12
	sub	r3, r3, r2, asr #1
	vmov	s11, r3	@ int
	vmul.f32	s13, s12, s11
	vfms.f32	s10, s11, s13
	vmul.f32	s13, s10, s11
	vmul.f32	s12, s12, s13
	vfms.f32	s14, s13, s12
	vmul.f32	s14, s14, s13
	vmul.f32	s16, s16, s14
	vmul.f32	s15, s15, s14
	vmul.f32	s18, s18, s14
	vmul.f32	s19, s19, s14
	vstr.32	s16, [r8]
	vstr.32	s15, [r7]
	vstr.32	s18, [r6]
	vstr.32	s19, [r5]
	add	sp, sp, #64
	@ sp needed
	vldm	sp!, {d8-d15}
	pop	{r4, r5, r6, r7, r8, pc}
.L37:
	ldr	r2, .L41+4
	vldr.32	s28, [r2]
	b	.L28
.L36:
	add	sp, sp, #64
	@ sp needed
	vldm	sp!, {d8-d15}
	pop	{r4, r5, r6, r7, r8, lr}
	b	ImuUpdateAcclGyro
.L42:
	.align	2
.L41:
	.word	1597463007
	.word	.LANCHOR6
	.size	ImuUpdate, .-ImuUpdate
	.section	.text.ImuComputeResult,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuComputeResult
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuComputeResult, %function
ImuComputeResult:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	vpush.64	{d8}
	vmov.f32	s17, #5.0e-1
	ldr	r4, .L45
	ldr	r7, .L45+4
	mov	r10, r0
	vldr.32	s15, [r4]
	mov	r9, r1
	vmov.f32	s1, s17
	ldr	r6, .L45+8
	vldr.32	s14, [r7]
	mov	r8, r2
	vldr.32	s0, [r6]
	vfms.f32	s1, s15, s15
	ldr	r5, .L45+12
	vmul.f32	s0, s14, s0
	vldr.32	s16, .L45+16
	vldr.32	s13, [r5]
	vfma.f32	s0, s13, s15
	vfms.f32	s1, s14, s14
	bl	atan2f
	vldr.32	s13, [r5]
	vldr.32	s15, [r7]
	vmul.f32	s0, s0, s16
	vldr.32	s12, [r4]
	vmov.f32	s14, #-2.0e+0
	vnmul.f32	s15, s15, s13
	vldr.32	s13, [r6]
	vstr.32	s0, [r10]
	vfma.f32	s15, s12, s13
	vmul.f32	s0, s15, s14
	bl	asinf
	vmov.f32	s1, s17
	vldr.32	s14, [r7]
	vmul.f32	s12, s0, s16
	vldr.32	s15, [r6]
	vfms.f32	s1, s14, s14
	vldr.32	s0, [r5]
	vldr.32	s13, [r4]
	vmul.f32	s0, s15, s0
	vstr.32	s12, [r9]
	vfma.f32	s0, s13, s14
	vfms.f32	s1, s15, s15
	bl	atan2f
	vmul.f32	s0, s0, s16
	vldm	sp!, {d8}
	vstr.32	s0, [r8]
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L46:
	.align	2
.L45:
	.word	.LANCHOR2
	.word	.LANCHOR3
	.word	.LANCHOR4
	.word	.LANCHOR1
	.word	1113927393
	.size	ImuComputeResult, .-ImuComputeResult
	.section	.bss.beta,"aw",%nobits
	.align	2
	.set	.LANCHOR0,. + 0
	.type	beta, %object
	.size	beta, 4
beta:
	.space	4
	.section	.bss.g_bFixSampleRate,"aw",%nobits
	.align	2
	.set	.LANCHOR7,. + 0
	.type	g_bFixSampleRate, %object
	.size	g_bFixSampleRate, 4
g_bFixSampleRate:
	.space	4
	.section	.bss.g_bMagEn,"aw",%nobits
	.align	2
	.set	.LANCHOR5,. + 0
	.type	g_bMagEn, %object
	.size	g_bMagEn, 4
g_bMagEn:
	.space	4
	.section	.bss.invSampleFreq,"aw",%nobits
	.align	2
	.set	.LANCHOR6,. + 0
	.type	invSampleFreq, %object
	.size	invSampleFreq, 4
invSampleFreq:
	.space	4
	.section	.bss.q0,"aw",%nobits
	.align	2
	.set	.LANCHOR1,. + 0
	.type	q0, %object
	.size	q0, 4
q0:
	.space	4
	.section	.bss.q1,"aw",%nobits
	.align	2
	.set	.LANCHOR2,. + 0
	.type	q1, %object
	.size	q1, 4
q1:
	.space	4
	.section	.bss.q2,"aw",%nobits
	.align	2
	.set	.LANCHOR3,. + 0
	.type	q2, %object
	.size	q2, 4
q2:
	.space	4
	.section	.bss.q3,"aw",%nobits
	.align	2
	.set	.LANCHOR4,. + 0
	.type	q3, %object
	.size	q3, 4
q3:
	.space	4
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
