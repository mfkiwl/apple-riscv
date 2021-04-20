"""
 === Description ===

SB and SH test

 === ASM ===

.text
main:

  	# SB test
	ori     x1, x0, 0x12
	ori     x2, x0, 0x34
	ori     x3, x0, 0x56
	ori     x4, x0, 0x78

    li      x31, 0x01000000
    sw		x0, 0(x31)
    sb		x1, 0(x31)
    sb		x2, 1(x31)
    sb		x3, 2(x31)
    sb		x4, 3(x31)

    lw		x6, 0(x31)

  	# SH test
    ori 	x7, x0, -1
    sw		x0, 4(x31)
    sw		x0, 8(x31)

    sh		x7, 4(x31)
    sh		x7, 10(x31)

    lw		x8, 4(x31)
    lw		x9, 8(x31)

 === Machine Code ===

01206093
03406113
05606193
07806213
01000fb7
000f8f93
000fa023
001f8023
002f80a3
003f8123
004f81a3
000fa303
fff06393
000fa223
000fa423
007f9223
007f9523
004fa403
008fa483



"""

imem_data = [
0x01206093,
0x03406113,
0x05606193,
0x07806213,
0x01000fb7,
0x000f8f93,
0x000fa023,
0x001f8023,
0x002f80a3,
0x003f8123,
0x004f81a3,
0x000fa303,
0xfff06393,
0x000fa223,
0x000fa423,
0x007f9223,
0x007f9523,
0x004fa403,
0x008fa483,
]

expected_register = {
1 : 0x12,
2 : 0x34,
3 : 0x56,
4 : 0x78,

6 : 0x78563412,
7 : 0xffffffff,
8 : 0x0000ffff,
9 : 0xffff0000
}

