/* 
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include "system.h"
#include <stdlib.h>
#include <string.h>
#include <io.h>
#include <unistd.h>
#include <math.h>

#define PLL_FREQ 100000000


int jtag_key (int base_addr) {
	int key, ch;

	key = 0;
	ch = IORD(base_addr, 0);
	if ((ch & 0x8000) != 0)
		key = ch & 0xff;
	return key;
}

int wait_jtag_key (int base_addr) {
	int key;

	key = 0;
	while (key == 0) {
		key = jtag_key(base_addr);
	}
	return key;
}

int wait_ps2_key (long base) {
	IOWR(base, 2, 0);
	while ((IORD(base, 0) & 0x2) == 0);
	return IORD(base, 2);
}

long get_phase (int freq) {
	return (freq * pow(2.0, 32.0)) / (float)PLL_FREQ;
}

long get_freq (int phase) {
	return (long)(((float)phase * (float)PLL_FREQ) / (float)pow(2.0, 32.0));
}

void print_dec(alt_64 x) {
	alt_u64 t;
	int i, j;
	char r[20];

	i = 0;
	j = 0;
	if (x == 0)
		alt_putstr("0");
	else
		if (x < 0) {
			alt_putstr("-");
			t = -x;
		}
		else {
			t = x;
			while (t > 0) {
				j++;
				r[i++] = 0x30 + (t % 10);
				t = t / 10;
				if ((j % 3) == 0)
					r[i++] = ',';
			}
			if (r[i-1] == ',')
				i=i-1;
			for (j=i-1; j>=0; j--)
				alt_printf("%c", (char)r[j]);
		}
}

int main()
{
  alt_u64 freq, freq_step;
  alt_u32 gain, key;

  alt_putstr("DE0 Cyclone III - Software Defined AM Radio\n\n");
  alt_putstr("Operation Keys\n");
  alt_putstr("'1-9' frequency step (kHz)\n");
  alt_putstr("'g' increment CIC gain (0-8)\n");
  alt_putstr("'+' increment frequency by step\n");
  alt_putstr("'-' decrement frequency by step\n");

  freq = 1278000;
  gain = 4; // 0-15 range
  freq_step = 9;

  while (1) {

	  alt_putstr("FPGA PLL Frequency = ");
	  print_dec((alt_u64)PLL_FREQ);
	  alt_printf("\n");
	  alt_putstr("Frequency = ");
	  print_dec(freq);
	  alt_printf("\n");
	  alt_putstr("Frequency Step = ");
	  print_dec((freq_step * 1000));
	  alt_printf("\n");
	  alt_putstr("Gain = ");
	  print_dec((alt_u64)gain);
	  alt_printf("\n");

	  IOWR(PHASE_INCREMENT_BASE, 0, get_phase(freq));
	  IOWR(CIC_GAIN_BASE, 0, gain & 0xf);
      
      key = alt_getchar();

      if (key == '+') freq = freq + (freq_step * 1000);
      if (key == '-') freq = freq - (freq_step * 1000);
      if (key == 'g') {
		  if (gain == 8)
			  gain = 0;
		  else
			  gain = gain + 1;
      }
      if ((key >= '1') && (key <='9'))
    	  freq_step = (key - 0x30);

	  /*key = wait_ps2_key(PS2_BASE);
	  if (key == 0x55) { // '+'
		  freq = freq + (freq_step * 1000);
	  }
	  if (key == 0x4e) { // '-'
		  freq = freq - (freq_step * 1000);
	  }
	  if (key == 0x34) { // 'g'
		  if (gain == 8)
			  gain = 0;
		  else
			  gain = gain + 1;
	  }
	  if (key == 0x16) freq_step = 1; // '1' to '9'
	  if (key == 0x1e) freq_step = 2;
	  if (key == 0x26) freq_step = 3;
	  if (key == 0x25) freq_step = 4;
	  if (key == 0x2e) freq_step = 5;
	  if (key == 0x36) freq_step = 6;
	  if (key == 0x3d) freq_step = 7;
	  if (key == 0x3e) freq_step = 8;
	  if (key == 0x46) freq_step = 9;
      */
  }

  while(1);

  return 0;
}
