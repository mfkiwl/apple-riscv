"""
 === Description ===

 Simple logic and arithmetic instruction test.
 Mainly test the logic operation and arithmetic operation with signed/negative value

 === ASM ===

.data
.equ a, 100
.equ b, 50
.equ c, -50

.text
main:
	# Set some value to register
	ori     x1, x0, a
	ori     x2, x0, b
	ori     x3, x0, c
	or 		x0,	x0, x0
	or 		x0,	x0, x0
	or 		x0,	x0, x0

	#ADD
	add		x4, x1, x1		# => 100 + 100 = 200
	add		x5, x1, x3		# => 100 + (-50) = 50
	addi	x6, x1, c		# => 100 + (-50) = 50
	add		x7, x3, x3		# => (-50) + (-50) = -100

	#SUB
	sub		x8, x2, x3 		# => 50 - (-50) = 100
	sub 	x9, x3, x2		# => (-50) - 50 = -100

	#SLT
	slt  	x10, x3, x1		# => 1
	slt		x11, x1, x3		# => 0
	sltiu 	x12, x1, -5 	# => 1
	sltiu 	x13, x3, 0x5 	# => 0

	# END
	or 		x0,	x0, x0


 === Machine Code ===

Addr            MCode           Instruction

0x00000000		0x06406093		ori x1 x0 100
0x00000004		0x03206113		ori x2 x0 50
0x00000008		0xFCE06193		ori x3 x0 -50
0x0000000C		0x00006033		or x0 x0 x0
0x00000010		0x00006033		or x0 x0 x0
0x00000014		0x00006033		or x0 x0 x0
0x00000018		0x00108233		add x4 x1 x1
0x0000001C		0x003082B3		add x5 x1 x3
0x00000020		0xFCE08313		addi x6 x1 -50
0x00000024		0x003183B3		add x7 x3 x3
0x00000028		0x40310433		sub x8 x2 x3
0x0000002C		0x402184B3		sub x9 x3 x2
0x00000030		0x0011A533		slt x10 x3 x1
0x00000034		0x0030A5B3		slt x11 x1 x3
0x00000038		0xFFB0B613		sltiu x12 x1 -5
0x0000003C		0x0051B693		sltiu x13 x3 5
0x00000040		0x00006033		or x0 x0 x0


"""

imem_data = [
0x06406093,
0x03206113,
0xFCE06193,
0x00006033,
0x00006033,
0x00006033,
0x00108233,
0x003082B3,
0xFCE08313,
0x003183B3,
0x40310433,
0x402184B3,
0x0011A533,
0x0030A5B3,
0xFFB0B613,
0x0051B693,
0x00006033
]

expected_register = {
1 : 0x64,
2 : 0x32,
3 : 0xFFFFFFCE,
4 : 0xC8,
5 : 0x32,
6 : 0x32,
7 : 0xFFFFFF9C,
8 : 0x00000064,
9 : 0xFFFFFF9C,
10: 0x1,
11: 0x0,
12: 0x1,
13: 0x0
}

