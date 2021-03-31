"""
 === Description ===

 Simple logic and arithmetic instruction test.
 Mainly test the logic operation and arithmetic operation with unsigned value

 === ASM ===

.data
.equ a, 0xAA
.equ b, 0x55
.equ c, 0xFF

.text
main:
	# Set some value to register
	ori     x1, x0, a		# 0xAA
	ori     x2, x0, b		# 0x55
	ori     x3, x0, c		# 0xFF
	ori		x4, x0, 0x1
	ori		x5, x0, 0x2
	or 		x0,	x0, x0
	or 		x0,	x0, x0
	or 		x0,	x0, x0

	#AND
	and 	x6, x3, x2		# => 0x55
	andi	x7, x3, b		# => 0x55
	and		x8, x1, x2		# => 0x00

	#OR
	or		x9, x1, x2		# => 0xFF
	ori		x10, x1, b		# => 0xFF

	#ADD
	add		x11, x1, x1		# => 0x154
	addi	x12, x1, a  	# => 0x154
	add		x13, x4, x5		# => 0x3

	#SUB
	sub		x14, x5, x4 	# => 1
	sub 	x15, x1, x3		# => 0xFFFFFFAB

	#SLTU
	sltu	x16, x4, x5		# => 1
	sltu	x17, x5, x4		# => 0
	sltiu 	x18, x4, 0x5 	# => 1

	# END
	or 		x0,	x0, x0

 === Machine Code ===

Addr            MCode           Instruction

0x00000000		0x0AA06093		ori x1 x0 170
0x00000004		0x05506113		ori x2 x0 85
0x00000008		0x0FF06193		ori x3 x0 255
0x0000000C		0x00106213		ori x4 x0 1
0x00000010		0x00206293		ori x5 x0 2
0x00000014		0x00006033		or x0 x0 x0
0x00000018		0x00006033		or x0 x0 x0
0x0000001C		0x00006033		or x0 x0 x0
0x00000020		0x0021F333		and x6 x3 x2
0x00000024		0x0551F393		andi x7 x3 85
0x00000028		0x0020F433		and x8 x1 x2
0x0000002C		0x0020E4B3		or x9 x1 x2
0x00000030		0x0550E513		ori x10 x1 85
0x00000034		0x001085B3		add x11 x1 x1
0x00000038		0x0AA08613		addi x12 x1 170
0x0000003C		0x005206B3		add x13 x4 x5
0x00000040		0x40428733		sub x14 x5 x4
0x00000044		0x403087B3		sub x15 x1 x3
0x00000048		0x00523833		sltu x16 x4 x5
0x0000004C		0x0042B8B3		sltu x17 x5 x4
0x00000050		0x00523913		sltiu x18 x4 5
0x00000054		0x00006033		or x0 x0 x0



"""

imem_data = [
0x0AA06093,
0x05506113,
0x0FF06193,
0x00106213,
0x00206293,
0x00006033,
0x00006033,
0x00006033,
0x0021F333,
0x0551F393,
0x0020F433,
0x0020E4B3,
0x0550E513,
0x001085B3,
0x0AA08613,
0x005206B3,
0x40428733,
0x403087B3,
0x00523833,
0x0042B8B3,
0x00523913,
0x00006033
]

expected_register = {
1 : 0xAA,
2 : 0x55,
3 : 0xFF,
4 : 0x1,
5 : 0x2,
6 : 0x55,
7 : 0x55,
8 : 0x0,
9 : 0xFF,
10: 0xFF,
11: 0x154,
12: 0x154,
13: 0x3,
14: 0x1,
15: 0xFFFFFFAB,
16: 0x1,
17: 0x0,
18: 0x1
}

