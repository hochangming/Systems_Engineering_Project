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
	.file	"PololuV5.c"
	.text
	.section	.text.mpu_cbI2cOnDone,"ax",%progbits
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	mpu_cbI2cOnDone, %function
mpu_cbI2cOnDone:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L3
	movs	r2, #1
	str	r2, [r3]
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LANCHOR0
	.size	mpu_cbI2cOnDone, .-mpu_cbI2cOnDone
	.section	.text.mpu_TimerTick,"ax",%progbits
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	mpu_TimerTick, %function
mpu_TimerTick:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L10
	ldr	r2, [r3]
	cbz	r2, .L5
	ldr	r2, [r3]
	subs	r2, r2, #1
	str	r2, [r3]
.L5:
	bx	lr
.L11:
	.align	2
.L10:
	.word	.LANCHOR1
	.size	mpu_TimerTick, .-mpu_TimerTick
	.section	.text.ImuPololuInit,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuPololuInit
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuPololuInit, %function
ImuPololuInit:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	mul	r2, r3, r2
	ldr	r3, .L110
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r4, r0
	smull	r0, r3, r3, r2
	asrs	r2, r2, #31
	ldr	r6, .L110+4
	ldr	r5, .L110+8
	sub	sp, sp, #52
	rsb	r3, r2, r3, asr #6
	mov	r0, r1
	ldr	r2, .L110+12
	ldr	r1, .L110+16
	str	r3, [r6]
	str	r3, [r5]
	bl	TimerAddHook
	mov	r0, r4
	ldr	r2, .L110+20
	ldr	r1, .L110+24
	bl	I2cAddHook
	ldr	r7, .L110+28
	movs	r3, #1
	mov	ip, #0
	ldr	r8, .L110+36
	mov	r0, r4
	str	r3, [sp]
	movs	r2, #15
	mov	r3, r7
	movs	r1, #214
	str	r4, [r8]
	strb	ip, [r7]
	bl	I2cRead
	ldr	r3, [r6]
	ldr	r4, .L110+32
	str	r3, [r5]
	b	.L13
.L15:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L13:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L15
	ldr	r9, .L110+40
	movs	r1, #0
	ldr	r2, .L110
	ldr	r3, [r9]
	str	r1, [r4]
	add	r3, r3, r3, lsl #2
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #8]
	ldr	r3, [sp, #8]
	subs	r2, r3, #1
	str	r2, [sp, #8]
	cbz	r3, .L77
.L17:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #8]
	subs	r2, r3, #1
	str	r2, [sp, #8]
	cmp	r3, #0
	bne	.L17
.L77:
	movs	r1, #1
	mov	ip, #80
	ldr	r3, .L110+28
	movs	r2, #16
	str	r1, [sp]
	movs	r1, #214
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L18
.L20:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L18:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L20
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L110
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #12]
	ldr	r3, [sp, #12]
	subs	r2, r3, #1
	str	r2, [sp, #12]
	cbz	r3, .L76
.L22:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #12]
	subs	r2, r3, #1
	str	r2, [sp, #12]
	cmp	r3, #0
	bne	.L22
.L76:
	movs	r1, #1
	mov	ip, #80
	ldr	r3, .L110+28
	movs	r2, #17
	str	r1, [sp]
	movs	r1, #214
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L23
.L25:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L23:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L25
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L110
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #16]
	ldr	r3, [sp, #16]
	subs	r2, r3, #1
	str	r2, [sp, #16]
	cbz	r3, .L75
.L27:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #16]
	subs	r2, r3, #1
	str	r2, [sp, #16]
	cmp	r3, #0
	bne	.L27
.L75:
	movs	r1, #1
	mov	ip, #4
	ldr	r3, .L110+28
	movs	r2, #18
	str	r1, [sp]
	movs	r1, #214
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L28
.L30:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L28:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L30
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L110
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #20]
	ldr	r3, [sp, #20]
	subs	r2, r3, #1
	str	r2, [sp, #20]
	cbz	r3, .L74
.L32:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #20]
	subs	r2, r3, #1
	str	r2, [sp, #20]
	cmp	r3, #0
	bne	.L32
.L74:
	movs	r1, #1
	mov	ip, #128
	ldr	r3, .L110+28
	movs	r2, #19
	str	r1, [sp]
	movs	r1, #214
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L33
.L35:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L33:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L35
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L110
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #24]
	ldr	r3, [sp, #24]
	subs	r2, r3, #1
	str	r2, [sp, #24]
	cbz	r3, .L73
.L37:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #24]
	subs	r2, r3, #1
	str	r2, [sp, #24]
	cmp	r3, #0
	bne	.L37
.L73:
	movs	r1, #1
	mov	ip, #110
	ldr	r3, .L110+28
	movs	r2, #10
	str	r1, [sp]
	movs	r1, #214
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L38
.L40:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L38:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L40
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L110
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #28]
	ldr	r3, [sp, #28]
	subs	r2, r3, #1
	str	r2, [sp, #28]
	cbz	r3, .L72
.L42:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #28]
	subs	r2, r3, #1
	str	r2, [sp, #28]
	cmp	r3, #0
	bne	.L42
.L72:
	movs	r1, #1
	mov	ip, #116
	ldr	r3, .L110+28
	movs	r2, #32
	str	r1, [sp]
	movs	r1, #60
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L43
.L111:
	.align	2
.L110:
	.word	274877907
	.word	.LANCHOR2
	.word	.LANCHOR1
	.word	mpu_TimerTick
	.word	.LANCHOR3
	.word	mpu_cbI2cOnDone
	.word	.LANCHOR4
	.word	.LANCHOR6
	.word	.LANCHOR0
	.word	.LANCHOR5
	.word	SystemCoreClock
.L45:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L43:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L45
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L112
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #32]
	ldr	r3, [sp, #32]
	subs	r2, r3, #1
	str	r2, [sp, #32]
	cbz	r3, .L71
.L47:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #32]
	subs	r2, r3, #1
	str	r2, [sp, #32]
	cmp	r3, #0
	bne	.L47
.L71:
	movs	r1, #1
	mov	ip, #12
	ldr	r3, .L112+4
	movs	r2, #35
	str	r1, [sp]
	movs	r1, #60
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L48
.L50:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L48:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L50
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L112
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #36]
	ldr	r3, [sp, #36]
	subs	r2, r3, #1
	str	r2, [sp, #36]
	cbz	r3, .L70
.L52:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #36]
	subs	r2, r3, #1
	str	r2, [sp, #36]
	cmp	r3, #0
	bne	.L52
.L70:
	movs	r1, #1
	mov	ip, #64
	ldr	r3, .L112+4
	movs	r2, #36
	str	r1, [sp]
	movs	r1, #60
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L53
.L55:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L53:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L55
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L112
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #40]
	ldr	r3, [sp, #40]
	subs	r2, r3, #1
	str	r2, [sp, #40]
	cbz	r3, .L69
.L57:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #40]
	subs	r2, r3, #1
	str	r2, [sp, #40]
	cmp	r3, #0
	bne	.L57
.L69:
	movs	r1, #1
	mov	ip, #0
	ldr	r3, .L112+4
	movs	r2, #33
	str	r1, [sp]
	movs	r1, #60
	ldr	r0, [r8]
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L58
.L60:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L14
.L58:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L60
	ldr	r3, [r9]
	movs	r1, #0
	ldr	r2, .L112
	add	r3, r3, r3, lsl #2
	str	r1, [r4]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #6
	str	r3, [sp, #44]
	ldr	r3, [sp, #44]
	subs	r2, r3, #1
	str	r2, [sp, #44]
	cbz	r3, .L68
.L62:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #44]
	subs	r2, r3, #1
	str	r2, [sp, #44]
	cmp	r3, #0
	bne	.L62
.L68:
	mov	ip, #1
	ldr	r3, .L112+4
	ldr	r0, [r8]
	movs	r2, #34
	str	ip, [sp]
	movs	r1, #60
	strb	ip, [r7]
	bl	I2cWrite
	ldr	r3, [r6]
	str	r3, [r5]
	b	.L63
.L65:
	ldr	r3, [r5]
	cbz	r3, .L14
.L63:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L65
	movs	r0, #0
	str	r0, [r4]
	add	sp, sp, #52
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L14:
	mvn	r0, #1
	str	r3, [r4]
	add	sp, sp, #52
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L113:
	.align	2
.L112:
	.word	274877907
	.word	.LANCHOR6
	.size	ImuPololuInit, .-ImuPololuInit
	.section	.text.ImuPololuReadUntilComplete,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuPololuReadUntilComplete
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuPololuReadUntilComplete, %function
ImuPololuReadUntilComplete:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	uxtb	r5, r2
	sub	sp, sp, #12
	ldr	r4, .L122
	mov	r3, r1
	mov	r2, r0
	movs	r1, #214
	str	r5, [sp]
	ldr	r0, [r4]
	bl	I2cRead
	ldr	r3, .L122+4
	ldr	r1, .L122+8
	ldr	r3, [r3]
	ldr	r2, .L122+12
	str	r3, [r1]
	b	.L115
.L117:
	ldr	r3, [r1]
	cbz	r3, .L116
.L115:
	ldr	r3, [r2]
	cmp	r3, #0
	beq	.L117
	movs	r3, #0
	mov	r0, r3
	str	r3, [r2]
.L114:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
.L116:
	str	r3, [r2]
	mvn	r0, #1
	b	.L114
.L123:
	.align	2
.L122:
	.word	.LANCHOR5
	.word	.LANCHOR2
	.word	.LANCHOR1
	.word	.LANCHOR0
	.size	ImuPololuReadUntilComplete, .-ImuPololuReadUntilComplete
	.section	.text.ImuPololuReadData,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuPololuReadData
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuPololuReadData, %function
ImuPololuReadData:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	movs	r2, #1
	sub	sp, sp, #12
	ldr	r6, .L137
	movs	r5, #0
	ldr	r8, .L137+16
	mov	r9, r0
	ldr	r4, .L137+4
	mov	r3, r6
	ldr	r7, .L137+8
	movs	r1, #214
	str	r2, [sp]
	movs	r2, #30
	ldr	r0, [r8]
	strb	r5, [r6]
	str	r5, [r4]
	bl	I2cRead
	ldr	r5, .L137+12
	ldr	r3, [r7]
	str	r3, [r5]
	b	.L125
.L127:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L126
.L125:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L127
	mov	ip, #0
	str	ip, [r4]
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldrb	r3, [r6]	@ zero_extendqisi2
	and	r3, r3, #3
	cmp	r3, #3
	beq	.L134
	mov	r0, ip
.L124:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L134:
	movs	r1, #12
	ldr	r3, .L137
	ldr	r0, [r8]
	movs	r2, #34
	str	r1, [sp]
	movs	r1, #214
	strb	ip, [r6]
	bl	I2cRead
	ldr	r3, [r7]
	str	r3, [r5]
	b	.L129
.L131:
	ldr	r3, [r5]
	cbz	r3, .L126
.L129:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L131
	ldrb	r2, [r6, #1]	@ zero_extendqisi2
	movs	r0, #0
	ldrb	r3, [r6]	@ zero_extendqisi2
	str	r0, [r4]
	orr	r3, r3, r2, lsl #8
	strh	r3, [r9, #6]	@ movhi
	ldrb	r2, [r6, #3]	@ zero_extendqisi2
	ldrb	r3, [r6, #2]	@ zero_extendqisi2
	orr	r3, r3, r2, lsl #8
	strh	r3, [r9, #8]	@ movhi
	ldrb	r2, [r6, #5]	@ zero_extendqisi2
	ldrb	r3, [r6, #4]	@ zero_extendqisi2
	orr	r3, r3, r2, lsl #8
	strh	r3, [r9, #10]	@ movhi
	ldrb	r2, [r6, #7]	@ zero_extendqisi2
	ldrb	r3, [r6, #6]	@ zero_extendqisi2
	orr	r3, r3, r2, lsl #8
	strh	r3, [r9]	@ movhi
	ldrb	r2, [r6, #9]	@ zero_extendqisi2
	ldrb	r3, [r6, #8]	@ zero_extendqisi2
	orr	r3, r3, r2, lsl #8
	strh	r3, [r9, #2]	@ movhi
	ldrb	r2, [r6, #11]	@ zero_extendqisi2
	ldrb	r3, [r6, #10]	@ zero_extendqisi2
	orr	r3, r3, r2, lsl #8
	strh	r3, [r9, #4]	@ movhi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L126:
	str	r3, [r4]
	mvn	r0, #1
	b	.L124
.L138:
	.align	2
.L137:
	.word	.LANCHOR6
	.word	.LANCHOR0
	.word	.LANCHOR2
	.word	.LANCHOR1
	.word	.LANCHOR5
	.size	ImuPololuReadData, .-ImuPololuReadData
	.section	.text.ImuPololuIsDone,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	ImuPololuIsDone
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	ImuPololuIsDone, %function
ImuPololuIsDone:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L140
	ldr	r0, [r3]
	bx	lr
.L141:
	.align	2
.L140:
	.word	.LANCHOR0
	.size	ImuPololuIsDone, .-ImuPololuIsDone
	.section	.bss.g_I2cHook,"aw",%nobits
	.align	2
	.set	.LANCHOR4,. + 0
	.type	g_I2cHook, %object
	.size	g_I2cHook, 8
g_I2cHook:
	.space	8
	.section	.bss.g_aBuf,"aw",%nobits
	.align	2
	.set	.LANCHOR6,. + 0
	.type	g_aBuf, %object
	.size	g_aBuf, 64
g_aBuf:
	.space	64
	.section	.bss.g_bDataReady,"aw",%nobits
	.align	2
	.type	g_bDataReady, %object
	.size	g_bDataReady, 4
g_bDataReady:
	.space	4
	.section	.bss.g_bI2cDone,"aw",%nobits
	.align	2
	.set	.LANCHOR0,. + 0
	.type	g_bI2cDone, %object
	.size	g_bI2cDone, 4
g_bI2cDone:
	.space	4
	.section	.bss.g_hTimerHook,"aw",%nobits
	.align	2
	.set	.LANCHOR3,. + 0
	.type	g_hTimerHook, %object
	.size	g_hTimerHook, 8
g_hTimerHook:
	.space	8
	.section	.bss.g_nInterval,"aw",%nobits
	.align	2
	.set	.LANCHOR1,. + 0
	.type	g_nInterval, %object
	.size	g_nInterval, 4
g_nInterval:
	.space	4
	.section	.bss.g_nIntervalConst,"aw",%nobits
	.align	2
	.set	.LANCHOR2,. + 0
	.type	g_nIntervalConst, %object
	.size	g_nIntervalConst, 4
g_nIntervalConst:
	.space	4
	.section	.bss.g_pI2cHandle,"aw",%nobits
	.align	2
	.set	.LANCHOR5,. + 0
	.type	g_pI2cHandle, %object
	.size	g_pI2cHandle, 4
g_pI2cHandle:
	.space	4
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
