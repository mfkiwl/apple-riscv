"""
 === Description ===

Test BLTU/BGEU

 === ASM ===


.text
main:
	# Set some value to register
	ori     x1, x0, -3
	ori     x2, x0, 2
	ori     x3, x0, -1
	ori     x4, x0, 0
	bltu	x2, x3, BLTU_TAKEN
    ori		x4,	x0, 1
BLTU_TAKEN:
	ori     x5, x0, 0
	ori     x6, x0, 0
	ori		x5, x0, 1
    bltu	x3, x2, BLTU_NOT_TAKEN
    ori		x6, x0, 1
BLTU_NOT_TAKEN:
	ori		x7	x0,	0
    ori		x0,	x0, 0
    bgeu	x1,	x1,	BGEU_TAKEN
    ori		x7, x0, 1
BGEU_TAKEN:
	ori		x8, x0, 0
    bgeu	x2,	x1, BGEU_NOT_TAKEN
    ori		x8,	x0,	1
BGEU_NOT_TAKEN:
	ori		x9	x0, 1
    ori		x10 x0, 0
    bgeu	x1,	x3, BGEU_NOT_TAKEN_2
    ori		x10, x0,1
BGEU_NOT_TAKEN_2:
	ori		x11,x0, 1
END:
    ori		x0, x0, 0

    ### Expected result ###
    # We should see
    # x4 => 0
    # x5 => 1
    # x6 => 1
    # x7 => 0
    # x8 => 1
    # x9 => 1
    # x10 => 1
    # x11 => 1

 === Machine Code ===

ffd06093
00206113
fff06193
00006213
00316463
00106213
00006293
00006313
00106293
0021e463
00106313
00006393
00006013
0010f463
00106393
00006413
00117463
00106413
00106493
00006513
0030f463
00106513
00106593
00006013


"""

imem_data = [
0xffd06093,
0x00206113,
0xfff06193,
0x00006213,
0x00316463,
0x00106213,
0x00006293,
0x00006313,
0x00106293,
0x0021e463,
0x00106313,
0x00006393,
0x00006013,
0x0010f463,
0x00106393,
0x00006413,
0x00117463,
0x00106413,
0x00106493,
0x00006513,
0x0030f463,
0x00106513,
0x00106593,
0x00006013
]

expected_register = {
4 : 0x0,
5 : 0x1,
6 : 0x1,
7 : 0x0,
8 : 0x1,
9 : 0x1,
10 : 0x1,
11 : 0x1
}
