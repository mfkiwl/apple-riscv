"""
 === Description ===

Test LUI/AUIPC

 === ASM ===

.data
main:
	# Set some value to register
	ori     x1, x0, 0
	ori     x2, x0, 0
	ori     x3, x0, 0
	ori     x4, x0, 0
	lui		x1, 0xFFFFF
    auipc	x2, 0xFFFFF


 === Machine Code ===

00006093
00006113
00006193
00006213
fffff0b7
fffff117


"""

imem_data = [
0x00006093,
0x00006113,
0x00006193,
0x00006213,
0xfffff0b7,
0xfffff117
]

expected_register = {
1 : 0xfffff000,
2 : 0xfffff014
}
