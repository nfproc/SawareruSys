// Baseline Code for FPGA RemoCon
// 2021.07.02 Naoki F., AIT 

#ifndef __SYSTEM_H__
#define __SYSTEM_H__

// buffers defined in usb_device_cdc.c has to be located in dedicated memory
// In the PIC18F4450 case, it is at bank 4 (0x400-0x4ff)
#define FIXED_ADDRESS_MEMORY

#define IN_DATA_BUFFER_ADDRESS_TAG  __at(0x440)
#define OUT_DATA_BUFFER_ADDRESS_TAG __at(0x480)
#define CONTROL_BUFFER_ADDRESS_TAG  __at(0x4c0)
#define DRIVER_DATA_ADDRESS_TAG     __at(0x4c8)
#endif