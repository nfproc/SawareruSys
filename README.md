SawareruSys: A "touchable" remote FPGA lab system
=================================================
Copyright (C) 2022-2025 Naoki FUJIEDA. All rights reserved.

### 概要

ディジタル回路や FPGA の学習におけるこれまでの遠隔学習システムには，
その操作から実際にハードウェアに触れているとの実感を得ることが難しい，
という問題点がありました．例えば，ACRi ルーム上の仮想マシンには FPGA
ボードが接続されているものの，そのスイッチや LED 等を直接操作・確認
することはできませんでした．

本リポジトリでは，この問題点に対する解決法として開発された，ディジタル
回路の「さわれる」遠隔学習システム SawareruSys のソースコード一式を
公開しています．詳しい学術的背景や，システムの設計・評価については，
以下の文献を参照してください．

N. Fujieda and A. Okuchi. A Novel Remote FPGA Lab Platform Using
MCU-based Controller Board. In 12th International Conference on
Teaching, Assessment and Learning for Engineering (TALE 2023),
pp. 188-193, 2023, DOI: <a href="https://doi.org/10.1109/TALE56641.2023.10398409">
10.1109/TALE56641.2023.10398409</a>.

ユーザ向けの説明は，ユーザマニュアルを参照してください．マニュアルは，
本リポジトリの Manual/main.pdf または配布パッケージの UserManual.pdf
にあります．

配布パッケージのダウンロード:
<a href="https://aitech.ac.jp/~dslab/nf/SawareruSys/SawareruSys_dist_v1_1_0.zip">
ZIP</a> (33.2 MiB)

### 本リポジトリの内容:
- Board/         : コントローラボードの KiCad による設計ファイル一式
  - v2/          : 「FPGA リモコンボード V2」用
  - v4/          : 「FPGA リモコンボード V4」および「SawareruBoard V1」用
- Connector/     : コントローラボードと FPGA ボードとの通信中継アプリ
  - Client/      : PC 側で動作させる Connector アプリ（C# + WPF）
  - Server/      : 遠隔サーバ側で動作させる Connector アプリ（Python）
- DRFront/       : <a href="https://github.com/nfproc/DRFront">DRFront</a>
- Manual/        : ユーザマニュアルの LaTeX ソース一式
- PIC/           : コントローラボード上の PIC 制御プログラム（C）
  - RemoCon_v2.X : 「FPGA リモコンボード V2」用
  - RemoCon_v4.X : 「FPGA リモコンボード V4」および「SawareruBoard V1」用
- svinst_port/   : <a href="https://github.com/nfproc/svinst_port">svinst_port</a>

### 動作環境
- PC 側: Windows 10 以降 + .NET Framework 4.8
- サーバ側: Ubuntu 20.04 LTS 以降 + Python 3.8 以降 + Vivado 2020.2 以降

配布パッケージをビルドする際には，msbuild と Rust (cargo) も必要です．
msbuild 17.13.19 (Visual Studio 2022) および cargo 1.86.0 の環境で
ビルドできることを確認しています．

### 配布パッケージのビルド
配布パッケージのビルドは，PowerShell スクリプト Generate_Dist.ps1
により自動的に行います．このスクリプトは，作業フォルダとして Build，
Dist，Pkg の3つのフォルダを作成し，SawareruSys の配布パッケージを
SawareruSys_dist.zip，DRFront の配布パッケージを DRFront_dist.zip
として，それぞれ保存します．

### ライセンス
サブモジュール（DRFront と svinst_port），および PIC/RemoCon_v2.x
フォルダの `usb_` で始まるファイルを**除く**各ファイルには，New BSD
ライセンスが適用されます．

また，SawareruSys の配布パッケージには以下のソフトウェアが含まれ，
それぞれのライセンスに従ってバイナリを再配布しています．
- DRFront: New BSD ライセンス
- Ookii.Dialogs.Wpf: New BSD ライセンス
- svinst_port: MIT ライセンス
- WinSCP: GPL v3 ライセンス

PIC/RemoCon_v2.x フォルダの `usb_` で始まるファイル群は，Microchip
USB ライブラリの一部であり，Microchip 社の著作物です．これらには
Apache ライセンス v2.0 が適用されます．

詳細は COPYING ファイルを参照してください．

### 更新履歴
- v1.1.0 2025-05-08
  - DRFront のバージョンを 0.6.0 に更新．
  - 上記更新に伴うビルドスクリプトの修正．

- v1.0.1 2024-05-06
  - DRFront のバージョンを 0.5.1 に更新．
  - 配布パッケージをビルドする際，前回作成した zip ファイルを上書き
    するように変更．

- v1.0.0 2024-04-03
  - 最初のバージョン．