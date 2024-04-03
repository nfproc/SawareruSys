// FPGA RemoCon: Commander Program for PIC18F45K50
// 2023.07.13 Naoki F., AIT
////////////////////////////////////////////////////////////////////////

#include "mcc_generated_files/mcc.h"

static unsigned char inbuf[CDC_DATA_OUT_EP_SIZE];
static unsigned char outbuf[CDC_DATA_IN_EP_SIZE];

static unsigned short last_sw;
static char led_value[5];
static char segpos, ledpos, connected;
static unsigned char recv_bytes;

// display a digit on the 7-seg LED
void disp_digit() {
    // NOPs are required to (perhaps) avoid data hazard... why?
    unsigned char value = led_value[segpos];
    CATH0_PORT  = 0; __nop();
    CATH1_PORT  = 0; __nop();
    CATH2_PORT  = 0; __nop();
    CATH3_PORT  = 0; __nop();
    
    SEG_A_PORT  = ((value & 0x01) != 0); __nop();
    SEG_B_PORT  = ((value & 0x02) != 0); __nop();
    SEG_C_PORT  = ((value & 0x04) != 0); __nop();
    SEG_D_PORT  = ((value & 0x08) != 0); __nop();
    SEG_E_PORT  = ((value & 0x10) != 0); __nop();
    SEG_F_PORT  = ((value & 0x20) != 0); __nop();
    SEG_G_PORT  = ((value & 0x40) != 0); __nop();
    SEG_DP_PORT = ((value & 0x80) != 0); __nop();

    CATH0_PORT = (segpos == 0); __nop();
    CATH1_PORT = (segpos == 1); __nop();
    CATH2_PORT = (segpos == 2); __nop();
    CATH3_PORT = (segpos == 3); __nop();
}

// display LEDs
void disp_LED () {
    unsigned char value = led_value[4];
    LED0_PORT = ((value & 0x01) != 0); __nop();
    LED1_PORT = ((value & 0x02) != 0); __nop();
    LED2_PORT = ((value & 0x04) != 0); __nop();
    LED3_PORT = ((value & 0x08) != 0); __nop();
    LED4_PORT = ((value & 0x10) != 0); __nop();
    LED5_PORT = ((value & 0x20) != 0); __nop();
    LED6_PORT = ((value & 0x40) != 0); __nop();
    LED7_PORT = ((value & 0x80) != 0); __nop();
}

// get the switch value (SW13-SW1)
// NOTE: switches are active low
unsigned short get_switch () {
    unsigned char toggle = 0, push = 0;
    toggle = toggle | ((SW0_PORT  ) ? 0 : 0x01);
    toggle = toggle | ((SW1_PORT  ) ? 0 : 0x02);
    toggle = toggle | ((SW2_PORT  ) ? 0 : 0x04);
    toggle = toggle | ((SW3_PORT  ) ? 0 : 0x08);
    toggle = toggle | ((SW4_PORT  ) ? 0 : 0x10);
    toggle = toggle | ((SW5_PORT  ) ? 0 : 0x20);
    toggle = toggle | ((SW6_PORT  ) ? 0 : 0x40);
    toggle = toggle | ((SW7_PORT  ) ? 0 : 0x80);
    push   = push   | ((BTN_R_PORT) ? 0 : 0x01);
    push   = push   | ((BTN_C_PORT) ? 0 : 0x02);
    push   = push   | ((BTN_L_PORT) ? 0 : 0x04);
    push   = push   | ((BTN_D_PORT) ? 0 : 0x08);
    push   = push   | ((BTN_U_PORT) ? 0 : 0x10);
    return ((unsigned short) push << 8) | toggle;
}

// initialization, run only once
void setup() {
    // Initialize the device
    SYSTEM_Initialize();
    
    // Enable Interrupts
    INTERRUPT_GlobalInterruptEnable();
    INTERRUPT_PeripheralInterruptEnable();

    // Initialize global variables
    last_sw = 0;
    led_value[0] = led_value[1] = led_value[2] = led_value[3] = 0x40;
    led_value[4] = 0;
    segpos = ledpos = connected = 0;
}

// main loop, run periodically
void loop() {
    unsigned char i, send_bytes;
    unsigned short sw, comp_bit;
    send_bytes = 0;
    
    // 7-seg display and switches
    if (recv_bytes == 0)
        __delay_us(500);
    recv_bytes = 0;
    disp_LED();
    disp_digit();
    segpos = (segpos + 1) % 4;

    // USB task
    if (USBGetDeviceState() < CONFIGURED_STATE)
        return;       // do nothing if device is not initialized
    if (USBIsDeviceSuspended() == true)
        return;       // do nothing if device is suspended

    // do something (after attached as a USB device)
    if (USBUSARTIsTxTrfReady() == true) {
        recv_bytes = getsUSBUSART(inbuf, sizeof(inbuf));
        for (i = 0; i < recv_bytes; i++) {
            if (inbuf[i] != 'X' && ! connected) {
                continue;
            }
            switch (inbuf[i]) {
                case 'X':
                    connected = 1;
                    outbuf[send_bytes]     = 'W';
                    outbuf[send_bytes + 1] = 'Y';
                    send_bytes += 2;
                    break;
                case 'Z':
                    last_sw = sw ^ 0x7ff; // force resend
                    led_value[0] = led_value[1] = led_value[2] = 0;
                    led_value[3] = led_value[4] = 0;
                    break;
                case '0': ledpos = 0; break;
                case '1': ledpos = 1; break;
                case '2': ledpos = 2; break;
                case '3': ledpos = 3; break;
                case '4': ledpos = 4; break;
                case 'A': led_value[ledpos] = led_value[ledpos] | 0x01; break;
                case 'B': led_value[ledpos] = led_value[ledpos] | 0x02; break;
                case 'C': led_value[ledpos] = led_value[ledpos] | 0x04; break;
                case 'D': led_value[ledpos] = led_value[ledpos] | 0x08; break;
                case 'E': led_value[ledpos] = led_value[ledpos] | 0x10; break;
                case 'F': led_value[ledpos] = led_value[ledpos] | 0x20; break;
                case 'G': led_value[ledpos] = led_value[ledpos] | 0x40; break;
                case 'H': led_value[ledpos] = led_value[ledpos] | 0x80; break;
                case 'a': led_value[ledpos] = led_value[ledpos] & 0xfe; break;
                case 'b': led_value[ledpos] = led_value[ledpos] & 0xfd; break;
                case 'c': led_value[ledpos] = led_value[ledpos] & 0xfb; break;
                case 'd': led_value[ledpos] = led_value[ledpos] & 0xf7; break;
                case 'e': led_value[ledpos] = led_value[ledpos] & 0xef; break;
                case 'f': led_value[ledpos] = led_value[ledpos] & 0xdf; break;
                case 'g': led_value[ledpos] = led_value[ledpos] & 0xbf; break;
                case 'h': led_value[ledpos] = led_value[ledpos] & 0x7f; break;
            }
        }
        if (connected) {
            sw = get_switch();
            comp_bit = 0x001;
            for (i = 0; i < 13; i++) {
                if ((last_sw ^ sw) & comp_bit) {
                    switch (i) {
                        case  0: outbuf[send_bytes] = 'I'; break;
                        case  1: outbuf[send_bytes] = 'J'; break;
                        case  2: outbuf[send_bytes] = 'K'; break;
                        case  3: outbuf[send_bytes] = 'L'; break;
                        case  4: outbuf[send_bytes] = 'M'; break;
                        case  5: outbuf[send_bytes] = 'N'; break;
                        case  6: outbuf[send_bytes] = 'O'; break;
                        case  7: outbuf[send_bytes] = 'P'; break;
                        case  8: outbuf[send_bytes] = 'Q'; break;
                        case  9: outbuf[send_bytes] = 'R'; break;
                        case 10: outbuf[send_bytes] = 'S'; break;
                        case 11: outbuf[send_bytes] = 'q'; break;
                        case 12: outbuf[send_bytes] = 'r'; break;
                    }
                    outbuf[send_bytes + 1] = (sw & comp_bit) ? 'U' : 'u';
                    send_bytes += 2;
                }
                comp_bit = comp_bit << 1;
            }
            last_sw = sw;
        }
        if (send_bytes != 0) {
            putUSBUSART(outbuf, send_bytes);
        }
    }
    
    // finally, try to send data to PC (if needed)
    CDCTxService();
}

// Arduino-like main function
void main() {
    setup();
    while (1) {
        loop();
    }
}
