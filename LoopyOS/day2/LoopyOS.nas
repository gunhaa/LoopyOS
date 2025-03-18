; hello-os
; TAB=4

		ORG		0x7c00			; 메모리 내 어디에 로딩되는가(origin, 시작점)
								; 실행 시 PC의 메모리 내 어디에 로딩되는 지를 어셈블러에게 가르쳐주기 위한 명령
								; 10진수=>31744(0x7c00) 를 사용한다
; 이하는 표준 FAT12 포맷 플로피디스크를 위한 서술

JMP		entry ; JMP 0x7c50과 같다, 어셈블리어에서 레이블은 단지 숫자에 불과하다
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
		MOV		AX, 0			; 레지스터 초기화
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg			; msg는 0x4c74라서 해당 명령은 SI에 0x7c74를 넣는 것이다
putloop:
		MOV		AL,[SI]			; []기호는 어셈블리어에서 메모리를 뜻한다
								; CPU의 기억용량은 모든 레지스터와 세그먼트 레지스터를 합쳐도 44byte밖에 안된다
								; CPU가 기계어를 실행할 떄는 메모리로부터 1명령씩 읽어들여 차례로 실행한다
								; 레지스터는 계산을 할 수 있고, 메모리는 많이 있으니 많이 넣을 수 있다
		ADD		SI, 1			;  SI에 1을 더한다
		CMP		AL,0
		JE		fin
		MOV		AH, 0x0e		; 한 문자 표시 기능
		MOV		BX, 15			; 컬러코드
		INT		0x10			; 비디오 BIOS 호출
		JMP		putloop
fin:
		HLT					; CPU를 정지시킴
		JMP		fin			; 무한 루프

msg:
		DB		0x0a, 0x0a		; 줄바꿈 2개
		DB		"Loopy, hello world"
		DB		0x0a			; 줄 바꿈
		DB		0

		RESB	0x7dfe-$			; 지정 메모리 위치까지 0으로 채움

		DB		0x55, 0xaa

; 부트 섹터 이외의 부분에 기술
; 현재는 미사용 코드
;		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
;		RESB	4600
;		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
;		RESB	1469432
; cmd에서 asm, makeimg, run 명령어로 만들 수 있다