EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "FPGA-RemoCon"
Date "2022-05-02"
Rev "0.2.0"
Comp "AIT-DSLab"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_PIC18:PIC18F4450-IP U1
U 1 1 60B9CF25
P 3550 2450
F 0 "U1" H 4150 3850 50  0000 C CNN
F 1 "PIC18F4450-IP" H 4150 3750 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_LongPads" H 3550 2450 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/39760d.pdf" H 3550 2200 50  0001 C CNN
	1    3550 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal X1
U 1 1 60BA86F4
P 1650 2100
F 0 "X1" V 1604 2231 50  0000 L CNN
F 1 "16MHz" V 1695 2231 50  0000 L CNN
F 2 "Crystal:Crystal_HC49-4H_Vertical" H 1650 2100 50  0001 C CNN
F 3 "~" H 1650 2100 50  0001 C CNN
	1    1650 2100
	0    1    1    0   
$EndComp
$Comp
L Device:C C4
U 1 1 60BAA074
P 1650 2500
F 0 "C4" H 1765 2546 50  0000 L CNN
F 1 "22p" H 1765 2455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1688 2350 50  0001 C CNN
F 3 "~" H 1650 2500 50  0001 C CNN
	1    1650 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 60BAB33E
P 1250 2500
F 0 "C5" H 1365 2546 50  0000 L CNN
F 1 "22p" H 1365 2455 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1288 2350 50  0001 C CNN
F 3 "~" H 1250 2500 50  0001 C CNN
	1    1250 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 1950 1650 1950
Wire Wire Line
	1650 1950 1250 1950
Wire Wire Line
	1250 1950 1250 2350
Connection ~ 1650 1950
Wire Wire Line
	2450 2150 2100 2150
Wire Wire Line
	2100 2150 2100 2300
Wire Wire Line
	2100 2300 1650 2300
Wire Wire Line
	1650 2300 1650 2250
Wire Wire Line
	1650 2350 1650 2300
Connection ~ 1650 2300
Wire Wire Line
	1650 2650 1650 2700
Wire Wire Line
	1650 2700 1250 2700
Wire Wire Line
	1250 2700 1250 2650
$Comp
L power:GND #PWR0101
U 1 1 60BB19C0
P 1250 2800
F 0 "#PWR0101" H 1250 2550 50  0001 C CNN
F 1 "GND" H 1255 2627 50  0000 C CNN
F 2 "" H 1250 2800 50  0001 C CNN
F 3 "" H 1250 2800 50  0001 C CNN
	1    1250 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 2700 1250 2800
Connection ~ 1250 2700
$Comp
L Device:C C6
U 1 1 60BB222E
P 5350 2300
F 0 "C6" H 5465 2346 50  0000 L CNN
F 1 "0.1u" H 5465 2255 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 5388 2150 50  0001 C CNN
F 3 "~" H 5350 2300 50  0001 C CNN
	1    5350 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 60BB2AF5
P 5350 2600
F 0 "#PWR0102" H 5350 2350 50  0001 C CNN
F 1 "GND" H 5355 2427 50  0000 C CNN
F 2 "" H 5350 2600 50  0001 C CNN
F 3 "" H 5350 2600 50  0001 C CNN
	1    5350 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 2450 5350 2600
$Comp
L power:+5V #PWR0103
U 1 1 60BB3039
P 3450 950
F 0 "#PWR0103" H 3450 800 50  0001 C CNN
F 1 "+5V" H 3465 1123 50  0000 C CNN
F 2 "" H 3450 950 50  0001 C CNN
F 3 "" H 3450 950 50  0001 C CNN
	1    3450 950 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 60BB3850
P 3450 3950
F 0 "#PWR0104" H 3450 3700 50  0001 C CNN
F 1 "GND" H 3455 3777 50  0000 C CNN
F 2 "" H 3450 3950 50  0001 C CNN
F 3 "" H 3450 3950 50  0001 C CNN
	1    3450 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 3850 3450 3900
Wire Wire Line
	3450 3900 3550 3900
Wire Wire Line
	3550 3900 3550 3850
Connection ~ 3450 3900
Wire Wire Line
	3450 3900 3450 3950
Wire Wire Line
	3450 950  3450 1000
Wire Wire Line
	3450 1000 3550 1000
Wire Wire Line
	3550 1000 3550 1050
Connection ~ 3450 1000
Wire Wire Line
	3450 1000 3450 1050
Text Label 5150 3550 2    50   ~ 0
BTN2_MCLR
Wire Wire Line
	4650 3550 5150 3550
Wire Wire Line
	4650 2150 5350 2150
Wire Wire Line
	2450 2950 2000 2950
Wire Wire Line
	2450 3050 2000 3050
Text Label 2000 2950 0    50   ~ 0
BTN0_PGC
Text Label 2000 3050 0    50   ~ 0
BTN1_PGD
Wire Wire Line
	2150 2850 2450 2850
Wire Wire Line
	2150 2750 2450 2750
Wire Wire Line
	2150 2650 2450 2650
Wire Wire Line
	2150 2550 2450 2550
Wire Wire Line
	2150 2450 2450 2450
Wire Wire Line
	2150 2350 2450 2350
Text Label 2150 2850 0    50   ~ 0
SW7
Text Label 2150 2750 0    50   ~ 0
SW6
Text Label 2150 2650 0    50   ~ 0
SW5
Text Label 2150 2550 0    50   ~ 0
SW4
Text Label 2150 2450 0    50   ~ 0
SW3
Text Label 2150 2350 0    50   ~ 0
SW2
Text Label 5000 1850 2    50   ~ 0
SW0
Text Label 5000 1950 2    50   ~ 0
SW1
Wire Wire Line
	4650 1950 5000 1950
Wire Wire Line
	4650 1850 5000 1850
Wire Wire Line
	5000 1750 4650 1750
Wire Wire Line
	5000 1650 4650 1650
Wire Wire Line
	5000 2350 4650 2350
Wire Wire Line
	5000 2450 4650 2450
Wire Wire Line
	5000 2550 4650 2550
Wire Wire Line
	5000 2650 4650 2650
Wire Wire Line
	5000 2750 4650 2750
Wire Wire Line
	5000 2850 4650 2850
Wire Wire Line
	5000 2950 4650 2950
Wire Wire Line
	5000 3050 4650 3050
Text Label 5000 3050 2    50   ~ 0
SEG_DP
Text Label 5000 2950 2    50   ~ 0
SEG_G
Text Label 5000 2850 2    50   ~ 0
SEG_F
Text Label 5000 2750 2    50   ~ 0
SEG_E
Text Label 5000 2650 2    50   ~ 0
SEG_D
Text Label 5000 2550 2    50   ~ 0
SEG_C
Text Label 5000 2450 2    50   ~ 0
SEG_B
Text Label 5000 2350 2    50   ~ 0
SEG_A
Text Label 5000 1750 2    50   ~ 0
USB_DP
Text Label 5000 1650 2    50   ~ 0
USB_DN
Wire Wire Line
	5000 1550 4650 1550
Wire Wire Line
	5000 1450 4650 1450
Wire Wire Line
	5000 1350 4650 1350
Wire Wire Line
	2150 1350 2450 1350
Wire Wire Line
	2150 1450 2450 1450
Wire Wire Line
	2150 1550 2450 1550
Wire Wire Line
	2150 1650 2450 1650
Wire Wire Line
	2150 1750 2450 1750
Wire Wire Line
	2150 1850 2450 1850
Wire Wire Line
	5000 3250 4650 3250
Wire Wire Line
	5000 3350 4650 3350
Wire Wire Line
	5000 3450 4650 3450
Text Label 5000 3450 2    50   ~ 0
CATH3
Text Label 5000 1350 2    50   ~ 0
CATH2
Text Label 5000 1450 2    50   ~ 0
CATH1
Text Label 5000 1550 2    50   ~ 0
CATH0
Text Label 5000 3350 2    50   ~ 0
LED0
Text Label 5000 3250 2    50   ~ 0
LED1
Text Label 2150 1850 0    50   ~ 0
LED2
Text Label 2150 1750 0    50   ~ 0
LED3
Text Label 2150 1650 0    50   ~ 0
LED4
Text Label 2150 1550 0    50   ~ 0
LED5
Text Label 2150 1450 0    50   ~ 0
LED6
Text Label 2150 1350 0    50   ~ 0
LED7
$Comp
L Connector:USB_B_Mini CN1
U 1 1 60BCAB2E
P 2550 5100
F 0 "CN1" H 2607 5567 50  0000 C CNN
F 1 "USB_B_Mini" H 2607 5476 50  0000 C CNN
F 2 "Board:USB_MiniB_TE_2172034-1" H 2700 5050 50  0001 C CNN
F 3 "~" H 2700 5050 50  0001 C CNN
	1    2550 5100
	1    0    0    -1  
$EndComp
Text Notes 1250 850  0    100  ~ 0
PIC Microcontroller
Text Notes 1300 4500 0    100  ~ 0
Power / Mini USB
$Comp
L power:GND #PWR0105
U 1 1 60BD1F63
P 2550 5650
F 0 "#PWR0105" H 2550 5400 50  0001 C CNN
F 1 "GND" H 2555 5477 50  0000 C CNN
F 2 "" H 2550 5650 50  0001 C CNN
F 3 "" H 2550 5650 50  0001 C CNN
	1    2550 5650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 60BD2514
P 3000 4900
F 0 "#PWR0106" H 3000 4750 50  0001 C CNN
F 1 "+5V" H 3015 5073 50  0000 C CNN
F 2 "" H 3000 4900 50  0001 C CNN
F 3 "" H 3000 4900 50  0001 C CNN
	1    3000 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 4900 3000 4900
Wire Wire Line
	2550 5500 2550 5600
NoConn ~ 2450 5500
NoConn ~ 2850 5300
Connection ~ 2550 5600
Wire Wire Line
	2550 5600 2550 5650
Connection ~ 3000 4900
Text Label 3200 5100 2    50   ~ 0
USB_DP
Wire Wire Line
	2850 5100 3200 5100
Wire Wire Line
	2850 5200 3200 5200
Text Label 3200 5200 2    50   ~ 0
USB_DN
$Comp
L Device:R R1
U 1 1 60BDF7EF
P 3400 5400
F 0 "R1" H 3470 5446 50  0000 L CNN
F 1 "1k" H 3470 5355 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3330 5400 50  0001 C CNN
F 3 "~" H 3400 5400 50  0001 C CNN
	1    3400 5400
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 60BE04B3
P 3400 5050
F 0 "D1" V 3439 4932 50  0000 R CNN
F 1 "Red" V 3348 4932 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 3400 5050 50  0001 C CNN
F 3 "~" H 3400 5050 50  0001 C CNN
	1    3400 5050
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C2
U 1 1 60BE950B
P 4300 5250
F 0 "C2" H 4415 5296 50  0000 L CNN
F 1 "0.1u" H 4415 5205 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 4338 5100 50  0001 C CNN
F 3 "~" H 4300 5250 50  0001 C CNN
	1    4300 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 60BEA214
P 4750 5250
F 0 "C3" H 4865 5296 50  0000 L CNN
F 1 "0.1u" H 4865 5205 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 4788 5100 50  0001 C CNN
F 3 "~" H 4750 5250 50  0001 C CNN
	1    4750 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 5200 3400 5250
Wire Wire Line
	3400 5550 3400 5600
Wire Wire Line
	4300 4900 4300 5100
Wire Wire Line
	4750 5400 4750 5600
Wire Wire Line
	4300 5400 4300 5600
Text Notes 1300 6150 0    100  ~ 0
PIC Programming
$Comp
L power:+5V #PWR0107
U 1 1 60C09C7A
P 2400 6450
F 0 "#PWR0107" H 2400 6300 50  0001 C CNN
F 1 "+5V" H 2415 6623 50  0000 C CNN
F 2 "" H 2400 6450 50  0001 C CNN
F 3 "" H 2400 6450 50  0001 C CNN
	1    2400 6450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 60C0A22F
P 2400 7350
F 0 "#PWR0108" H 2400 7100 50  0001 C CNN
F 1 "GND" H 2405 7177 50  0000 C CNN
F 2 "" H 2400 7350 50  0001 C CNN
F 3 "" H 2400 7350 50  0001 C CNN
	1    2400 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 7300 2400 7350
Wire Wire Line
	2400 6450 2400 6500
$Comp
L Connector:Conn_PIC_ICSP_ICD CN2
U 1 1 60C059FC
P 2600 6900
F 0 "CN2" H 2800 7300 50  0000 R TNN
F 1 "Conn_PIC_ICSP_ICD" H 2271 6855 50  0001 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 2650 7050 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/devicedoc/30277d.pdf" V 2300 6750 50  0001 C CNN
	1    2600 6900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 6900 3100 6900
Wire Wire Line
	3600 7000 3100 7000
NoConn ~ 3100 7100
Text Label 4650 6900 2    50   ~ 0
BTN2_MCLR
Text Label 3600 6900 2    50   ~ 0
BTN1_PGD
Text Label 3600 7000 2    50   ~ 0
BTN0_PGC
Wire Wire Line
	3100 6700 3750 6700
$Comp
L Device:R R2
U 1 1 60C1D8D5
P 4050 6700
F 0 "R2" H 4120 6746 50  0000 L CNN
F 1 "10k" H 4120 6655 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3980 6700 50  0001 C CNN
F 3 "~" H 4050 6700 50  0001 C CNN
	1    4050 6700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 6700 3750 6900
Wire Wire Line
	3750 6900 4050 6900
Wire Wire Line
	4050 6850 4050 6900
Connection ~ 4050 6900
Wire Wire Line
	4050 6900 4650 6900
Wire Wire Line
	4050 6550 4050 6500
$Comp
L power:+5V #PWR0109
U 1 1 60C282E5
P 4050 6500
F 0 "#PWR0109" H 4050 6350 50  0001 C CNN
F 1 "+5V" H 4065 6673 50  0000 C CNN
F 2 "" H 4050 6500 50  0001 C CNN
F 3 "" H 4050 6500 50  0001 C CNN
	1    4050 6500
	1    0    0    -1  
$EndComp
Text Notes 6150 850  0    100  ~ 0
Switches
Text Notes 6150 3200 0    100  ~ 0
LEDs
Text Notes 6100 4600 0    100  ~ 0
7-segment LED
$Comp
L Switch:SW_SPDT SW1
U 1 1 60C38099
P 7300 2000
F 0 "SW1" H 7300 2193 50  0000 C CNN
F 1 "SW_SPDT" H 7300 2194 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 7300 2000 50  0001 C CNN
F 3 "~" H 7300 2000 50  0001 C CNN
	1    7300 2000
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW2
U 1 1 60C3B54C
P 7300 2500
F 0 "SW2" H 7300 2693 50  0000 C CNN
F 1 "SW_SPDT" H 7300 2694 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 7300 2500 50  0001 C CNN
F 3 "~" H 7300 2500 50  0001 C CNN
	1    7300 2500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW3
U 1 1 60C3DC60
P 8200 1500
F 0 "SW3" H 8200 1693 50  0000 C CNN
F 1 "SW_SPDT" H 8200 1694 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 8200 1500 50  0001 C CNN
F 3 "~" H 8200 1500 50  0001 C CNN
	1    8200 1500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW4
U 1 1 60C3FE8F
P 8200 2000
F 0 "SW4" H 8200 2193 50  0000 C CNN
F 1 "SW_SPDT" H 8200 2194 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 8200 2000 50  0001 C CNN
F 3 "~" H 8200 2000 50  0001 C CNN
	1    8200 2000
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW5
U 1 1 60C420CD
P 8200 2500
F 0 "SW5" H 8200 2693 50  0000 C CNN
F 1 "SW_SPDT" H 8200 2694 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 8200 2500 50  0001 C CNN
F 3 "~" H 8200 2500 50  0001 C CNN
	1    8200 2500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW6
U 1 1 60C442E6
P 9100 1500
F 0 "SW6" H 9100 1693 50  0000 C CNN
F 1 "SW_SPDT" H 9100 1694 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 9100 1500 50  0001 C CNN
F 3 "~" H 9100 1500 50  0001 C CNN
	1    9100 1500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW7
U 1 1 60C463F3
P 9100 2000
F 0 "SW7" H 9100 2193 50  0000 C CNN
F 1 "SW_SPDT" H 9100 2194 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 9100 2000 50  0001 C CNN
F 3 "~" H 9100 2000 50  0001 C CNN
	1    9100 2000
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT SW8
U 1 1 60C485E9
P 9100 2500
F 0 "SW8" H 9100 2693 50  0000 C CNN
F 1 "SW_SPDT" H 9100 2694 50  0001 C CNN
F 2 "Board:SW_Slide_MSS102545" H 9100 2500 50  0001 C CNN
F 3 "~" H 9100 2500 50  0001 C CNN
	1    9100 2500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW9
U 1 1 60C4A97C
P 10150 1500
F 0 "SW9" H 10150 1693 50  0000 C CNN
F 1 "SW_Push" H 10150 1694 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm_H5mm" H 10150 1700 50  0001 C CNN
F 3 "~" H 10150 1700 50  0001 C CNN
	1    10150 1500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW10
U 1 1 60C4C6A9
P 10150 2000
F 0 "SW10" H 10150 2193 50  0000 C CNN
F 1 "SW_Push" H 10150 2194 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm_H5mm" H 10150 2200 50  0001 C CNN
F 3 "~" H 10150 2200 50  0001 C CNN
	1    10150 2000
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW11
U 1 1 60C4E7B2
P 10150 2500
F 0 "SW11" H 10150 2693 50  0000 C CNN
F 1 "SW_Push" H 10150 2694 50  0001 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm_H5mm" H 10150 2700 50  0001 C CNN
F 3 "~" H 10150 2700 50  0001 C CNN
	1    10150 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 60C50BB1
P 6950 1650
F 0 "R4" H 7020 1696 50  0000 L CNN
F 1 "10k" H 7020 1605 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6880 1650 50  0001 C CNN
F 3 "~" H 6950 1650 50  0001 C CNN
	1    6950 1650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 60C51635
P 6650 1650
F 0 "R3" H 6720 1696 50  0000 L CNN
F 1 "10k" H 6720 1605 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6580 1650 50  0001 C CNN
F 3 "~" H 6650 1650 50  0001 C CNN
	1    6650 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 1800 6950 2500
Wire Wire Line
	6950 2500 7100 2500
Wire Wire Line
	7100 2000 6650 2000
Wire Wire Line
	6650 2000 6650 1800
Wire Wire Line
	6350 2000 6650 2000
Connection ~ 6650 2000
Wire Wire Line
	6350 2500 6950 2500
Connection ~ 6950 2500
Wire Wire Line
	7750 1500 8000 1500
Wire Wire Line
	7750 2000 8000 2000
Wire Wire Line
	7750 2500 8000 2500
Wire Wire Line
	8650 2500 8900 2500
Wire Wire Line
	8650 2000 8900 2000
Wire Wire Line
	8650 1500 8900 1500
Wire Wire Line
	6650 1150 6650 1400
Wire Wire Line
	6950 1500 6950 1400
Wire Wire Line
	6950 1400 6650 1400
Connection ~ 6650 1400
Wire Wire Line
	6650 1400 6650 1500
$Comp
L power:+5V #PWR0110
U 1 1 60C93B20
P 6650 1150
F 0 "#PWR0110" H 6650 1000 50  0001 C CNN
F 1 "+5V" H 6665 1323 50  0000 C CNN
F 2 "" H 6650 1150 50  0001 C CNN
F 3 "" H 6650 1150 50  0001 C CNN
	1    6650 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0111
U 1 1 60C994D6
P 10450 2800
F 0 "#PWR0111" H 10450 2550 50  0001 C CNN
F 1 "GND" H 10455 2627 50  0000 C CNN
F 2 "" H 10450 2800 50  0001 C CNN
F 3 "" H 10450 2800 50  0001 C CNN
	1    10450 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 2100 7600 2100
Wire Wire Line
	7600 2100 7600 2600
Wire Wire Line
	7600 2800 8500 2800
Wire Wire Line
	7500 2600 7600 2600
Connection ~ 7600 2600
Wire Wire Line
	7600 2600 7600 2800
Wire Wire Line
	8400 1600 8500 1600
Wire Wire Line
	8500 1600 8500 2100
Connection ~ 8500 2800
Wire Wire Line
	8500 2800 9400 2800
Wire Wire Line
	8400 2100 8500 2100
Connection ~ 8500 2100
Wire Wire Line
	8500 2100 8500 2600
Wire Wire Line
	8400 2600 8500 2600
Connection ~ 8500 2600
Wire Wire Line
	8500 2600 8500 2800
Wire Wire Line
	9300 2600 9400 2600
Wire Wire Line
	9400 2600 9400 2800
Wire Wire Line
	9400 2600 9400 2100
Wire Wire Line
	9400 1600 9300 1600
Connection ~ 9400 2600
Wire Wire Line
	9300 2100 9400 2100
Connection ~ 9400 2100
Wire Wire Line
	9400 2100 9400 1600
Wire Wire Line
	10350 1500 10450 1500
Wire Wire Line
	10450 1500 10450 2000
Connection ~ 10450 2800
Wire Wire Line
	10350 2500 10450 2500
Connection ~ 10450 2500
Wire Wire Line
	10450 2500 10450 2800
Wire Wire Line
	10350 2000 10450 2000
Connection ~ 10450 2000
Wire Wire Line
	10450 2000 10450 2500
NoConn ~ 9300 1400
NoConn ~ 9300 1900
NoConn ~ 9300 2400
NoConn ~ 8400 2400
NoConn ~ 8400 1900
NoConn ~ 8400 1400
NoConn ~ 7500 2400
NoConn ~ 7500 1900
Text Label 6350 2000 0    50   ~ 0
SW0
Text Label 6350 2500 0    50   ~ 0
SW1
Text Label 7750 1500 0    50   ~ 0
SW2
Text Label 7750 2000 0    50   ~ 0
SW3
Text Label 7750 2500 0    50   ~ 0
SW4
Text Label 8650 1500 0    50   ~ 0
SW5
Text Label 8650 2000 0    50   ~ 0
SW6
Text Label 8650 2500 0    50   ~ 0
SW7
Wire Wire Line
	9400 2800 10450 2800
Connection ~ 9400 2800
Wire Wire Line
	9550 2500 9950 2500
Wire Wire Line
	9550 2000 9950 2000
Wire Wire Line
	9550 1500 9950 1500
Text Label 9550 1500 0    50   ~ 0
BTN0_PGC
Text Label 9550 2000 0    50   ~ 0
BTN1_PGD
Text Label 9550 2500 0    50   ~ 0
BTN2_MCLR
Wire Notes Line
	7650 1000 7650 2700
Wire Notes Line
	7650 2700 9500 2700
Wire Notes Line
	9500 2700 9500 2150
Wire Notes Line
	9500 2150 10550 2150
Wire Notes Line
	10550 2150 10550 1000
Text Notes 9400 1100 0    50   ~ 0
* Internal pull-ups are used
Wire Notes Line
	10550 1000 7650 1000
$Comp
L Device:LED D2
U 1 1 60D17F41
P 6550 3850
F 0 "D2" V 6589 3732 50  0000 R CNN
F 1 "Green" V 6498 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 6550 3850 50  0001 C CNN
F 3 "~" H 6550 3850 50  0001 C CNN
	1    6550 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6350 3350 6550 3350
Wire Wire Line
	6550 3350 6550 3400
Text Label 6350 3350 0    50   ~ 0
LED0
$Comp
L Device:LED D3
U 1 1 60D1DCDF
P 7100 3850
F 0 "D3" V 7139 3732 50  0000 R CNN
F 1 "Green" V 7048 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 7100 3850 50  0001 C CNN
F 3 "~" H 7100 3850 50  0001 C CNN
	1    7100 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6900 3350 7100 3350
Wire Wire Line
	7100 3350 7100 3400
Text Label 6900 3350 0    50   ~ 0
LED1
$Comp
L Device:LED D4
U 1 1 60D22347
P 7650 3850
F 0 "D4" V 7689 3732 50  0000 R CNN
F 1 "Green" V 7598 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 7650 3850 50  0001 C CNN
F 3 "~" H 7650 3850 50  0001 C CNN
	1    7650 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7450 3350 7650 3350
Wire Wire Line
	7650 3350 7650 3400
Text Label 7450 3350 0    50   ~ 0
LED2
$Comp
L Device:LED D5
U 1 1 60D26AFD
P 8200 3850
F 0 "D5" V 8239 3732 50  0000 R CNN
F 1 "Green" V 8148 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 8200 3850 50  0001 C CNN
F 3 "~" H 8200 3850 50  0001 C CNN
	1    8200 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8000 3350 8200 3350
Wire Wire Line
	8200 3350 8200 3400
Text Label 8000 3350 0    50   ~ 0
LED3
$Comp
L Device:LED D6
U 1 1 60D2B488
P 8750 3850
F 0 "D6" V 8789 3732 50  0000 R CNN
F 1 "Green" V 8698 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 8750 3850 50  0001 C CNN
F 3 "~" H 8750 3850 50  0001 C CNN
	1    8750 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8550 3350 8750 3350
Wire Wire Line
	8750 3350 8750 3400
Text Label 8550 3350 0    50   ~ 0
LED4
$Comp
L Device:LED D7
U 1 1 60D3011F
P 9300 3850
F 0 "D7" V 9339 3732 50  0000 R CNN
F 1 "Green" V 9248 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 9300 3850 50  0001 C CNN
F 3 "~" H 9300 3850 50  0001 C CNN
	1    9300 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9100 3350 9300 3350
Wire Wire Line
	9300 3350 9300 3400
Text Label 9100 3350 0    50   ~ 0
LED5
$Comp
L Device:LED D8
U 1 1 60D34F3B
P 9850 3850
F 0 "D8" V 9889 3732 50  0000 R CNN
F 1 "Green" V 9798 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 9850 3850 50  0001 C CNN
F 3 "~" H 9850 3850 50  0001 C CNN
	1    9850 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9650 3350 9850 3350
Wire Wire Line
	9850 3350 9850 3400
Text Label 9650 3350 0    50   ~ 0
LED6
$Comp
L Device:LED D9
U 1 1 60D39FD1
P 10350 3850
F 0 "D9" V 10389 3732 50  0000 R CNN
F 1 "Green" V 10298 3732 50  0000 R CNN
F 2 "LED_THT:LED_D3.0mm" H 10350 3850 50  0001 C CNN
F 3 "~" H 10350 3850 50  0001 C CNN
	1    10350 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10150 3350 10350 3350
Wire Wire Line
	10350 3350 10350 3400
Text Label 10150 3350 0    50   ~ 0
LED7
$Comp
L Device:R_Pack04_SIP_Split RN1
U 1 1 60D486F5
P 8200 3550
F 0 "RN1" H 8288 3596 50  0000 L CNN
F 1 "1k" H 8288 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 8120 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 8200 3550 50  0001 C CNN
	1    8200 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN1
U 2 1 60D493C7
P 7650 3550
F 0 "RN1" H 7738 3596 50  0000 L CNN
F 1 "1k" H 7738 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 7570 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 7650 3550 50  0001 C CNN
	2    7650 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN1
U 3 1 60D4A8BE
P 7100 3550
F 0 "RN1" H 7188 3596 50  0000 L CNN
F 1 "1k" H 7188 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 7020 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 7100 3550 50  0001 C CNN
	3    7100 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN1
U 4 1 60D4AE67
P 6550 3550
F 0 "RN1" H 6638 3596 50  0000 L CNN
F 1 "1k" H 6638 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6470 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6550 3550 50  0001 C CNN
	4    6550 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN2
U 1 1 60D4D5F6
P 10350 3550
F 0 "RN2" H 10438 3596 50  0000 L CNN
F 1 "1k" H 10438 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 10270 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 10350 3550 50  0001 C CNN
	1    10350 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN2
U 2 1 60D4D5FC
P 9850 3550
F 0 "RN2" H 9938 3596 50  0000 L CNN
F 1 "1k" H 9938 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 9770 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 9850 3550 50  0001 C CNN
	2    9850 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN2
U 3 1 60D4D602
P 9300 3550
F 0 "RN2" H 9388 3596 50  0000 L CNN
F 1 "1k" H 9388 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 9220 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 9300 3550 50  0001 C CNN
	3    9300 3550
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN2
U 4 1 60D4D608
P 8750 3550
F 0 "RN2" H 8838 3596 50  0000 L CNN
F 1 "1k" H 8838 3505 50  0000 L CNN
F 2 "Resistor_THT:R_Array_SIP8" V 8670 3550 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 8750 3550 50  0001 C CNN
	4    8750 3550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 60D53259
P 10350 4200
F 0 "#PWR0112" H 10350 3950 50  0001 C CNN
F 1 "GND" H 10355 4027 50  0000 C CNN
F 2 "" H 10350 4200 50  0001 C CNN
F 3 "" H 10350 4200 50  0001 C CNN
	1    10350 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	10350 4200 10350 4150
Wire Wire Line
	10350 4150 9850 4150
Connection ~ 10350 4150
Connection ~ 7100 4150
Wire Wire Line
	7100 4150 6550 4150
Connection ~ 7650 4150
Wire Wire Line
	7650 4150 7100 4150
Connection ~ 8200 4150
Wire Wire Line
	8200 4150 7650 4150
Connection ~ 8750 4150
Wire Wire Line
	8750 4150 8200 4150
Connection ~ 9300 4150
Wire Wire Line
	9300 4150 8750 4150
Connection ~ 9850 4150
Wire Wire Line
	9850 4150 9300 4150
NoConn ~ 9450 5000
NoConn ~ 9450 5100
NoConn ~ 9450 5200
NoConn ~ 9800 4900
NoConn ~ 9800 5500
NoConn ~ 9800 5600
NoConn ~ 9800 5700
NoConn ~ 9450 5800
NoConn ~ 10600 5500
NoConn ~ 10600 5600
NoConn ~ 10600 5700
$Comp
L power:GND #PWR0113
U 1 1 60EA6E2F
P 10200 5950
F 0 "#PWR0113" H 10200 5700 50  0001 C CNN
F 1 "GND" H 10205 5777 50  0000 C CNN
F 2 "" H 10200 5950 50  0001 C CNN
F 3 "" H 10200 5950 50  0001 C CNN
	1    10200 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	10200 5900 10200 5950
Text Label 10900 5100 2    50   ~ 0
CATH0
Wire Wire Line
	10600 5100 10900 5100
Wire Wire Line
	10600 5200 10900 5200
Wire Wire Line
	10600 5300 10900 5300
Wire Wire Line
	10600 5400 10900 5400
Text Label 10900 5200 2    50   ~ 0
CATH1
Text Label 10900 5300 2    50   ~ 0
CATH2
Text Label 10900 5400 2    50   ~ 0
CATH3
$Comp
L Device:R_Pack04_SIP_Split RN3
U 1 1 60F5FB78
P 6800 5100
F 0 "RN3" V 6700 5000 50  0000 C CNN
F 1 "330" V 6700 5200 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5100 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5100 50  0001 C CNN
	1    6800 5100
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN3
U 2 1 60F61241
P 6800 5200
F 0 "RN3" V 6593 5200 50  0001 C CNN
F 1 "330" V 6684 5200 50  0001 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5200 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5200 50  0001 C CNN
	2    6800 5200
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN3
U 3 1 60F62C97
P 6800 5300
F 0 "RN3" V 6593 5300 50  0001 C CNN
F 1 "330" V 6684 5300 50  0001 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5300 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5300 50  0001 C CNN
	3    6800 5300
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN3
U 4 1 60F69F0F
P 6800 5400
F 0 "RN3" V 6593 5400 50  0001 C CNN
F 1 "330" V 6684 5400 50  0001 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5400 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5400 50  0001 C CNN
	4    6800 5400
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN4
U 1 1 60F7448B
P 6800 5650
F 0 "RN4" V 6700 5550 50  0000 C CNN
F 1 "330" V 6700 5750 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5650 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5650 50  0001 C CNN
	1    6800 5650
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN4
U 2 1 60F74491
P 6800 5750
F 0 "RN4" V 6593 5750 50  0001 C CNN
F 1 "330" V 6684 5750 50  0001 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5750 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5750 50  0001 C CNN
	2    6800 5750
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN4
U 3 1 60F74497
P 6800 5850
F 0 "RN4" V 6593 5850 50  0001 C CNN
F 1 "330" V 6684 5850 50  0001 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5850 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5850 50  0001 C CNN
	3    6800 5850
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Pack04_SIP_Split RN4
U 4 1 60F7449D
P 6800 5950
F 0 "RN4" V 6900 5850 50  0001 C CNN
F 1 "330" V 6900 6050 50  0001 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 6720 5950 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 6800 5950 50  0001 C CNN
	4    6800 5950
	0    -1   1    0   
$EndComp
Wire Wire Line
	6300 5100 6650 5100
Wire Wire Line
	6650 5200 6300 5200
Wire Wire Line
	6300 5650 6650 5650
Wire Wire Line
	6300 5300 6650 5300
Wire Wire Line
	6300 5750 6650 5750
Wire Wire Line
	6300 5850 6650 5850
Wire Wire Line
	6300 5400 6650 5400
Wire Wire Line
	6300 5950 6650 5950
Text Label 6300 5100 0    50   ~ 0
SEG_A
Text Label 6300 5200 0    50   ~ 0
SEG_B
Text Label 6300 5650 0    50   ~ 0
SEG_C
Text Label 6300 5300 0    50   ~ 0
SEG_D
Text Label 6300 5750 0    50   ~ 0
SEG_E
Text Label 6300 5850 0    50   ~ 0
SEG_F
Text Label 6300 5400 0    50   ~ 0
SEG_G
Text Label 6300 5950 0    50   ~ 0
SEG_DP
Wire Wire Line
	3000 4900 3400 4900
Wire Wire Line
	2550 5600 3400 5600
Connection ~ 3400 4900
Connection ~ 3400 5600
Connection ~ 4300 4900
Connection ~ 4300 5600
Wire Wire Line
	3400 5600 3850 5600
Wire Wire Line
	3400 4900 3850 4900
Wire Wire Line
	4750 4900 4750 5100
Wire Wire Line
	4300 4900 4750 4900
Wire Wire Line
	4300 5600 4750 5600
$Comp
L Device:C C1
U 1 1 6105A603
P 3850 5250
F 0 "C1" H 3965 5296 50  0000 L CNN
F 1 "2.2u" H 3965 5205 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3888 5100 50  0001 C CNN
F 3 "~" H 3850 5250 50  0001 C CNN
	1    3850 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 4900 3850 5100
Wire Wire Line
	3850 5400 3850 5600
Connection ~ 3850 4900
Wire Wire Line
	3850 4900 4300 4900
Connection ~ 3850 5600
Wire Wire Line
	3850 5600 4300 5600
Wire Wire Line
	6550 4000 6550 4150
Wire Wire Line
	10350 4000 10350 4150
Wire Wire Line
	7100 4000 7100 4150
Wire Wire Line
	7650 4000 7650 4150
Wire Wire Line
	8200 4000 8200 4150
Wire Wire Line
	8750 4000 8750 4150
Wire Wire Line
	9300 4000 9300 4150
Wire Wire Line
	9850 4000 9850 4150
$Comp
L Board:OSL40391-LX U2
U 1 1 60DDE545
P 8350 5400
F 0 "U2" H 8350 6067 50  0000 C CNN
F 1 "OSL40391-LX" H 8350 5976 50  0000 C CNN
F 2 "Board:OSL40391" H 8350 4800 50  0001 C CNN
F 3 "" H 7970 5430 50  0001 C CNN
	1    8350 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 5500 9600 5300
Wire Wire Line
	9650 5600 9650 5200
$Comp
L Transistor_Array:ULN2003A U3
U 1 1 60E335D1
P 10200 5300
F 0 "U3" H 10200 5967 50  0000 C CNN
F 1 "ULN2003A" H 10200 5876 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_LongPads" H 10250 4750 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/uln2003a.pdf" H 10300 5100 50  0001 C CNN
	1    10200 5300
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9700 5700 9700 5100
Wire Wire Line
	9700 5100 9800 5100
Wire Wire Line
	9700 5700 9450 5700
Wire Wire Line
	9450 5600 9650 5600
Wire Wire Line
	9450 5500 9600 5500
Wire Wire Line
	9450 5400 9800 5400
Wire Wire Line
	9600 5300 9800 5300
Wire Wire Line
	9650 5200 9800 5200
Wire Wire Line
	6950 5100 7250 5100
Wire Wire Line
	6950 5200 7250 5200
Wire Wire Line
	6950 5400 7050 5400
Wire Wire Line
	7050 5400 7050 5700
Wire Wire Line
	7050 5700 7250 5700
Wire Wire Line
	6950 5300 7150 5300
Wire Wire Line
	7150 5300 7150 5400
Wire Wire Line
	7150 5400 7250 5400
Wire Wire Line
	6950 5650 7200 5650
Wire Wire Line
	7200 5650 7200 5300
Wire Wire Line
	7200 5300 7250 5300
Wire Wire Line
	7250 5600 7150 5600
Wire Wire Line
	7150 5600 7150 5850
Wire Wire Line
	6950 5850 7150 5850
Wire Wire Line
	7100 5500 7100 5750
Wire Wire Line
	7100 5750 6950 5750
Wire Wire Line
	7100 5500 7250 5500
Wire Wire Line
	6950 5950 7200 5950
Wire Wire Line
	7200 5950 7200 5800
Wire Wire Line
	7200 5800 7250 5800
$EndSCHEMATC
