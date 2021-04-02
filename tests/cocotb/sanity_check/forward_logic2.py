"""
 === Description ===

 Testing the forward logic. Tests the I-type

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
    ori		x6, x5, 0x0F


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
00f2e313


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
0x00f2e313
]

expected_register = {
1 :  0xaa000000,
2 :  0x00550000,
3 :  0x0000aa00,
4 :  0x00000055,
5 :  0xaa55aa55,
6 :  0xaa55aa5f
}

