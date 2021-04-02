"""
 === Description ===

 Testing the data dependency on the load word logic.
 Forward is not working for this. Only stall works

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
    sw		x5,	 0(x0)
    ori		x7, x0, 0
    ori		x7, x0, 0
    ori		x7, x0, 0
	lw		x6, 0(x0)
    ori		x7, x6, 0
	lw		x8, 0(x0)
    or		x9, x8, x0
	lw		x10, 0(x0)
    or		x11, x0, x10
	lw		x12, 0(x0)
    or		x13, x12, x12

 === Machine Code ===

0aa06093
05506113
0aa06193
05506213
01809093
01011113
00819193
0000e2b3
005162b3
0051e2b3
005262b3
00502023
00006393
00006393
00006393
00002303
00036393
00002403
000464b3
00002503
00a065b3
00002603
00c666b3



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
0x00006393,
0x00006393,
0x00006393,
0x00002303,
0x00036393,
0x00002403,
0x000464b3,
0x00002503,
0x00a065b3,
0x00002603,
0x00c666b3
]

expected_register = {
1 :  0xaa000000,
2 :  0x00550000,
3 :  0x0000aa00,
4 :  0x00000055,
5 :  0xaa55aa55,
6 :  0xaa55aa55,
7 :  0xaa55aa55,
8 :  0xaa55aa55,
9 :  0xaa55aa55,
10 :  0xaa55aa55,
11 :  0xaa55aa55,
12 :  0xaa55aa55,
13 :  0xaa55aa55
}

