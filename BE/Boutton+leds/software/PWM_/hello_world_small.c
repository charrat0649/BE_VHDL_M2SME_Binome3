#include "sys/alt_stdio.h"
#include "stdio.h"
#include "system.h"
#define freq (unsigned int *) AVALON_PWM_0_BASE
#define duty (unsigned int *) (AVALON_PWM_0_BASE + 4)
#define control (unsigned int *) (AVALON_PWM_0_BASE + 8)

#define config (unsigned int *) (GESTION_ANEMOMETRE_0_BASE)
#define code (unsigned int *) (GESTION_ANEMOMETRE_0_BASE + 4)



int main()
{
  alt_putstr("Hello from Nios II!\n");
    //*freq=0x00000400;
    *duty=0x00000200;
    *control = 3;
  alt_putstr(" salut!\n");
    //*config = 7;
    int resultat = 0;
    int data =0;
    int i = 0xff;
    while(1)
    {
    resultat = *code;
    data = i & resultat;
    printf("data %d  \n", data);
    }

  return 0;
}
