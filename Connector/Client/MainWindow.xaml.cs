// Connector for SawareruSys (Client Side)
// 2023-02-22 Naoki F., AIT (Renamed on 2024-03-28)

using System;
using System.IO.Ports;
using System.Linq;
using System.Management;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Text;
using System.Net.Sockets;
using System.Collections.Generic;
using System.Windows.Controls;
using Microsoft.VisualBasic;
using System.IO;

namespace Connector
{
    /// <summary>
    /// 操作に使用する文字列の定義
    /// </summary>
    public class RemoChar
    {
        public const string HELLO_SEND = "VX";
        public const string RESET_SEND = "VZ";
        public const string FPGA_RECV  = "vx";
        public const string REMO_RECV  = "WY";
        public const byte   HELLO_SEND1 = (byte)'V';
        public const byte   HELLO_SEND2 = (byte)'X';
        public const byte   FPGA_RECV1  = (byte)'v';
        public const byte   FPGA_RECV2  = (byte)'x';
        public const byte   REMO_RECV1  = (byte)'W';
        public const byte   REMO_RECV2  = (byte)'Y';
    }

    /// <summary>
    /// デバイスが認識/切断されたことをウィンドウに通知するときに使う
    /// </summary>
    public class DeviceRecognizedEventArgs : EventArgs
    {
        public bool IsFPGA;
        public bool IsRecognized;
        public DeviceRecognizedEventArgs(bool IsFPGA, bool IsRecognized)
        {
            this.IsFPGA = IsFPGA;
            this.IsRecognized = IsRecognized;
        }
    }

    /// <summary>
    /// シリアルポート関連の情報を保持するクラス
    /// </summary>
    public class DevicePort
    {
        public event EventHandler<DeviceRecognizedEventArgs> Recognized;

        private bool closing;
        private int recognizeStep;
        public SerialPort ser;
        public TCPPort other;
        public Task iotask;
        private MainWindow win;
        public string portName;
        private DateTime hb_send, hb_recv;

        public const string NoPort = "None";

        public DevicePort(MainWindow win)
        {
            this.win = win;
            closing = true;
            portName = NoPort;
        }

        // ポートを開く
        public void Open()
        {
            if (ser != null || portName == NoPort)
                return;
            ser = new SerialPort();
            ser.PortName = portName;
            ser.BaudRate = 115200;
            ser.ReadTimeout = 500;
            win.AddLog("Opening " + ser.PortName);
            try
            {
                ser.Open();
            } catch (Exception e)
            {
                win.AddLog("Error opening the port: " + e.Message);
                ser = null;
                Recognized.Invoke(this, new DeviceRecognizedEventArgs(false, false));
                return;
            }
            hb_send = DateTime.Now - new TimeSpan(1, 0, 0);
            hb_recv = DateTime.Now;
            closing = false;

            try
            {
                iotask = Task.Run(() => ReadLoop());
                iotask.ContinueWith((t) =>
                {
                    if (t.IsFaulted)
                    {
                        win.AddLog("Failed to access to " + ser.PortName);
                        Close();
                    }
                });
            }
            catch (Exception) { }
        }

        // ポートを閉じる
        public void Close()
        {
            if (ser == null)
                return;
            win.AddLog("Closing " + ser.PortName);
            closing = true;
            iotask = null;
        }

        private void ReadLoop()
        {
            while (! closing)
            {
                try
                {
                    // シリアルポートから読み出して処理
                    int newByte = ser.ReadByte();
                    if (newByte == RemoChar.REMO_RECV1)
                    {
                        if (recognizeStep == 0)
                            recognizeStep = 1;
                        else if (recognizeStep != 3)
                            recognizeStep = 0;
                    }
                    else if (newByte == RemoChar.REMO_RECV2)
                    {
                        hb_recv = DateTime.Now;
                        if (recognizeStep == 1)
                        {
                            recognizeStep = 3;
                            Recognized.Invoke(this, new DeviceRecognizedEventArgs(false, true));
                        }
                        else if (recognizeStep != 3)
                            recognizeStep = 0;
                    }
                    else if (recognizeStep == 3)
                    {
                        other?.Write(((char)newByte).ToString());
                    }
                }
                catch (TimeoutException) { }
                catch (IOException)
                {
                    win.AddLog("Serial port error occurred. Closing...");
                    closing = true;
                    break;
                }

                // 定期的に文字列を送信し，返答がなければ切断
                if ((DateTime.Now - hb_send).TotalMilliseconds > 3000)
                {
                    hb_send = DateTime.Now;
                    Write(RemoChar.HELLO_SEND);
                }
                if ((DateTime.Now - hb_recv).TotalMilliseconds > 15000)
                {
                    win.AddLog("Serial port timeout reached. Closing...");
                    closing = true;
                }
            }
            recognizeStep = 0;
            ser.Close();
            ser = null;
            Recognized.Invoke(this, new DeviceRecognizedEventArgs(false, false));
        }

        public void Write(string str) // この Write は TCP 側から呼ばれる
        {
            try
            {
                ser?.Write(str);
            }
            // 既に ser が閉じていたり，ser が開く前に Write が呼ばれると起きる例外
            catch (InvalidOperationException) { } 
        }
    }

    /// <summary>
    /// TCP クライアント関係の情報を保持するクラス
    /// </summary>
    public class TCPPort
    {
        public event EventHandler<DeviceRecognizedEventArgs> Recognized;

        private bool closing;
        public Socket client;
        public DevicePort other;
        public Task iotask;
        private MainWindow win;
        public int portNumber;

        public const int defaultPortNumber = 13399;

        public TCPPort(MainWindow win)
        {
            this.win = win;
            closing = true;
            portNumber = defaultPortNumber;
        }

        // TCP ポートをサーバに接続する
        public void Open()
        {
            if (client != null)
                return;

            win.AddLog("Opening TCP client");
            client = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            closing = false;

            try
            {
                iotask = Task.Run(() => ReadLoop());
                iotask.ContinueWith((t) =>
                {
                    if (t.IsFaulted)
                    {
                        win.AddLog("TCP client thread got an exception.");
                        Close();
                    }
                });
            }
            catch (Exception) { }
        }

        // ポートを閉じる
        public void Close()
        {
            if (client == null)
                return;
            win.AddLog("Closing TCP client");
            closing = true;
            client?.Close();
            iotask = null;
        }

        // データを読み取る
        public void ReadLoop()
        {
            byte[] buf = new byte[256];
            try
            {
                client.Connect("127.0.0.1", portNumber);
            }
            catch (SocketException e)
            {
                if (e.SocketErrorCode == SocketError.ConnectionRefused ||
                    e.SocketErrorCode == SocketError.TimedOut)
                    win.AddLog("TCP connection is timed out or refused.");
                else
                    win.AddLog("Unexpected socket exception: " + e.ToString());
                client?.Close();
                client = null;
                Recognized.Invoke(this, new DeviceRecognizedEventArgs(true, false));
                return;
            }

            Recognized.Invoke(this, new DeviceRecognizedEventArgs(true, true));
            win.AddLog("Connected to port " + portNumber.ToString());

            while (!closing)
            {
                try
                {
                    while (!closing && client != null)
                    {
                        int readBytes = client.Receive(buf);
                        if (readBytes == 0)
                        {
                            // 空文字列を受け取ったら，サーバが接続を切断したと判断
                            win.AddLog("Server has closed connection.");
                            break;
                        }
                        for (int i = 0; i < readBytes; i++)
                        {
                            if (buf[i] == RemoChar.HELLO_SEND2)
                            {
                                // Hello が送られてきたら返答する
                                Write(RemoChar.REMO_RECV);
                            }
                            else if (buf[i] != RemoChar.HELLO_SEND1)
                            {
                                // それ以外の場合は受け取った文字列をシリアルに書き込む
                                other?.Write(((char)buf[i]).ToString());
                            }
                        }
                    }
                    closing = true;
                }
                catch (SocketException e) // Close ボタンが押されたときにこれらの例外が発生
                {
                    if (e.SocketErrorCode != SocketError.Interrupted &&
                        e.SocketErrorCode != SocketError.ConnectionAborted &&
                        e.SocketErrorCode != SocketError.ConnectionReset)
                        win.AddLog("Unexpected socket exception: " + e.Message);
                    closing = true;
                }
            }
            client?.Close();
            client = null;
            win.AddLog("TCP client is closed.");
            Recognized.Invoke(this, new DeviceRecognizedEventArgs(true, false));
        }

        public void Write(string str) // この Write はシリアル側から呼ばれる
        {
            try
            {
                client?.Send(Encoding.ASCII.GetBytes(str));
            }
            catch (SocketException e) // 接続が切断されると例外が発生するかも
            {
                if (e.SocketErrorCode == SocketError.ConnectionAborted ||
                    e.SocketErrorCode == SocketError.ConnectionReset)
                    win.AddLog("Server has closed connection.");
                else
                    win.AddLog("Unexpected socket exception: " + e.Message);
                client?.Close();
                client = null;
                closing = true;
            }
        }
    }

    /// <summary>
    /// MainWindow.xaml の相互作用ロジック
    /// </summary>
    public partial class MainWindow : Window
    {
        private DevicePort RemoConPort;
        private TCPPort FPGAPort;
        private bool RemoConRecognized, FPGARecognized;

        private const string ButtonStringConnect = "Connect";
        private const string ButtonStringDisconnect = "Disconnect";
        private const string PortStringDefault = "Use Default Port";
        private const string PortStringOther = "Specify Other Port";


        public MainWindow()
        {
            InitializeComponent();
            FPGAPort = new TCPPort(this);
            FPGAPort.Recognized += DeviceRecognized;

            RemoConPort = new DevicePort(this);
            RemoConPort.Recognized += DeviceRecognized;

            RemoConPort.other = FPGAPort;
            FPGAPort.other = RemoConPort;

            txtLog.Text = "";
            txtLog.DataContext = this;
            RemoConRecognized = FPGARecognized = false;
            AddLog("Connector App is started.");
            UpdateStatus();
        }

        // ポート一覧をアップデートする
        public List<string> EnumCOMPorts()
        {
            string[] usedPortNames = new string[]
            {
                RemoConPort.ser == null ? "" : RemoConPort.ser.PortName
            };
                
            string[] portNames = SerialPort.GetPortNames().Except(usedPortNames).ToArray();

            using (var searcher = new ManagementObjectSearcher("SELECT * FROM Win32_PnPEntity WHERE Caption like '%(COM%'"))
            {
                var ports = searcher.Get().Cast<ManagementBaseObject>().ToList().Select(p => p["Caption"].ToString());
                return portNames.Select(n => n + ": " + ports.FirstOrDefault(s => s.Contains('(' + n + ')'))).ToList();
            }
        }

        // 接続ステータスをアップデートする
        private void UpdateStatus()
        {
            btnConnectRemoCon.Dispatcher.Invoke(() =>
            {
                btnConnectRemoCon.Content   = (RemoConPort.ser == null) ? ButtonStringConnect : ButtonStringDisconnect;
                btnConnectRemoCon.IsEnabled = (RemoConPort.portName != DevicePort.NoPort);
            });
            btnConnectFPGA.Dispatcher.Invoke(() =>
            {
                btnConnectFPGA.Content   = (FPGAPort.client == null) ? ButtonStringConnect : ButtonStringDisconnect;
            });
            lblRemoConPort.Dispatcher.Invoke(() =>
            {
                lblRemoConPort.Content    = RemoConPort.portName;
                lblRemoConPort.Foreground = (RemoConRecognized)       ? Brushes.Blue :
                                            (RemoConPort.ser == null) ? Brushes.Gray : Brushes.Black;
            });
            lblFPGAPort.Dispatcher.Invoke(() =>
            {
                lblFPGAPort.Content    = FPGAPort.portNumber;
                lblFPGAPort.Foreground = (FPGARecognized)          ? Brushes.Blue :
                                         (FPGAPort.client == null) ? Brushes.Gray : Brushes.Black;
            });
            rctConnect.Dispatcher.Invoke(() =>
            {
                rctConnect.Fill = (FPGARecognized && RemoConRecognized)                ? Brushes.Blue :
                                  (FPGAPort.client != null && RemoConPort.ser != null) ? Brushes.Red : Brushes.Gray;
            });
        }

        // ログに1行追加する
            public void AddLog(string line)
        {
            txtLog.Dispatcher.Invoke(() =>
            {
                if (txtLog.Text != "")
                    txtLog.Text += "\n";
                txtLog.Text += "[" + DateTime.Now.ToString("HH:mm:ss") + "] " + line;
                txtLog.ScrollToEnd();
            });
        }

        // デバイスが認識されたときにコールバックされる
        public void DeviceRecognized(object sender, DeviceRecognizedEventArgs e)
        {
            if (e.IsFPGA)
            {
                FPGARecognized = e.IsRecognized;
                if (FPGARecognized)
                    AddLog("FPGA board is recognized.");
            }
            else
            {
                RemoConRecognized = e.IsRecognized;
                if (RemoConRecognized)
                    AddLog("RemoCon board is recognized.");
            }
            if (FPGARecognized && RemoConRecognized)
            {
                RemoConPort.Write(RemoChar.RESET_SEND);
                FPGAPort.Write(RemoChar.RESET_SEND);
            }
            UpdateStatus();
        }

        // 各イベントに対応するメソッド
        private void Window_Closed(object sender, EventArgs e)
        {
            // ウィンドウを閉じる: ポートの後始末
            RemoConPort.Close();
            FPGAPort.Close();
        }

        private void FPGAPort_Click(object sender, RoutedEventArgs e)
        {
            if (FPGAPort.client != null)
                return;

            ContextMenu menu = new ContextMenu();
            string[] ports = new string[]{PortStringDefault, PortStringOther};
            foreach (string port in ports)
            {
                MenuItem item = new MenuItem();
                item.Header = port;
                item.Click += FPGAPortItem_Click;
                menu.Items.Add(item);
            }
            menu.PlacementTarget = lblRemoConPort;
            menu.IsOpen = true;
            e.Handled = true;
        }

        private void FPGAPortItem_Click(object sender, RoutedEventArgs e)
        {
            if (FPGAPort.client != null)
                return;

            if (((MenuItem)sender).Header.ToString() == PortStringDefault)
            {
                FPGAPort.portNumber = TCPPort.defaultPortNumber;
            }
            else
            {
                string ret = Interaction.InputBox("Specify Port Number", "Connector", FPGAPort.portNumber.ToString(), -1, -1);
                if (!ushort.TryParse(ret, out ushort newPortNumber))
                    return;
                if (newPortNumber == 0)
                    return;
                FPGAPort.portNumber = newPortNumber;
            }
            UpdateStatus();
        }

        private void ConnectFPGA_Click(object sender, RoutedEventArgs e)
        {
            if (btnConnectFPGA.Content.ToString() == ButtonStringConnect)
                FPGAPort.Open();
            else
                FPGAPort.Close();
            UpdateStatus();
        }

        private void RemoConPort_Click(object sender, RoutedEventArgs e)
        {
            if (RemoConPort.ser != null)
                return;

            List<string> COMPorts = EnumCOMPorts();
            if (COMPorts.Count == 0)
            {
                AddLog("No serial ports were found.");
                e.Handled = true;
                return;
            }

            ContextMenu menu = new ContextMenu();
            foreach (string port in COMPorts)
            {
                MenuItem item = new MenuItem();
                item.Header = port;
                item.Click += RemoConPortItem_Click;
                menu.Items.Add(item);
            }
            menu.PlacementTarget = lblFPGAPort;
            menu.IsOpen = true;
            e.Handled = true;
        }

        private void RemoConPortItem_Click(object sender, RoutedEventArgs e)
        {
            if (RemoConPort.ser != null)
                return;

            string portName = ((MenuItem)sender).Header.ToString();
            RemoConPort.portName = portName.Substring(0, portName.IndexOf(":"));
            UpdateStatus();
        }

        private void ConnectRemoCon_Click(object sender, RoutedEventArgs e)
        {
            if (btnConnectRemoCon.Content.ToString() == ButtonStringConnect)
                RemoConPort.Open();
            else
                RemoConPort.Close();
            UpdateStatus();
        }
    }
}