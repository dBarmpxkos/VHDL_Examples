#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include <stdio.h>

int main(){

	IOWR(LED_PIO_BASE, 0, 0x00);	/* init led */

	while(1){
		/* erwtima 1 */
		while (~IORD(USERSIG_BASE, 0)){ 	/* brutal rising edge capture */
			if (IORD(USERSIG_BASE, 0))
				IOWR(LED_PIO_BASE, 0, IORD(LED_PIO_BASE, 0) == 0 ? 1 : 0);
		}
		/* erwtima 1 */

		/* erwtima 2 */
		while (~IORD(USERSIG_BASE, 0)){ 	/* brutal rising edge capture */
			if (IORD(USERSIG_BASE, 0)){
				if (IORD(LED_PIO_BASE, 0) == 0){
					usleep(1000000);
					IOWR(LED_PIO_BASE, 0, 1);
				} else
					IOWR(LED_PIO_BASE, 0, 0);
			}
		}
		/* erwtima 2 */
	}
}


