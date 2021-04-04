"""
 === Description ===

Test BEQ/BNE

 === ASM ===

.text
main:
	# Set some value to register
	ori     x1, x0, 1
	ori     x2, x0, 2
	ori     x3, x0, 3
	ori     x4, x0, 0
	beq		x1, x0, BEQ_NOT_TAKEN
	# Branch should not taken
    ori		x4,	x0, 1
BEQ_NOT_TAKEN:
	ori     x5, x0, 0
	ori     x6, x0, 0
	ori		x5, x0, 1
    beq		x0, x0, BEQ_TAKEN
    # Branch should taken
    ori		x6, x0, 1
BEQ_TAKEN:
	ori		x7	x0,	0
    ori		x0,	x0, 0
    bne		x0,	x0,	BNE_NOT_TAKEN
    ori		x7, x0, 1
BNE_NOT_TAKEN:
	ori		x8, x0, 0
    bne		x1,	x0, BNE_TAKEN
    ori		x8,	x0,	1
BNE_TAKEN:
	ori		x9	x0, 1
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

 === Machine Code ===

00106093
00206113
00306193
00006213
00008463
00106213
00006293
00006313
00106293
00000463
00106313
00006393
00006013
00001463
00106393
00006413
00009463
00106413
00106493
00006013


"""

imem_data = [
0x00106093,
0x00206113,
0x00306193,
0x00006213,
0x00008463,
0x00106213,
0x00006293,
0x00006313,
0x00106293,
0x00000463,
0x00106313,
0x00006393,
0x00006013,
0x00001463,
0x00106393,
0x00006413,
0x00009463,
0x00106413,
0x00106493,
0x00006013

]

expected_register = {
1 : 0x1,
2 : 0x2,
3 : 0x3,
4 : 0x1,
5 : 0x1,
6 : 0x0,
7 : 0x1,
8 : 0x0,
9 : 0x1
}
