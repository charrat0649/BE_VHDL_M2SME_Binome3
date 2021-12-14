

#include "sys/alt_stdio.h"
#include "system.h"
#define Switches (volatile char *) SWITCHES_BASE
#define LEDs (volatile char *) LEDS_BASE

int main()
{ 
  alt_putstr("Hello from Nios II!\n");

  /* Event loop never exits. */
  while (1)
	  *LEDs=*Switches;

  return 0;
}
