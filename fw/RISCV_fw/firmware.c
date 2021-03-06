#include <stdint.h>
#include <stdbool.h>

#include "FatFs/ff.h"

// a pointer to this is a null pointer, but the compiler does not
// know that because "sram" is a linker symbol from sections.lds.
extern uint32_t sram;

#define UART0_BASE 0x02001100
#define UART0_SETUP (*(volatile uint32_t *)((UART0_BASE) + 0x0))
#define UART0_FIFO (*(volatile uint32_t *)((UART0_BASE) + 0x4))
#define UART0_RXREG (*(volatile uint32_t *)((UART0_BASE) + 0x8))
#define UART0_TXREG (*(volatile uint32_t *)((UART0_BASE) + 0xc))

#define UART1_BASE 0x02001200
#define UART1_SETUP (*(volatile uint32_t *)((UART1_BASE) + 0x0))
#define UART1_FIFO (*(volatile uint32_t *)((UART1_BASE) + 0x4))
#define UART1_RXREG (*(volatile uint32_t *)((UART1_BASE) + 0x8))
#define UART1_TXREG (*(volatile uint32_t *)((UART1_BASE) + 0xc))

#define reg_spictrl (*(volatile uint32_t *)0x02000000)
#define reg_leds (*(volatile uint32_t *)0x02000200)

#define reg_hyperram_ctrl_a (*(volatile uint32_t *)0x02010010)
#define reg_hyperram_ctrl_b (*(volatile uint32_t *)0x02010014)

#define CCC_BASE 0x02100100
#define CCC_STATUS (*(volatile uint32_t *)(CCC_BASE + 0x04))

#define CC_ENABLE (*(volatile uint32_t *)(0x02002100))

#define CCC_STREAMER_BASE 0x02002000
#define CCC_STREAM_STATUS (*(volatile uint32_t *)(CCC_STREAMER_BASE + 0x00))
#define CCC_STREAM_START_ADR (*(volatile uint32_t *)(CCC_STREAMER_BASE + 0x04))
#define CCC_STREAM_BUF_SIZE (*(volatile uint32_t *)(CCC_STREAMER_BASE + 0x08))
#define CCC_STREAM_BURST_SIZE (*(volatile uint32_t *)(CCC_STREAMER_BASE + 0x0C))
#define CCC_STREAM_TX_CNT (*(volatile uint32_t *)(CCC_STREAMER_BASE + 0x10))

#define HRAM0_LATENCY_1 (*(volatile uint32_t *)(0x02200000))
#define HRAM0_LATENCY_2 (*(volatile uint32_t *)(0x02200004))
#define HRAM0_CFG (*(volatile uint32_t *)(0x02200008))

#define HRAM0 (*(volatile uint32_t *)(0x04000000))

// --------------------------------------------------------

extern uint32_t flashio_worker_begin;
extern uint32_t flashio_worker_end;

void flashio(uint8_t *data, int len, uint8_t wrencmd)
{
	uint32_t func[&flashio_worker_end - &flashio_worker_begin];

	uint32_t *src_ptr = &flashio_worker_begin;
	uint32_t *dst_ptr = func;

	while (src_ptr != &flashio_worker_end)
		*(dst_ptr++) = *(src_ptr++);

	((void (*)(uint8_t *, uint32_t, uint32_t))func)(data, len, wrencmd);
}

void set_flash_qspi_flag()
{
	uint8_t buffer_rd[2] = {0x05, 0};
	flashio(buffer_rd, 2, 0);

	uint8_t status_1 = buffer_rd[1];

	buffer_rd[0] = 0x35;
	flashio(buffer_rd, 2, 0);

	uint8_t status_2 = buffer_rd[1];

	/* Enable QSPI */
	status_2 |= (1 << 1);

	uint8_t buffer_wr[3] = {0x01, status_1, status_2};
	flashio(buffer_wr, 3, 0);
}

void set_flash_latency(uint8_t value)
{
	reg_spictrl = (reg_spictrl & ~0x007f0000) | ((value & 15) << 16);
}

// --------------------------------------------------------

void set_latency(uint32_t latency_1x, uint32_t latency_2x)
{
	reg_hyperram_ctrl_a = (latency_2x << 8) | latency_1x;
}

#define DEEP_PWR_DOWN (1 << 15)
#define DRIVE_STRENGTH(x) ((x & 0xe) << 12)
#define RESERVED_1 (0xe << 8)
#define INITIAL_LATENCY(x) ((x & 0xf) << 4)
#define FIXED_LATENCY (1 << 3)
#define HYBRID_BURST (1 << 2)
#define BURST_LENGTH(x) ((x & 0x3) << 0)

void set_hyperram_speed()
{
	//	set_latency(0x9, 0xB);
	reg_hyperram_ctrl_b = (DEEP_PWR_DOWN | DRIVE_STRENGTH(0b000) | RESERVED_1 | INITIAL_LATENCY(0b1110) | HYBRID_BURST | BURST_LENGTH(0b11)) << 16;
	set_latency(0x0B, 0x0B);
}

//--------------------------------------------------------

void putchar(char c)
{
	if (c == '\n')
		putchar('\r');

	while ((UART0_TXREG & (1 << 13)) != 0)
		;

	UART0_TXREG = c;
}

void print(const char *p)
{
	while (*p)
		putchar(*(p++));
}

void print_hex(uint32_t v, int digits)
{
	for (int i = 7; i >= 0; i--)
	{
		char c = "0123456789abcdef"[(v >> (4 * i)) & 15];
		if (c == '0' && i >= digits)
			continue;
		putchar(c);
		digits = i;
	}
}

void print_dec(uint32_t v)
{
	if (v >= 100)
	{
		print(">=100");
		return;
	}

	if (v >= 90)
	{
		putchar('9');
		v -= 90;
	}
	else if (v >= 80)
	{
		putchar('8');
		v -= 80;
	}
	else if (v >= 70)
	{
		putchar('7');
		v -= 70;
	}
	else if (v >= 60)
	{
		putchar('6');
		v -= 60;
	}
	else if (v >= 50)
	{
		putchar('5');
		v -= 50;
	}
	else if (v >= 40)
	{
		putchar('4');
		v -= 40;
	}
	else if (v >= 30)
	{
		putchar('3');
		v -= 30;
	}
	else if (v >= 20)
	{
		putchar('2');
		v -= 20;
	}
	else if (v >= 10)
	{
		putchar('1');
		v -= 10;
	}

	if (v >= 9)
	{
		putchar('9');
		v -= 9;
	}
	else if (v >= 8)
	{
		putchar('8');
		v -= 8;
	}
	else if (v >= 7)
	{
		putchar('7');
		v -= 7;
	}
	else if (v >= 6)
	{
		putchar('6');
		v -= 6;
	}
	else if (v >= 5)
	{
		putchar('5');
		v -= 5;
	}
	else if (v >= 4)
	{
		putchar('4');
		v -= 4;
	}
	else if (v >= 3)
	{
		putchar('3');
		v -= 3;
	}
	else if (v >= 2)
	{
		putchar('2');
		v -= 2;
	}
	else if (v >= 1)
	{
		putchar('1');
		v -= 1;
	}
	else
		putchar('0');
}

char getchar_prompt(char *prompt)
{
	int32_t c = 0x100;
	int flip = 0;

	uint32_t cycles_begin, cycles_now, cycles;
	__asm__ volatile("rdcycle %0"
					 : "=r"(cycles_begin));

	if (prompt)
		print(prompt);

	reg_leds = 0x00010001;
	while (c & 0x100)
	{
		__asm__ volatile("rdcycle %0"
						 : "=r"(cycles_now));
		cycles = cycles_now - cycles_begin;
		if (cycles > 12000000)
		{
			if (prompt)
				print(prompt);
			cycles_begin = cycles_now;
			reg_leds = 0x00010000 | flip;
			flip ^= 1;
		}
		c = UART0_RXREG;
	}
	reg_leds = 0x00010000;
	return c;
}

char getchar()
{
	return getchar_prompt(0);
}

// --------------------------------------------------------

void cmd_read_flash_id()
{
	uint8_t buffer[17] = {0x9F, /* zeros */};
	flashio(buffer, 17, 0);

	for (int i = 1; i <= 16; i++)
	{
		putchar(' ');
		print_hex(buffer[i], 2);
	}
	putchar('\n');
}

// --------------------------------------------------------

uint8_t cmd_read_flash_regs_print(uint32_t addr, const char *name)
{
	set_flash_latency(8);

	uint8_t buffer[6] = {0x65, addr >> 16, addr >> 8, addr, 0, 0};
	flashio(buffer, 6, 0);

	print("0x");
	print_hex(addr, 6);
	print(" ");
	print(name);
	print(" 0x");
	print_hex(buffer[5], 2);
	print("\n");

	return buffer[5];
}

void cmd_read_flash_regs()
{
	print("\n");
	uint8_t sr1v = cmd_read_flash_regs_print(0x800000, "SR1V");
	uint8_t sr2v = cmd_read_flash_regs_print(0x800001, "SR2V");
	uint8_t cr1v = cmd_read_flash_regs_print(0x800002, "CR1V");
	uint8_t cr2v = cmd_read_flash_regs_print(0x800003, "CR2V");
	uint8_t cr3v = cmd_read_flash_regs_print(0x800004, "CR3V");
	uint8_t vdlp = cmd_read_flash_regs_print(0x800005, "VDLP");
}

// --------------------------------------------------------

uint32_t cmd_benchmark(bool verbose, uint32_t *instns_p)
{
	uint8_t data[256];
	uint32_t *words = (void *)data;

	uint32_t x32 = 314159265;

	uint32_t cycles_begin, cycles_end;
	uint32_t instns_begin, instns_end;
	__asm__ volatile("rdcycle %0"
					 : "=r"(cycles_begin));
	__asm__ volatile("rdinstret %0"
					 : "=r"(instns_begin));

	for (int i = 0; i < 20; i++)
	{
		for (int k = 0; k < 256; k++)
		{
			x32 ^= x32 << 13;
			x32 ^= x32 >> 17;
			x32 ^= x32 << 5;
			data[k] = x32;
		}

		for (int k = 0, p = 0; k < 256; k++)
		{
			if (data[k])
				data[p++] = k;
		}

		for (int k = 0, p = 0; k < 64; k++)
		{
			x32 = x32 ^ words[k];
		}
	}

	__asm__ volatile("rdcycle %0"
					 : "=r"(cycles_end));
	__asm__ volatile("rdinstret %0"
					 : "=r"(instns_end));

	if (verbose)
	{
		print("Cycles: 0x");
		print_hex(cycles_end - cycles_begin, 8);
		putchar('\n');

		print("Instns: 0x");
		print_hex(instns_end - instns_begin, 8);
		putchar('\n');

		print("Chksum: 0x");
		print_hex(x32, 8);
		putchar('\n');
	}

	if (instns_p)
		*instns_p = instns_end - instns_begin;

	return cycles_end - cycles_begin;
}

// --------------------------------------------------------

void cmd_benchmark_all()
{
	uint32_t instns = 0;

	print("default        ");
	reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00000000;
	print(": ");
	print_hex(cmd_benchmark(false, &instns), 8);
	putchar('\n');

	for (int i = 8; i > 0; i--)
	{
		print("dspi-");
		print_dec(i);
		print("         ");

		set_flash_latency(i);
		reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00400000;

		print(": ");
		print_hex(cmd_benchmark(false, &instns), 8);
		putchar('\n');
	}

	for (int i = 8; i > 0; i--)
	{
		print("dspi-crm-");
		print_dec(i);
		print("     ");

		set_flash_latency(i);
		reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00500000;

		print(": ");
		print_hex(cmd_benchmark(false, &instns), 8);
		putchar('\n');
	}

	for (int i = 8; i > 0; i--)
	{
		print("qspi-");
		print_dec(i);
		print("         ");

		set_flash_latency(i);
		reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00200000;

		print(": ");
		print_hex(cmd_benchmark(false, &instns), 8);
		putchar('\n');
	}

	for (int i = 8; i > 0; i--)
	{
		print("qspi-crm-");
		print_dec(i);
		print("     ");

		set_flash_latency(i);
		reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00300000;

		print(": ");
		print_hex(cmd_benchmark(false, &instns), 8);
		putchar('\n');
	}

	for (int i = 8; i > 0; i--)
	{
		print("qspi-ddr-");
		print_dec(i);
		print("     ");

		set_flash_latency(i);
		reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00600000;

		print(": ");
		print_hex(cmd_benchmark(false, &instns), 8);
		putchar('\n');
	}

	for (int i = 8; i > 0; i--)
	{
		print("qspi-ddr-crm-");
		print_dec(i);
		print(" ");

		set_flash_latency(i);
		reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00700000;

		print(": ");
		print_hex(cmd_benchmark(false, &instns), 8);
		putchar('\n');
	}

	print("instns         : ");
	print_hex(instns, 8);
	putchar('\n');
}

// --------------------------------------------------------

static void dly_us(UINT n) /* Delay n microseconds (avr-gcc -Os) */
{

	uint32_t cycles_begin, cycles_now, cycles;
	__asm__ volatile("rdcycle %0"
					 : "=r"(cycles_begin));

	uint32_t cycles_total = n * 48;

	while (1)
	{
		__asm__ volatile("rdcycle %0"
						 : "=r"(cycles_now));
		cycles = cycles_now - cycles_begin;
		if (cycles > cycles_total)
		{
			break;
		}
	}
}

FATFS FatFs; /* FatFs work area needed for each volume */
FIL Fil;	 /* File object needed for each open file */

void fatFS_write_fast(void)
{
	UINT bw = 0;
	FRESULT res;

	print("FatFs Test\r\n");

	print("FatFs buff:");
	print_hex(FatFs.win, 8);
	print("\r\nFil Buffer:");

	print_hex(Fil.buf, 8);
	print("\r\n");

	res = f_mount(&FatFs, "", 0); /* Give a work area to the default drive */
	if ((res = f_open(&Fil, "newfile_fast.txt", FA_WRITE | FA_CREATE_ALWAYS)) == FR_OK)
	{ /* Create a file */
		uint8_t *ptr = 0x04000000;

		print("File Open\r\n");

		//	for(int i = 0; i< 1024 && res == FR_OK; i++){
		//		res = f_write(&Fil, ptr, 512, &bw);
		//		ptr += 512;
		//	}
		res = f_write(&Fil, ptr, 512 * 1024, &bw);

		if (res == FR_OK)
		{ /* Write data to the file */
			if ((res = f_close(&Fil)) == FR_OK)
			{   /* Close the file */
				//if (bw == 11 && res == FR_OK) {		/* Lights green LED if data written well */
				print("It Works\r\n");
				//}
			}
		}
	}

	if (res != FR_OK)
	{
		print("Error\r\n");
		print_hex(res, 2);
		print("\r\n");
		print_hex(bw, 4);
		print("\r\n");

		dump(FatFs.win, 0);
	}

	print("Test Complete\r\n");
}

void fatFS_write(void)
{
	UINT bw = 0;
	FRESULT res;

	print("FatFs Test Slow\r\n");

	res = f_mount(&FatFs, "", 0); /* Give a work area to the default drive */
	if ((res = f_open(&Fil, "newfile_slow.txt", FA_WRITE | FA_CREATE_ALWAYS)) == FR_OK)
	{ /* Create a file */
		uint8_t *ptr = 0x04000000;

		print("File Open\r\n");

		for (int i = 0; i < 1024 && res == FR_OK; i++)
		{
			res = f_write(&Fil, ptr, 512, &bw);
			ptr += 512;
		}

		if (res == FR_OK)
		{ /* Write data to the file */
			if ((res = f_close(&Fil)) == FR_OK)
			{   /* Close the file */
				//if (bw == 11 && res == FR_OK) {		/* Lights green LED if data written well */
				print("It Works\r\n");
				//}
			}
		}
	}

	if (res != FR_OK)
	{
		print("Error\r\n");
		print_hex(res, 2);
		print("\r\n");
		print_hex(bw, 4);
		print("\r\n");

		dump(FatFs.win, 0);
	}

	print("Test Complete\r\n");
}

void fatFS_write_expand(void)
{
	UINT bw = 0;
	FRESULT res;

	print("FatFs Test Expand\r\n");

	res = f_mount(&FatFs, "", 0); /* Give a work area to the default drive */
	if ((res = f_open(&Fil, "newfile_expand.txt", FA_WRITE | FA_CREATE_ALWAYS)) == FR_OK)
	{ /* Create a file */
		uint8_t *ptr = 0x04000000;

		print("File Open\r\n");

		/* Find and allocate a 512kb block for us */
		if ((res = f_expand(&Fil, 512 * 1024, 1)) == FR_OK)
		{
			/* Accessing the contiguous file via low-level disk functions */

			/* Get physical location of the file data */
			BYTE drv = Fil.obj.fs->pdrv;
			DWORD lba = Fil.obj.fs->database + Fil.obj.fs->csize * (Fil.obj.sclust - 2);

			/* Write 2048 sectors from top of the file at a time */
			res = disk_write(drv, ptr, lba, 1024);

			if (res == FR_OK)
			{ /* Write data to the file */
				if ((res = f_close(&Fil)) == FR_OK)
				{   /* Close the file */
					//if (bw == 11 && res == FR_OK) {		/* Lights green LED if data written well */
					print("It Works\r\n");
					//}
				}
			}
		}
	}
	if (res != FR_OK)
	{
		print("Error\r\n");
		print_hex(res, 2);
		print("\r\n");
		print_hex(bw, 4);
		print("\r\n");

		dump(FatFs.win, 0);
	}

	print("Test Complete\r\n");
}

uint8_t buff[512] __attribute__((aligned(8)));

void SDMMC_readblock()
{
	disk_initialize(0);

	disk_read(
		0,
		buff,
		0x8000,
		1);

	dump(buff, 512);
}

void SDMMC_writeblock()
{
	disk_initialize(0);

	for (int i = 0; i < 512; i++)
	{
		if (i & 0x04)
		{
			buff[i] = 0xFF;
		}
		else
			buff[i] = 0x00;
	}

	disk_write(
		0,
		buff,
		0x8000,
		1);

	dump(buff, 512);
}

void put_dump(const BYTE *buff, DWORD ofs, WORD cnt)
{
	WORD i;

	//xprintf(PSTR("%08lX:"), ofs);
	print_hex(ofs, 8);
	print(":");

	for (i = 0; i < cnt; i++)
	{
		print(" ");
		print_hex(buff[i], 2);
		//xprintf(PSTR(" %02X"), buff[i]);
	}

	print(" ");
	for (i = 0; i < cnt; i++)
	{
		{
			char c[2];
			c[0] = (buff[i] >= ' ' && buff[i] <= '~') ? buff[i] : '.';
			c[1] = 0;
			print(c);
		}
	}

	print("\r\n");
	//xputc('\n');
}

void dump(const BYTE *buff, WORD cnt)
{
	char *bp;
	WORD ofs;

	for (bp = buff, ofs = 0; ofs < 0x200; bp += 16, ofs += 16)
		put_dump(bp, cnt + ofs, 16);
}

void check_CCC_status()
{
	print("CMOS Capture Controller Status:\r\n");

	print("Pixel count: 0x");
	//	print_hex(CCC,8);
	print("\r\n");
}

void short_delay()
{
	uint32_t cycles_begin, cycles_now, cycles;
	__asm__ volatile("rdcycle %0"
					 : "=r"(cycles_begin));

	while (true)
	{
		__asm__ volatile("rdcycle %0"
						 : "=r"(cycles_now));
		cycles = cycles_now - cycles_begin;
		if (cycles > 48000000)
		{
			break;
		}
	}
}

int flip = 0;

uint32_t data_buf[640];

char c;

void test_uart()
{

	//CCC_START_ADR = (uint32_t)data_buf;
	//CCC_BUF_SIZE = 320;
	//CCC_BURST_SIZE = 1;

	/* Prep the Stream DMA */
	//CCC_STREAM_STATUS = 1;

	/* Gate the data from the camera */
	//CCC_DATA_COUNT = 1;

	short_delay();

	//while(CCC_STREAM_STATUS & 1){

	//}

	for (int i = 0; i < 6; i++)
	{
		c++;
		if (c > '~')
			c = ' ';

		putchar(c);
	}

	flip ^= 1;
	reg_leds = 0x00010000 | flip;
}

void test_ccc()
{

	CCC_STREAM_START_ADR = (uint32_t)data_buf;
	CCC_STREAM_BUF_SIZE = 640;
	CCC_STREAM_BURST_SIZE = 4;

	/* Prep the Stream DMA */
	CCC_STREAM_STATUS = 1;

	/* Gate the data from the camera */
	CCC_STATUS = 1;

	while ((CCC_STREAM_STATUS & 2) == 0)
	{

		short_delay();

		flip ^= 1;
		reg_leds = 0x00010000 | flip;

		print_hex(CCC_STREAM_TX_CNT, 4);
		print("\r\n");
	}

	/* clear IRQ */
	CCC_STREAM_STATUS = 2;

	dump(data_buf, 0);
}

void HRAM_write_test_good()
{
	static uint32_t counter;

	*((uint32_t *)0x04000000) = 0x12345678;
	*((uint32_t *)0x04000004) = 0xAAAAAAAA;
	*((uint32_t *)0x04000008) = 0x55555555;
	*((uint32_t *)0x0400000C) = 0x01020408;

	counter = *((uint32_t *)0x04000000);
	counter = *((uint32_t *)0x04000004);
	counter = *((uint32_t *)0x04000008);
	counter = *((uint32_t *)0x0400000C);
	
	dump(0x04000000, 0);
}


void HRAM_write_test_bad()
{
	uint32_t *ptr = HRAM0;

	for (int i = 0; i < 2048; i++)
	{
		*ptr++ = i;
	}
}

void test_HRAM_rnd()
{

	CCC_STREAM_START_ADR = (uint32_t)0x04000000;
	CCC_STREAM_BUF_SIZE = 320 * 256 * 2;
	CCC_STREAM_BURST_SIZE = 8;

	/* Prep the Stream DMA */
	CCC_STREAM_STATUS = 1;

	/* Gate the data from the camera */
	CCC_STATUS = 1;

	while ((CCC_STREAM_STATUS & 2) == 0)
	{

		short_delay();

		flip ^= 1;
		reg_leds = 0x00010000 | flip;

		print_hex(CCC_STREAM_TX_CNT, 4);
		print("\r\n");
	}

	/* clear IRQ */
	CCC_STREAM_STATUS = 2;

	dump(0x04000000, 0);
	//	dump (HRAM0+128, 0x200);
}

void test_HRAM_read()
{

	uint32_t *ptr = (uint32_t *)0x04000000;
	dump(ptr, 0);
	dump(ptr + 128, 0x200);
}

void simple_test()
{
	while (1)
	{

		flip ^= 1;
		reg_leds = 0x00010000 | flip;
	}
}

void WriteCapturedImage()
{
}

void set_filename(char *p, int i)
{
	*p++ = 'I';
	*p++ = 'M';
	*p++ = 'G';
	*p++ = '_';
	*p++ = '0' + i / 1000 % 10;
	*p++ = '0' + i / 100 % 10;
	*p++ = '0' + i / 10 % 10;
	*p++ = '0' + i % 10;
	*p++ = '.';
	*p++ = 'R';
	*p++ = 'A';
	*p++ = 'W';
	*p++ = 0;
}

void continuousCapture()
{

	char filename[13];
	int image_number = 0;

	FRESULT res;
	res = f_mount(&FatFs, "", 0); /* Give a work area to the default drive */

	while (1)
	{

		set_filename(filename, image_number++);

		/* Capture our image length into external hyperRAM */
		/* Burst size is in DWORDS, 8 = 16 clock cycles */
		CCC_STREAM_START_ADR = (uint32_t)0x04000000;
		//CCC_STREAM_BUF_SIZE = 320 * 256 * 2;
		CCC_STREAM_BUF_SIZE = 640 * 512 * 2;
		CCC_STREAM_BURST_SIZE = 16;

		/* Enable the Stream DMA */
		CCC_STREAM_STATUS = 1;

		/* Gate the data from the camera */
		CC_ENABLE = 1;

		/* Wait for IRQ signal to be set */
		while ((CCC_STREAM_STATUS & 2) == 0)
		{
			reg_leds = 0x00010001;
			reg_leds = 0x00010000;
		}

		/* clear IRQ */
		CCC_STREAM_STATUS = 2;

		blink_led(1);

		UINT bw = 0;

		if ((res = f_open(&Fil, filename, FA_WRITE | FA_CREATE_ALWAYS)) == FR_OK)
		{ /* Create a file */
			uint8_t *ptr = 0x04000000;

			/* Find and allocate a 512kb block for us */
			if ((res = f_expand(&Fil, 640 * 512 * 2, 1)) == FR_OK)
			//if ((res = f_expand(&Fil, 320 * 256 * 2, 1)) == FR_OK)
			{
				/* Accessing the contiguous file via low-level disk functions */

				/* Get physical location of the file data */
				BYTE drv = Fil.obj.fs->pdrv;
				DWORD lba = Fil.obj.fs->database + Fil.obj.fs->csize * (Fil.obj.sclust - 2);

				/* Write 2048 sectors from top of the file at a time */
				res = disk_write(drv, ptr, lba, 1280);
				//res = disk_write(drv, ptr, lba, 320);

				if (res == FR_OK)
				{ /* Write data to the file */
					if ((res = f_close(&Fil)) == FR_OK)
					{ /* Close the file */
						blink_led(1);
					}
				}
			}

			if ((res = f_close(&Fil)) == FR_OK)
			{ /* Close the file */
				blink_led(2);
			}
		}

		if (res != FR_OK)
		{
			blink_led(5);
		}
	}
}

void blink_led(int numBlinks)
{

	for (int i = 0; i < numBlinks; i++)
	{
		reg_leds = 0x00010001;
		dly_us(5000);
		reg_leds = 0x00010000;
		dly_us(5000);
	}

	dly_us(20000);
}

void CaptureCamera()
{

	print("Capture stream to 0x04000000\r\n");
	CCC_STREAM_START_ADR = (uint32_t)0x04000000;
	CCC_STREAM_BUF_SIZE = (320 * 256 * 2);
	CCC_STREAM_BURST_SIZE = 8;

	/* Enable the Stream DMA */
	CCC_STREAM_STATUS = 1;

	/* Gate the data from the camera */
	CC_ENABLE = 1;

	/* Wait for IRQ signal to be set */
	while ((CCC_STREAM_STATUS & 2) == 0)
	{

		dly_us(1000);

		flip ^= 1;
		reg_leds = 0x00010000 | flip;

		print_hex(CCC_STREAM_TX_CNT, 4);
		print(" - ");
		print_hex(CC_ENABLE, 1);
		print("\r\n");
	}

	/* clear IRQ */
	CCC_STREAM_STATUS = 2;

	print("Data at 0x04000000:\r\n");
	dump(0x04000000, 0);
}

extern uint32_t _sidata, _sdata, _edata, _sbss, _ebss;

void main()
{
	// copy data section
	for (uint32_t *src = &_sidata, *dest = &_sdata; dest < &_edata;)
	{

		*dest++ = *src++;
	}
	// zero out .bss section
	for (uint32_t *dest = &_sbss; dest < &_ebss;)
	{
		*dest++ = 0;
	}
	UART0_SETUP = 417;
	//set_flash_qspi_flag();

	//set_flash_latency(4);
	//reg_spictrl = (reg_spictrl & ~0x00700000) | 0x00300000;

	//test_HRAM_rnd();

	//simple_test();

	//HRAM0_LATENCY_1 = 0x04;
	//HRAM0_LATENCY_2 = 0x0a;
	//HRAM0_CFG = 0x8fe40000;

	//set_hyperram_speed();

	//set_hyperram_speed();

	continuousCapture();

	while (getchar_prompt("Press ENTER to continue..\n") != '\r')
	{ /* wait */
	}

	print("\r\n");
	print("  __               __            __                 \r\n");
	print(" |__) _  _ _  _   |_ _ _  _  _  / _  _ _ |_ |_  _ _ \r\n");
	print(" |__)(_)_)(_)| )  | | (_||||(-  \\__)| (_||_)|_)(-|  \r\n");
	print("                                                    \r\n");
	print("  Boson Frame Grabber. Powered by picorv32, ECP5\r\n");
	print("    Build Date: "__DATE__
		  " "__TIME__
		  "\r\n");

	while (1)
	{
		print("\n");

		print("\n");
		print("Select an action:\n");
		print("\n");
		print("   [1] FATFS Write\n");
		print("   [2] FATFS Write_fast\n");
		print("   [3] FATFS Write_expand\n");
		print("   [4] Capture from Camera\n");
		print("   [5] Continuous Capture\n");
		print("   [6] HRAM0 test write \n");
		
		print("   [9] Run simplistic benchmark\n");
		print("   [0] Benchmark all configs\n");
		print("\n");

		for (int rep = 10; rep > 0; rep--)
		{
			print("Command> ");
			char cmd = getchar();
			if (cmd > 32 && cmd < 127)
				putchar(cmd);
			print("\n");

			switch (cmd)
			{
			case '1':
				fatFS_write();
				break;
			case '2':
				fatFS_write_fast();
				break;

			case '3':
				fatFS_write_expand();
				break;
			case '4':
				CaptureCamera();
				break;
			case '5':
				/* continuous capture */
				continuousCapture();
				break;
			case '6':
				HRAM_write_test_good();
				break;
			case '7':
				reg_spictrl = reg_spictrl ^ 0x00100000;
				break;
			case '9':
				cmd_benchmark(true, 0);
				break;
			case '0':
				cmd_benchmark_all();
				break;
			default:
				continue;
			}

			break;
		}
	}
}
