
#include "sys/alt_stdio.h"
#include "stdio.h"
#include "system.h"

// PWM Simple
#define freq (unsigned int *) AVALON_PWM_0_BASE
#define duty (unsigned int *) (AVALON_PWM_0_BASE + 4)
#define control (unsigned int *) (AVALON_PWM_0_BASE + 8)

// Anémomètre
#define config (unsigned int *) (GESTION_ANEMOMETRE_0_BASE)
#define code (unsigned int *) (GESTION_ANEMOMETRE_0_BASE + 4)

// Verin
#define v_duty_freq (unsigned int *)VERIN_TEST_0_BASE
#define v_butee_d_g (unsigned int *)(VERIN_TEST_0_BASE + 4)
#define v_config (unsigned int *)(VERIN_TEST_0_BASE + 8)
#define v_angle_barre (unsigned int *)(VERIN_TEST_0_BASE + 20)

// Bouton Poussoire
#define BP_config (char *) AVALON_GESTION_BP_0_BASE
#define code_fonction (char *) (AVALON_GESTION_BP_0_BASE + 4)

// Compas
#define compas_config (int *)AVALON_COMPAS_0_BASE
#define compas (int *)(AVALON_COMPAS_0_BASE + 4)

// LED
#define led_control (char *) SORTIE_BASE

// BP de la Nano
#define bouton_control (char *) ENTREE_BASE


int main()
{ 

  alt_putstr("Hello from Nios II!\n");
  	//Setup PWM Simple********************
    *freq=0x00000400;
    *duty=0x00000200;
    *control = 3;
    //Setup Anémomètre********************
    *config = 7;
    int resultat = 0;
    int data =0;
    int i = 0xff;
    //Setup Verin*************************
    *v_duty_freq = 0x05DC07D0;
    *v_butee_d_g = 0x0B420536;
    *v_config = 7;
    short f, d, l, r;
    //Setup bp et compas******************
    *compas_config = 3;
    *BP_config = 1;
    *led_control= 0xff;//active circuits gestion_bp et gestion_compas
    unsigned int a;
    unsigned char b;
    int ref = 0;
    int angle_corr = 0;
    int angle_barre_ref = 0;
    int new_auto = 1;
    int boucle_0_360 = 0;
    while(1){
		printf(" __________________________________________________________________________________________________________________________\n");

		// Anémometre
		resultat = *code;
		data = i & resultat;
		printf("Anémo data = %d | config = %X \n", data, *config);

		//Verin
		f = *v_duty_freq & 0x0000FFFF;
		d = (*v_duty_freq >> 16);
		l = *v_butee_d_g & 0x0000FFFF;
		r = (*v_butee_d_g >> 16);
		printf("freq= %d | duty= %d | b_g= %d | b_d= %d | config= %d | angle_b= %d\n", f, d, l, r, *v_config, *v_angle_barre);

		//Compass
		a=((*compas)-10)&0x1ff;
		printf("compas= %d | compass_config = %d \n", a, *compas_config);

		//test bp en mode manuel seul
		b=*code_fonction;
		printf("code_fonction= %d | bp_config = %d\n", b, *BP_config);
		printf("Compass_ref= %d | angle_barre_ref = %d | Angle_corr = %d | new_auto = %d\n", ref, angle_barre_ref, angle_corr, new_auto);
		switch(b)
		{
		  case 0: *v_config=1; new_auto = 1;break;
		  case 1: *v_config=7; new_auto = 1;break;
		  case 2: *v_config=3; new_auto = 1;break;
		  case 3:
			  if (new_auto == 1){
				  ref = a;
				  angle_barre_ref = *v_angle_barre;
				  new_auto = 0;
				  if ((ref > 315 && ref < 360) ||(ref < 45&&ref > 0)){
					  ref = (ref + 180) % 360;
					  boucle_0_360 = 1;
				  }
				  else
					  boucle_0_360 = 0;
				  angle_corr = angle_barre_ref - ((a-ref)*8);
			  }
			  angle_corr = angle_barre_ref - ((a-ref)*8);


			  if (boucle_0_360 == 1)
				  a = (a + 180) % 360;

			  if (a > ref){
				  if(*v_angle_barre > angle_corr)
					  *v_config = 3;
				  else
					  *v_config = 1;
				 }
			  if (a < ref){
				  if(*v_angle_barre > angle_corr)
					  *v_config = 1;
				  else
					  *v_config = 7;
				 }
			  ;break;
		  default:*v_config=1;
		}

		 usleep(200000);
    }
  return 0;
}
