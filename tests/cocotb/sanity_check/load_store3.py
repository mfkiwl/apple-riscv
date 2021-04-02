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
    or		x5, x1, x0
    or		x5, x2, x5
    or		x5, x3, x5
    or		x5, x4, x5
    sw		x5, 0(x0)

    lb		x6, 0(x0)
    lb		x7, 1(x0)
    lb		x8, 2(x0)
    lb		x9, 3(x0)

    lbu		x10, 0(x0)
    lbu		x11, 1(x0)
    lbu		x12, 2(x0)
    lbu		x13, 3(x0)

    lh		x14, 0(x0)
    lh		x15, 2(x0)
    lhu		x16, 0(x0)
    lhu		x17, 2(x0)


 === Machine Code ===


"""

imem_data = [
0x0aa06093,
0x05506113,
0x0aa06193,
0x05506213,
0x01809093,
0x01011113,
0x00819193,
0x0000e2b3,
0x005162b3,
0x0051e2b3,
0x005262b3,
0x00502023,
0x00000303,
0x00100383,
0x00200403,
0x00300483,
0x00004503,
0x00104583,
0x00204603,
0x00304683,
0x00001703,
0x00201783,
0x00005803,
0x00205883
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

