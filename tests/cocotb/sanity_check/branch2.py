"""
 === Description ===

Test BLT/BGE

 === ASM ===

.text
main:
	# Set some value to register
	ori     x1, x0, -3
	ori     x2, x0, -2
	ori     x3, x0, -1
	ori     x4, x0, 0
	blt		x1, x1, BLT_NOT_TAKEN
    ori		x4,	x0, 1
BLT_NOT_TAKEN:
	ori     x5, x0, 0
	ori     x6, x0, 0
	ori		x5, x0, 1
    blt		x1, x2, BLT_TAKEN
    ori		x6, x0, 1
BLT_TAKEN:
	ori		x7	x0,	0
    ori		x0,	x0, 0
    bge		x1,	x2,	BGE_NOT_TAKEN
    ori		x7, x0, 1
BGE_NOT_TAKEN:
	ori		x8, x0, 0
    bge		x1,	x1, BGE_TAKEN
    ori		x8,	x0,	1
BGE_TAKEN:
	ori		x9	x0, 1
    ori		x10 x0, 0
    bge		x1,	x1, BGE_TAKEN_2
    ori		x10, x0,1
BGE_TAKEN_2:
	ori		x11,x0, 1
END:
    ori		x0, x0, 0

    ### Expected result ###
    # We should see
    # x4 => 1
    # x5 => 1
    # x6 => 0
    # x7 => 1
    # x8 => 0
    # x9 => 1
    # x10 => 0

 === Machine Code ===

ffd06093
ffe06113
fff06193
00006213
0010c463
00106213
00006293
00006313
00106293
0020c463
00106313
00006393
00006013
0020d463
00106393
00006413
0010d463
00106413
00106493
00006513
0010d463
00106513
00106593
00006013

"""

imem_data = [
0xffd06093,
0xffe06113,
0xfff06193,
0x00006213,
0x0010c463,
0x00106213,
0x00006293,
0x00006313,
0x00106293,
0x0020c463,
0x00106313,
0x00006393,
0x00006013,
0x0020d463,
0x00106393,
0x00006413,
0x0010d463,
0x00106413,
0x00106493,
0x00006513,
0x0010d463,
0x00106513,
0x00106593,
0x00006013

]

expected_register = {
4 : 0x1,
5 : 0x1,
6 : 0x0,
7 : 0x1,
8 : 0x0,
9 : 0x1,
10 : 0x0,
11 : 0x1
}
