; haribote-os
; TAB=4

		ORG		0xc200			; 이 프로그램이 어디에 로딩되는가

		MOV		AL, 0x13		; VGA 그래픽스, 320 x200x8bit
		MOV		AH,0x00
		INT		0x10		; 비디오 BIOS 호출
fin:
		HLT
		JMP		fin
