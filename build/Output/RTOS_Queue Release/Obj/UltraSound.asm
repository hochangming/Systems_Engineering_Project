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
	.file	"UltraSound.c"
	.text
	.section	.text.sonic_cbOnTimer,"ax",%progbits
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	sonic_cbOnTimer, %function
sonic_cbOnTimer:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldr	r4, .L16
	mov	r6, #-1
	movs	r5, #180
	add	r7, r4, #32
.L6:
	ldr	r3, [r4, #4]!
	cbz	r3, .L3
	ldr	r2, [r3, #8]
	adds	r2, r2, #1
	str	r2, [r3, #8]
	ldr	r2, [r3, #12]
	cbz	r2, .L4
	ldr	r2, [r3, #12]
	subs	r2, r2, #1
	str	r2, [r3, #12]
	ldr	r2, [r3, #12]
	mov	r0, r2
	cbnz	r2, .L4
	ldr	r3, [r3, #36]
	blx	r3
	ldr	r3, [r4]
	str	r5, [r3, #16]
.L4:
	ldr	r2, [r3, #16]
	cbz	r2, .L3
	ldr	r2, [r3, #16]
	subs	r2, r2, #1
	str	r2, [r3, #16]
	ldr	r2, [r3, #16]
	cbnz	r2, .L3
	str	r6, [r3, #24]
	ldr	r1, [r3, #40]
	str	r2, [r3, #8]
	str	r2, [r3, #32]
	blx	r1
.L3:
	cmp	r4, r7
	bne	.L6
	pop	{r3, r4, r5, r6, r7, pc}
.L17:
	.align	2
.L16:
	.word	.LANCHOR0-4
	.size	sonic_cbOnTimer, .-sonic_cbOnTimer
	.section	.text.USonicInit,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	USonicInit
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	USonicInit, %function
USonicInit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movw	r3, #9999
	cmp	r1, r3
	bls	.L23
	ldr	r3, .L24
	ldr	r2, .L24+4
	ldr	r1, .L24+8
	push	{r4, lr}
	movs	r4, #0
	strd	r4, r4, [r3]
	strd	r4, r4, [r3, #8]
	strd	r4, r4, [r3, #16]
	strd	r4, r4, [r3, #24]
	bl	TimerAddHook
	pop	{r4, pc}
.L23:
	mvn	r0, #3
	bx	lr
.L25:
	.align	2
.L24:
	.word	.LANCHOR0
	.word	sonic_cbOnTimer
	.word	.LANCHOR1
	.size	USonicInit, .-USonicInit
	.section	.text.UsonicAddDevice,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	UsonicAddDevice
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	UsonicAddDevice, %function
UsonicAddDevice:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r1, #8
	bhi	.L28
	push	{r4, r5, r6}
	ldr	r5, .L34
	ldr	r4, [r5, r1, lsl #2]
	cbnz	r4, .L29
	movs	r6, #180
	str	r2, [r0, #36]
	str	r3, [r0, #40]
	movw	r2, #20000
	mov	r3, r4
	str	r4, [r0, #24]
	str	r4, [r0, #16]
	str	r4, [r0, #8]
	str	r4, [r0, #12]
	str	r4, [r0, #32]
	str	r6, [r0, #20]
	str	r2, [r0, #28]
	str	r0, [r5, r1, lsl #2]
.L26:
	mov	r0, r3
	pop	{r4, r5, r6}
	bx	lr
.L29:
	mvn	r3, #2
	b	.L26
.L28:
	mvn	r3, #1
	mov	r0, r3
	bx	lr
.L35:
	.align	2
.L34:
	.word	.LANCHOR0
	.size	UsonicAddDevice, .-UsonicAddDevice
	.section	.text.USonicTrigger,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	USonicTrigger
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	USonicTrigger, %function
USonicTrigger:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4}
	mov	r3, r0
	ldr	r4, [r0, #36]
	movs	r2, #0
	movs	r1, #1
	str	r2, [r0, #16]
	mov	r0, r1
	str	r2, [r3, #8]
	str	r1, [r3, #12]
	str	r2, [r3, #32]
	mov	r3, r4
	ldr	r4, [sp], #4
	bx	r3	@ indirect register sibling call
	.size	USonicTrigger, .-USonicTrigger
	.section	.text.USonicSetEchoTimeOut,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	USonicSetEchoTimeOut
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	USonicSetEchoTimeOut, %function
USonicSetEchoTimeOut:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	str	r1, [r0, #20]
	str	r2, [r0, #28]
	bx	lr
	.size	USonicSetEchoTimeOut, .-USonicSetEchoTimeOut
	.section	.text.USonicRead,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	USonicRead
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	USonicRead, %function
USonicRead:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, [r0, #24]
	bx	lr
	.size	USonicRead, .-USonicRead
	.global	__aeabi_ui2d
	.global	__aeabi_dmul
	.global	__aeabi_ddiv
	.global	__aeabi_d2uiz
	.section	.text.UsonicISR,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	UsonicISR
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	UsonicISR, %function
UsonicISR:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cbnz	r1, .L52
	ldr	r3, [r0, #32]
	cbz	r3, .L40
	str	r1, [r0, #32]
	str	r1, [r0, #16]
	ldr	r3, [r0, #8]
	cbz	r3, .L40
	push	{r4, lr}
	mov	r4, r0
	ldr	r0, [r0, #8]
	bl	__aeabi_ui2d
	movs	r2, #0
	ldr	r3, .L53
	bl	__aeabi_dmul
	movs	r2, #0
	ldr	r3, .L53+4
	bl	__aeabi_ddiv
	movs	r2, #0
	ldr	r3, .L53+8
	bl	__aeabi_dmul
	bl	__aeabi_d2uiz
	cmp	r0, #200
	bls	.L45
	str	r0, [r4, #24]
.L45:
	ldr	r3, [r4, #40]
	pop	{r4, lr}
	bx	r3	@ indirect register sibling call
.L40:
	bx	lr
.L52:
	movs	r2, #0
	movs	r3, #1
	str	r2, [r0, #8]
	str	r3, [r0, #32]
	bx	lr
.L54:
	.align	2
.L53:
	.word	1078525952
	.word	1077739520
	.word	1079574528
	.size	UsonicISR, .-UsonicISR
	.section	.bss.g_TimerHook,"aw",%nobits
	.align	2
	.set	.LANCHOR1,. + 0
	.type	g_TimerHook, %object
	.size	g_TimerHook, 8
g_TimerHook:
	.space	8
	.section	.bss.g_pusonicIrqHandles,"aw",%nobits
	.align	2
	.set	.LANCHOR0,. + 0
	.type	g_pusonicIrqHandles, %object
	.size	g_pusonicIrqHandles, 32
g_pusonicIrqHandles:
	.space	32
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
