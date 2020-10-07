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
	.file	"matrix.c"
	.text
	.global	__aeabi_dmul
	.global	__aeabi_dsub
	.global	__aeabi_ddiv
	.section	.text.MatrixInverse,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	MatrixInverse
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	MatrixInverse, %function
MatrixInverse:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldrd	r8, [r0, #24]
	ldrd	r2, [r0]
	mov	r5, r1
	mov	r4, r0
	mov	r1, r9
	mov	r0, r8
	bl	__aeabi_dmul
	mov	r6, r0
	mov	r7, r1
	ldrd	r2, [r4, #16]
	ldrd	r0, [r4, #8]
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r6
	mov	r1, r7
	bl	__aeabi_dsub
	mov	r2, r0
	mov	r3, r1
	movs	r0, #0
	ldr	r1, .L4
	bl	__aeabi_ddiv
	mov	r6, r0
	mov	r7, r1
	mov	r2, r0
	mov	r3, r1
	mov	r0, r8
	mov	r1, r9
	bl	__aeabi_dmul
	strd	r0, [r5]
	mov	r0, r6
	mov	r1, r7
	ldrd	r2, [r4, #8]
	bl	__aeabi_dmul
	mov	r8, r0
	mov	r9, r1
	mov	r0, r6
	mov	r1, r7
	strd	r8, [r5, #8]
	ldrd	r2, [r4, #16]
	bl	__aeabi_dmul
	mov	r10, r0
	mov	fp, r1
	mov	r2, r6
	mov	r3, r7
	strd	r10, [r5, #16]
	ldrd	r0, [r4]
	bl	__aeabi_dmul
	mov	r2, r8
	mov	r3, r9
	strd	r0, [r5, #24]
	movs	r0, #0
	movs	r1, #0
	bl	__aeabi_dsub
	mov	r2, r10
	mov	r3, fp
	strd	r0, [r5, #8]
	movs	r0, #0
	movs	r1, #0
	bl	__aeabi_dsub
	strd	r0, [r5, #16]
	movs	r0, #1
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L5:
	.align	2
.L4:
	.word	1072693248
	.size	MatrixInverse, .-MatrixInverse
	.global	__aeabi_dadd
	.section	.text.MatrixMultiply,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	MatrixMultiply
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	MatrixMultiply, %function
MatrixMultiply:
	@ args = 12, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	subs	r10, r2, #0
	vpush.64	{d8}
	sub	sp, sp, #28
	ldr	r1, [sp, #76]
	ble	.L7
	cmp	r1, #0
	ble	.L7
	add	r2, r0, r10, lsl #4
	str	r3, [sp, #20]
	rsb	r3, r1, r1, lsl #29
	add	r7, r0, #24
	adds	r2, r2, #24
	lsls	r3, r3, #3
	str	r2, [sp, #12]
	ldr	r2, [sp, #80]
	str	r3, [sp, #16]
	add	r3, r0, r10, lsl #3
	add	r2, r2, r1, lsl #3
	str	r3, [sp, #8]
	str	r2, [sp, #4]
	vldr.64	d8, .L26
.L9:
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #16]
	ldr	r5, [sp, #20]
	adds	r4, r3, r2
.L12:
	mov	r6, r5
	vstr.64	d8, [r4]
	ldrd	r2, [r7, #-24]
	ldrd	r0, [r6], #8
	bl	__aeabi_dmul
	movs	r2, #0
	movs	r3, #0
	bl	__aeabi_dadd
	cmp	r10, #1
	mov	r8, r0
	mov	r9, r1
	strd	r8, [r4], #8
	beq	.L10
	ldrd	r2, [r5, #8]
	ldrd	r0, [r7, #-16]
	bl	__aeabi_dmul
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_dadd
	cmp	r10, #2
	mov	r8, r0
	mov	r9, r1
	strd	r8, [r4, #-8]
	beq	.L10
	ldrd	r2, [r6, #8]
	ldrd	r0, [r7, #-8]
	bl	__aeabi_dmul
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_dadd
	cmp	r10, #3
	mov	r8, r0
	mov	r9, r1
	strd	r8, [r4, #-8]
	beq	.L10
	mov	r3, r10
	mov	fp, r7
	mov	r10, r7
	adds	r5, r5, #24
	mov	r7, r6
	mov	r6, r3
.L11:
	ldrd	r2, [r5], #8
	ldrd	r0, [fp], #8
	bl	__aeabi_dmul
	mov	r3, r1
	mov	r2, r0
	mov	r1, r9
	mov	r0, r8
	bl	__aeabi_dadd
	ldr	r3, [sp, #8]
	mov	r8, r0
	mov	r9, r1
	cmp	fp, r3
	strd	r8, [r4, #-8]
	bne	.L11
	mov	r3, r6
	mov	r6, r7
	mov	r7, r10
	mov	r10, r3
.L10:
	ldr	r3, [sp, #4]
	mov	r5, r6
	cmp	r4, r3
	bne	.L12
	adds	r3, r3, #8
	adds	r7, r7, #16
	str	r3, [sp, #4]
	ldr	r3, [sp, #8]
	adds	r3, r3, #16
	str	r3, [sp, #8]
	ldr	r3, [sp, #12]
	cmp	r7, r3
	bne	.L9
.L7:
	movs	r0, #1
	add	sp, sp, #28
	@ sp needed
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L27:
	.align	3
.L26:
	.word	0
	.word	0
	.size	MatrixMultiply, .-MatrixMultiply
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
