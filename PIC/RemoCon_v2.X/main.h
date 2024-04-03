// Baseline Code for FPGA RemoCon
// 2021.07.02 Naoki F., AIT 

// Header Files
#include <xc.h>
#include "usb_config.h"
#define _XTAL_FREQ 48000000

// suppress some warnings
// (functions not being called, expression generating no code)
#pragma warning disable 520
#pragma warning disable 759

// Configuration Memory
// CONFIG1L
#pragma config PLLDIV = 4       
#pragma config CPUDIV = OSC1_PLL2
#pragma config USBDIV = 2       

// CONFIG1H
#pragma config FOSC = HSPLL_HS  
#pragma config FCMEN = OFF      
#pragma config IESO = OFF       

// CONFIG2L
#pragma config PWRT = OFF       
#pragma config BOR = ON         
#pragma config BORV = 21        
#pragma config VREGEN = ON     

// CONFIG2H
#pragma config WDT = OFF        
#pragma config WDTPS = 32768    

// CONFIG3H
#pragma config PBADEN = OFF     
#pragma config LPT1OSC = OFF    
#pragma config MCLRE = OFF      

// CONFIG4L
#pragma config STVREN = ON      
#pragma config LVP = OFF         
#pragma config BBSIZ = BB1K     
#pragma config ICPRT = OFF      
#pragma config XINST = OFF      

// CONFIG5L
#pragma config CP0 = OFF        
#pragma config CP1 = OFF        

// CONFIG5H
#pragma config CPB = OFF        

// CONFIG6L
#pragma config WRT0 = OFF       
#pragma config WRT1 = OFF       

// CONFIG6H
#pragma config WRTC = OFF       
#pragma config WRTB = OFF       

// CONFIG7L
#pragma config EBTR0 = OFF      
#pragma config EBTR1 = OFF      

// CONFIG7H
#pragma config EBTRB = OFF     