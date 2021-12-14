

#include "sys/alt_stdio.h"
#include <stdio.h>

#define Switches (volatile char *) 0x0009000
#define LEDs (volatile char *) 0x0009010
int main()
{
  printf("Hello from Nios II!\n");
while (1)
	*LEDs= *Switches;
  return 0;
}
