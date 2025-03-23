void io_hlt(void);

void HariMain(void)
{
	int i; /* 변수 선언.i라고 하는 변수는 32 비트 정수형 */
	char *p; /* p라고 하는 변수는 BYTE [...]용 번지 */

	for (i = 0xa0000; i <= 0xaffff; i++) {

		//ver3
		p = (char *) 0xa0000; /* 번지를 대입 */

		for( i = 0 ; i <= 0xffff; i++){
			p[i] = i & 0x0f;
		}

		/* 이것으로 write_mem8(i, i & 0x0f); 대신 */
	}

	for (;;) {
		io_hlt();
	}
}
