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
	.file	"Serial.c"
	.text
	.section	.text.SerialInit,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialInit
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialInit, %function
SerialInit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	mov	r4, r0
	mov	r5, r1
	mov	r6, r2
	movs	r1, #0
	movs	r2, #80
	mov	r7, r3
	bl	memset
	str	r5, [r4]
	ldr	r5, [r5]
	mov	r2, r7
	mov	r1, r6
	mov	r0, r4
	mov	r3, r5
	pop	{r4, r5, r6, r7, r8, lr}
	bx	r3
	.size	SerialInit, .-SerialInit
	.section	.text.SerialBuffer,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialBuffer
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialBuffer, %function
SerialBuffer:
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4}
	ldr	r4, [sp, #4]
	str	r2, [r0, #40]
	str	r4, [r0, #56]
	str	r1, [r0, #52]
	str	r3, [r0, #68]
	ldr	r4, [sp], #4
	bx	lr
	.size	SerialBuffer, .-SerialBuffer
	.section	.text.SerialBaudrate,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialBaudrate
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialBaudrate, %function
SerialBaudrate:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0]
	ldr	r3, [r3, #4]
	bx	r3
	.size	SerialBaudrate, .-SerialBaudrate
	.section	.text.SerialConfig,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialConfig
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialConfig, %function
SerialConfig:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4}
	ldr	r4, [r0]
	ldr	r4, [r4, #8]
	mov	ip, r4
	ldr	r4, [sp], #4
	bx	ip
	.size	SerialConfig, .-SerialConfig
	.section	.text.SerialAddCallback,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialAddCallback
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialAddCallback, %function
SerialAddCallback:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cbz	r1, .L10
	str	r1, [r0, #72]
.L10:
	cbz	r2, .L9
	str	r2, [r0, #76]
.L9:
	bx	lr
	.size	SerialAddCallback, .-SerialAddCallback
	.section	.text.SerialWrite,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialWrite
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialWrite, %function
SerialWrite:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	ldr	r6, [r0, #32]
	cmp	r6, #0
	bne	.L29
	ldr	r3, [r0]
	mov	r4, r0
	mov	r7, r1
	ldr	r3, [r3, #56]
	blx	r3
	ldr	r3, [r4]
	mov	r0, r4
	ldr	r3, [r3, #40]
	blx	r3
	mov	r5, r0
	cbnz	r0, .L20
	ldr	r2, [r4, #40]
	cmp	r2, #0
	beq	.L23
	ldr	r3, [r4, #44]
	ldr	r1, [r4, #48]
	adds	r3, r3, #1
	cmp	r2, r3
	it	le
	movle	r3, #0
	cmp	r1, r3
	beq	.L23
	ldr	r2, [r4, #44]
	mov	r0, r4
	ldr	r1, [r4, #52]
	strb	r7, [r1, r2]
	ldr	r2, [r4]
	str	r3, [r4, #44]
	ldr	r3, [r2, #60]
	blx	r3
.L18:
	mov	r0, r5
	pop	{r3, r4, r5, r6, r7, pc}
.L20:
	ldr	r2, [r4, #44]
	ldr	r3, [r4, #48]
	cmp	r2, r3
	beq	.L24
	ldr	r2, [r4, #40]
	cbz	r2, .L25
	ldr	r3, [r4, #44]
	ldr	r1, [r4, #48]
	adds	r3, r3, #1
	cmp	r2, r3
	it	le
	movle	r3, #0
	cmp	r1, r3
	beq	.L27
	ldr	r2, [r4, #44]
	ldr	r1, [r4, #52]
	strb	r7, [r1, r2]
	ldr	r2, [r4, #40]
	str	r3, [r4, #44]
	cbz	r2, .L25
.L27:
	ldr	r1, [r4, #44]
	ldr	r3, [r4, #48]
	cmp	r1, r3
	beq	.L25
	ldr	r3, [r4, #48]
	ldr	r0, [r4, #52]
	adds	r1, r3, #1
	str	r1, [r4, #48]
	ldr	r1, [r4, #48]
	ldrb	r6, [r0, r3]	@ zero_extendqisi2
	cmp	r2, r1
	bne	.L28
	movs	r3, #0
	str	r3, [r4, #48]
.L28:
	ldr	r3, [r4]
	mov	r0, r4
	movs	r5, #0
	ldr	r3, [r3, #60]
	blx	r3
	ldr	r3, [r4]
	mov	r0, r4
	mov	r1, r6
	ldr	r3, [r3, #20]
	blx	r3
	mov	r0, r5
	pop	{r3, r4, r5, r6, r7, pc}
.L25:
	ldr	r3, [r4]
	movs	r5, #0
	mov	r0, r4
	ldr	r3, [r3, #60]
	blx	r3
	mov	r0, r5
	pop	{r3, r4, r5, r6, r7, pc}
.L23:
	ldr	r3, [r4]
	mvn	r5, #3
	mov	r0, r4
	ldr	r3, [r3, #60]
	blx	r3
	mov	r0, r5
	pop	{r3, r4, r5, r6, r7, pc}
.L24:
	ldr	r3, [r4]
	mov	r0, r4
	mov	r5, r6
	ldr	r3, [r3, #60]
	blx	r3
	ldr	r3, [r4]
	mov	r0, r4
	mov	r1, r7
	ldr	r3, [r3, #20]
	blx	r3
	mov	r0, r5
	pop	{r3, r4, r5, r6, r7, pc}
.L29:
	mvn	r5, #4
	b	.L18
	.size	SerialWrite, .-SerialWrite
	.section	.text.SerialWriteEx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialWriteEx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialWriteEx, %function
SerialWriteEx:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, lr}
	mov	r4, r0
	mov	r6, r1
	mov	r7, r2
.L38:
	ldr	r3, [r4]
	mov	r0, r4
	ldr	r3, [r3, #40]
	blx	r3
	cmp	r0, #0
	beq	.L38
	ldr	r5, [r4, #40]
	mov	r1, r6
	ldr	r0, [r4, #52]
	cmp	r5, r7
	it	ge
	movge	r5, r7
	mov	r2, r5
	bl	memcpy
	cmp	r7, r5
	blt	.L39
	str	r5, [r4, #44]
	ldr	r3, [r4, #48]
	adds	r3, r3, #1
	str	r3, [r4, #48]
.L39:
	ldr	r3, [r4]
	mov	r0, r4
	ldrb	r1, [r6]	@ zero_extendqisi2
	ldr	r3, [r3, #20]
	blx	r3
	mov	r0, r5
	pop	{r3, r4, r5, r6, r7, pc}
	.size	SerialWriteEx, .-SerialWriteEx
	.section	.text.SerialRead,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialRead
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialRead, %function
SerialRead:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r5, [r0, #36]
	cbnz	r5, .L48
	ldr	r3, [r0]
	mov	r4, r0
	ldr	r3, [r3, #56]
	blx	r3
	ldr	r3, [r4, #56]
	cbz	r3, .L51
	ldr	r0, [r4, #60]
	ldr	r2, [r4, #64]
	ldr	r1, [r4]
	cmp	r0, r2
	ldr	r1, [r1, #60]
	beq	.L46
	ldr	r2, [r4, #64]
	ldr	r6, [r4, #68]
	adds	r0, r2, #1
	str	r0, [r4, #64]
	ldr	r0, [r4, #64]
	ldrb	r6, [r6, r2]	@ zero_extendqisi2
	cmp	r3, r0
	bne	.L50
	str	r5, [r4, #64]
.L50:
	mov	r0, r4
	blx	r1
	mov	r0, r6
	pop	{r4, r5, r6, pc}
.L51:
	ldr	r2, [r4]
	mov	r6, r3
	mov	r0, r4
	ldr	r3, [r2, #60]
	blx	r3
.L44:
	mov	r0, r6
	pop	{r4, r5, r6, pc}
.L48:
	movs	r6, #251
	mov	r0, r6
	pop	{r4, r5, r6, pc}
.L46:
	mov	r0, r4
	mov	r6, r5
	blx	r1
	b	.L44
	.size	SerialRead, .-SerialRead
	.section	.text.SerialReadEx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialReadEx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialReadEx, %function
SerialReadEx:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	SerialReadEx, .-SerialReadEx
	.section	.text.SerialTxEmpty,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialTxEmpty
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialTxEmpty, %function
SerialTxEmpty:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	SerialTxEmpty, .-SerialTxEmpty
	.section	.text.SerialRxEmpty,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialRxEmpty
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialRxEmpty, %function
SerialRxEmpty:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	SerialRxEmpty, .-SerialRxEmpty
	.section	.text.SerialIsTxEmpty,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialIsTxEmpty
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialIsTxEmpty, %function
SerialIsTxEmpty:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r0, #0
	bx	lr
	.size	SerialIsTxEmpty, .-SerialIsTxEmpty
	.section	.text.SerialIsTxReady,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialIsTxReady
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialIsTxReady, %function
SerialIsTxReady:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, lr}
	ldr	r3, [r0]
	mov	r5, r0
	ldr	r3, [r3, #56]
	blx	r3
	ldr	r4, [r5, #44]
	ldr	r2, [r5, #40]
	mov	r0, r5
	adds	r4, r4, #1
	ldr	r3, [r5]
	ldr	r5, [r5, #48]
	cmp	r2, r4
	it	le
	movle	r4, #0
	ldr	r3, [r3, #60]
	blx	r3
	subs	r0, r4, r5
	it	ne
	movne	r0, #1
	pop	{r3, r4, r5, pc}
	.size	SerialIsTxReady, .-SerialIsTxReady
	.section	.text.SerialIsRxReady,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	SerialIsRxReady
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	SerialIsRxReady, %function
SerialIsRxReady:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, [r0, #60]
	ldr	r0, [r0, #64]
	subs	r0, r2, r0
	it	ne
	movne	r0, #1
	bx	lr
	.size	SerialIsRxReady, .-SerialIsRxReady
	.section	.text.UartIsrTx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	UartIsrTx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	UartIsrTx, %function
UartIsrTx:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, [r0, #40]
	push	{r4, lr}
	cbz	r3, .L61
	ldr	r1, [r0, #44]
	ldr	r2, [r0, #48]
	cmp	r1, r2
	beq	.L61
	ldr	r2, [r0, #48]
	ldr	r1, [r0, #52]
	adds	r4, r2, #1
	str	r4, [r0, #48]
	ldr	r4, [r0, #48]
	ldrb	r1, [r1, r2]	@ zero_extendqisi2
	cmp	r3, r4
	beq	.L68
	ldr	r3, [r0]
	pop	{r4, lr}
	ldr	r3, [r3, #20]
	bx	r3	@ indirect register sibling call
.L61:
	ldr	r3, [r0]
	mov	r4, r0
	ldr	r3, [r3, #48]
	blx	r3
	ldr	r3, [r4, #72]
	cbz	r3, .L60
	pop	{r4, lr}
	bx	r3	@ indirect register sibling call
.L68:
	movs	r3, #0
	str	r3, [r0, #48]
	ldr	r3, [r0]
	pop	{r4, lr}
	ldr	r3, [r3, #20]
	bx	r3	@ indirect register sibling call
.L60:
	pop	{r4, pc}
	.size	UartIsrTx, .-UartIsrTx
	.section	.text.UartIsrRx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	UartIsrRx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	UartIsrRx, %function
UartIsrRx:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, [r0]
	push	{r4, lr}
	mov	r4, r0
	ldr	r3, [r3, #28]
	blx	r3
	ldr	r3, [r4, #24]
	cbz	r3, .L70
	ldr	r2, [r4, #28]
	cbz	r2, .L69
	ldr	r2, [r4, #28]
	adds	r1, r3, #1
	subs	r2, r2, #1
	str	r1, [r4, #24]
	str	r2, [r4, #28]
	strb	r0, [r3]
	ldr	r3, [r4, #28]
	cbnz	r3, .L69
	ldr	r3, [r4, #76]
	cbz	r3, .L74
	blx	r3
.L74:
	movs	r3, #0
	str	r3, [r4, #24]
.L69:
	pop	{r4, pc}
.L70:
	ldr	r2, [r4, #56]
	cbz	r2, .L75
	ldr	r3, [r4, #60]
	ldr	r1, [r4, #64]
	adds	r3, r3, #1
	cmp	r2, r3
	it	le
	movle	r3, #0
	cmp	r1, r3
	beq	.L75
	ldr	r2, [r4, #60]
	ldr	r1, [r4, #68]
	strb	r0, [r1, r2]
	ldr	r2, [r4, #76]
	str	r3, [r4, #60]
	cmp	r2, #0
	beq	.L69
	pop	{r4, lr}
	bx	r2	@ indirect register sibling call
.L75:
	ldr	r3, [r4, #4]
	orr	r3, r3, #1
	str	r3, [r4, #4]
	pop	{r4, pc}
	.size	UartIsrRx, .-UartIsrRx
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
