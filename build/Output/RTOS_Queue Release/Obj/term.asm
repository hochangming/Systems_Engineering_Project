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
	.file	"term.c"
	.text
	.section	.text.TerminalInit,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	TerminalInit
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	TerminalInit, %function
TerminalInit:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L3
	movs	r0, #0
	movs	r1, #0
	strd	r0, [r3]
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LANCHOR0
	.size	TerminalInit, .-TerminalInit
	.section	.text.TerminalAckToHost,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	TerminalAckToHost
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	TerminalAckToHost, %function
TerminalAckToHost:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r1, #560
	sub	sp, sp, #32
	movs	r2, #0
	movs	r3, #49
	mov	r4, r0
	strh	r1, [sp]	@ movhi
	strb	r2, [sp, #2]
	strb	r3, [sp, #17]
.L6:
	mov	r0, r4
	bl	SerialIsTxReady
	cmp	r0, #0
	beq	.L6
	movs	r2, #18
	mov	r1, sp
	mov	r0, r4
	bl	SerialWriteEx
	add	sp, sp, #32
	@ sp needed
	pop	{r4, pc}
	.size	TerminalAckToHost, .-TerminalAckToHost
	.section	.text.TerminalMapToHost,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	TerminalMapToHost
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	TerminalMapToHost, %function
TerminalMapToHost:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #44
	mov	r5, #1072
	mov	r4, r0
	str	r2, [sp, #4]
	movs	r2, #4
	strb	r1, [sp, #10]
	add	r0, sp, #11
	add	r1, sp, r2
	str	r3, [sp]
	strh	r5, [sp, #8]	@ movhi
	bl	memcpy
	movs	r2, #4
	mov	r1, sp
	add	r0, sp, #15
	bl	memcpy
	movs	r3, #49
	strb	r3, [sp, #25]
.L11:
	mov	r0, r4
	bl	SerialIsTxReady
	cmp	r0, #0
	beq	.L11
	movs	r2, #18
	add	r1, sp, #8
	mov	r0, r4
	bl	SerialWriteEx
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, pc}
	.size	TerminalMapToHost, .-TerminalMapToHost
	.section	.text.TerminalParse,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	TerminalParse
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	TerminalParse, %function
TerminalParse:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, lr}
	mov	r5, r0
	ldr	r4, .L28
	movs	r6, #0
	movs	r7, #0
	mov	r8, #1
	mov	r9, #0
.L16:
	mov	r0, r5
	bl	SerialIsRxReady
	cmp	r0, #1
	mov	r0, r5
	bne	.L27
.L24:
	bl	SerialRead
	ldr	r3, [r4]
	cmp	r3, #1
	beq	.L17
	cmp	r0, #48
	bne	.L16
	mov	r0, r5
	strd	r8, [r4]
	bl	SerialIsRxReady
	cmp	r0, #1
	mov	r0, r5
	beq	.L24
.L27:
	movs	r0, #0
	pop	{r3, r4, r5, r6, r7, r8, r9, pc}
.L17:
	ldr	r3, [r4, #4]
	cmp	r3, #10
	add	r1, r4, r3
	add	r2, r3, #1
	beq	.L20
	cmp	r2, #10
	mov	r3, #0
	strb	r0, [r1, #8]
	ite	le
	strle	r2, [r4, #4]
	strgt	r3, [r4, #4]
	b	.L16
.L20:
	cmp	r0, #49
	strd	r6, [r4]
	bne	.L16
	ldr	r0, .L28+4
	pop	{r3, r4, r5, r6, r7, r8, r9, pc}
.L29:
	.align	2
.L28:
	.word	.LANCHOR0
	.word	.LANCHOR0+8
	.size	TerminalParse, .-TerminalParse
	.section	.bss.g_Cmd,"aw",%nobits
	.align	3
	.set	.LANCHOR0,. + 0
	.type	g_Cmd, %object
	.size	g_Cmd, 40
g_Cmd:
	.space	40
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
