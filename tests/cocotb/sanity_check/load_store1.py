"""
 === Description ===

SW and LW test

 === ASM ===

.text
main:
	# Set some value to register
	ori     x1, x0, 0xFF
	slli	x2, x1, 8
	slli	x3, x1, 16
	slli	x4, x1, 24
    ori		x5, x0, -1

  	# SW/LW test
    sw		x1, 0(x0)
    sw		x2, 4(x0)
    sw		x3, 8(x0)
    sw		x4, 0xc(x0)
    sw		x5, 0x10(x0)

    lw		x6, 0(x0)
    lw		x7, 4(x0)
    lw		x8, 8(x0)
    lw		x9, 0xc(x0)
    lw		x10, 0x10(x0)

 === Machine Code ===

0ff06093
00809113
01009193
01809213
fff06293
00102023
00202223
00302423
00402623
00502823
00002303
00402383
00802403
00c02483
01002503

"""

imem_data = [
0x0ff06093,
0x00809113,
0x01009193,
0x01809213,
0xfff06293,
0x00102023,
0x00202223,
0x00302423,
0x00402623,
0x00502823,
0x00002303,
0x00402383,
0x00802403,
0x00c02483,
0x01002503
]

expected_register = {
1 : 0xff,
2 : 0xff00,
3 : 0xff0000,
4 : 0xff000000,
5 : 0xffffffff,
6 : 0xff,
7 : 0xff00,
8 : 0xff0000,
9 : 0xff000000,
10: 0xffffffff
}

