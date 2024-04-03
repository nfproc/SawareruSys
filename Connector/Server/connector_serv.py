#!/usr/bin/env python3

## Connector for SawareruSys (Server Side), Python version
## 2023-01-18 Naoki F., AIT (Renamed on 2024-03-28)

import sys
import time
import errno
import signal
import socket
import serial
from threading import Thread

FINISH = False

def writelog(str):
    nowstr = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
    print("[%s] %s" % (nowstr, str))
    sys.stdout.flush()

## SIGINT handler
def handler(signum, frame):
    global FINISH
    writelog("Interrupt caught. Exiting...")
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    FINISH = True

class DeviceParam():
    HELLO_SEND = b"VX"
    RESET_SEND = b"VZ"
    FPGA_RECV1 = b"v"
    FPGA_RECV2 = b"x"
    REMO_RECV1 = b"W"
    REMO_RECV2 = b"Y"
    TIMEOUT_READ = 0.5
    TIMEOUT_PING = 15.0
    PING_INTERVAL = 3.0

## Manager Base Class
class Manager():
    def device_recognized(self): # called when the device is recognized
        if not self.recognized:
            self.recognized = True
            if self.other.recognized:
                self.write(DeviceParam.RESET_SEND)
                self.other.write(DeviceParam.RESET_SEND)

## Manager class for serial port
class DevicePort(Manager):
    def __init__(self, portname):
        self.thread = Thread(target=self.readloop)
        self.ser = serial.Serial()
        self.ser.port = portname
        self.ser.baudrate = 115200
        self.ser.timeout = DeviceParam.TIMEOUT_READ
        self.initialized = True
        self.last_hb_send = self.last_hb_recv = 0
        self.last_failure = False
        self.recognized = False
            
    def open(self):
        self.thread.start()

    def close(self):
        self.ser.close()
        self.last_hb_send = self.last_hb_recv = 0
        self.last_failure = False
        self.recognized = False

    def readloop(self):
        while not FINISH:
            if self.ser.is_open:
                try:
                    # receive a byte from serial port
                    new_byte = self.ser.read()
                    if len(new_byte) == 0 or new_byte == DeviceParam.FPGA_RECV1:
                        pass
                    elif new_byte == DeviceParam.FPGA_RECV2:
                        self.last_hb_recv = time.time()
                        self.device_recognized()
                    else:
                        self.other.write(new_byte)
                    # check timeout
                    if self.last_hb_send + DeviceParam.PING_INTERVAL < time.time():
                        self.last_hb_send = time.time()
                        self.ser.write(DeviceParam.HELLO_SEND)
                    if self.last_hb_recv + DeviceParam.TIMEOUT_PING < time.time():
                        writelog("Serial port timeout reached. Closing...")
                        self.ser.close()
                        self.recognized = False
                except serial.SerialException as e:
                    self.handle_exception(e)
            else:
                try:
                    # try to open port
                    self.ser.open()
                    self.ser.write(DeviceParam.HELLO_SEND)
                    self.last_hb_send = self.last_hb_recv = time.time()
                    self.last_failure = False
                    writelog("Serial port opened.")
                except serial.SerialException as e:
                    if not self.last_failure:
                        writelog("Serial port not opened. Keep trying...")
                        self.last_failure = True
                    time.sleep(10)

    def write(self, str): # This write() is called from the TCP side
        if self.ser.is_open:
            try:
                self.ser.write(str)
            except serial.SerialException as e:
                self.handle_exception(e)

    def handle_exception(self, e): # handle exception, which may occur if disconnected
        writelog("Serial port exception occurred (%s). Closing..." % e)
        self.ser.close()
        self.recognized = False

## Manager class for TCP Server
class TCPServer(Manager):
    def __init__(self, portname):
        self.thread = Thread(target=self.readloop)
        try:
            self.serv = socket.socket(socket.AF_INET)
            self.serv.bind(('', int(portname)))
            self.serv.listen(1)
            self.initialized = True
        except OSError:
            writelog("Server cannot start. Stop.")
            self.serv = None
        self.client = None
        self.last_hb_send = self.last_hb_recv = 0
        self.recognized = False

    def open(self):
        self.thread.start()
        writelog("Server started listening.")

    def close(self):
        if self.client is not None:
            self.client.close()
            self.client = None
        self.serv.close()
        self.serv = None
        self.last_hb_send = self.last_hb_recv = 0
        self.recognized = False

    def readloop(self):
        while not FINISH:
            try:
                self.serv.settimeout(DeviceParam.TIMEOUT_READ)
                self.client, addr = self.serv.accept()
                self.client.settimeout(DeviceParam.TIMEOUT_READ)
                self.last_hb_send = self.last_hb_recv = time.time()
                self.client.sendall(DeviceParam.HELLO_SEND)
                writelog("Client %s is connected." % str(addr))
                while not FINISH and self.client is not None:
                    try:
                        new_bytes = self.client.recv(4096)
                        if len(new_bytes) == 0:
                            # recv returns empty when disconnected
                            writelog("Client has closed connection.")
                            break
                        # transfer received string otherwise
                        if DeviceParam.REMO_RECV2 in new_bytes:
                            self.last_hb_recv = time.time()
                            self.device_recognized()
                        new_bytes = new_bytes.replace(DeviceParam.REMO_RECV1, b"")
                        new_bytes = new_bytes.replace(DeviceParam.REMO_RECV2, b"")
                        self.other.write(new_bytes)
                    except socket.timeout:
                        pass
                    # check timeout
                    if self.last_hb_send + DeviceParam.PING_INTERVAL < time.time():
                        self.last_hb_send = time.time()
                        self.client.sendall(DeviceParam.HELLO_SEND)
                    if self.last_hb_recv + DeviceParam.TIMEOUT_PING < time.time():
                        writelog("TCP timeout reached. Closing...")
                        self.client.close()
                        self.client = None
                        self.recognized = False
            except socket.timeout:
                pass
            except OSError as e: # exception may occur if disconnected
                self.handle_exception(e, (errno.EINTR, errno.ECONNABORTED, errno.ECONNRESET))

    def write(self, str): # This write() is called from the Serial side
        if self.client is not None:
            try:
                self.client.sendall(str)
            except OSError as e:
                self.handle_exception(e, (errno.ECONNABORTED, errno.ECONNRESET))

    def handle_exception(self, e, expected): # handle exception, which may occur if disconnected
        if e.errno in expected:
            writelog("Client has closed connection.")
        else:
            writelog("Socket exception occurred (%s)." % e)
        if self.client is not None:
            self.client.close()
        self.client = None
        self.recognized = False
        

## main routine
if __name__ == "__main__": 
    if len(sys.argv) != 3:
        print("usage: python3 connector_serv.py serial_device port_number")
        exit(1)
  
    port = DevicePort(sys.argv[1])
    serv = TCPServer(sys.argv[2])
    if not port.initialized or not serv.initialized:
        exit(1)
    port.other = serv
    serv.other = port

    print("")
    writelog("Connector for SawareruSys started.")

    signal.signal(signal.SIGINT, handler)
    port.open()
    serv.open()
    port.thread.join()
    serv.thread.join()
    port.close()
    serv.close()

    writelog("Connector for SawareruSys stopped.")