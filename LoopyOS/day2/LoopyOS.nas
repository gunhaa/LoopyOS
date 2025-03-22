; hello-os
; TAB=4

		ORG		0x7c00			

JMP		entry 
DB		0x90
DB 		"LoopyIPL" ; 부트섹터의 이름
DW 		512 ; 1섹터의 크기(바이트 단위, 512)
DB 		1 ; 클러스터의 크기(1섹터)
DW 		1 ; 예약된 섹터의 수
DB 		2 ; 디스크의 FAT 테이블 수
DW 		224 ; 루트 디렉토리 엔트리의 수(보통은 224엔트리)
DW 		2880 ; 디스크의 총 섹터 수(2880임, 플로피 디스크)
DB 		0xf0 ; 미디어 타입(0xf0으로 해야함, 1.44mb 플로피디스크)
DW 		9 ; 하나의 FAT 테이블의 섹터 수(9섹터로 해야함)
DW 		18 ; 1트랙에 몇 섹터가 있는가(18로 해야함)
DW 		2 ; 헤드의 수(2로 해야함)
DD 		0 ; 파티션을 사용하지 않으므로 이곳은 반드시 0
DD 		2880 ; 이 드라이브의 크기를 한번 더 씀
DB 		0,0,0x29 ; 볼륨 ID가 포함된 부트 섹터임을 표시하는 마커
DD 		0xffffffff ; 볼륨의 시리얼 번호
DB 		"Loopy-OS    " ; 디스크의 이름
DB 		"FAT12    " ; 포맷의 이름
RESB 	18 ; 18바이트 남겨둠

; 프로그램 본체

entry:
		MOV		AX, 0			
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg		
putloop:
		MOV		AL,[SI]			
		ADD		SI, 1			
		CMP		AL,0
		JE		fin
		MOV		AH, 0x0e		
		MOV		BX, 15			
		INT		0x10			
		JMP		putloop
fin:
		HLT					
		JMP		fin			

msg:
		DB		0x0a, 0x0a		
		DB		"Loopy, hello world"
		DB		0x0a			
		DB		0

		RESB	0x7dfe-$			

		DB		0x55, 0xaa
