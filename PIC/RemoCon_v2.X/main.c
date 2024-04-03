// FPGA RemoCon: Commander Program for PIC18F4450
// 2022.04.25 - 2023.01.18 Naoki F., AIT
////////////////////////////////////////////////////////////////////////
#include "main.h"
#include "usb.h"
#include "usb_device.h"
#include "usb_device_cdc.h"

static unsigned char inbuf[CDC_DATA_OUT_EP_SIZE];
static unsigned char outbuf[CDC_DATA_IN_EP_SIZE];

static unsigned short last_sw;
static char led_value[5];
static char segpos, ledpos, connected;

// display a digit on the 7-seg LED
void disp_digit() {
    if      (segpos == 0) LATD = led_value[0];
    else if (segpos == 1) LATD = led_value[1];
    else if (segpos == 2) LATD = led_value[2];
    else if (segpos == 3) LATD = led_value[3];

    LATCbits.LC2 = (segpos == 0);
    LATCbits.LC1 = (segpos == 1);
    LATCbits.LC0 = (segpos == 2);
    LATEbits.LE2 = (segpos == 3);
}

// display LEDs
void disp_LED () {
    unsigned char value = led_value[4];
    LATEbits.LE1 = ((value & 0x01) != 0);
    LATEbits.LE0 = ((value & 0x02) != 0);
    LATAbits.LA5 = ((value & 0x04) != 0);
    LATAbits.LA4 = ((value & 0x08) != 0);
    LATAbits.LA3 = ((value & 0x10) != 0);
    LATAbits.LA2 = ((value & 0x20) != 0);
    LATAbits.LA1 = ((value & 0x40) != 0);
    LATAbits.LA0 = ((value & 0x80) != 0);
}

// get the switch value (SW11-SW1)
// NOTE: SW11-SW9 are active low
unsigned short get_switch () {
    unsigned char toggle = (unsigned char)
        (((PORTB & 0x3f) << 2) | ((PORTC & 0xc0) >> 6));
    unsigned char push = (unsigned char)
        ((PORTEbits.RE3 << 2) | (PORTBbits.RB7 << 1) | PORTBbits.RB6) ^ 0x07;
    return ((unsigned short) push << 8) | toggle;
}

// initialization, run only once
void setup() {
    __delay_ms(1000);

    // I/O Ports Initialization
    TRISA = 0x00;         // Port A = output
    LATA = 0x00;
    INTCON2bits.RBPU = 0; // Port B Pull-up Enabled
    TRISC = 0xf8;         // Port C = RC0-RC2 are output
    LATC = 0x00;
    TRISD = 0x00;         // Port D = output
    LATD = 0x00;
    TRISE = 0x00;         // Port E = output (except RE3)
    LATE = 0x00;

    // USB device initialization
    USBDeviceInit();
    USBDeviceAttach();

    last_sw = 0;
    led_value[0] = led_value[1] = led_value[2] = led_value[3] = 0x40;
    led_value[4] = 0;
    segpos = ledpos = connected = 0;
}

// main loop, run periodically
void loop() {
    unsigned char i, send_bytes, recv_bytes;
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
    USBDeviceTasks(); // assuming USB_POLLING mode
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
            for (i = 0; i < 11; i++) {
                if ((last_sw ^ sw) & comp_bit) {
                    outbuf[send_bytes]     = 'I' + i;
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
