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
  li      x31, 0x01000000
  # SW/LW test
  sw		x1, 0(x31)
  sw		x2, 4(x31)
  sw		x3, 8(x31)
  sw		x4, 0xc(x31)
  sw		x5, 0x10(x31)
  lw		x6, 0(x31)
  lw		x7, 4(x31)
  lw		x8, 8(x31)
  lw		x9, 0xc(x31)
  lw		x10, 0x10(x31)

 === Machine Code ===

0ff06093
00809113
01009193
01809213
fff06293
01000fb7
000f8f93
001fa023
002fa223
003fa423
004fa623
005fa823
000fa303
004fa383
008fa403
00cfa483
010fa503


"""

imem_data = [
0x0ff06093,
0x00809113,
0x01009193,
0x01809213,
0xfff06293,
0x01000fb7,
0x000f8f93,
0x001fa023,
0x002fa223,
0x003fa423,
0x004fa623,
0x005fa823,
0x000fa303,
0x004fa383,
0x008fa403,
0x00cfa483,
0x010fa503,
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

