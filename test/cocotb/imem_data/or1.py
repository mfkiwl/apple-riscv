"""
 === Description ===

 Simple ORI/OR instruction test. Test the basic function of the cpu pipeline

 === ASM ===

.text
main:
    ori     x0, x0, 1
	ori	    x0, x0, 0
	ori	    x0, x0, 0
	ori	    x0, x0, 0
    or      x2, x1, x0
    or      x1, x1, x0


 === Machine Code ===

Addr            MCode           Instruction

0x00000000		0x00106093		ori x1 x0 1
0x00000004		0x00006013		ori x0 x0 0
0x00000008		0x00006013		ori x0 x0 0
0x0000000C		0x00006013		ori x0 x0 0
0x00000010		0x0000E133		or x2 x1 x0
0x00000014		0x0000E0B3		or x1 x1 x0

"""

imem_data = [
    0x00106093,
    0x00006013,
    0x00006013,
    0x00006013,
    0x0000E133,
    0x0000E0B3
]

expected_register = {
    1 : 1,
    2 : 1
}