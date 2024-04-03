// Baseline Code for FPGA RemoCon
// 2021.07.02 Naoki F., AIT

#include "usb.h"
#include "usb_device.h"
#include "usb_device_cdc.h"

// CDC initialization (does it really take effect?)
void initialize_CDC() {
    line_coding.bCharFormat = 0;
    line_coding.bDataBits = 8;
    line_coding.bParityType = 0;
    line_coding.dwDTERate = 115200;
}

// event handler, called from usb_device.c
bool USER_USB_CALLBACK_EVENT_HANDLER(USB_EVENT event, void *pdata, uint16_t size) {
    if (event == EVENT_CONFIGURED) {
        CDCInitEP();
        initialize_CDC();
    } else if (event == EVENT_EP0_REQUEST) {
        USBCheckCDCRequest();
    }
    return true;
}

// interrupt will be called from USB controller, but we just ignore it
void __interrupt() isr() {
    
}