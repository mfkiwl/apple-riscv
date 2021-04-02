"""
 === Description ===

 Testing the forward logic

 === ASM ===

.data
.equ a,  0xFF


.text
main:
	ori     x1, x0, a		#  0xFF
	or      x2, x0, x1
	or      x3, x0, x1
	or      x4, x0, x1
	ori     x5, x0, a		#  0xFF
	or      x6, x5, x0
	or      x7, x5, x0
	or      x8, x5, x0
	ori     x9, x0, a		#  0xFF
	or      x10, x9, x9
	or      x11, x9, x9
	or      x12, x9, x9

	ori 	x13, x0, a
	addi	x14, x13, 1
	addi 	x15, x13, 1
	addi	x16, x13, 1

	# END
	or 		x0,	x0, x0


 === Machine Code ===

Addr            MCode           Instruction

0x00000000		0x0FF06093		ori x1 x0 255
0x00000004		0x00106133		or x2 x0 x1
0x00000008		0x001061B3		or x3 x0 x1
0x0000000C		0x00106233		or x4 x0 x1
0x00000010		0x0FF06293		ori x5 x0 255
0x00000014		0x0002E333		or x6 x5 x0
0x00000018		0x0002E3B3		or x7 x5 x0
0x0000001C		0x0002E433		or x8 x5 x0
0x00000020		0x0FF06493		ori x9 x0 255
0x00000024		0x0094E533		or x10 x9 x9
0x00000028		0x0094E5B3		or x11 x9 x9
0x0000002C		0x0094E633		or x12 x9 x9
0x00000030		0x0FF06693		ori x13 x0 255
0x00000034		0x00168713		addi x14 x13 1
0x00000038		0x00168793		addi x15 x13 1
0x0000003C		0x00168813		addi x16 x13 1
0x00000040		0x00006033		or x0 x0 x0

"""

imem_data = [
0x0FF06093,
0x00106133,
0x001061B3,
0x00106233,
0x0FF06293,
0x0002E333,
0x0002E3B3,
0x0002E433,
0x0FF06493,
0x0094E533,
0x0094E5B3,
0x0094E633,
0x0FF06693,
0x00168713,
0x00168793,
0x00168813,
0x00006033
]

expected_register = {
1 :  0xFF,
2 :  0xFF,
3 :  0xFF,
4 :  0xFF,
5 :  0xFF,
6 :  0xFF,
7 :  0xFF,
8 :  0xFF,
9 :  0xFF,
10:  0xFF,
11:  0xFF,
12:  0xFF,
13:  0xFF,
14:  0x100,
15:  0x100,
16:  0x100
}

