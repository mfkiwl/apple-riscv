"""
 === Description ===

Test BLTU/BGEU

 === ASM ===

.text
main:
	# Set some value to register
	ori     x1, x0, 1
	ori     x2, x0, 2
	ori     x3, x0, 3
	ori     x4, x0, 4

	jalr	x5, x1, 0x18
	ori		x1, x0, 0
	ori		x6,	x0,	6

 === Machine Code ===

00106093
00206113
00306193
00406213
018082e7
00006093
00606313

"""

imem_data = [
0x00106093,
0x00206113,
0x00306193,
0x00406213,
0x018082e7,
0x00006093,
0x00606313,
]

expected_register = {
1 : 0x1,
2 : 0x2,
3 : 0x3,
4 : 0x4,
5 : 0x14,
6 : 0x6,
}
