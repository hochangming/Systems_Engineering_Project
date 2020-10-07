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
	.file	"deca_device.c"
	.text
	.section	.text.dwt_OtpRead,"ax",%progbits
	.align	1
	.p2align 2,,3
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_OtpRead, %function
dwt_OtpRead:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movw	r4, #1261
	sub	sp, sp, #20
	movs	r2, #2
	movw	r5, #1773
	strh	r4, [sp, #12]	@ movhi
	movs	r4, #3
	strh	r0, [sp, #8]	@ movhi
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	strb	r4, [sp, #8]
	movs	r2, #1
	movs	r4, #0
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	strb	r4, [sp, #8]
	bl	writetospi
	movs	r2, #4
	movw	r5, #2669
	add	r3, sp, #12
	movs	r0, #2
	add	r1, sp, r2
	str	r4, [sp, #8]
	strh	r5, [sp, #4]	@ movhi
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
	.size	dwt_OtpRead, .-dwt_OtpRead
	.section	.text.DWT_OtpRevision,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_OtpRevision
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_OtpRevision, %function
DWT_OtpRevision:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r0, [r0, #9]	@ zero_extendqisi2
	bx	lr
	.size	DWT_OtpRevision, .-DWT_OtpRevision
	.section	.text.DWT_SetFineGrainTxSeq,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetFineGrainTxSeq
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetFineGrainTxSeq, %function
DWT_SetFineGrainTxSeq:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #12
	cbz	r0, .L6
	movs	r2, #2
	movw	r5, #2932
	movw	r4, #9974
	mov	r3, sp
	add	r1, sp, #4
	mov	r0, r2
	strh	r5, [sp]	@ movhi
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
.L6:
	movs	r2, #2
	mov	r4, r0
	movw	r5, #9974
	mov	r3, sp
	add	r1, sp, #4
	mov	r0, r2
	strh	r4, [sp]	@ movhi
	strh	r5, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_SetFineGrainTxSeq, .-DWT_SetFineGrainTxSeq
	.section	.text.DWT_SetLnaPaMode,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetLnaPaMode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetLnaPaMode, %function
DWT_SetLnaPaMode:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r2, #0
	sub	sp, sp, #16
	movs	r6, #38
	mov	r5, r0
	add	r3, sp, #12
	str	r2, [sp, #8]
	mov	r4, r1
	movs	r2, #4
	add	r1, sp, #4
	movs	r0, #1
	strb	r6, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	bic	r3, r3, #1032192
	cbz	r5, .L10
	orr	r3, r3, #262144
.L10:
	cbz	r4, .L11
	orr	r3, r3, #81920
.L11:
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	movs	r4, #166
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
	.size	DWT_SetLnaPaMode, .-DWT_SetLnaPaMode
	.section	.text.DWT_SetGpioDirection,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetGpioDirection
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetGpioDirection, %function
DWT_SetGpioDirection:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	orrs	r0, r0, r1
	sub	sp, sp, #12
	movw	r4, #2278
	movs	r2, #3
	lsrs	r5, r0, #16
	mov	r3, sp
	add	r1, sp, #4
	strh	r0, [sp]	@ movhi
	movs	r0, #2
	strb	r5, [sp, #2]
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_SetGpioDirection, .-DWT_SetGpioDirection
	.section	.text.DWT_SetGpioValue,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetGpioValue
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetGpioValue, %function
DWT_SetGpioValue:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	orrs	r0, r0, r1
	sub	sp, sp, #12
	movw	r4, #3302
	movs	r2, #3
	lsrs	r5, r0, #16
	mov	r3, sp
	add	r1, sp, #4
	strh	r0, [sp]	@ movhi
	movs	r0, #2
	strb	r5, [sp, #2]
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_SetGpioValue, .-DWT_SetGpioValue
	.section	.text.DWT_GetpPartID,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_GetpPartID
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_GetpPartID, %function
DWT_GetpPartID:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, [r0]
	bx	lr
	.size	DWT_GetpPartID, .-DWT_GetpPartID
	.section	.text.DWT_GetLotID,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_GetLotID
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_GetLotID, %function
DWT_GetLotID:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, [r0, #4]
	bx	lr
	.size	DWT_GetLotID, .-DWT_GetLotID
	.section	.text.DWT_ReadDevID,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadDevID
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadDevID, %function
DWT_ReadDevID:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #4
	sub	sp, sp, #16
	movs	r4, #0
	movs	r0, #1
	add	r1, sp, r2
	add	r3, sp, #12
	str	r4, [sp, #8]
	strb	r4, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadDevID, .-DWT_ReadDevID
	.section	.text.DWT_Configtxrf,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_Configtxrf
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_Configtxrf, %function
DWT_Configtxrf:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	mov	r4, r0
	sub	sp, sp, #20
	ldrb	r0, [r0]	@ zero_extendqisi2
	movw	r5, #3050
	add	r3, sp, #8
	add	r1, sp, #12
	strb	r0, [sp, #8]
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r3, [r4, #1]	@ unaligned
	add	r1, sp, #8
	add	r0, sp, #12
	movs	r2, #4
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movs	r4, #158
	add	r3, sp, #12
	add	r1, sp, r2
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_Configtxrf, .-DWT_Configtxrf
	.section	.text.DWT_Config,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_Config
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_Config, %function
DWT_Config:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r4, r1
	ldrb	r7, [r1, #1]	@ zero_extendqisi2
	ldrb	r6, [r1]	@ zero_extendqisi2
	sub	sp, sp, #16
	ldr	r3, .L46
	subs	r7, r7, #1
	cmp	r6, #7
	it	ne
	cmpne	r6, #4
	ldrb	r1, [r1, #5]	@ zero_extendqisi2
	ldrb	r2, [r4, #7]	@ zero_extendqisi2
	mov	r5, r0
	ldrh	r9, [r3, r1, lsl #1]
	ite	eq
	moveq	r10, #1
	movne	r10, #0
	uxtb	r7, r7
	ldr	r3, [r0, #20]
	cmp	r2, #0
	bne	.L30
	orr	r3, r3, #4194304
	lsr	r9, r9, #3
.L31:
	ldrb	r2, [r4, #8]	@ zero_extendqisi2
	bic	ip, r3, #196608
	add	r1, sp, #8
	add	r0, sp, #12
	lsls	r3, r2, #16
	strb	r2, [r5, #8]
	movs	r2, #4
	movw	r8, #34542
	and	r3, r3, #196608
	orr	r3, r3, ip
	orr	r3, r3, #536870912
	str	r3, [r5, #20]
	str	r3, [sp, #8]
	bl	memcpy
	movs	r0, #132
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	strb	r0, [sp, #4]
	movs	r0, #1
	bl	writetospi
	movw	r0, #34030
	mov	ip, #80
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #2
	strh	r0, [sp, #12]	@ movhi
	movs	r0, #3
	strb	ip, [sp, #14]
	strh	r9, [sp, #8]	@ movhi
	bl	writetospi
	movs	r0, #109
	mov	ip, #16
	add	r3, sp, #8
	add	r1, sp, #12
	strb	r0, [sp, #8]
	movs	r2, #1
	movs	r0, #3
	strh	r8, [sp, #12]	@ movhi
	strb	ip, [sp, #14]
	bl	writetospi
	cmp	r7, #0
	beq	.L32
	movw	r0, #1543
.L42:
	mov	ip, #48
	add	r3, sp, #8
	movs	r2, #2
	add	r1, sp, #12
	strh	r0, [sp, #8]	@ movhi
	movs	r0, #3
	strb	ip, [sp, #14]
	strh	r8, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r0, .L46+4
	movs	r2, #4
	ldr	r3, .L46+8
	add	r1, sp, #8
	ldrb	r8, [r0, r6]	@ zero_extendqisi2
	add	r0, sp, #12
	ldr	r3, [r3, r8, lsl #2]
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movw	ip, #2027
	add	r3, sp, #12
	movs	r0, #2
	add	r1, sp, r2
	strh	ip, [sp, #4]	@ movhi
	bl	writetospi
	ldr	r2, .L46+12
	movw	r0, #3051
	add	r3, sp, #8
	ldrb	ip, [r2, r8]	@ zero_extendqisi2
	add	r1, sp, #12
	movs	r2, #1
	strh	r0, [sp, #12]	@ movhi
	movs	r0, #2
	strb	ip, [sp, #8]
	bl	writetospi
	ldr	r2, .L46+16
	movw	ip, #3048
	add	r3, sp, #8
	ldrb	lr, [r2, r10]	@ zero_extendqisi2
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strb	lr, [sp, #8]
	strh	ip, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r3, .L46+20
	movs	r2, #4
	add	r1, sp, #8
	add	r0, sp, #12
	ldr	r3, [r3, r8, lsl #2]
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movw	ip, #3304
	add	r3, sp, #12
	movs	r0, #2
	add	r1, sp, r2
	strh	ip, [sp, #4]	@ movhi
	bl	writetospi
	ldrb	r3, [r4, #7]	@ zero_extendqisi2
	ldrb	r1, [r4, #6]	@ zero_extendqisi2
	movw	lr, #743
	ldr	ip, .L46+28
	movs	r2, #2
	add	r1, r1, r3, lsl #1
	strh	lr, [sp, #12]	@ movhi
	mov	r0, r2
	add	r3, sp, #8
	ldrh	ip, [ip, r1, lsl #1]
	add	r1, sp, #12
	strh	ip, [sp, #8]	@ movhi
	bl	writetospi
	ldr	r1, .L46+24
	movs	r2, #2
	movw	lr, #1255
	add	r3, sp, #8
	ldrh	ip, [r1, r7, lsl #1]
	mov	r0, r2
	add	r1, sp, #12
	strh	lr, [sp, #12]	@ movhi
	strh	ip, [sp, #8]	@ movhi
	bl	writetospi
	ldrb	r3, [r4, #7]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L43
	ldrb	r3, [r4, #2]	@ zero_extendqisi2
	movs	r2, #2
	cmp	r3, #4
	beq	.L44
	movs	r1, #32
	movw	ip, #1767
	add	r3, sp, #8
	mov	r0, r2
	strh	r1, [sp, #8]	@ movhi
	add	r1, sp, #12
	strh	ip, [sp, #12]	@ movhi
	bl	writetospi
	movs	r0, #40
	movw	ip, #9959
	add	r3, sp, #8
	movs	r2, #1
	strb	r0, [sp, #8]
	add	r1, sp, #12
	movs	r0, #2
	strh	ip, [sp, #12]	@ movhi
	bl	writetospi
.L35:
	ldrb	r3, [r4, #3]	@ zero_extendqisi2
	movs	r2, #4
	ldr	ip, .L46+32
	add	r1, sp, #8
	add	r3, r3, r7, lsl #2
	add	r0, sp, #12
	ldr	r3, [ip, r3, lsl #2]
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movw	ip, #2279
	add	r3, sp, #12
	movs	r0, #2
	add	r1, sp, r2
	strh	ip, [sp, #4]	@ movhi
	bl	writetospi
	ldrh	r1, [r4, #9]	@ unaligned
	cmp	r1, #0
	beq	.L37
	uxtb	r0, r1
	lsrs	r1, r1, #8
.L38:
	movs	r2, #2
	movw	ip, #8423
	ldr	r8, .L46+36
	add	r3, sp, #8
	strb	r0, [sp, #8]
	mov	r0, r2
	strb	r1, [sp, #9]
	add	r1, sp, #12
	strh	ip, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r3, [r8]	@ unaligned
	movs	r2, #4
	add	r1, sp, #8
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movw	ip, #3299
	add	r7, r8, r7, lsl #1
	add	r3, sp, #12
	add	r1, sp, r2
	movs	r0, #2
	strh	ip, [sp, #4]	@ movhi
	bl	writetospi
	ldrh	r7, [r7, #4]	@ unaligned
	movw	ip, #1251
	movs	r2, #2
	add	r3, sp, #8
	strh	ip, [sp, #12]	@ movhi
	lsr	ip, r7, #8
	mov	r0, r2
	add	r1, sp, #12
	strb	r7, [sp, #8]
	strb	ip, [sp, #9]
	bl	writetospi
	ldrb	r7, [r4, #6]	@ zero_extendqisi2
	cmp	r7, #0
	bne	.L45
	mov	ip, r7
.L39:
	ldrb	r2, [r4, #5]	@ zero_extendqisi2
	and	r1, r6, #15
	ldrb	r3, [r4, #1]	@ zero_extendqisi2
	lsls	r6, r6, #4
	ldrb	r0, [r4, #4]	@ zero_extendqisi2
	orr	r1, r1, r2, lsl #27
	uxtb	r6, r6
	movs	r2, #4
	lsls	r3, r3, #18
	orrs	r1, r1, r6
	lsls	r0, r0, #22
	and	r3, r3, #786432
	movs	r6, #159
	and	r0, r0, #130023424
	orrs	r3, r3, r1
	add	r1, sp, #8
	orrs	r3, r3, r0
	add	r0, sp, #12
	orr	r3, r3, ip
	orrs	r3, r3, r7
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	add	r3, sp, #12
	movs	r0, #1
	strb	r6, [sp, #4]
	add	r1, sp, r2
	bl	writetospi
	ldrb	r0, [r4, #2]	@ zero_extendqisi2
	ldrb	r6, [r4, #1]	@ zero_extendqisi2
	add	r1, sp, #8
	ldrb	r3, [r4, #7]	@ zero_extendqisi2
	movs	r2, #4
	orr	r4, r0, r6
	add	r0, sp, #12
	lsls	r3, r3, #13
	orr	r3, r3, r4, lsl #16
	movs	r4, #136
	str	r3, [r5, #12]
	movs	r5, #66
	str	r3, [sp, #8]
	bl	memcpy
	add	r1, sp, #4
	add	r3, sp, #12
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	movs	r2, #1
	movs	r4, #141
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strb	r5, [sp, #8]
	strb	r4, [sp, #12]
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L47:
	.align	2
.L46:
	.word	lde_replicaCoeff
	.word	chan_idx
	.word	fs_pll_cfg
	.word	fs_pll_tune
	.word	rx_config
	.word	tx_config
	.word	dtune1
	.word	sftsh
	.word	digital_bb_config
	.word	agc_config
.L44:
	mov	r8, #16
	movw	ip, #1767
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strh	ip, [sp, #12]	@ movhi
	strh	r8, [sp, #8]	@ movhi
	bl	writetospi
	movw	ip, #9959
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strb	r8, [sp, #8]
	strh	ip, [sp, #12]	@ movhi
	bl	writetospi
	b	.L35
.L30:
	bic	r3, r3, #4194304
	b	.L31
.L32:
	movw	r0, #5639
	b	.L42
.L37:
	movs	r2, #65
	movs	r3, #16
	mov	r0, r2
	strb	r2, [r4, #9]
	mov	r1, r3
	strb	r3, [r4, #10]
	b	.L38
.L43:
	movs	r2, #2
	movs	r1, #100
	movw	ip, #1767
	add	r3, sp, #8
	strh	r1, [sp, #8]	@ movhi
	mov	r0, r2
	add	r1, sp, #12
	strh	ip, [sp, #12]	@ movhi
	bl	writetospi
	b	.L35
.L45:
	ldrb	r3, [r4, #7]	@ zero_extendqisi2
	movs	r2, #1
	ldr	r7, .L48
	movs	r1, #161
	mov	r0, r2
	ldrb	r7, [r7, r3]	@ zero_extendqisi2
	add	r3, sp, #8
	strb	r1, [sp, #12]
	add	r1, sp, #12
	strb	r7, [sp, #8]
	bl	writetospi
	mov	r7, #131072
	mov	ip, #3145728
	b	.L39
.L49:
	.align	2
.L48:
	.word	dwnsSFDlen
	.size	DWT_Config, .-DWT_Config
	.section	.text.DWT_SetRxAntennaDelay,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetRxAntennaDelay
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetRxAntennaDelay, %function
DWT_SetRxAntennaDelay:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #12
	movw	r5, #34030
	movs	r4, #48
	movs	r2, #2
	mov	r3, sp
	add	r1, sp, #4
	strh	r0, [sp]	@ movhi
	movs	r0, #3
	strh	r5, [sp, #4]	@ movhi
	strb	r4, [sp, #6]
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_SetRxAntennaDelay, .-DWT_SetRxAntennaDelay
	.section	.text.DWT_SetTxAntennaDelay,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetTxAntennaDelay
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetTxAntennaDelay, %function
DWT_SetTxAntennaDelay:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movs	r4, #152
	movs	r2, #2
	mov	r3, sp
	add	r1, sp, #4
	strh	r0, [sp]	@ movhi
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_SetTxAntennaDelay, .-DWT_SetTxAntennaDelay
	.section	.text.DWT_WriteTxData,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_WriteTxData
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_WriteTxData, %function
DWT_WriteTxData:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	adds	r3, r2, r0
	cmp	r3, #1024
	bgt	.L59
	push	{r4, lr}
	subs	r4, r0, #2
	sub	sp, sp, #8
	cbz	r2, .L64
	movs	r0, #201
	cmp	r2, #127
	uxtb	r3, r2
	strb	r0, [sp, #4]
	bhi	.L58
	movs	r0, #2
	strb	r3, [sp, #5]
.L57:
	mov	r3, r1
	mov	r2, r4
	add	r1, sp, #4
	bl	writetospi
	movs	r0, #0
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L64:
	movs	r3, #137
	movs	r0, #1
	strb	r3, [sp, #4]
	b	.L57
.L58:
	orn	r3, r3, #127
	lsrs	r2, r2, #7
	movs	r0, #3
	strb	r3, [sp, #5]
	strb	r2, [sp, #6]
	b	.L57
.L59:
	mov	r0, #-1
	bx	lr
	.size	DWT_WriteTxData, .-DWT_WriteTxData
	.section	.text.DWT_WriteTxFrameCtrl,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_WriteTxFrameCtrl
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_WriteTxFrameCtrl, %function
DWT_WriteTxFrameCtrl:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, [r0, #12]
	orr	r3, r1, r3, lsl #15
	orrs	r3, r3, r0
	push	{r4, lr}
	sub	sp, sp, #16
	orr	r3, r3, r2, lsl #22
	movs	r2, #4
	movs	r4, #136
	add	r1, sp, #8
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	add	r3, sp, #12
	movs	r0, #1
	strb	r4, [sp, #4]
	add	r1, sp, r2
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_WriteTxFrameCtrl, .-DWT_WriteTxFrameCtrl
	.section	.text.DWT_ReadRxData,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadRxData
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadRxData, %function
DWT_ReadRxData:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, r0
	sub	sp, sp, #8
	cbnz	r2, .L68
	movs	r2, #17
	movs	r0, #1
	strb	r2, [sp, #4]
	mov	r2, r1
	add	r1, sp, #4
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L68:
	movs	r4, #81
	cmp	r2, #127
	uxtb	r0, r2
	strb	r4, [sp, #4]
	bhi	.L70
	mov	r2, r1
	add	r1, sp, #4
	strb	r0, [sp, #5]
	movs	r0, #2
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L70:
	lsrs	r2, r2, #7
	orn	r4, r0, #127
	movs	r0, #3
	strb	r2, [sp, #6]
	mov	r2, r1
	add	r1, sp, #4
	strb	r4, [sp, #5]
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadRxData, .-DWT_ReadRxData
	.section	.text.dwt_readaccdata,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readaccdata
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readaccdata, %function
dwt_readaccdata:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #8
	movs	r4, #54
	mov	r6, r2
	mov	r8, r0
	mov	r3, sp
	movs	r2, #2
	mov	r7, r1
	movs	r0, #1
	add	r1, sp, #4
	strb	r4, [sp, #4]
	bl	readfromspi
	ldrb	r4, [sp]	@ zero_extendqisi2
	ldrb	r5, [sp, #1]	@ zero_extendqisi2
	movs	r2, #1
	bic	r4, r4, #76
	movs	r1, #182
	orn	r5, r5, #127
	mov	r3, sp
	orr	r4, r4, #72
	strb	r1, [sp, #4]
	mov	r0, r2
	add	r1, sp, #4
	strb	r4, [sp]
	mov	r4, #502
	strb	r5, [sp, #1]
	bl	writetospi
	add	r1, sp, #4
	add	r3, sp, #1
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	cbnz	r6, .L73
	movs	r3, #37
	movs	r0, #1
	strb	r3, [sp, #4]
.L74:
	mov	r3, r8
	mov	r2, r7
	add	r1, sp, #4
	movs	r4, #54
	bl	readfromspi
	mov	r3, sp
	add	r1, sp, #4
	movs	r2, #2
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	readfromspi
	ldrh	r4, [sp]
	movs	r2, #1
	movs	r1, #182
	bic	r4, r4, #32768
	mov	r3, sp
	strb	r1, [sp, #4]
	mov	r0, r2
	bic	r4, r4, #76
	add	r1, sp, #4
	strh	r4, [sp]	@ movhi
	bl	writetospi
	mov	r4, #502
	add	r3, sp, #1
	add	r1, sp, #4
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L73:
	movs	r2, #101
	cmp	r6, #127
	uxtb	r3, r6
	strb	r2, [sp, #4]
	bhi	.L75
	strb	r3, [sp, #5]
	movs	r0, #2
	b	.L74
.L75:
	orn	r3, r3, #127
	lsrs	r6, r6, #7
	movs	r0, #3
	strb	r3, [sp, #5]
	strb	r6, [sp, #6]
	b	.L74
	.size	dwt_readaccdata, .-dwt_readaccdata
	.section	.text.dwt_readcarrierintegrator,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readcarrierintegrator
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readcarrierintegrator, %function
dwt_readcarrierintegrator:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movw	r4, #10343
	movs	r2, #3
	movs	r0, #2
	mov	r3, sp
	add	r1, sp, #4
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r1, [sp, #2]	@ zero_extendqisi2
	ldrb	r2, [sp, #1]	@ zero_extendqisi2
	ldrb	r3, [sp]	@ zero_extendqisi2
	add	r2, r2, r1, lsl #8
	add	r3, r3, r2, lsl #8
	lsls	r2, r3, #11
	bpl	.L78
	ldr	r0, .L81
	orrs	r0, r0, r3
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L78:
	ubfx	r0, r3, #0, #21
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L82:
	.align	2
.L81:
	.word	-1048576
	.size	dwt_readcarrierintegrator, .-dwt_readcarrierintegrator
	.section	.text.dwt_readdiagnostics,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readdiagnostics
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readdiagnostics, %function
dwt_readdiagnostics:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r2, #2
	sub	sp, sp, #16
	movw	r5, #1365
	mov	r4, r0
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strh	r5, [sp, #12]	@ movhi
	bl	readfromspi
	ldrb	r2, [sp, #9]	@ zero_extendqisi2
	ldrb	r5, [sp, #8]	@ zero_extendqisi2
	movs	r0, #46
	add	r3, sp, #8
	add	r1, sp, #12
	add	r5, r5, r2, lsl #8
	strb	r0, [sp, #12]
	movs	r2, #2
	movs	r0, #1
	strh	r5, [r4, #14]	@ unaligned
	movs	r6, #18
	bl	readfromspi
	ldrb	r2, [sp, #9]	@ zero_extendqisi2
	ldrb	r5, [sp, #8]	@ zero_extendqisi2
	mov	r3, r4
	add	r1, sp, #12
	movs	r0, #1
	add	r5, r5, r2, lsl #8
	movs	r2, #8
	strb	r6, [sp, #12]
	movs	r6, #16
	strh	r5, [r3], #4	@ unaligned
	movw	r5, #1877
	bl	readfromspi
	movs	r2, #2
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strh	r5, [sp, #12]	@ movhi
	bl	readfromspi
	ldrb	r2, [sp, #9]	@ zero_extendqisi2
	ldrb	r5, [sp, #8]	@ zero_extendqisi2
	movs	r1, #0
	add	r3, sp, #12
	movs	r0, #1
	add	r5, r5, r2, lsl #8
	movs	r2, #4
	str	r1, [sp, #8]
	strh	r5, [r4, #2]	@ unaligned
	add	r1, sp, r2
	strb	r6, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	ubfx	r3, r3, #20, #12
	strh	r3, [r4, #12]	@ unaligned
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
	.size	dwt_readdiagnostics, .-dwt_readdiagnostics
	.section	.text.DWT_ReadTxTimeStamp,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadTxTimeStamp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadTxTimeStamp, %function
DWT_ReadTxTimeStamp:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	mov	r3, r0
	movs	r4, #23
	movs	r2, #5
	add	r1, sp, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadTxTimeStamp, .-DWT_ReadTxTimeStamp
	.section	.text.DWT_ReadTxTimeStamphi32,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadTxTimeStamphi32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadTxTimeStamphi32, %function
DWT_ReadTxTimeStamphi32:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #4
	sub	sp, sp, #16
	movs	r0, #0
	movw	r4, #343
	add	r1, sp, r2
	add	r3, sp, #12
	str	r0, [sp, #8]
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadTxTimeStamphi32, .-DWT_ReadTxTimeStamphi32
	.section	.text.DWT_ReadTxTimeStamplo32,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadTxTimeStamplo32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadTxTimeStamplo32, %function
DWT_ReadTxTimeStamplo32:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #4
	sub	sp, sp, #16
	movs	r0, #0
	movs	r4, #23
	add	r1, sp, r2
	add	r3, sp, #12
	str	r0, [sp, #8]
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadTxTimeStamplo32, .-DWT_ReadTxTimeStamplo32
	.section	.text.DWT_ReadRxTimeStamp,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadRxTimeStamp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadRxTimeStamp, %function
DWT_ReadRxTimeStamp:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	mov	r3, r0
	movs	r4, #21
	movs	r2, #5
	add	r1, sp, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadRxTimeStamp, .-DWT_ReadRxTimeStamp
	.section	.text.DWT_ReadRxTimesTamphi32,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadRxTimesTamphi32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadRxTimesTamphi32, %function
DWT_ReadRxTimesTamphi32:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #4
	sub	sp, sp, #16
	movs	r0, #0
	movw	r4, #341
	add	r1, sp, r2
	add	r3, sp, #12
	str	r0, [sp, #8]
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadRxTimesTamphi32, .-DWT_ReadRxTimesTamphi32
	.section	.text.DWT_ReadRxTimeStamplo32,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadRxTimeStamplo32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadRxTimeStamplo32, %function
DWT_ReadRxTimeStamplo32:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #4
	sub	sp, sp, #16
	movs	r0, #0
	movs	r4, #21
	add	r1, sp, r2
	add	r3, sp, #12
	str	r0, [sp, #8]
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadRxTimeStamplo32, .-DWT_ReadRxTimeStamplo32
	.section	.text.DWT_ReadSysTimeStamphi32,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadSysTimeStamphi32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadSysTimeStamphi32, %function
DWT_ReadSysTimeStamphi32:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #4
	sub	sp, sp, #16
	movs	r0, #0
	mov	r4, #326
	add	r1, sp, r2
	add	r3, sp, #12
	str	r0, [sp, #8]
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadSysTimeStamphi32, .-DWT_ReadSysTimeStamphi32
	.section	.text.DWT_ReadSysTime,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ReadSysTime
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ReadSysTime, %function
DWT_ReadSysTime:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	mov	r3, r0
	movs	r4, #6
	movs	r2, #5
	add	r1, sp, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_ReadSysTime, .-DWT_ReadSysTime
	.section	.text.dwt_writetodevice,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_writetodevice
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_writetodevice, %function
dwt_writetodevice:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	uxtb	r0, r0
	sub	sp, sp, #8
	cbnz	r1, .L102
	orn	r1, r0, #127
	movs	r0, #1
	strb	r1, [sp, #4]
	add	r1, sp, #4
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L102:
	orn	r0, r0, #63
	cmp	r1, #127
	uxtb	r4, r1
	strb	r0, [sp, #4]
	bhi	.L104
	add	r1, sp, #4
	movs	r0, #2
	strb	r4, [sp, #5]
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L104:
	lsrs	r1, r1, #7
	orn	r4, r4, #127
	movs	r0, #3
	strb	r1, [sp, #6]
	add	r1, sp, #4
	strb	r4, [sp, #5]
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_writetodevice, .-dwt_writetodevice
	.section	.text.dwt_readfromdevice,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readfromdevice
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readfromdevice, %function
dwt_readfromdevice:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	uxtb	r0, r0
	sub	sp, sp, #8
	cbnz	r1, .L107
	add	r1, sp, #4
	strb	r0, [sp, #4]
	movs	r0, #1
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L107:
	orr	r0, r0, #64
	cmp	r1, #127
	uxtb	r4, r1
	strb	r0, [sp, #4]
	bhi	.L109
	add	r1, sp, #4
	movs	r0, #2
	strb	r4, [sp, #5]
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
.L109:
	lsrs	r1, r1, #7
	orn	r4, r4, #127
	movs	r0, #3
	strb	r1, [sp, #6]
	add	r1, sp, #4
	strb	r4, [sp, #5]
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_readfromdevice, .-dwt_readfromdevice
	.section	.text.dwt_read32bitoffsetreg,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_read32bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_read32bitoffsetreg, %function
dwt_read32bitoffsetreg:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
	movs	r2, #0
	sub	sp, sp, #20
	uxth	r3, r1
	uxtb	r0, r0
	str	r2, [sp, #8]
	cbnz	r3, .L112
	strb	r0, [sp, #4]
	movs	r0, #1
.L113:
	movs	r2, #4
	add	r3, sp, #12
	add	r1, sp, r2
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r0, [sp, #8]
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
.L112:
	orr	r0, r0, #64
	cmp	r3, #127
	uxtb	r1, r1
	strb	r0, [sp, #4]
	bhi	.L114
	strb	r1, [sp, #5]
	movs	r0, #2
	b	.L113
.L114:
	orn	r1, r1, #127
	lsrs	r3, r3, #7
	movs	r0, #3
	strb	r1, [sp, #5]
	strb	r3, [sp, #6]
	b	.L113
	.size	dwt_read32bitoffsetreg, .-dwt_read32bitoffsetreg
	.section	.text.dwt_read16bitoffsetreg,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_read16bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_read16bitoffsetreg, %function
dwt_read16bitoffsetreg:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	uxth	r3, r1
	uxtb	r0, r0
	push	{lr}
	sub	sp, sp, #12
	cbnz	r3, .L117
	strb	r0, [sp, #4]
	movs	r0, #1
.L118:
	mov	r3, sp
	movs	r2, #2
	add	r1, sp, #4
	bl	readfromspi
	ldrb	r3, [sp, #1]	@ zero_extendqisi2
	ldrb	r0, [sp]	@ zero_extendqisi2
	add	r0, r0, r3, lsl #8
	uxth	r0, r0
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L117:
	orr	r0, r0, #64
	cmp	r3, #127
	uxtb	r1, r1
	strb	r0, [sp, #4]
	bhi	.L119
	strb	r1, [sp, #5]
	movs	r0, #2
	b	.L118
.L119:
	orn	r1, r1, #127
	lsrs	r3, r3, #7
	movs	r0, #3
	strb	r1, [sp, #5]
	strb	r3, [sp, #6]
	b	.L118
	.size	dwt_read16bitoffsetreg, .-dwt_read16bitoffsetreg
	.section	.text.dwt_read8bitoffsetreg,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_read8bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_read8bitoffsetreg, %function
dwt_read8bitoffsetreg:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	uxth	r3, r1
	uxtb	r0, r0
	push	{lr}
	sub	sp, sp, #12
	cbnz	r3, .L122
	strb	r0, [sp, #4]
	movs	r0, #1
.L123:
	add	r3, sp, #3
	movs	r2, #1
	add	r1, sp, #4
	bl	readfromspi
	ldrb	r0, [sp, #3]	@ zero_extendqisi2
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L122:
	orr	r0, r0, #64
	cmp	r3, #127
	uxtb	r1, r1
	strb	r0, [sp, #4]
	bhi	.L124
	strb	r1, [sp, #5]
	movs	r0, #2
	b	.L123
.L124:
	orn	r1, r1, #127
	lsrs	r3, r3, #7
	movs	r0, #3
	strb	r1, [sp, #5]
	strb	r3, [sp, #6]
	b	.L123
	.size	dwt_read8bitoffsetreg, .-dwt_read8bitoffsetreg
	.section	.text.dwt_write8bitoffsetreg,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_write8bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_write8bitoffsetreg, %function
dwt_write8bitoffsetreg:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
	uxth	r3, r1
	sub	sp, sp, #20
	uxtb	r0, r0
	strb	r2, [sp, #7]
	cbnz	r3, .L127
	orn	r3, r0, #127
	movs	r0, #1
	strb	r3, [sp, #12]
.L128:
	add	r3, sp, #7
	movs	r2, #1
	add	r1, sp, #12
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
.L127:
	orn	r0, r0, #63
	cmp	r3, #127
	uxtb	r1, r1
	strb	r0, [sp, #12]
	bhi	.L129
	strb	r1, [sp, #13]
	movs	r0, #2
	b	.L128
.L129:
	orn	r1, r1, #127
	lsrs	r3, r3, #7
	movs	r0, #3
	strb	r1, [sp, #13]
	strb	r3, [sp, #14]
	b	.L128
	.size	dwt_write8bitoffsetreg, .-dwt_write8bitoffsetreg
	.section	.text.dwt_write16bitoffsetreg,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_write16bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_write16bitoffsetreg, %function
dwt_write16bitoffsetreg:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
	uxth	r3, r1
	sub	sp, sp, #12
	uxtb	r0, r0
	strh	r2, [sp]	@ movhi
	cbnz	r3, .L132
	orn	r3, r0, #127
	movs	r0, #1
	strb	r3, [sp, #4]
.L133:
	mov	r3, sp
	movs	r2, #2
	add	r1, sp, #4
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	ldr	pc, [sp], #4
.L132:
	orn	r0, r0, #63
	cmp	r3, #127
	uxtb	r1, r1
	strb	r0, [sp, #4]
	bhi	.L134
	strb	r1, [sp, #5]
	movs	r0, #2
	b	.L133
.L134:
	orn	r1, r1, #127
	lsrs	r3, r3, #7
	movs	r0, #3
	strb	r1, [sp, #5]
	strb	r3, [sp, #6]
	b	.L133
	.size	dwt_write16bitoffsetreg, .-dwt_write16bitoffsetreg
	.section	.text.dwt_write32bitoffsetreg,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_write32bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_write32bitoffsetreg, %function
dwt_write32bitoffsetreg:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #20
	mov	r5, r1
	mov	r4, r0
	str	r2, [sp, #4]
	movs	r2, #4
	add	r0, sp, #12
	uxtb	r4, r4
	add	r1, sp, r2
	bl	memcpy
	uxth	r3, r5
	cbnz	r3, .L137
	orn	r4, r4, #127
	movs	r0, #1
	strb	r4, [sp, #8]
.L138:
	add	r3, sp, #12
	movs	r2, #4
	add	r1, sp, #8
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L137:
	orn	r4, r4, #63
	cmp	r3, #127
	uxtb	r5, r5
	strb	r4, [sp, #8]
	bhi	.L139
	strb	r5, [sp, #9]
	movs	r0, #2
	b	.L138
.L139:
	orn	r5, r5, #127
	lsrs	r3, r3, #7
	movs	r0, #3
	strb	r5, [sp, #9]
	strb	r3, [sp, #10]
	b	.L138
	.size	dwt_write32bitoffsetreg, .-dwt_write32bitoffsetreg
	.section	.text.DWT_EnableFrameFilter,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_EnableFrameFilter
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_EnableFrameFilter, %function
DWT_EnableFrameFilter:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movs	r5, #4
	sub	sp, sp, #20
	movs	r7, #0
	mov	r6, r0
	mov	r2, r5
	add	r3, sp, #12
	mov	r4, r1
	movs	r0, #1
	add	r1, sp, r5
	strb	r5, [sp, #4]
	str	r7, [sp, #8]
	bl	readfromspi
	mov	r2, r5
	add	r1, sp, #12
	add	r0, sp, #8
	bl	memcpy
	ldr	r2, [sp, #8]
	cbz	r4, .L142
	ldr	r1, .L145
	and	r3, r4, #510
	ands	r1, r1, r2
	orrs	r3, r3, r1
	orr	r3, r3, #1
.L143:
	str	r3, [r6, #20]
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	movs	r4, #132
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L142:
	ldr	r3, .L145+4
	ands	r3, r3, r2
	b	.L143
.L146:
	.align	2
.L145:
	.word	-263717375
	.word	-263716866
	.size	DWT_EnableFrameFilter, .-DWT_EnableFrameFilter
	.section	.text.DWT_SetPanID,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetPanID
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetPanID, %function
DWT_SetPanID:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #2
	sub	sp, sp, #8
	movw	r4, #707
	strh	r0, [sp]	@ movhi
	mov	r3, sp
	add	r1, sp, #4
	mov	r0, r2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	movs	r2, #2
	movw	r4, #579
	add	r3, sp, #4
	mov	r1, sp
	mov	r0, r2
	strh	r4, [sp]	@ movhi
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_SetPanID, .-DWT_SetPanID
	.section	.text.DWT_SetAddr16,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetAddr16
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetAddr16, %function
DWT_SetAddr16:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movs	r4, #131
	movs	r2, #2
	mov	r3, sp
	add	r1, sp, #4
	strh	r0, [sp]	@ movhi
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_SetAddr16, .-DWT_SetAddr16
	.section	.text.dwt_seteui,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_seteui
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_seteui, %function
dwt_seteui:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	mov	r3, r0
	movs	r4, #129
	movs	r2, #8
	add	r1, sp, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_seteui, .-dwt_seteui
	.section	.text.dwt_geteui,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_geteui
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_geteui, %function
dwt_geteui:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movs	r4, #1
	mov	r3, r0
	movs	r2, #8
	add	r1, sp, #4
	mov	r0, r4
	strb	r4, [sp, #4]
	bl	readfromspi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_geteui, .-dwt_geteui
	.section	.text.dwt_otpread,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_otpread
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_otpread, %function
dwt_otpread:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #16
	movs	r5, #54
	mov	r6, r2
	mov	r4, r0
	add	r3, sp, #8
	movs	r2, #2
	mov	r7, r1
	movs	r0, #1
	add	r1, sp, #12
	strb	r5, [sp, #12]
	bl	readfromspi
	ldrb	r5, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	movs	r0, #182
	bic	r5, r5, #3
	add	r3, sp, #8
	add	r1, sp, #12
	strb	r0, [sp, #12]
	orrs	r5, r5, r2
	mov	r0, r2
	strb	r5, [sp, #8]
	mov	r5, #502
	bl	writetospi
	add	r1, sp, #12
	add	r3, sp, #9
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	cmp	r6, #0
	beq	.L156
	uxth	r4, r4
	subs	r7, r7, #4
	add	r8, r4, r6
	uxth	r8, r8
.L157:
	movs	r2, #2
	movw	r5, #1261
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	movw	r6, #1773
	strh	r4, [sp, #8]	@ movhi
	adds	r4, r4, #1
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	mov	ip, #3
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	movs	r5, #0
	movs	r0, #2
	strb	ip, [sp, #8]
	uxth	r4, r4
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	movw	r6, #2669
	strb	r5, [sp, #8]
	bl	writetospi
	movs	r2, #4
	add	r3, sp, #12
	movs	r0, #2
	str	r5, [sp, #8]
	add	r1, sp, r2
	strh	r6, [sp, #4]	@ movhi
	bl	readfromspi
	movs	r2, #4
	add	r1, sp, #12
	add	r0, sp, #8
	bl	memcpy
	ldr	r3, [sp, #8]
	cmp	r8, r4
	str	r3, [r7, #4]!
	bne	.L157
.L156:
	movs	r4, #54
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #2
	movs	r0, #1
	strb	r4, [sp, #12]
	bl	readfromspi
	ldrb	r1, [sp, #9]	@ zero_extendqisi2
	movs	r2, #1
	movs	r5, #0
	bic	r1, r1, #1
	movs	r4, #182
	add	r3, sp, #8
	mov	r0, r2
	strb	r1, [sp, #9]
	add	r1, sp, #12
	strb	r4, [sp, #12]
	mov	r4, #502
	strb	r5, [sp, #8]
	bl	writetospi
	add	r3, sp, #9
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
	.size	dwt_otpread, .-dwt_otpread
	.section	.text._dwt_otpsetmrregs,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	_dwt_otpsetmrregs
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	_dwt_otpsetmrregs, %function
_dwt_otpsetmrregs:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #36
	and	r5, r0, #15
	movs	r4, #3
	movw	r7, 2029	@ movhi
	add	r3, sp, #16
	add	r1, sp, #28
	movs	r2, #1
	movs	r0, #2
	strb	r4, [sp, #16]
	strh	r7, [sp, #28]	@ movhi
	bl	writetospi
	cmp	r5, #5
	ble	.L186
	mov	r0, #-1
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L186:
	ldr	r2, .L188
	mov	r10, #173
	ldr	lr, .L188+8
	add	r3, sp, #16
	ldrh	r8, [r2, r5, lsl #2]
	movs	r2, #2
	ldr	ip, .L188+12
	add	r1, sp, #28
	ldr	r7, [lr, r5, lsl #2]
	movs	r0, #1
	strh	r8, [sp, #16]	@ movhi
	mov	r4, r2
	ldrh	ip, [ip, r5, lsl #2]
	movw	r6, #1773
	str	r7, [sp]
	mov	r9, #8
	str	ip, [sp, #4]
	movw	r7, 2029	@ movhi
	strb	r10, [sp, #28]
	bl	writetospi
	movs	r2, #1
	add	r3, sp, #16
	add	r1, sp, #28
	mov	r0, r4
	mov	r8, r2
	strb	r9, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strh	r7, [sp, #28]	@ movhi
	mov	fp, #0
	strb	r4, [sp, #16]
	bl	writetospi
	mvn	ip, #119
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	ip, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	mvn	lr, #127
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	lr, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	fp, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	mov	ip, #5
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	ip, [sp, #16]
	strh	r7, [sp, #28]	@ movhi
	bl	writetospi
	ldr	r7, [sp]
	mov	r2, r4
	add	r3, sp, #16
	add	r1, sp, #28
	mov	r0, r8
	strb	r7, [sp, #16]
	strb	fp, [sp, #17]
	movw	r7, 2029	@ movhi
	strb	r10, [sp, #28]
	bl	writetospi
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	r9, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	mov	ip, #4
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strh	r7, [sp, #28]	@ movhi
	strb	ip, [sp, #16]
	bl	writetospi
	mvn	ip, #119
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	ip, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	mvn	lr, #127
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	lr, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	add	r3, sp, #16
	mov	r2, r8
	add	r1, sp, #28
	mov	r0, r4
	strb	fp, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	mov	r2, r8
	add	r3, sp, #16
	add	r1, sp, #28
	mov	r0, r4
	strh	r7, [sp, #28]	@ movhi
	strb	r8, [sp, #16]
	bl	writetospi
	ldr	r7, [sp, #4]
	mov	r2, r4
	add	r3, sp, #16
	add	r1, sp, #28
	ldr	fp, .L188+16
	mov	r0, r8
	strh	r7, [sp, #16]	@ movhi
	strb	r10, [sp, #28]
	bl	writetospi
	mov	r2, r8
	add	r3, sp, #16
	mov	r0, r4
	add	r1, sp, #28
	strb	r9, [sp, #16]
	strh	r6, [sp, #28]	@ movhi
	bl	writetospi
	ldr	r3, [fp]
	ldr	r2, .L188+4
	add	r3, r3, r3, lsl #2
	lsl	r3, r3, r8
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #28]
	ldr	r3, [sp, #28]
	subs	r2, r3, #1
	str	r2, [sp, #28]
	cbz	r3, .L165
.L166:
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
	bne	.L166
.L165:
	movs	r2, #1
	movs	r0, #2
	mov	ip, #0
	movw	r6, #2029
	mov	r4, r2
	mov	r8, r0
	add	r3, sp, #16
	add	r1, sp, #24
	strb	ip, [sp, #16]
	strh	r6, [sp, #24]	@ movhi
	bl	writetospi
	movw	ip, #1773
	add	r1, sp, #24
	mov	r2, r4
	add	r3, sp, #16
	mov	r0, r8
	strh	ip, [sp, #24]	@ movhi
	strb	r4, [sp, #16]
	bl	writetospi
	mov	r2, r4
	add	r1, sp, #24
	add	r3, sp, #16
	mov	r0, r8
	strh	r6, [sp, #24]	@ movhi
	strb	r8, [sp, #16]
	bl	writetospi
	mov	ip, #4
	mov	r2, r4
	add	r1, sp, #24
	add	r3, sp, #16
	mov	r0, r8
	strh	r6, [sp, #24]	@ movhi
	strb	ip, [sp, #16]
	bl	writetospi
	ldr	r1, [fp]
	movs	r3, #100
	ldr	r2, .L188+4
	mul	r3, r3, r1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #24]
	ldr	r3, [sp, #24]
	subs	r2, r3, #1
	str	r2, [sp, #24]
	cbz	r3, .L167
.L168:
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
	bne	.L168
.L167:
	movw	r6, #2029
	movs	r4, #0
	add	r3, sp, #16
	add	r1, sp, #20
	movs	r2, #1
	strh	r6, [sp, #20]	@ movhi
	movs	r0, #2
	movw	r6, #1773
	strb	r4, [sp, #16]
	bl	writetospi
	add	r3, sp, #16
	movs	r2, #1
	add	r1, sp, #20
	movs	r0, #2
	strb	r4, [sp, #16]
	strh	r6, [sp, #20]	@ movhi
	bl	writetospi
	ldr	r3, [fp]
	ldr	r2, .L188+4
	add	r3, r3, r3, lsl #2
	lsls	r3, r3, #1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #20]
	ldr	r3, [sp, #20]
	subs	r2, r3, #1
	str	r2, [sp, #20]
	cbz	r3, .L169
.L170:
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
	bne	.L170
.L169:
	subs	r5, r5, #1
	cmp	r5, #1
	bls	.L187
	movs	r0, #0
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L187:
	movw	r4, #2157
	add	r3, sp, #12
	movs	r2, #1
	add	r1, sp, #8
	movs	r0, #2
	strh	r4, [sp, #8]	@ movhi
	bl	readfromspi
	movs	r0, #0
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L189:
	.align	2
.L188:
	.word	.LANCHOR0
	.word	-776530087
	.word	.LANCHOR1
	.word	.LANCHOR2
	.word	SystemCoreClock
	.size	_dwt_otpsetmrregs, .-_dwt_otpsetmrregs
	.section	.text.dwt_otpwriteandverify,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_otpwriteandverify
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_otpwriteandverify, %function
dwt_otpwriteandverify:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #68
	movs	r4, #54
	movs	r2, #2
	movs	r5, #182
	str	r0, [sp, #12]
	add	r3, sp, #56
	str	r1, [sp, #4]
	movs	r0, #1
	add	r1, sp, #60
	strb	r4, [sp, #60]
	bl	readfromspi
	ldrb	r4, [sp, #56]	@ zero_extendqisi2
	movs	r2, #1
	add	r3, sp, #56
	bic	r4, r4, #3
	add	r1, sp, #60
	mov	r0, r2
	movw	r6, #2029
	orrs	r4, r4, r2
	strb	r5, [sp, #60]
	mov	r9, #173
	movw	r7, #37408
	strb	r4, [sp, #56]
	mov	r4, #502
	bl	writetospi
	add	r1, sp, #60
	add	r3, sp, #57
	movs	r2, #1
	strh	r4, [sp, #60]	@ movhi
	movs	r0, #2
	movs	r4, #3
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	movs	r2, #1
	movs	r0, #2
	strb	r4, [sp, #60]
	movw	r5, #1773
	strh	r6, [sp, #56]	@ movhi
	bl	writetospi
	movs	r2, #2
	mov	r8, #8
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r4, r2
	movs	r0, #1
	strh	r7, [sp, #60]	@ movhi
	mov	fp, #136
	strb	r9, [sp, #56]
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	movs	r2, #1
	mov	r0, r4
	strb	r8, [sp, #60]
	mov	r10, #128
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	movs	r2, #1
	mov	r0, r4
	strh	r6, [sp, #56]	@ movhi
	strb	r4, [sp, #60]
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	movs	r2, #1
	mov	r0, r4
	strh	r5, [sp, #56]	@ movhi
	strb	fp, [sp, #60]
	bl	writetospi
	movs	r2, #1
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r4
	mov	r7, r2
	strh	r5, [sp, #56]	@ movhi
	strb	r10, [sp, #60]
	bl	writetospi
	mov	ip, #0
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strb	ip, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mov	ip, #5
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strh	r6, [sp, #56]	@ movhi
	strb	ip, [sp, #60]
	bl	writetospi
	mov	ip, #14
	add	r3, sp, #60
	mov	r2, r4
	add	r1, sp, #56
	mov	r0, r7
	strh	ip, [sp, #60]	@ movhi
	strb	r9, [sp, #56]
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strb	r8, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mov	ip, #4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strb	ip, [sp, #60]
	strh	r6, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strb	fp, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strb	r10, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mov	ip, #0
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strb	ip, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r2, r7
	mov	r0, r4
	strh	r6, [sp, #56]	@ movhi
	strb	r7, [sp, #60]
	bl	writetospi
	movw	ip, #4132
	add	r3, sp, #60
	mov	r2, r4
	add	r1, sp, #56
	mov	r0, r7
	ldr	r6, .L241
	strh	ip, [sp, #60]	@ movhi
	strb	r9, [sp, #56]
	bl	writetospi
	mov	r2, r7
	add	r3, sp, #60
	mov	r0, r4
	add	r1, sp, #56
	strb	r8, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	ldr	r3, [r6]
	ldr	r2, .L241+4
	add	r3, r3, r3, lsl #2
	lsls	r3, r3, r7
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #20]
	ldr	r3, [sp, #20]
	subs	r2, r3, #1
	str	r2, [sp, #20]
	cbz	r3, .L194
.L191:
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
	bne	.L191
.L194:
	movs	r2, #1
	movs	r7, #0
	movs	r0, #2
	movw	r5, #2029
	mov	r4, r2
	add	r3, sp, #60
	add	r1, sp, #56
	strb	r7, [sp, #60]
	mov	r7, r0
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	movw	ip, #1773
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r7
	strh	ip, [sp, #56]	@ movhi
	strb	r4, [sp, #60]
	bl	writetospi
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r7
	strh	r5, [sp, #56]	@ movhi
	strb	r7, [sp, #60]
	bl	writetospi
	mov	ip, #4
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r7
	strh	r5, [sp, #56]	@ movhi
	strb	ip, [sp, #60]
	bl	writetospi
	ldr	r1, [r6]
	movs	r3, #100
	ldr	r2, .L241+4
	mul	r3, r3, r1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #24]
	ldr	r3, [sp, #24]
	subs	r2, r3, #1
	str	r2, [sp, #24]
	cbz	r3, .L193
.L192:
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
	bne	.L192
.L193:
	movw	r5, #2029
	movs	r4, #0
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	strh	r5, [sp, #56]	@ movhi
	movs	r0, #2
	movw	r5, #1773
	strb	r4, [sp, #60]
	bl	writetospi
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	movs	r0, #2
	strb	r4, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	ldr	r3, [r6]
	ldr	r2, .L241+4
	add	r3, r3, r3, lsl #2
	lsls	r3, r3, #1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #28]
	ldr	r3, [sp, #28]
	subs	r2, r3, #1
	str	r2, [sp, #28]
	cbz	r3, .L196
.L195:
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
	bne	.L195
.L196:
	movw	r8, #2157
	add	r3, sp, #56
	movs	r2, #1
	add	r1, sp, #52
	movs	r0, #2
	strh	r8, [sp, #52]	@ movhi
	bl	readfromspi
	ldr	r3, [sp, #4]
	movs	r4, #5
	ldr	r9, .L241+4
	uxtb	r10, r3
	ubfx	fp, r3, #8, #3
	str	r10, [sp, #8]
	ldr	r10, [sp, #12]
.L197:
	add	r3, sp, #52
	movs	r2, #1
	add	r1, sp, #60
	movs	r0, #2
	strh	r8, [sp, #60]	@ movhi
	bl	readfromspi
	ldrb	r3, [sp, #52]	@ zero_extendqisi2
	lsls	r2, r3, #30
	bpl	.L198
	movs	r5, #173
	add	r3, sp, #60
	movs	r2, #4
	add	r1, sp, #56
	movw	r7, #1261
	movs	r0, #1
	strb	r5, [sp, #56]
	str	r10, [sp, #60]
	bl	writetospi
	movs	r2, #2
	ldr	r5, [sp, #8]
	strh	r7, [sp, #56]	@ movhi
	movs	r7, #64
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r2
	strb	r5, [sp, #60]
	movw	r5, #1773
	strb	fp, [sp, #61]
	bl	writetospi
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	strb	r7, [sp, #60]
	movs	r0, #2
	movs	r7, #0
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	movs	r0, #2
	strh	r5, [sp, #56]	@ movhi
	strb	r7, [sp, #60]
	bl	writetospi
.L199:
	ldr	r3, [r6]
	umull	r2, r3, r9, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #32]
	ldr	r3, [sp, #32]
	subs	r2, r3, #1
	str	r2, [sp, #32]
	cbz	r3, .L201
.L200:
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
	bne	.L200
.L201:
	add	r3, sp, #52
	movs	r2, #1
	add	r1, sp, #56
	movs	r0, #2
	strh	r8, [sp, #56]	@ movhi
	bl	readfromspi
	ldrb	r3, [sp, #52]	@ zero_extendqisi2
	lsls	r3, r3, #31
	bpl	.L199
.L198:
	movw	r5, #1261
	movs	r2, #2
	ldr	r7, [sp, #4]
	add	r3, sp, #56
	strh	r5, [sp, #60]	@ movhi
	movs	r5, #3
	add	r1, sp, #60
	mov	r0, r2
	strh	r7, [sp, #56]	@ movhi
	movw	r7, #1773
	bl	writetospi
	add	r3, sp, #56
	movs	r2, #1
	add	r1, sp, #60
	strb	r5, [sp, #56]
	movs	r0, #2
	movs	r5, #0
	strh	r7, [sp, #60]	@ movhi
	bl	writetospi
	add	r3, sp, #56
	movs	r2, #1
	add	r1, sp, #60
	strh	r7, [sp, #60]	@ movhi
	movs	r0, #2
	movw	r7, #2669
	strb	r5, [sp, #56]
	bl	writetospi
	add	r3, sp, #60
	movs	r2, #4
	add	r1, sp, #52
	movs	r0, #2
	str	r5, [sp, #56]
	strh	r7, [sp, #52]	@ movhi
	bl	readfromspi
	movs	r2, #4
	add	r1, sp, #60
	add	r0, sp, #56
	bl	memcpy
	ldr	r3, [sp, #56]
	cmp	r10, r3
	beq	.L202
	subs	r4, r4, #1
	bne	.L197
	b	.L242
.L243:
	.align	2
.L241:
	.word	SystemCoreClock
	.word	-776530087
.L242:
.L202:
	mov	r4, #3
	movw	r7, #2029
	mov	r9, #0
	mov	fp, #173
	strb	r4, [sp, #60]
	movs	r4, #2
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	movs	r0, #2
	movw	r5, #1773
	mov	r10, #8
	strh	r7, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	mov	r2, r4
	add	r1, sp, #56
	movs	r0, #1
	strh	r9, [sp, #60]	@ movhi
	strb	fp, [sp, #56]
	bl	writetospi
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	mov	r0, r4
	strb	r10, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	movs	r2, #1
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r4
	mov	r8, r2
	strh	r7, [sp, #56]	@ movhi
	strb	r4, [sp, #60]
	bl	writetospi
	mvn	ip, #119
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	ip, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mvn	lr, #127
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	lr, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	r9, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mov	ip, #5
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	ip, [sp, #60]
	strh	r7, [sp, #56]	@ movhi
	bl	writetospi
	mov	ip, #3	@ movhi
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r8
	strh	ip, [sp, #60]	@ movhi
	strb	fp, [sp, #56]
	bl	writetospi
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	r10, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mov	ip, #4
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	ip, [sp, #60]
	strh	r7, [sp, #56]	@ movhi
	bl	writetospi
	mvn	ip, #119
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	ip, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mvn	lr, #127
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	lr, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	add	r3, sp, #60
	mov	r2, r8
	add	r1, sp, #56
	mov	r0, r4
	strb	r9, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	mov	r2, r8
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r4
	strh	r7, [sp, #56]	@ movhi
	strb	r8, [sp, #60]
	bl	writetospi
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r8
	strh	r9, [sp, #60]	@ movhi
	strb	fp, [sp, #56]
	bl	writetospi
	mov	r2, r8
	add	r3, sp, #60
	mov	r0, r4
	add	r1, sp, #56
	strb	r10, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	ldr	r3, [r6]
	ldr	r2, .L244
	add	r3, r3, r3, lsl #2
	lsl	r3, r3, r8
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #36]
	ldr	r3, [sp, #36]
	subs	r2, r3, #1
	str	r2, [sp, #36]
	cbz	r3, .L206
.L203:
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
	bne	.L203
.L206:
	movs	r2, #1
	movs	r7, #0
	movs	r0, #2
	movw	r5, #2029
	mov	r4, r2
	add	r3, sp, #60
	add	r1, sp, #56
	strb	r7, [sp, #60]
	mov	r7, r0
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	movw	ip, #1773
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r7
	strh	ip, [sp, #56]	@ movhi
	strb	r4, [sp, #60]
	bl	writetospi
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r7
	strh	r5, [sp, #56]	@ movhi
	strb	r7, [sp, #60]
	bl	writetospi
	mov	ip, #4
	mov	r2, r4
	add	r3, sp, #60
	add	r1, sp, #56
	mov	r0, r7
	strh	r5, [sp, #56]	@ movhi
	strb	ip, [sp, #60]
	bl	writetospi
	ldr	r1, [r6]
	movs	r3, #100
	ldr	r2, .L244
	mul	r3, r3, r1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #40]
	ldr	r3, [sp, #40]
	subs	r2, r3, #1
	str	r2, [sp, #40]
	cbz	r3, .L205
.L204:
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
	bne	.L204
.L205:
	movw	r5, #2029
	movs	r4, #0
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	strh	r5, [sp, #56]	@ movhi
	movs	r0, #2
	movw	r5, #1773
	strb	r4, [sp, #60]
	bl	writetospi
	add	r3, sp, #60
	movs	r2, #1
	add	r1, sp, #56
	movs	r0, #2
	strb	r4, [sp, #60]
	strh	r5, [sp, #56]	@ movhi
	bl	writetospi
	ldr	r3, [r6]
	ldr	r2, .L244
	add	r3, r3, r3, lsl #2
	lsls	r3, r3, #1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #44]
	ldr	r3, [sp, #44]
	subs	r2, r3, #1
	str	r2, [sp, #44]
	cbz	r3, .L208
.L207:
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
	bne	.L207
.L208:
	ldr	r0, [sp, #4]
	movs	r4, #3
	bl	dwt_OtpRead
	ldr	r3, [sp, #12]
	movw	r8, #2029
	strb	r4, [sp, #48]
	subs	r3, r0, r3
	mov	r4, #2
	mov	r7, #0
	mov	fp, #173
	it	ne
	movne	r3, #-1
	movs	r2, #1
	add	r1, sp, #60
	movs	r0, #2
	str	r3, [sp, #4]
	add	r3, sp, #48
	movw	r5, #1773
	mov	r10, #8
	strh	r8, [sp, #60]	@ movhi
	bl	writetospi
	add	r3, sp, #48
	mov	r2, r4
	add	r1, sp, #60
	movs	r0, #1
	strh	r7, [sp, #48]	@ movhi
	strb	fp, [sp, #60]
	bl	writetospi
	add	r3, sp, #48
	movs	r2, #1
	add	r1, sp, #60
	mov	r0, r4
	strb	r10, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	movs	r2, #1
	add	r3, sp, #48
	add	r1, sp, #60
	mov	r0, r4
	mov	r9, r2
	strh	r8, [sp, #60]	@ movhi
	strb	r4, [sp, #48]
	bl	writetospi
	mvn	ip, #119
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	ip, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	mvn	lr, #127
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	lr, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	r7, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	mov	ip, #5
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	ip, [sp, #48]
	strh	r8, [sp, #60]	@ movhi
	bl	writetospi
	add	r3, sp, #48
	mov	r2, r4
	add	r1, sp, #60
	mov	r0, r9
	strh	r7, [sp, #48]	@ movhi
	strb	fp, [sp, #60]
	bl	writetospi
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	r10, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	mov	ip, #4
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	ip, [sp, #48]
	strh	r8, [sp, #60]	@ movhi
	bl	writetospi
	mvn	ip, #119
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	ip, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	mvn	lr, #127
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	lr, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strb	r7, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	add	r3, sp, #48
	mov	r2, r9
	add	r1, sp, #60
	mov	r0, r4
	strh	r8, [sp, #60]	@ movhi
	strb	r9, [sp, #48]
	bl	writetospi
	add	r3, sp, #48
	mov	r2, r4
	add	r1, sp, #60
	mov	r0, r9
	strh	r7, [sp, #48]	@ movhi
	strb	fp, [sp, #60]
	bl	writetospi
	mov	r2, r9
	add	r3, sp, #48
	mov	r0, r4
	add	r1, sp, #60
	strb	r10, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	ldr	r3, [r6]
	ldr	r2, .L244
	add	r3, r3, r3, lsl #2
	lsl	r3, r3, r9
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #52]
	ldr	r3, [sp, #52]
	subs	r2, r3, #1
	str	r2, [sp, #52]
	cbz	r3, .L210
.L209:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #52]
	subs	r2, r3, #1
	str	r2, [sp, #52]
	cmp	r3, #0
	bne	.L209
	b	.L245
.L246:
	.align	2
.L244:
	.word	-776530087
.L245:
.L210:
	movs	r2, #1
	movs	r7, #0
	movs	r0, #2
	movw	r5, #2029
	mov	r4, r2
	add	r3, sp, #48
	add	r1, sp, #60
	strb	r7, [sp, #48]
	mov	r7, r0
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	movw	ip, #1773
	mov	r2, r4
	add	r3, sp, #48
	add	r1, sp, #60
	mov	r0, r7
	strh	ip, [sp, #60]	@ movhi
	strb	r4, [sp, #48]
	bl	writetospi
	mov	r2, r4
	add	r3, sp, #48
	add	r1, sp, #60
	mov	r0, r7
	strh	r5, [sp, #60]	@ movhi
	strb	r7, [sp, #48]
	bl	writetospi
	mov	ip, #4
	mov	r2, r4
	add	r3, sp, #48
	add	r1, sp, #60
	mov	r0, r7
	strh	r5, [sp, #60]	@ movhi
	strb	ip, [sp, #48]
	bl	writetospi
	ldr	r1, [r6]
	movs	r3, #100
	ldr	r2, .L247
	mul	r3, r3, r1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #56]
	ldr	r3, [sp, #56]
	subs	r2, r3, #1
	str	r2, [sp, #56]
	cbz	r3, .L212
.L211:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #56]
	subs	r2, r3, #1
	str	r2, [sp, #56]
	cmp	r3, #0
	bne	.L211
.L212:
	movw	r5, #2029
	movs	r4, #0
	add	r3, sp, #48
	movs	r2, #1
	add	r1, sp, #60
	strh	r5, [sp, #60]	@ movhi
	movs	r0, #2
	movw	r5, #1773
	strb	r4, [sp, #48]
	bl	writetospi
	add	r3, sp, #48
	movs	r2, #1
	add	r1, sp, #60
	movs	r0, #2
	strb	r4, [sp, #48]
	strh	r5, [sp, #60]	@ movhi
	bl	writetospi
	ldr	r3, [r6]
	ldr	r2, .L247
	add	r3, r3, r3, lsl #2
	lsls	r3, r3, #1
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #60]
	ldr	r3, [sp, #60]
	subs	r2, r3, #1
	str	r2, [sp, #60]
	cbz	r3, .L190
.L213:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #60]
	subs	r2, r3, #1
	str	r2, [sp, #60]
	cmp	r3, #0
	bne	.L213
.L190:
	ldr	r0, [sp, #4]
	add	sp, sp, #68
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L248:
	.align	2
.L247:
	.word	-776530087
	.size	dwt_otpwriteandverify, .-dwt_otpwriteandverify
	.section	.text.dwt_entersleep,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_entersleep
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_entersleep, %function
dwt_entersleep:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movs	r4, #0
	sub	sp, sp, #12
	mov	r5, #748
	movs	r2, #1
	add	r3, sp, #3
	add	r1, sp, #4
	strb	r4, [sp, #3]
	movs	r0, #2
	movs	r4, #2
	strh	r5, [sp, #4]	@ movhi
	bl	writetospi
	add	r3, sp, #3
	add	r1, sp, #4
	movs	r2, #1
	mov	r0, r4
	strh	r5, [sp, #4]	@ movhi
	strb	r4, [sp, #3]
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	dwt_entersleep, .-dwt_entersleep
	.section	.text.DWT_Configsleepcnt,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_Configsleepcnt
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_Configsleepcnt, %function
DWT_Configsleepcnt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #20
	mov	r10, #54
	movs	r2, #2
	mov	r9, #182
	str	r0, [sp, #4]
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r0, #1
	strb	r10, [sp, #12]
	bl	readfromspi
	ldrb	r4, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	add	r3, sp, #8
	add	r1, sp, #12
	bic	r4, r4, #3
	mov	r8, #502
	mov	r0, r2
	movs	r5, #0
	orrs	r4, r4, r2
	strb	r9, [sp, #12]
	movw	fp, #2796
	mov	r6, #748
	strb	r4, [sp, #8]
	bl	writetospi
	movw	r4, #1772
	add	r1, sp, #12
	add	r3, sp, #9
	movs	r2, #1
	movs	r0, #2
	strh	r8, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	strb	r5, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strb	r5, [sp, #8]
	movs	r7, #4
	strh	fp, [sp, #12]	@ movhi
	bl	writetospi
	movs	r2, #1
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r0, #2
	mov	r4, r2
	strh	r6, [sp, #12]	@ movhi
	strb	r7, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r2, r4
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	strb	r5, [sp, #8]
	bl	writetospi
	ldr	r0, [sp, #4]
	movs	r2, #2
	movw	ip, #2284
	add	r3, sp, #8
	add	r1, sp, #12
	strh	r0, [sp, #8]	@ movhi
	mov	r0, r2
	strh	ip, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r2, r4
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	strb	r7, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r2, r4
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	strb	r5, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r2, r4
	movs	r0, #2
	strh	fp, [sp, #12]	@ movhi
	strb	r4, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	mov	r2, r4
	add	r1, sp, #12
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	strb	r7, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	mov	r2, r4
	add	r1, sp, #12
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	strb	r5, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r4
	movs	r2, #2
	strb	r10, [sp, #12]
	bl	readfromspi
	ldrb	r6, [sp, #9]	@ zero_extendqisi2
	add	r3, sp, #8
	mov	r2, r4
	add	r1, sp, #12
	bic	r6, r6, #1
	mov	r0, r4
	strb	r5, [sp, #8]
	strb	r9, [sp, #12]
	strb	r6, [sp, #9]
	bl	writetospi
	add	r3, sp, #9
	mov	r2, r4
	add	r1, sp, #12
	movs	r0, #2
	strh	r8, [sp, #12]	@ movhi
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	DWT_Configsleepcnt, .-DWT_Configsleepcnt
	.section	.text.dwt_calibratesleepcnt,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_calibratesleepcnt
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_calibratesleepcnt, %function
dwt_calibratesleepcnt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	sub	sp, sp, #20
	movs	r6, #4
	movw	r7, #2796
	mov	r4, #748
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	movs	r5, #0
	strb	r6, [sp, #8]
	strh	r7, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	strb	r6, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	strb	r5, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strb	r5, [sp, #8]
	strh	r7, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	strb	r6, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	strh	r4, [sp, #12]	@ movhi
	movs	r0, #2
	movs	r4, #54
	strb	r5, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #2
	movs	r0, #1
	strb	r4, [sp, #12]
	bl	readfromspi
	ldrb	r4, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	movs	r5, #182
	add	r3, sp, #8
	bic	r4, r4, #3
	add	r1, sp, #12
	mov	r0, r2
	strb	r5, [sp, #12]
	orrs	r4, r4, r2
	strb	r4, [sp, #8]
	mov	r4, #502
	bl	writetospi
	add	r3, sp, #9
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r3, .L261
	ldr	r2, .L261+4
	ldr	r3, [r3]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #12]
	ldr	r3, [sp, #12]
	subs	r2, r3, #1
	str	r2, [sp, #12]
	cbz	r3, .L254
.L255:
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
	bne	.L255
.L254:
	movw	r9, #1260
	movs	r4, #118
	mov	r5, #748
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r6, #128
	movs	r2, #1
	movs	r0, #2
	strb	r4, [sp, #4]
	mov	r8, #136
	strh	r9, [sp, #8]	@ movhi
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #1
	movs	r0, #2
	strb	r6, [sp, #4]
	mov	r7, #876
	strh	r5, [sp, #8]	@ movhi
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #8]	@ movhi
	strb	r8, [sp, #4]
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #1
	movs	r0, #2
	strh	r7, [sp, #8]	@ movhi
	bl	readfromspi
	mov	ip, #117
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #1
	movs	r0, #2
	ldrb	r4, [sp, #4]	@ zero_extendqisi2
	strh	r9, [sp, #8]	@ movhi
	strb	ip, [sp, #4]
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #1
	movs	r0, #2
	strb	r6, [sp, #4]
	movs	r6, #0
	strh	r5, [sp, #8]	@ movhi
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #8]	@ movhi
	lsls	r4, r4, #8
	strb	r8, [sp, #4]
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #1
	movs	r0, #2
	strh	r7, [sp, #8]	@ movhi
	bl	readfromspi
	add	r3, sp, #4
	add	r1, sp, #8
	strh	r5, [sp, #8]	@ movhi
	movs	r2, #1
	movs	r5, #54
	movs	r0, #2
	ldrb	r7, [sp, #4]	@ zero_extendqisi2
	strb	r6, [sp, #4]
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #8
	movs	r2, #2
	movs	r0, #1
	strb	r5, [sp, #8]
	bl	readfromspi
	ldrb	r5, [sp, #5]	@ zero_extendqisi2
	movs	r2, #1
	orrs	r4, r4, r7
	movs	r7, #182
	bic	r5, r5, #1
	add	r3, sp, #4
	add	r1, sp, #8
	mov	r0, r2
	strb	r5, [sp, #5]
	mov	r5, #502
	strb	r6, [sp, #4]
	strb	r7, [sp, #8]
	bl	writetospi
	add	r1, sp, #8
	add	r3, sp, #5
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #8]	@ movhi
	bl	writetospi
	mov	r0, r4
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L262:
	.align	2
.L261:
	.word	SystemCoreClock
	.word	-776530087
	.size	dwt_calibratesleepcnt, .-dwt_calibratesleepcnt
	.section	.text.DWT_Configsleep,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_Configsleep
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_Configsleep, %function
DWT_Configsleep:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	ldrh	r0, [r0, #24]
	push	{r4, r5, lr}
	orrs	r0, r0, r1
	sub	sp, sp, #12
	movs	r4, #172
	mov	r5, r2
	mov	r3, sp
	add	r1, sp, #4
	strh	r0, [sp]	@ movhi
	movs	r2, #2
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	movw	r4, #1772
	mov	r3, sp
	add	r1, sp, #4
	movs	r2, #1
	movs	r0, #2
	strb	r5, [sp]
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_Configsleep, .-DWT_Configsleep
	.section	.text.dwt_entersleepaftertx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_entersleepaftertx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_entersleepaftertx, %function
dwt_entersleepaftertx:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movs	r2, #0
	sub	sp, sp, #20
	movw	r5, #1142
	mov	r4, r0
	add	r3, sp, #12
	add	r1, sp, #4
	str	r2, [sp, #8]
	movs	r0, #2
	movs	r2, #4
	strh	r5, [sp, #4]	@ movhi
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	cbz	r4, .L266
	orr	r3, r3, #2048
.L267:
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	movw	r4, #1270
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L266:
	bic	r3, r3, #2048
	b	.L267
	.size	dwt_entersleepaftertx, .-dwt_entersleepaftertx
	.section	.text.dwt_spicswakeup,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_spicswakeup
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_spicswakeup, %function
dwt_spicswakeup:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r2, #4
	sub	sp, sp, #16
	movs	r4, #0
	mov	r6, r0
	add	r3, sp, #12
	mov	r5, r1
	movs	r0, #1
	add	r1, sp, r2
	str	r4, [sp, #8]
	strb	r4, [sp, #4]
	bl	readfromspi
	movs	r2, #4
	add	r1, sp, #12
	add	r0, sp, #8
	bl	memcpy
	ldr	r2, [sp, #8]
	ldr	r3, .L279
	cmp	r2, r3
	beq	.L273
	mov	r3, r6
	mov	r2, r5
	add	r1, sp, #12
	movs	r0, #1
	strb	r4, [sp, #12]
	bl	readfromspi
	ldr	r3, .L279+4
	ldr	r2, .L279+8
	ldr	r3, [r3]
	add	r3, r3, r3, lsl #2
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #4]
	ldr	r3, [sp, #4]
	subs	r2, r3, #1
	str	r2, [sp, #4]
	cbz	r3, .L271
.L272:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #4]
	subs	r2, r3, #1
	str	r2, [sp, #4]
	cmp	r3, #0
	bne	.L272
.L271:
	movs	r4, #0
	add	r3, sp, #12
	mov	r1, sp
	movs	r2, #4
	movs	r0, #1
	str	r4, [sp, #8]
	strb	r4, [sp]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	ldr	r4, .L279
	bl	memcpy
	ldr	r0, [sp, #8]
	subs	r0, r0, r4
	it	ne
	movne	r0, #-1
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
.L273:
	mov	r0, r4
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
.L280:
	.align	2
.L279:
	.word	-557186768
	.word	SystemCoreClock
	.word	-776530087
	.size	dwt_spicswakeup, .-dwt_spicswakeup
	.section	.text.dwt_loadopsettabfromotp,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_loadopsettabfromotp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_loadopsettabfromotp, %function
dwt_loadopsettabfromotp:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #8
	mov	r8, #54
	mov	r4, r0
	movs	r2, #2
	mov	r3, sp
	add	r1, sp, #4
	movs	r0, #1
	strb	r8, [sp, #4]
	bl	readfromspi
	movs	r2, #1
	movs	r6, #182
	movw	r7, #769
	lsls	r4, r4, #5
	mov	r3, sp
	add	r1, sp, #4
	mov	r5, #502
	mov	r0, r2
	strh	r7, [sp]	@ movhi
	strb	r6, [sp, #4]
	and	r4, r4, #96
	bl	writetospi
	add	r1, sp, #4
	add	r3, sp, #1
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #4]	@ movhi
	bl	writetospi
	movs	r2, #2
	movw	ip, #4845
	movs	r7, #0
	orr	r4, r4, #1
	mov	r3, sp
	add	r1, sp, #4
	mov	r0, r2
	strh	ip, [sp, #4]	@ movhi
	strb	r4, [sp]
	strb	r7, [sp, #1]
	bl	writetospi
	mov	r3, sp
	add	r1, sp, #4
	movs	r2, #2
	movs	r0, #1
	strb	r8, [sp, #4]
	bl	readfromspi
	ldrb	r4, [sp, #1]	@ zero_extendqisi2
	movs	r2, #1
	mov	r3, sp
	add	r1, sp, #4
	bic	r4, r4, #1
	mov	r0, r2
	strb	r7, [sp]
	strb	r6, [sp, #4]
	strb	r4, [sp, #1]
	bl	writetospi
	add	r3, sp, #1
	add	r1, sp, #4
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
	.size	dwt_loadopsettabfromotp, .-dwt_loadopsettabfromotp
	.section	.text.DWT_SetSmartTxPower,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetSmartTxPower
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetSmartTxPower, %function
DWT_SetSmartTxPower:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movs	r4, #4
	sub	sp, sp, #20
	movs	r7, #0
	mov	r5, r0
	add	r3, sp, #12
	mov	r2, r4
	mov	r6, r1
	movs	r0, #1
	add	r1, sp, r4
	strb	r4, [sp, #4]
	str	r7, [sp, #8]
	bl	readfromspi
	mov	r2, r4
	add	r1, sp, #12
	add	r0, sp, #8
	bl	memcpy
	ldr	r3, [sp, #8]
	cbz	r6, .L284
	bic	r3, r3, #262144
.L285:
	str	r3, [r5, #20]
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	movs	r4, #132
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L284:
	orr	r3, r3, #262144
	b	.L285
	.size	DWT_SetSmartTxPower, .-DWT_SetSmartTxPower
	.section	.text.dwt_enableautoack,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_enableautoack
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_enableautoack, %function
dwt_enableautoack:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #20
	mov	r4, r0
	movw	r5, #986
	movs	r2, #1
	strb	r1, [sp, #8]
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r3, [r4, #20]
	add	r1, sp, #8
	add	r0, sp, #12
	movs	r2, #4
	orr	r3, r3, #1073741824
	str	r3, [r4, #20]
	movs	r4, #132
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	add	r3, sp, #12
	movs	r0, #1
	strb	r4, [sp, #4]
	add	r1, sp, r2
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
	.size	dwt_enableautoack, .-dwt_enableautoack
	.section	.text.dwt_setdblrxbuffmode,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_setdblrxbuffmode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_setdblrxbuffmode, %function
dwt_setdblrxbuffmode:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r3, [r0, #20]
	sub	sp, sp, #16
	cbz	r1, .L290
	bic	r3, r3, #4096
	movs	r1, #1
.L291:
	strb	r1, [r0, #17]
	movs	r2, #4
	str	r3, [r0, #20]
	add	r1, sp, #8
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movs	r4, #132
	add	r3, sp, #12
	add	r1, sp, r2
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
.L290:
	orr	r3, r3, #4096
	b	.L291
	.size	dwt_setdblrxbuffmode, .-dwt_setdblrxbuffmode
	.section	.text.dwt_setrxaftertxdelay,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_setrxaftertxdelay
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_setrxaftertxdelay, %function
dwt_setrxaftertxdelay:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movs	r2, #0
	sub	sp, sp, #20
	movs	r5, #26
	mov	r4, r0
	add	r3, sp, #12
	add	r1, sp, #4
	str	r2, [sp, #8]
	movs	r0, #1
	movs	r2, #4
	strb	r5, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r2, [sp, #8]
	ldr	r3, .L295
	ubfx	r4, r4, #0, #20
	add	r1, sp, #8
	add	r0, sp, #12
	ands	r3, r3, r2
	movs	r2, #4
	orrs	r4, r4, r3
	str	r4, [sp, #8]
	bl	memcpy
	movs	r4, #154
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L296:
	.align	2
.L295:
	.word	-1048576
	.size	dwt_setrxaftertxdelay, .-dwt_setrxaftertxdelay
	.section	.text.dwt_setcallbacks,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_setcallbacks
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_setcallbacks, %function
dwt_setcallbacks:
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4}
	ldr	r4, [sp, #4]
	strd	r1, r2, [r0, #36]
	strd	r3, r4, [r0, #44]
	ldr	r4, [sp], #4
	bx	lr
	.size	dwt_setcallbacks, .-dwt_setcallbacks
	.section	.text.dwt_checkirq,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_checkirq
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_checkirq, %function
dwt_checkirq:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	movs	r2, #1
	sub	sp, sp, #8
	movs	r4, #15
	add	r3, sp, #3
	add	r1, sp, #4
	mov	r0, r2
	strb	r4, [sp, #4]
	bl	readfromspi
	ldrb	r0, [sp, #3]	@ zero_extendqisi2
	and	r0, r0, #1
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_checkirq, .-dwt_checkirq
	.section	.text.dwt_lowpowerlistenisr,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_lowpowerlistenisr
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_lowpowerlistenisr, %function
dwt_lowpowerlistenisr:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #20
	movs	r5, #0
	movs	r6, #15
	mov	r4, r0
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r6, [sp, #4]
	movw	r7, #1142
	str	r5, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r6, [sp, #8]
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	str	r6, [r4, #27]	@ unaligned
	movs	r0, #2
	strh	r7, [sp, #4]	@ movhi
	str	r5, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	movw	r7, #1270
	bl	memcpy
	ldr	r3, [sp, #8]
	add	r1, sp, #8
	movs	r2, #4
	bic	r3, r3, #12288
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #2
	strh	r7, [sp, #4]	@ movhi
	bl	writetospi
	movs	r7, #143
	mov	r3, #28416
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	strb	r7, [sp, #4]
	movs	r0, #1
	movs	r7, #16
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #2
	strb	r5, [r4, #35]
	movs	r0, #1
	strb	r7, [sp, #12]
	bl	readfromspi
	ldrb	r1, [sp, #9]	@ zero_extendqisi2
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	ldrb	r2, [r4, #8]	@ zero_extendqisi2
	add	r3, r3, r1, lsl #8
	uxth	r3, r3
	cbz	r2, .L302
	ubfx	r2, r3, #0, #10
.L303:
	strh	r2, [r4, #31]	@ unaligned
	lsls	r2, r3, #16
	bpl	.L304
	ldrb	r3, [r4, #35]	@ zero_extendqisi2
	orr	r3, r3, #1
	strb	r3, [r4, #35]
.L304:
	movs	r5, #17
	add	r3, r4, #33
	movs	r2, #2
	add	r1, sp, #12
	movs	r0, #1
	strb	r5, [sp, #12]
	bl	readfromspi
	lsls	r3, r6, #28
	bpl	.L305
	ldrb	r3, [r4, #33]	@ zero_extendqisi2
	ands	r5, r3, #32
	beq	.L314
.L305:
	ldr	r3, [r4, #40]
	cbz	r3, .L301
	add	r0, r4, #27
	blx	r3
.L301:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L302:
	and	r2, r3, #127
	b	.L303
.L314:
	movs	r3, #8
	movs	r2, #4
	add	r0, sp, #12
	movs	r6, #143
	add	r1, sp, r3
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r6, [sp, #4]
	bl	writetospi
	ldr	r3, [r4, #27]	@ unaligned
	strb	r5, [r4, #26]
	bic	r3, r3, #8
	str	r3, [r4, #27]	@ unaligned
	b	.L305
	.size	dwt_lowpowerlistenisr, .-dwt_lowpowerlistenisr
	.section	.text.DWT_SetLEDs,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetLEDs
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetLEDs, %function
DWT_SetLEDs:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	ands	r2, r0, #1
	push	{r4, r5, r6, lr}
	sub	sp, sp, #16
	beq	.L316
	movs	r5, #0
	movs	r6, #38
	add	r3, sp, #12
	mov	r4, r0
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	str	r5, [sp, #8]
	strb	r6, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	movs	r6, #166
	bl	memcpy
	ldr	r3, [sp, #8]
	add	r1, sp, #8
	movs	r2, #4
	bic	r3, r3, #15360
	add	r0, sp, #12
	orr	r3, r3, #5120
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	strb	r6, [sp, #4]
	movs	r0, #1
	movs	r6, #54
	bl	writetospi
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	str	r5, [sp, #8]
	strb	r6, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	movs	r5, #182
	bl	memcpy
	ldr	r3, [sp, #8]
	add	r1, sp, #8
	movs	r2, #4
	orr	r3, r3, #8650752
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r5, [sp, #4]
	bl	writetospi
	lsls	r3, r4, #30
	bmi	.L317
	mov	r3, #272
	movw	r4, #10486
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
.L322:
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
.L316:
	movs	r0, #38
	add	r3, sp, #12
	add	r1, sp, #4
	str	r2, [sp, #8]
	strb	r0, [sp, #4]
	movs	r2, #4
	movs	r0, #1
	movs	r4, #166
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	add	r1, sp, #8
	add	r0, sp, #12
	bic	r3, r3, #15360
	movs	r2, #4
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
.L317:
	ldr	r3, .L323
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movw	r4, #10486
	add	r3, sp, #12
	movs	r0, #2
	add	r1, sp, r2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	mov	r3, #272
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	b	.L322
.L324:
	.align	2
.L323:
	.word	983312
	.size	DWT_SetLEDs, .-DWT_SetLEDs
	.section	.text._dwt_disablesequencing,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	_dwt_disablesequencing
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	_dwt_disablesequencing, %function
_dwt_disablesequencing:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #12
	movs	r4, #54
	movs	r2, #2
	movs	r0, #1
	mov	r3, sp
	add	r1, sp, #4
	strb	r4, [sp, #4]
	bl	readfromspi
	ldrb	r4, [sp]	@ zero_extendqisi2
	movs	r2, #1
	movs	r0, #182
	mov	r3, sp
	bic	r4, r4, #3
	add	r1, sp, #4
	strb	r0, [sp, #4]
	mov	r0, r2
	orrs	r4, r4, r2
	movs	r5, #0
	strb	r4, [sp]
	mov	r4, #502
	bl	writetospi
	add	r1, sp, #4
	add	r3, sp, #1
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	movs	r2, #2
	movw	r4, #1270
	mov	r3, sp
	add	r1, sp, #4
	mov	r0, r2
	strh	r5, [sp]	@ movhi
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	_dwt_disablesequencing, .-_dwt_disablesequencing
	.section	.text.DWT_SetDelayedTrxTime,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetDelayedTrxTime
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetDelayedTrxTime, %function
DWT_SetDelayedTrxTime:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #16
	movs	r2, #4
	mov	r4, #458
	str	r0, [sp, #8]
	add	r1, sp, #8
	add	r0, sp, #12
	bl	memcpy
	movs	r2, #4
	add	r3, sp, #12
	movs	r0, #2
	add	r1, sp, r2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, pc}
	.size	DWT_SetDelayedTrxTime, .-DWT_SetDelayedTrxTime
	.section	.text.DWT_StartTx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_StartTx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_StartTx, %function
DWT_StartTx:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	lsls	r3, r1, #30
	push	{r4, r5, r6, r7, lr}
	mov	r4, r1
	sub	sp, sp, #12
	mov	r6, r0
	bmi	.L336
	mov	ip, #2
	mov	lr, #6
	mov	r7, sp
	add	r5, sp, #4
.L330:
	ands	r4, r4, #1
	mov	r2, #1
	beq	.L331
	movs	r4, #141
	mov	r3, r7
	mov	r1, r5
	mov	r0, r2
	strb	lr, [sp]
	strb	r4, [sp, #4]
	bl	writetospi
	movs	r2, #2
	movw	ip, #847
	mov	r3, r7
	mov	r1, r5
	mov	r0, r2
	strh	ip, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r3, [sp, #1]	@ zero_extendqisi2
	ldrb	r0, [sp]	@ zero_extendqisi2
	add	r0, r0, r3, lsl #8
	ands	r0, r0, #1032
	bne	.L337
.L329:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L331:
	movs	r6, #141
	mov	r3, r7
	mov	r1, r5
	mov	r0, r2
	strb	ip, [sp]
	strb	r6, [sp, #4]
	bl	writetospi
	mov	r0, r4
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L336:
	movs	r2, #1
	mov	r7, sp
	add	r5, sp, #4
	mov	lr, #128
	mov	ip, #141
	mov	r3, r7
	mov	r1, r5
	mov	r0, r2
	strb	lr, [sp]
	strb	ip, [sp, #4]
	bl	writetospi
	movs	r3, #1
	mov	ip, #130
	mov	lr, #134
	strb	r3, [r6, #26]
	b	.L330
.L337:
	movs	r2, #1
	mov	ip, #64
	mov	r3, r7
	mov	r1, r5
	mov	r0, r2
	strb	r4, [sp, #4]
	strb	ip, [sp]
	bl	writetospi
	movs	r3, #0
	mov	r0, #-1
	strb	r3, [r6, #26]
	b	.L329
	.size	DWT_StartTx, .-DWT_StartTx
	.section	.text.DWT_ForceTrxOff,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ForceTrxOff
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ForceTrxOff, %function
DWT_ForceTrxOff:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #20
	movs	r4, #0
	movs	r6, #14
	movs	r2, #4
	add	r3, sp, #12
	add	r1, sp, #4
	mov	r5, r0
	movs	r0, #1
	str	r4, [sp, #8]
	strb	r6, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	movs	r2, #4
	add	r0, sp, #8
	bl	memcpy
	ldr	r7, [sp, #8]
	bl	decamutexon
	add	r1, sp, #8
	movs	r2, #4
	str	r4, [sp, #8]
	mov	r6, r0
	movs	r4, #142
	add	r0, sp, #12
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	movs	r2, #1
	mov	ip, #64
	movs	r4, #141
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strb	ip, [sp, #8]
	strb	r4, [sp, #12]
	bl	writetospi
	movs	r4, #143
	ldr	r3, .L345
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	strb	r4, [sp, #4]
	movs	r0, #1
	movw	r4, #847
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	bl	readfromspi
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	eor	r3, r3, r3, lsl #1
	lsls	r3, r3, #24
	bmi	.L344
.L339:
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	movs	r4, #142
	str	r7, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	mov	r0, r6
	bl	decamutexoff
	movs	r3, #0
	strb	r3, [r5, #26]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L344:
	movs	r0, #1
	movw	r4, #973
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r2, r0
	strb	r0, [sp, #8]
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	bl	writetospi
	b	.L339
.L346:
	.align	2
.L345:
	.word	69730296
	.size	DWT_ForceTrxOff, .-DWT_ForceTrxOff
	.section	.text.dwt_isr,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_isr
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_isr, %function
dwt_isr:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #20
	movs	r5, #15
	movs	r6, #0
	mov	r4, r0
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r5, [sp, #4]
	str	r6, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r5, [sp, #8]
	lsls	r7, r5, #17
	str	r5, [r4, #27]	@ unaligned
	bmi	.L391
.L349:
	lsls	r2, r5, #24
	bmi	.L392
.L357:
	tst	r5, #2228224
	bne	.L393
.L361:
	ldr	r3, .L396
	tst	r5, r3
	bne	.L394
.L347:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L391:
	mov	r3, #28416
	movs	r2, #4
	add	r1, sp, #8
	add	r0, sp, #12
	str	r3, [sp, #8]
	movs	r7, #143
	bl	memcpy
	movs	r2, #4
	add	r3, sp, #12
	strb	r7, [sp, #4]
	add	r1, sp, r2
	movs	r0, #1
	movs	r7, #16
	bl	writetospi
	add	r3, sp, #8
	movs	r2, #2
	add	r1, sp, #12
	strb	r6, [r4, #35]
	movs	r0, #1
	strb	r7, [sp, #12]
	bl	readfromspi
	ldrb	r1, [sp, #9]	@ zero_extendqisi2
	ldrb	r3, [sp, #8]	@ zero_extendqisi2
	ldrb	r2, [r4, #8]	@ zero_extendqisi2
	add	r3, r3, r1, lsl #8
	uxth	r3, r3
	cmp	r2, #0
	beq	.L350
	ubfx	r2, r3, #0, #10
.L351:
	lsls	r0, r3, #16
	strh	r2, [r4, #31]	@ unaligned
	bpl	.L352
	ldrb	r3, [r4, #35]	@ zero_extendqisi2
	orr	r3, r3, #1
	strb	r3, [r4, #35]
.L352:
	movs	r6, #17
	add	r1, sp, #12
	add	r3, r4, #33
	movs	r2, #2
	movs	r0, #1
	strb	r6, [sp, #12]
	bl	readfromspi
	lsls	r1, r5, #28
	bpl	.L353
	ldrb	r3, [r4, #33]	@ zero_extendqisi2
	ands	r6, r3, #32
	beq	.L395
.L353:
	ldr	r3, [r4, #40]
	cbz	r3, .L354
	add	r0, r4, #27
	blx	r3
.L354:
	ldrb	r3, [r4, #17]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L349
	movs	r0, #1
	movw	r6, #973
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r2, r0
	strb	r0, [sp, #8]
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	lsls	r2, r5, #24
	bpl	.L357
.L392:
	movs	r3, #248
	movs	r2, #4
	add	r1, sp, #8
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movs	r6, #143
	add	r3, sp, #12
	movs	r0, #1
	add	r1, sp, r2
	strb	r6, [sp, #4]
	bl	writetospi
	lsls	r3, r5, #28
	bpl	.L358
	ldrb	r3, [r4, #26]	@ zero_extendqisi2
	cbz	r3, .L358
	movs	r7, #224
	mov	r0, r4
	movw	r6, #1014
	bl	DWT_ForceTrxOff
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	strb	r7, [sp, #8]
	movs	r0, #2
	movs	r7, #240
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	strb	r7, [sp, #8]
	bl	writetospi
.L358:
	ldr	r3, [r4, #36]
	cmp	r3, #0
	beq	.L357
	add	r0, r4, #27
	blx	r3
	tst	r5, #2228224
	beq	.L361
.L393:
	mov	r3, #131072
	movs	r2, #4
	add	r1, sp, #8
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	movs	r6, #143
	add	r3, sp, #12
	movs	r0, #1
	add	r1, sp, r2
	strb	r6, [sp, #4]
	bl	writetospi
	movs	r3, #0
	movs	r7, #224
	mov	r0, r4
	movw	r6, #1014
	strb	r3, [r4, #26]
	bl	DWT_ForceTrxOff
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	strb	r7, [sp, #8]
	movs	r0, #2
	movs	r7, #240
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	strb	r7, [sp, #8]
	bl	writetospi
	ldr	r3, [r4, #44]
	cmp	r3, #0
	beq	.L361
	add	r0, r4, #27
	blx	r3
	ldr	r3, .L396
	tst	r5, r3
	beq	.L347
.L394:
	movs	r2, #4
	add	r1, sp, #8
	movs	r5, #143
	add	r0, sp, #12
	str	r3, [sp, #8]
	bl	memcpy
	add	r1, sp, #4
	movs	r2, #4
	add	r3, sp, #12
	movs	r0, #1
	strb	r5, [sp, #4]
	bl	writetospi
	movs	r3, #0
	movs	r6, #224
	mov	r0, r4
	movw	r5, #1014
	strb	r3, [r4, #26]
	bl	DWT_ForceTrxOff
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	strb	r6, [sp, #8]
	movs	r0, #2
	movs	r6, #240
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	strb	r6, [sp, #8]
	bl	writetospi
	ldr	r3, [r4, #48]
	cmp	r3, #0
	beq	.L347
	add	r0, r4, #27
	blx	r3
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L350:
	and	r2, r3, #127
	b	.L351
.L395:
	movs	r3, #8
	movs	r2, #4
	add	r0, sp, #12
	movs	r7, #143
	add	r1, sp, r3
	str	r3, [sp, #8]
	bl	memcpy
	movs	r2, #4
	add	r3, sp, #12
	movs	r0, #1
	add	r1, sp, r2
	strb	r7, [sp, #4]
	bl	writetospi
	ldr	r3, [r4, #27]	@ unaligned
	strb	r6, [r4, #26]
	bic	r3, r3, #8
	str	r3, [r4, #27]	@ unaligned
	b	.L353
.L397:
	.align	2
.L396:
	.word	67473408
	.size	dwt_isr, .-dwt_isr
	.section	.text.DWT_SyncRxBufPtrs,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SyncRxBufPtrs
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SyncRxBufPtrs, %function
DWT_SyncRxBufPtrs:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #12
	movw	r4, #847
	movs	r2, #1
	movs	r0, #2
	add	r3, sp, #3
	add	r1, sp, #4
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r3, [sp, #3]	@ zero_extendqisi2
	eor	r3, r3, r3, lsl #1
	lsls	r3, r3, #24
	bmi	.L404
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
.L404:
	movs	r4, #1
	movw	r5, #973
	add	r3, sp, #3
	add	r1, sp, #4
	mov	r2, r4
	movs	r0, #2
	strb	r4, [sp, #3]
	strh	r5, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_SyncRxBufPtrs, .-DWT_SyncRxBufPtrs
	.section	.text.DWT_SetSniffMode,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetSniffMode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetSniffMode, %function
DWT_SetSniffMode:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #20
	cmp	r0, #0
	beq	.L406
	orr	r1, r1, r2, lsl #8
	movs	r5, #157
	add	r3, sp, #8
	movs	r2, #2
	bic	r4, r1, #240
	movs	r0, #1
	add	r1, sp, #12
	strb	r5, [sp, #12]
	strh	r4, [sp, #8]	@ movhi
	bl	writetospi
	movs	r0, #0
	movs	r4, #54
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	str	r0, [sp, #8]
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	add	r1, sp, #8
	add	r0, sp, #12
	orr	r3, r3, #16777216
.L409:
	movs	r2, #4
	str	r3, [sp, #8]
	movs	r4, #182
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L406:
	movs	r4, #157
	mov	r5, r0
	movs	r2, #2
	add	r3, sp, #8
	add	r1, sp, #12
	strb	r4, [sp, #12]
	movs	r0, #1
	movs	r4, #54
	strh	r5, [sp, #8]	@ movhi
	bl	writetospi
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	str	r5, [sp, #8]
	strb	r4, [sp, #4]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	add	r1, sp, #8
	add	r0, sp, #12
	bic	r3, r3, #16777216
	b	.L409
	.size	DWT_SetSniffMode, .-DWT_SetSniffMode
	.section	.text.DWT_SetLowPowerListening,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetLowPowerListening
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetLowPowerListening, %function
DWT_SetLowPowerListening:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	movs	r2, #0
	sub	sp, sp, #20
	movw	r5, #1142
	mov	r4, r0
	add	r3, sp, #12
	add	r1, sp, #4
	str	r2, [sp, #8]
	movs	r0, #2
	movs	r2, #4
	strh	r5, [sp, #4]	@ movhi
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	cbz	r4, .L411
	orr	r3, r3, #12288
.L412:
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	str	r3, [sp, #8]
	movw	r4, #1270
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, pc}
.L411:
	bic	r3, r3, #12288
	b	.L412
	.size	DWT_SetLowPowerListening, .-DWT_SetLowPowerListening
	.section	.text.DWT_SetSnoozeTime,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SetSnoozeTime
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SetSnoozeTime, %function
DWT_SetSnoozeTime:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movw	r4, #3318
	movs	r2, #1
	add	r3, sp, #3
	add	r1, sp, #4
	strb	r0, [sp, #3]
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	DWT_SetSnoozeTime, .-DWT_SetSnoozeTime
	.section	.text.DWT_EnableRx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_EnableRx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_EnableRx, %function
DWT_EnableRx:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r4, r1
	sub	sp, sp, #12
	lsls	r1, r1, #29
	mov	r8, r0
	mov	r7, sp
	add	r6, sp, #4
	bpl	.L417
.L418:
	ands	r5, r4, #1
	beq	.L430
	mov	r5, #768
	mov	r9, #141
	mov	r3, r7
	movs	r2, #2
	mov	r1, r6
	strh	r5, [sp]	@ movhi
	movs	r0, #1
	movw	r5, #847
	strb	r9, [sp, #4]
	bl	writetospi
	mov	r3, r7
	movs	r2, #1
	mov	r1, r6
	movs	r0, #2
	strh	r5, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r5, [sp]	@ zero_extendqisi2
	ands	r5, r5, #8
	bne	.L423
.L416:
	mov	r0, r5
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L430:
	mov	r0, #256
	movs	r4, #141
	mov	r3, r7
	mov	r1, r6
	strh	r0, [sp]	@ movhi
	movs	r2, #2
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	mov	r0, r5
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L417:
	movw	r5, #847
	movs	r2, #1
	mov	r3, r7
	mov	r1, r6
	movs	r0, #2
	strh	r5, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r3, [sp]	@ zero_extendqisi2
	eor	r3, r3, r3, lsl #1
	lsls	r2, r3, #24
	bpl	.L418
	movs	r0, #1
	movw	r5, #973
	mov	r3, r7
	mov	r1, r6
	mov	r2, r0
	strb	r0, [sp]
	movs	r0, #2
	strh	r5, [sp, #4]	@ movhi
	bl	writetospi
	b	.L418
.L423:
	mov	r0, r8
	bl	DWT_ForceTrxOff
	lsls	r3, r4, #30
	bpl	.L431
	mov	r5, #-1
	b	.L416
.L431:
	mov	r4, #256
	mov	r3, r7
	mov	r1, r6
	movs	r2, #2
	movs	r0, #1
	strb	r9, [sp, #4]
	strh	r4, [sp]	@ movhi
	mov	r5, #-1
	bl	writetospi
	b	.L416
	.size	DWT_EnableRx, .-DWT_EnableRx
	.section	.text.dwt_setrxtimeout,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_setrxtimeout
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_setrxtimeout, %function
dwt_setrxtimeout:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #12
	mov	r4, #836
	mov	r6, r1
	mov	r5, r0
	mov	r3, sp
	add	r1, sp, #4
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r4, [sp]	@ zero_extendqisi2
	cbz	r6, .L433
	movs	r7, #140
	mov	r3, sp
	add	r1, sp, #4
	movs	r2, #2
	movs	r0, #1
	strh	r6, [sp]	@ movhi
	strb	r7, [sp, #4]
	bl	writetospi
	ldr	r2, [r5, #20]
	orr	r4, r4, #16
	mov	r7, #964
	mov	r3, sp
	orr	r6, r2, #268435456
	add	r1, sp, #4
	movs	r2, #1
	movs	r0, #2
	str	r6, [r5, #20]
	strb	r4, [sp]
	strh	r7, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L433:
	ldr	r2, [r5, #20]
	bic	r4, r4, #16
	mov	r3, sp
	add	r1, sp, #4
	bic	r0, r2, #268435456
	mov	r6, #964
	movs	r2, #1
	strb	r4, [sp]
	str	r0, [r5, #20]
	movs	r0, #2
	strh	r6, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
	.size	dwt_setrxtimeout, .-dwt_setrxtimeout
	.section	.text.dwt_setpreambledetecttimeout,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_setpreambledetecttimeout
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_setpreambledetecttimeout, %function
dwt_setpreambledetecttimeout:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movs	r2, #2
	movw	r4, #9447
	mov	r3, sp
	add	r1, sp, #4
	strh	r0, [sp]	@ movhi
	mov	r0, r2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_setpreambledetecttimeout, .-dwt_setpreambledetecttimeout
	.section	.text.DWT_EnableInterrupt,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_EnableInterrupt
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_EnableInterrupt, %function
DWT_EnableInterrupt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	sub	sp, sp, #16
	mov	r6, r1
	mov	r5, r0
	bl	decamutexon
	movs	r2, #0
	mov	r4, r0
	movs	r0, #14
	add	r3, sp, #12
	add	r1, sp, #4
	str	r2, [sp, #8]
	strb	r0, [sp, #4]
	movs	r2, #4
	movs	r0, #1
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	cbz	r6, .L439
	orrs	r3, r3, r5
.L440:
	add	r1, sp, #8
	movs	r2, #4
	add	r0, sp, #12
	movs	r5, #142
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r5, [sp, #4]
	bl	writetospi
	mov	r0, r4
	bl	decamutexoff
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, pc}
.L439:
	bic	r3, r3, r5
	b	.L440
	.size	DWT_EnableInterrupt, .-DWT_EnableInterrupt
	.section	.text.dwt_configeventcounters,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_configeventcounters
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_configeventcounters, %function
dwt_configeventcounters:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	movs	r2, #1
	sub	sp, sp, #8
	mov	r5, r0
	movs	r6, #2
	movs	r4, #175
	add	r3, sp, #3
	add	r1, sp, #4
	mov	r0, r2
	strb	r6, [sp, #3]
	strb	r4, [sp, #4]
	bl	writetospi
	cbnz	r5, .L448
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, pc}
.L448:
	movs	r5, #1
	add	r3, sp, #3
	add	r1, sp, #4
	strb	r4, [sp, #4]
	mov	r2, r5
	mov	r0, r5
	strb	r5, [sp, #3]
	bl	writetospi
	add	sp, sp, #8
	@ sp needed
	pop	{r4, r5, r6, pc}
	.size	dwt_configeventcounters, .-dwt_configeventcounters
	.section	.text.dwt_readeventcounters,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readeventcounters
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readeventcounters, %function
dwt_readeventcounters:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #20
	movs	r5, #0
	movw	r6, #1135
	mov	r4, r0
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #2
	strh	r6, [sp, #4]	@ movhi
	movw	r6, #2159
	str	r5, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r0, [sp, #8]
	add	r3, sp, #12
	add	r1, sp, #4
	ubfx	r7, r0, #0, #12
	ubfx	r0, r0, #16, #12
	movs	r2, #4
	strh	r6, [sp, #4]	@ movhi
	strh	r7, [r4]	@ unaligned
	movw	r6, #3183
	strh	r0, [r4, #2]	@ unaligned
	movs	r0, #2
	str	r5, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r0, [sp, #8]
	add	r3, sp, #12
	add	r1, sp, #4
	ubfx	r7, r0, #0, #12
	ubfx	r0, r0, #16, #12
	movs	r2, #4
	strh	r6, [sp, #4]	@ movhi
	strh	r7, [r4, #4]	@ unaligned
	movw	r6, #4207
	strh	r0, [r4, #6]	@ unaligned
	movs	r0, #2
	str	r5, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r0, [sp, #8]
	add	r3, sp, #12
	add	r1, sp, #4
	ubfx	r7, r0, #0, #12
	ubfx	r0, r0, #16, #12
	movs	r2, #4
	strh	r6, [sp, #4]	@ movhi
	strh	r7, [r4, #8]	@ unaligned
	movw	r6, #5231
	strh	r0, [r4, #10]	@ unaligned
	movs	r0, #2
	str	r5, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r0, [sp, #8]
	add	r3, sp, #12
	add	r1, sp, #4
	ubfx	r7, r0, #16, #12
	ubfx	r0, r0, #0, #12
	movs	r2, #4
	strh	r6, [sp, #4]	@ movhi
	strh	r7, [r4, #14]	@ unaligned
	movw	r7, #6255
	strh	r0, [r4, #12]	@ unaligned
	movs	r0, #2
	str	r5, [sp, #8]
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r6, [sp, #8]
	add	r3, sp, #12
	add	r1, sp, #4
	ubfx	r0, r6, #16, #12
	ubfx	r6, r6, #0, #12
	movs	r2, #4
	str	r5, [sp, #8]
	strh	r0, [r4, #18]	@ unaligned
	movs	r0, #2
	strh	r6, [r4, #16]	@ unaligned
	strh	r7, [sp, #4]	@ movhi
	bl	readfromspi
	add	r1, sp, #12
	add	r0, sp, #8
	movs	r2, #4
	bl	memcpy
	ldr	r3, [sp, #8]
	ubfx	r2, r3, #0, #12
	ubfx	r3, r3, #16, #12
	strh	r2, [r4, #20]	@ unaligned
	strh	r3, [r4, #22]	@ unaligned
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
	.size	dwt_readeventcounters, .-dwt_readeventcounters
	.section	.text.DWT_ResetRx,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_ResetRx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_ResetRx, %function
DWT_ResetRx:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	sub	sp, sp, #12
	movw	r4, #1014
	movs	r5, #224
	movs	r2, #1
	add	r3, sp, #3
	add	r1, sp, #4
	movs	r0, #2
	strb	r5, [sp, #3]
	strh	r4, [sp, #4]	@ movhi
	movs	r5, #240
	bl	writetospi
	add	r3, sp, #3
	add	r1, sp, #4
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	strb	r5, [sp, #3]
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	DWT_ResetRx, .-DWT_ResetRx
	.section	.text.DWT_SoftReset,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_SoftReset
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_SoftReset, %function
DWT_SoftReset:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	sub	sp, sp, #20
	movs	r4, #54
	movs	r2, #2
	mov	r6, r0
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r0, #1
	strb	r4, [sp, #12]
	bl	readfromspi
	ldrb	r5, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	movs	r4, #182
	bic	r5, r5, #3
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	orrs	r5, r5, r2
	strb	r4, [sp, #12]
	movs	r4, #0
	mov	r7, #748
	strb	r5, [sp, #8]
	mov	r5, #502
	bl	writetospi
	add	r1, sp, #12
	add	r3, sp, #9
	movs	r2, #1
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	movw	r5, #1270
	movs	r2, #2
	add	r3, sp, #8
	add	r1, sp, #12
	strh	r5, [sp, #12]	@ movhi
	mov	r0, r2
	movs	r5, #172
	strh	r4, [sp, #8]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #2
	movs	r0, #1
	strb	r5, [sp, #12]
	movw	r5, #1772
	strh	r4, [sp, #8]	@ movhi
	bl	writetospi
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r5, r0
	movs	r2, #1
	strb	r4, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	mov	r0, r5
	strh	r7, [sp, #12]	@ movhi
	strb	r4, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	strh	r7, [sp, #12]	@ movhi
	mov	r0, r5
	movw	r7, #1014
	strb	r5, [sp, #8]
	bl	writetospi
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	mov	r0, r5
	strb	r4, [sp, #8]
	strh	r7, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r3, .L461
	ldr	r2, .L461+4
	ldr	r3, [r3]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #12]
	ldr	r3, [sp, #12]
	subs	r2, r3, #1
	str	r2, [sp, #12]
	cbz	r3, .L454
.L455:
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
	bne	.L455
.L454:
	movs	r0, #240
	movw	r4, #1014
	add	r3, sp, #7
	add	r1, sp, #8
	strb	r0, [sp, #7]
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #8]	@ movhi
	bl	writetospi
	movs	r3, #0
	strb	r3, [r6, #26]
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L462:
	.align	2
.L461:
	.word	SystemCoreClock
	.word	-776530087
	.size	DWT_SoftReset, .-DWT_SoftReset
	.section	.text.DWT_Init,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	DWT_Init
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	DWT_Init, %function
DWT_Init:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movs	r2, #4
	sub	sp, sp, #20
	movs	r5, #0
	mov	r4, r0
	add	r3, sp, #12
	mov	r6, r1
	strb	r5, [r0, #17]
	add	r1, sp, r2
	strb	r5, [r0, #26]
	strh	r5, [r0, #24]	@ movhi
	str	r5, [r0, #36]
	str	r5, [r0, #40]
	movs	r0, #1
	str	r5, [sp, #8]
	strb	r5, [sp, #4]
	strd	r5, r5, [r4, #44]
	bl	readfromspi
	movs	r2, #4
	add	r1, sp, #12
	add	r0, sp, #8
	bl	memcpy
	ldr	r2, [sp, #8]
	ldr	r3, .L480
	cmp	r2, r3
	bne	.L472
	mov	r0, r4
	movs	r5, #54
	bl	DWT_SoftReset
	add	r3, sp, #8
	movs	r2, #2
	add	r1, sp, #12
	movs	r0, #1
	strb	r5, [sp, #12]
	bl	readfromspi
	ldrb	r5, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	movs	r1, #182
	bic	r5, r5, #3
	add	r3, sp, #8
	mov	r0, r2
	strb	r1, [sp, #12]
	orrs	r5, r5, r2
	add	r1, sp, #12
	movs	r7, #4
	strb	r5, [sp, #8]
	mov	r5, #502
	bl	writetospi
	add	r3, sp, #9
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	movs	r2, #1
	movs	r5, #164
	add	r3, sp, #8
	mov	r0, r2
	add	r1, sp, #12
	strb	r5, [sp, #12]
	strb	r7, [sp, #8]
	bl	writetospi
	movs	r0, #30
	bl	dwt_OtpRead
	mov	r5, r0
	mov	r0, r7
	ubfx	r3, r5, #8, #8
	strb	r3, [r4, #9]
	bl	dwt_OtpRead
	tst	r0, #255
	bne	.L479
.L465:
	movs	r0, #6
	bl	dwt_OtpRead
	str	r0, [r4]
	movs	r0, #7
	bl	dwt_OtpRead
	ands	r5, r5, #31
	str	r0, [r4, #4]
	beq	.L466
	strb	r5, [r4, #16]
	orr	r5, r5, #96
.L467:
	movw	r7, #3819
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strb	r5, [sp, #8]
	strh	r7, [sp, #12]	@ movhi
	bl	writetospi
	lsls	r3, r6, #31
	bpl	.L468
	movs	r5, #54
	add	r3, sp, #8
	movs	r2, #2
	add	r1, sp, #12
	movs	r0, #1
	strb	r5, [sp, #12]
	bl	readfromspi
	movs	r5, #182
	movs	r2, #1
	movw	r1, #769
	add	r3, sp, #8
	strb	r5, [sp, #12]
	mov	r0, r2
	strh	r1, [sp, #8]	@ movhi
	mov	r5, #502
	add	r1, sp, #12
	bl	writetospi
	add	r3, sp, #9
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	movs	r2, #2
	mov	r1, #32768
	movw	r5, #1773
	mov	r0, r2
	add	r3, sp, #8
	strh	r1, [sp, #8]	@ movhi
	add	r1, sp, #12
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r3, .L480+4
	ldr	r2, .L480+8
	ldr	r3, [r3]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #4]
	ldr	r3, [sp, #4]
	subs	r2, r3, #1
	str	r2, [sp, #4]
	cbz	r3, .L471
.L469:
	.syntax unified
@ 375 "../src/BSP/MCU/CMSIS_4/CMSIS/Include/cmsis_gcc.h" 1
	nop
@ 0 "" 2
	.thumb
	.syntax unified
	ldr	r3, [sp, #4]
	subs	r2, r3, #1
	str	r2, [sp, #4]
	cmp	r3, #0
	bne	.L469
.L471:
	movs	r5, #54
	add	r3, sp, #8
	movs	r2, #2
	add	r1, sp, #12
	movs	r0, #1
	strb	r5, [sp, #12]
	bl	readfromspi
	ldrb	r1, [sp, #9]	@ zero_extendqisi2
	movs	r2, #1
	movs	r3, #0
	bic	r1, r1, #1
	movs	r5, #182
	mov	r0, r2
	strb	r3, [sp, #8]
	strb	r1, [sp, #9]
	add	r3, sp, #8
	add	r1, sp, #12
	strb	r5, [sp, #12]
	mov	r5, #502
	bl	writetospi
	add	r3, sp, #9
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strh	r5, [sp, #12]	@ movhi
	bl	writetospi
	ldrh	r3, [r4, #24]
	orr	r3, r3, #2048
	strh	r3, [r4, #24]	@ movhi
.L470:
	movs	r5, #54
	add	r3, sp, #8
	movs	r2, #2
	add	r1, sp, #12
	movs	r0, #1
	strb	r5, [sp, #12]
	bl	readfromspi
	ldrb	r1, [sp, #9]	@ zero_extendqisi2
	movs	r6, #182
	movs	r2, #1
	bic	r1, r1, #1
	movs	r5, #0
	strb	r6, [sp, #12]
	mov	r6, #502
	mov	r0, r2
	add	r3, sp, #8
	strb	r1, [sp, #9]
	add	r1, sp, #12
	strb	r5, [sp, #8]
	movw	r7, #2796
	bl	writetospi
	add	r3, sp, #9
	movs	r2, #1
	add	r1, sp, #12
	strh	r6, [sp, #12]	@ movhi
	movs	r0, #2
	movs	r6, #4
	bl	writetospi
	add	r3, sp, #8
	movs	r2, #1
	add	r1, sp, #12
	movs	r0, #2
	strb	r5, [sp, #8]
	strh	r7, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #12
	mov	r2, r6
	mov	r1, sp
	movs	r0, #1
	str	r5, [sp, #8]
	strb	r6, [sp]
	bl	readfromspi
	mov	r2, r6
	add	r1, sp, #12
	add	r0, sp, #8
	bl	memcpy
	ldr	r3, [sp, #8]
	mov	r0, r5
	str	r3, [r4, #20]
.L463:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L466:
	movs	r3, #16
	movs	r5, #112
	strb	r3, [r4, #16]
	b	.L467
.L468:
	movs	r2, #2
	movw	r5, #1398
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strh	r5, [sp, #12]	@ movhi
	bl	readfromspi
	ldrb	r0, [sp, #9]	@ zero_extendqisi2
	ldrb	r5, [sp, #8]	@ zero_extendqisi2
	movs	r2, #2
	movw	r1, #1526
	add	r3, sp, #8
	add	r5, r5, r0, lsl #8
	mov	r0, r2
	strh	r1, [sp, #12]	@ movhi
	add	r1, sp, #12
	bic	r5, r5, #512
	strh	r5, [sp, #8]	@ movhi
	bl	writetospi
	b	.L470
.L479:
	movs	r1, #2
	movw	r7, #4845
	add	r3, sp, #8
	movs	r2, #1
	mov	r0, r1
	strb	r1, [sp, #8]
	add	r1, sp, #12
	strh	r7, [sp, #12]	@ movhi
	bl	writetospi
	ldrh	r3, [r4, #24]
	orr	r3, r3, #4096
	strh	r3, [r4, #24]	@ movhi
	b	.L465
.L472:
	mov	r0, #-1
	b	.L463
.L481:
	.align	2
.L480:
	.word	-557186768
	.word	SystemCoreClock
	.word	-776530087
	.size	DWT_Init, .-DWT_Init
	.section	.text.dwt_setxtaltrim,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_setxtaltrim
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_setxtaltrim, %function
dwt_setxtaltrim:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, lr}
	and	r0, r0, #31
	sub	sp, sp, #12
	movw	r5, #3819
	movs	r2, #1
	orr	r4, r0, #96
	add	r3, sp, #3
	add	r1, sp, #4
	movs	r0, #2
	strh	r5, [sp, #4]	@ movhi
	strb	r4, [sp, #3]
	bl	writetospi
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	dwt_setxtaltrim, .-dwt_setxtaltrim
	.section	.text.dwt_getinitxtaltrim,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_getinitxtaltrim
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_getinitxtaltrim, %function
dwt_getinitxtaltrim:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r0, [r0, #16]	@ zero_extendqisi2
	bx	lr
	.size	dwt_getinitxtaltrim, .-dwt_getinitxtaltrim
	.section	.text.dwt_configcwmode,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_configcwmode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_configcwmode, %function
dwt_configcwmode:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #16
	movs	r4, #54
	mov	r8, r0
	movs	r2, #2
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r0, #1
	strb	r4, [sp, #12]
	bl	readfromspi
	ldrb	r4, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	movs	r7, #182
	bic	r4, r4, #3
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r6, #502
	orrs	r4, r4, r2
	mov	r0, r2
	strb	r7, [sp, #12]
	movs	r5, #0
	strb	r4, [sp, #8]
	bl	writetospi
	add	r1, sp, #12
	add	r3, sp, #9
	movs	r2, #1
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	movs	r2, #2
	movw	r4, #1270
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strh	r5, [sp, #8]	@ movhi
	strh	r4, [sp, #12]	@ movhi
	bl	writetospi
	ldr	r2, .L487
	add	r1, sp, #8
	ldr	r3, .L487+4
	add	r0, sp, #12
	ldrb	r4, [r2, r8]	@ zero_extendqisi2
	movs	r2, #4
	mov	r8, #168
	ldr	r3, [r3, r4, lsl #2]
	str	r3, [sp, #8]
	bl	memcpy
	movw	r0, #2027
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	strh	r0, [sp, #4]	@ movhi
	movs	r0, #2
	bl	writetospi
	ldr	r1, .L487+8
	movw	r2, #3051
	add	r3, sp, #8
	ldrb	r0, [r1, r4]	@ zero_extendqisi2
	add	r1, sp, #12
	strh	r2, [sp, #12]	@ movhi
	movs	r2, #1
	strb	r0, [sp, #8]
	movs	r0, #2
	bl	writetospi
	ldr	r3, .L487+12
	add	r1, sp, #8
	add	r0, sp, #12
	ldr	r3, [r3, r4, lsl #2]
	movs	r2, #4
	movw	r4, #3304
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #2
	strh	r4, [sp, #4]	@ movhi
	bl	writetospi
	mov	r3, #2088960
	add	r1, sp, #8
	add	r0, sp, #12
	movs	r2, #4
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r8, [sp, #4]
	bl	writetospi
	ldr	r3, .L487+16
	add	r1, sp, #8
	add	r0, sp, #12
	movs	r2, #4
	str	r3, [sp, #8]
	bl	memcpy
	add	r1, sp, #4
	add	r3, sp, #12
	movs	r2, #4
	movs	r0, #1
	strb	r8, [sp, #4]
	movs	r4, #34
	bl	writetospi
	movs	r2, #1
	add	r3, sp, #8
	add	r1, sp, #12
	strb	r4, [sp, #8]
	mov	r0, r2
	movs	r4, #7
	strb	r7, [sp, #12]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strb	r4, [sp, #8]
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	movs	r2, #2
	movw	r4, #9974
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strh	r5, [sp, #8]	@ movhi
	strh	r4, [sp, #12]	@ movhi
	movs	r5, #19
	bl	writetospi
	movw	r4, #3306
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strb	r5, [sp, #8]
	strh	r4, [sp, #12]	@ movhi
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L488:
	.align	2
.L487:
	.word	chan_idx
	.word	fs_pll_cfg
	.word	fs_pll_tune
	.word	tx_config
	.word	6291200
	.size	dwt_configcwmode, .-dwt_configcwmode
	.section	.text.dwt_configcontinuousframemode,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_configcontinuousframemode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_configcontinuousframemode, %function
dwt_configcontinuousframemode:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	sub	sp, sp, #16
	mov	r8, #54
	mov	r5, r0
	movs	r2, #2
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r0, #1
	strb	r8, [sp, #12]
	bl	readfromspi
	ldrb	r4, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	movs	r7, #182
	bic	r4, r4, #3
	mov	r6, #502
	add	r3, sp, #8
	add	r1, sp, #12
	orrs	r4, r4, r2
	mov	r0, r2
	strb	r7, [sp, #12]
	strb	r4, [sp, #8]
	bl	writetospi
	add	r1, sp, #12
	add	r3, sp, #9
	movs	r2, #1
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	movs	r2, #2
	movw	ip, #1270
	movs	r4, #0
	add	r3, sp, #8
	add	r1, sp, #12
	mov	r0, r2
	strh	ip, [sp, #12]	@ movhi
	strh	r4, [sp, #8]	@ movhi
	bl	writetospi
	mov	r3, #2088960
	movs	r4, #168
	add	r1, sp, #8
	add	r0, sp, #12
	movs	r2, #4
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	ldr	r3, .L491
	add	r1, sp, #8
	add	r0, sp, #12
	movs	r2, #4
	str	r3, [sp, #8]
	bl	memcpy
	add	r3, sp, #12
	add	r1, sp, #4
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #2
	movs	r0, #1
	strb	r8, [sp, #12]
	bl	readfromspi
	ldrb	r4, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	add	r3, sp, #8
	bic	r4, r4, #3
	add	r1, sp, #12
	mov	r0, r2
	strb	r7, [sp, #12]
	orr	r4, r4, #2
	strb	r4, [sp, #8]
	bl	writetospi
	add	r3, sp, #9
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #2
	movs	r0, #1
	strb	r8, [sp, #12]
	bl	readfromspi
	ldrb	r4, [sp, #8]	@ zero_extendqisi2
	movs	r2, #1
	add	r3, sp, #8
	add	r1, sp, #12
	bic	r4, r4, #48
	mov	r0, r2
	strb	r7, [sp, #12]
	orr	r4, r4, #32
	strb	r4, [sp, #8]
	bl	writetospi
	add	r3, sp, #9
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r6, [sp, #12]	@ movhi
	bl	writetospi
	cmp	r5, #4
	add	r1, sp, #8
	add	r0, sp, #12
	mov	r2, #4
	it	cc
	movcc	r5, #4
	movs	r4, #138
	str	r5, [sp, #8]
	bl	memcpy
	add	r1, sp, #4
	add	r3, sp, #12
	movs	r2, #4
	movs	r0, #1
	strb	r4, [sp, #4]
	movs	r5, #16
	bl	writetospi
	movw	r4, #9455
	add	r3, sp, #8
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strb	r5, [sp, #8]
	strh	r4, [sp, #12]	@ movhi
	bl	writetospi
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, pc}
.L492:
	.align	2
.L491:
	.word	6291200
	.size	dwt_configcontinuousframemode, .-dwt_configcontinuousframemode
	.section	.text.dwt_readtempvbat,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readtempvbat
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readtempvbat, %function
dwt_readtempvbat:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	movs	r5, #128
	sub	sp, sp, #16
	movw	r4, #4584
	mov	r6, r0
	strb	r5, [sp, #4]
	movs	r5, #10
	add	r3, sp, #4
	add	r1, sp, #12
	movs	r2, #1
	strh	r4, [sp, #12]	@ movhi
	movs	r0, #2
	movw	r4, #4840
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #12
	movs	r2, #1
	strb	r5, [sp, #4]
	movs	r0, #2
	movs	r5, #15
	strh	r4, [sp, #12]	@ movhi
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #12
	movs	r2, #1
	movs	r0, #2
	strh	r4, [sp, #12]	@ movhi
	strb	r5, [sp, #4]
	bl	writetospi
	movs	r2, #1
	movs	r5, #170
	movs	r7, #0
	add	r3, sp, #4
	mov	r4, r2
	add	r1, sp, #12
	mov	r0, r2
	strb	r7, [sp, #4]
	strb	r5, [sp, #12]
	bl	writetospi
	add	r3, sp, #4
	add	r1, sp, #12
	mov	r2, r4
	mov	r0, r4
	strb	r5, [sp, #12]
	strb	r4, [sp, #4]
	bl	writetospi
	cmp	r6, r4
	bne	.L494
	ldr	r3, .L503
	ldr	r2, .L503+4
	ldr	r3, [r3]
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #12]
	ldr	r3, [sp, #12]
	subs	r2, r3, #1
	str	r2, [sp, #12]
	cbz	r3, .L495
.L496:
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
	bne	.L496
.L495:
	add	r5, sp, #8
	movs	r2, #2
	movw	r4, #874
	add	r3, sp, #4
	mov	r1, r5
	mov	r0, r2
	strh	r4, [sp, #8]	@ movhi
	bl	readfromspi
.L497:
	movs	r2, #1
	ldrb	r4, [sp, #4]	@ zero_extendqisi2
	mov	r1, r5
	movs	r7, #0
	ldrb	r5, [sp, #5]	@ zero_extendqisi2
	movs	r6, #170
	add	r3, sp, #4
	mov	r0, r2
	strb	r7, [sp, #4]
	strb	r6, [sp, #8]
	bl	writetospi
	orr	r0, r4, r5, lsl #8
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L494:
	add	r5, sp, #8
	mov	r9, #54
	add	r1, sp, #12
	movs	r2, #2
	mov	r3, r5
	mov	r0, r4
	strb	r9, [sp, #12]
	bl	readfromspi
	ldrb	r6, [sp, #8]	@ zero_extendqisi2
	mov	r8, #182
	mov	r3, r5
	mov	r2, r4
	bic	r6, r6, #3
	add	r1, sp, #12
	mov	r10, #502
	mov	r0, r4
	orr	r6, r6, #1
	strb	r8, [sp, #12]
	strb	r6, [sp, #8]
	bl	writetospi
	add	r3, sp, #9
	mov	r2, r4
	add	r1, sp, #12
	movs	r0, #2
	strh	r10, [sp, #12]	@ movhi
	bl	writetospi
	movs	r2, #2
	movw	r6, #874
	add	r3, sp, #4
	add	r1, sp, #12
	mov	r0, r2
	strh	r6, [sp, #12]	@ movhi
	bl	readfromspi
	mov	r3, r5
	add	r1, sp, #12
	movs	r2, #2
	mov	r0, r4
	strb	r9, [sp, #12]
	bl	readfromspi
	ldrb	r6, [sp, #9]	@ zero_extendqisi2
	mov	r3, r5
	mov	r2, r4
	bic	r6, r6, #1
	add	r1, sp, #12
	mov	r0, r4
	strb	r8, [sp, #12]
	strb	r7, [sp, #8]
	strb	r6, [sp, #9]
	bl	writetospi
	add	r3, sp, #9
	mov	r2, r4
	add	r1, sp, #12
	movs	r0, #2
	strh	r10, [sp, #12]	@ movhi
	bl	writetospi
	b	.L497
.L504:
	.align	2
.L503:
	.word	SystemCoreClock
	.word	-776530087
	.size	dwt_readtempvbat, .-dwt_readtempvbat
	.section	.text.dwt_readwakeuptemp,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readwakeuptemp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readwakeuptemp, %function
dwt_readwakeuptemp:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movw	r4, #1130
	movs	r2, #1
	movs	r0, #2
	add	r3, sp, #3
	add	r1, sp, #4
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r0, [sp, #3]	@ zero_extendqisi2
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_readwakeuptemp, .-dwt_readwakeuptemp
	.section	.text.dwt_readwakeupvbat,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_readwakeupvbat
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_readwakeupvbat, %function
dwt_readwakeupvbat:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	sub	sp, sp, #8
	movw	r4, #874
	movs	r2, #1
	movs	r0, #2
	add	r3, sp, #3
	add	r1, sp, #4
	strh	r4, [sp, #4]	@ movhi
	bl	readfromspi
	ldrb	r0, [sp, #3]	@ zero_extendqisi2
	add	sp, sp, #8
	@ sp needed
	pop	{r4, pc}
	.size	dwt_readwakeupvbat, .-dwt_readwakeupvbat
	.section	.text.dwt_calcbandwidthtempadj,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_calcbandwidthtempadj
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_calcbandwidthtempadj, %function
dwt_calcbandwidthtempadj:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r2, #1
	sub	sp, sp, #36
	movs	r4, #54
	mov	r9, r0
	add	r3, sp, #24
	add	r1, sp, #28
	mov	r0, r2
	strb	r4, [sp, #28]
	movw	r4, #1142
	bl	readfromspi
	movs	r2, #2
	add	r3, sp, #24
	strh	r4, [sp, #28]	@ movhi
	add	r1, sp, #28
	ldrb	r4, [sp, #24]	@ zero_extendqisi2
	mov	r0, r2
	movs	r7, #182
	mov	r8, #128
	str	r4, [sp, #8]
	bl	readfromspi
	ldrb	r2, [sp, #25]	@ zero_extendqisi2
	mov	ip, #40
	ldrb	r5, [sp, #24]	@ zero_extendqisi2
	movs	r4, #0
	movs	r0, #1
	add	r3, sp, #28
	add	r5, r5, r2, lsl #8
	add	r1, sp, #20
	movs	r2, #4
	mov	r6, r0
	uxth	r5, r5
	strb	ip, [sp, #20]
	str	r4, [sp, #24]
	mov	r10, #300
	str	r5, [sp, #4]
	bl	readfromspi
	add	r1, sp, #28
	movs	r2, #4
	add	r0, sp, #24
	str	r4, [sp]
	bl	memcpy
	ldr	r5, [sp, #24]
	add	r3, sp, #24
	add	r1, sp, #28
	mov	r2, r6
	mov	r0, r6
	str	r5, [sp, #12]
	movw	r5, #1270
	strb	r7, [sp, #28]
	strb	r6, [sp, #24]
	bl	writetospi
	movs	r2, #2
	add	r3, sp, #24
	add	r1, sp, #28
	strh	r4, [sp, #24]	@ movhi
	mov	r0, r2
	strh	r5, [sp, #28]	@ movhi
	bl	writetospi
	ldr	r3, .L521
	add	r1, sp, #24
	movs	r2, #4
	movs	r4, #168
	add	r0, sp, #28
	str	r3, [sp, #24]
	bl	memcpy
	add	r1, sp, #20
	add	r3, sp, #28
	movs	r2, #4
	mov	r0, r6
	strb	r4, [sp, #20]
	movs	r5, #7
	bl	writetospi
	mov	r4, r8
	mov	ip, #34
	ldr	fp, .L521+8
	add	r3, sp, #24
	mov	r2, r6
	mov	r0, r6
	add	r1, sp, #28
	strb	r7, [sp, #28]
	strb	ip, [sp, #24]
	bl	writetospi
.L514:
	lsrs	r4, r4, #1
	movw	r7, #3050
	add	r3, sp, #24
	movs	r2, #1
	orr	r6, r4, r8
	add	r1, sp, #28
	movs	r0, #2
	strh	r7, [sp, #28]	@ movhi
	strb	r6, [sp, #24]
	movw	r7, #2282
	bl	writetospi
	mov	ip, #188
	add	r3, sp, #24
	movs	r2, #1
	add	r1, sp, #28
	movs	r0, #2
	strb	ip, [sp, #24]
	strh	r7, [sp, #28]	@ movhi
	bl	writetospi
	mov	ip, #189
	add	r3, sp, #24
	movs	r2, #1
	add	r1, sp, #28
	movs	r0, #2
	strh	r7, [sp, #28]	@ movhi
	strb	ip, [sp, #24]
	bl	writetospi
	ldr	r2, [fp]
	movs	r3, #100
	mul	r3, r3, r2
	ldr	r2, .L521+4
	umull	r2, r3, r2, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #20]
	ldr	r3, [sp, #20]
	subs	r2, r3, #1
	str	r2, [sp, #20]
	cbz	r3, .L512
.L510:
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
	bne	.L510
.L512:
	movs	r2, #2
	movw	r7, #2410
	add	r3, sp, #24
	add	r1, sp, #28
	mov	r0, r2
	strh	r7, [sp, #28]	@ movhi
	bl	readfromspi
	ldrb	r3, [sp, #25]	@ zero_extendqisi2
	ldrb	r7, [sp, #24]	@ zero_extendqisi2
	add	r7, r7, r3, lsl #8
	ubfx	r7, r7, #0, #12
	sub	r0, r7, r9
	bl	abs
	cmp	r0, r10
	bge	.L511
	mov	r10, r0
	str	r6, [sp]
.L511:
	cmp	r7, r9
	ite	ls
	bicls	r8, r8, r4
	movhi	r8, r6
	subs	r5, r5, #1
	bne	.L514
	ldr	r0, [sp, #8]
	movs	r2, #1
	movs	r4, #182
	add	r3, sp, #24
	add	r1, sp, #28
	strb	r0, [sp, #24]
	mov	r0, r2
	strb	r4, [sp, #28]
	bl	writetospi
	movs	r2, #2
	ldr	r5, [sp, #4]
	movw	r4, #1270
	add	r3, sp, #24
	add	r1, sp, #28
	mov	r0, r2
	strh	r4, [sp, #28]	@ movhi
	strh	r5, [sp, #24]	@ movhi
	bl	writetospi
	ldr	r3, [sp, #12]
	add	r1, sp, #24
	movs	r2, #4
	add	r0, sp, #28
	movs	r4, #168
	str	r3, [sp, #24]
	bl	memcpy
	add	r3, sp, #28
	movs	r2, #4
	add	r1, sp, #16
	movs	r0, #1
	strb	r4, [sp, #16]
	bl	writetospi
	ldr	r0, [sp]
	add	sp, sp, #36
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L522:
	.align	2
.L521:
	.word	2074368
	.word	-776530087
	.word	SystemCoreClock
	.size	dwt_calcbandwidthtempadj, .-dwt_calcbandwidthtempadj
	.section	.text._dwt_computetxpowersetting,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	_dwt_computetxpowersetting
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	_dwt_computetxpowersetting, %function
_dwt_computetxpowersetting:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, #0
	push	{r4, r5, r6, r7, r8, lr}
	mov	lr, r0
	mov	r0, ip
.L528:
	lsr	r5, lr, ip
	and	r7, r5, #31
	ubfx	r8, r5, #5, #3
	adds	r4, r1, r7
	subs	r3, r4, #4
	cmp	r3, #16
	bls	.L529
	mov	r2, r1
	movs	r5, #0
.L527:
	cmp	r4, #20
	add	r5, r5, #1
	ite	gt
	subgt	r2, r2, #5
	addle	r2, r2, #5
	adds	r3, r2, r7
	subs	r6, r3, #4
	mov	r4, r3
	cmp	r6, #16
	bhi	.L527
.L524:
	add	r5, r5, r8
	uxtb	r3, r3
	uxtb	r5, r5
	orr	r3, r3, r5, lsl #5
	lsl	r3, r3, ip
	add	ip, ip, #8
	cmp	ip, #32
	orr	r0, r0, r3
	bne	.L528
	pop	{r4, r5, r6, r7, r8, pc}
.L529:
	mov	r3, r4
	movs	r5, #0
	b	.L524
	.size	_dwt_computetxpowersetting, .-_dwt_computetxpowersetting
	.global	__aeabi_dsub
	.global	__aeabi_dmul
	.global	__aeabi_dadd
	.global	__aeabi_d2iz
	.section	.text.dwt_calcpowertempadj,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_calcpowertempadj
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_calcpowertempadj, %function
dwt_calcpowertempadj:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L543
	push	{r4, r5, r6, r7, r8, lr}
	ldrb	r3, [r3, r0]	@ zero_extendqisi2
	mov	r4, r1
	ldr	r5, .L543+4
	add	r5, r5, r3, lsl #3
	vmov	r0, r1, d0
	vmov	r2, r3, d1
	bl	__aeabi_dsub
	ldrd	r2, [r5]
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	bl	__aeabi_dadd
	bl	__aeabi_d2iz
	movs	r1, #0
	mov	r7, r0
	mov	r0, r1
.L538:
	lsr	r3, r4, r1
	and	lr, r3, #31
	ubfx	r2, r3, #5, #3
	add	ip, r7, lr
	sub	r3, ip, #4
	cmp	r3, #16
	bls	.L539
	mov	r5, r7
	movs	r6, #0
.L537:
	cmp	ip, #20
	add	r6, r6, #1
	ite	gt
	subgt	r5, r5, #5
	addle	r5, r5, #5
	add	r3, r5, lr
	sub	r8, r3, #4
	mov	ip, r3
	cmp	r8, #16
	bhi	.L537
.L534:
	add	r2, r2, r6
	uxtb	r3, r3
	uxtb	r2, r2
	orr	r3, r3, r2, lsl #5
	lsls	r3, r3, r1
	adds	r1, r1, #8
	cmp	r1, #32
	orr	r0, r0, r3
	bne	.L538
	pop	{r4, r5, r6, r7, r8, pc}
.L539:
	mov	r3, ip
	movs	r6, #0
	b	.L534
.L544:
	.align	2
.L543:
	.word	chan_idx
	.word	txpwr_compensation
	.size	dwt_calcpowertempadj, .-dwt_calcpowertempadj
	.section	.text.dwt_calcpgcount,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	dwt_calcpgcount
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv5-sp-d16
	.type	dwt_calcpgcount, %function
dwt_calcpgcount:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	movs	r2, #1
	sub	sp, sp, #28
	movs	r4, #54
	mov	r8, r0
	add	r3, sp, #16
	add	r1, sp, #20
	mov	r0, r2
	strb	r4, [sp, #20]
	bl	readfromspi
	movs	r2, #2
	movw	r4, #1142
	add	r3, sp, #16
	add	r1, sp, #20
	mov	r0, r2
	strh	r4, [sp, #20]	@ movhi
	movs	r6, #0
	ldrb	fp, [sp, #16]	@ zero_extendqisi2
	bl	readfromspi
	ldrb	r2, [sp, #17]	@ zero_extendqisi2
	movs	r5, #40
	ldrb	r4, [sp, #16]	@ zero_extendqisi2
	movs	r0, #1
	add	r3, sp, #20
	add	r1, sp, #12
	add	r4, r4, r2, lsl #8
	movs	r2, #4
	mov	r9, r0
	str	r6, [sp, #16]
	uxth	r4, r4
	strb	r5, [sp, #12]
	mov	r10, #182
	movw	r7, #1270
	str	r4, [sp]
	bl	readfromspi
	add	r1, sp, #20
	movs	r2, #4
	add	r0, sp, #16
	mov	r5, r6
	bl	memcpy
	ldr	r4, [sp, #16]
	add	r3, sp, #16
	add	r1, sp, #20
	mov	r2, r9
	mov	r0, r9
	str	r4, [sp, #4]
	movs	r4, #10
	strb	r10, [sp, #20]
	strb	r9, [sp, #16]
	bl	writetospi
	movs	r2, #2
	add	r3, sp, #16
	add	r1, sp, #20
	strh	r6, [sp, #16]	@ movhi
	mov	r0, r2
	strh	r7, [sp, #20]	@ movhi
	bl	writetospi
	ldr	r3, .L555
	add	r1, sp, #16
	movs	r2, #4
	movs	r6, #168
	add	r0, sp, #20
	str	r3, [sp, #16]
	bl	memcpy
	add	r1, sp, #12
	add	r3, sp, #20
	movs	r2, #4
	mov	r0, r9
	strb	r6, [sp, #12]
	bl	writetospi
	mov	ip, #34
	add	r3, sp, #16
	mov	r2, r9
	mov	r0, r9
	add	r1, sp, #20
	ldr	r7, .L555+4
	ldr	r6, .L555+8
	strb	r10, [sp, #20]
	strb	ip, [sp, #16]
	bl	writetospi
.L548:
	movw	ip, #3050
	add	r3, sp, #16
	movs	r2, #1
	add	r1, sp, #20
	movs	r0, #2
	strh	ip, [sp, #20]	@ movhi
	movw	r9, #2282
	strb	r8, [sp, #16]
	bl	writetospi
	mov	ip, #188
	add	r3, sp, #16
	movs	r2, #1
	add	r1, sp, #20
	movs	r0, #2
	strb	ip, [sp, #16]
	strh	r9, [sp, #20]	@ movhi
	bl	writetospi
	mov	ip, #189
	add	r3, sp, #16
	movs	r2, #1
	add	r1, sp, #20
	movs	r0, #2
	strh	r9, [sp, #20]	@ movhi
	strb	ip, [sp, #16]
	bl	writetospi
	ldr	r2, [r7]
	movs	r3, #100
	mul	r3, r3, r2
	umull	r2, r3, r6, r3
	lsrs	r3, r3, #13
	str	r3, [sp, #12]
	ldr	r3, [sp, #12]
	subs	r2, r3, #1
	str	r2, [sp, #12]
	cbz	r3, .L546
.L547:
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
	bne	.L547
.L546:
	movs	r2, #2
	movw	ip, #2410
	add	r3, sp, #16
	add	r1, sp, #20
	mov	r0, r2
	strh	ip, [sp, #20]	@ movhi
	bl	readfromspi
	ldrb	r2, [sp, #17]	@ zero_extendqisi2
	ldrb	r3, [sp, #16]	@ zero_extendqisi2
	subs	r4, r4, #1
	add	r3, r3, r2, lsl #8
	ubfx	r3, r3, #0, #12
	add	r5, r5, r3
	bne	.L548
	movs	r2, #1
	movs	r4, #182
	add	r3, sp, #16
	add	r1, sp, #20
	mov	r0, r2
	strb	r4, [sp, #20]
	strb	fp, [sp, #16]
	bl	writetospi
	movs	r2, #2
	ldr	r6, [sp]
	movw	r4, #1270
	add	r3, sp, #16
	add	r1, sp, #20
	mov	r0, r2
	strh	r4, [sp, #20]	@ movhi
	movs	r4, #168
	strh	r6, [sp, #16]	@ movhi
	bl	writetospi
	ldr	r3, [sp, #4]
	add	r1, sp, #16
	movs	r2, #4
	add	r0, sp, #20
	str	r3, [sp, #16]
	bl	memcpy
	add	r3, sp, #20
	movs	r2, #4
	add	r1, sp, #8
	movs	r0, #1
	strb	r4, [sp, #8]
	bl	writetospi
	ldr	r0, .L555+12
	umull	r3, r0, r0, r5
	ubfx	r0, r0, #3, #16
	add	sp, sp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L556:
	.align	2
.L555:
	.word	2074368
	.word	SystemCoreClock
	.word	-776530087
	.word	-858993459
	.size	dwt_calcpgcount, .-dwt_calcpgcount
	.section	.rodata.CSWTCH.20,"a"
	.align	2
	.set	.LANCHOR0,. + 0
	.type	CSWTCH.20, %object
	.size	CSWTCH.20, 24
CSWTCH.20:
	.word	0
	.word	37408
	.word	37408
	.word	37408
	.word	0
	.word	0
	.section	.rodata.CSWTCH.21,"a"
	.align	2
	.set	.LANCHOR1,. + 0
	.type	CSWTCH.21, %object
	.size	CSWTCH.21, 24
CSWTCH.21:
	.word	0
	.word	14
	.word	3
	.word	78
	.word	3
	.word	3
	.section	.rodata.CSWTCH.22,"a"
	.align	2
	.set	.LANCHOR2,. + 0
	.type	CSWTCH.22, %object
	.size	CSWTCH.22, 24
CSWTCH.22:
	.word	0
	.word	4132
	.word	6180
	.word	6180
	.word	0
	.word	36
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"
