"""
 === Description ===

LB and LH test

 === ASM ===

.text
main:

	ori     x1, x0, 0xAA
	ori     x2, x0, 0x55
	ori     x3, x0, 0xAA
	ori     x4, x0, 0x55
	slli	x1, x1, 24
	slli	x2, x2, 16
	slli	x3, x3, 8
    li      x31, 0x01000000
    or		x5, x1, x0
    or		x5, x2, x5
    or		x5, x3, x5
    or		x5, x4, x5
    sw		x5, 0(x31)

    lb		x6, 0(x31)
    lb		x7, 1(x31)
    lb		x8, 2(x31)
    lb		x9, 3(x31)

    lbu		x10, 0(x31)
    lbu		x11, 1(x31)
    lbu		x12, 2(x31)
    lbu		x13, 3(x31)

    lh		x14, 0(x31)
    lh		x15, 2(x31)
    lhu		x16, 0(x31)
    lhu		x17, 2(x31)


 === Machine Code ===

0aa06093
05506113
0aa06193
05506213
01809093
01011113
00819193
01000fb7
000f8f93
0000e2b3
005162b3
0051e2b3
005262b3
005fa023
000f8303
001f8383
002f8403
003f8483
000fc503
001fc583
002fc603
003fc683
000f9703
002f9783
000fd803
002fd883


"""

imem_data = [
0x0aa06093,
0x05506113,
0x0aa06193,
0x05506213,
0x01809093,
0x01011113,
0x00819193,
0x01000fb7,
0x000f8f93,
0x0000e2b3,
0x005162b3,
0x0051e2b3,
0x005262b3,
0x005fa023,
0x000f8303,
0x001f8383,
0x002f8403,
0x003f8483,
0x000fc503,
0x001fc583,
0x002fc603,
0x003fc683,
0x000f9703,
0x002f9783,
0x000fd803,
0x002fd883,
]

expected_register = {
1 : 0xaa000000,
2 : 0x550000,
3 : 0xaa00,
4 : 0x55,
5 : 0xaa55aa55,
6 : 0x55,
7 : 0xffffffaa,
8 : 0x55,
9 : 0xffffffaa,
10: 0x55,
11: 0xaa,
12: 0x55,
13: 0xaa,
14: 0xffffaa55,
15: 0xffffaa55,
16: 0x0000aa55,
17: 0x0000aa55
}

