# Distibution Package Generation for SawareruSys
# 2024-04-02 Naoki F., AIT
$OutputEncoding = [Text.Encoding]::UTF8

# Constants
$DistDir        = $PSScriptRoot + "\Dist"
$PackageDir     = $PSScriptRoot + "\Pkg"
$BuildDir       = $PSScriptRoot + "\Build"
$WinSCPRemote   = "https://sourceforge.net/projects/winscp/files/WinSCP/6.3.2/WinSCP-6.3.2-Portable.zip"
$WinSCPLocal    = $PackageDir + "\WinSCP632.zip"
$WinSCPJARemote = "https://winscp.net/translations/dll/6.3.2/jp.zip"
$WinSCPJALocal  = $PackageDir + "\WinSCP632JA.zip"
$OokiiRemote    = "https://www.nuget.org/api/v2/package/Ookii.Dialogs.Wpf/5.0.1"
$OokiiLocal     = $PackageDir + "\Ookii.Dialogs.Wpf.5.0.1.zip"

# Check if msbuild and cargo is available
if (-Not (Get-Command msbuild -errorAction SilentlyContinue)) {
  Write-Host "msbuild が利用できません．Developer Powershell を使用しているか確認してください．"
  pause
  exit
}
if (-Not (Get-Command cargo -errorAction SilentlyContinue)) {
  Write-Host "cargo が利用できません．Rust がインストールされているか確認してください．"
  pause
  exit
}

# Prepare Destination and Temporary Folders
If (-Not (Test-Path $DistDir)) {
  New-Item -Path $DistDir -ItemType Directory > $null
  Write-Host $DistDir "を作成しました．"
} Else {
  Remove-Item ${DistDir}\* -Recurse -Force
  Write-Host $DistDir "の中身を削除しました．"
}
If (-Not (Test-Path $BuildDir)) {
  New-Item -Path $BuildDir -ItemType Directory > $null
  Write-Host $BuildDir "を作成しました．"
} Else {
  Remove-Item ${BuildDir}\* -Recurse -Force
  Write-Host $BuildDir "の中身を削除しました．"
}
If (-Not (Test-Path $PackageDir)) {
  New-Item -Path $PackageDir -ItemType Directory > $null
  Write-Host $PackageDir "を作成しました．"
}

# Download packages unless it already exists
If (-Not (Test-Path $WinSCPLocal)) {
  Write-Host "WinSCP をダウンロードします．"
  Invoke-WebRequest $WinSCPRemote -OutFile $WinSCPLocal -UserAgent "Wget"
}
If (-Not (Test-Path $WinSCPJALocal)) {
  Write-Host "WinSCP の日本語言語ファイルをダウンロードします．"
  Invoke-WebRequest $WinSCPJARemote -OutFile $WinSCPJALocal -UserAgent "Wget"
}
If (-Not (Test-Path $OokiiLocal)) {
  Write-Host "Ookii.Dialogs.Wpf をダウンロードします．"
  Invoke-WebRequest $OokiiRemote -OutFile $OokiiLocal -UserAgent "Wget"
}


# Build Programs
$OriginalWD = Get-Location

Write-Host "DRFront をビルドします．"
New-Item -Path ${BuildDir}\DRFront -ItemType Directory > $null
New-Item -Path ${BuildDir}\DRFront\packages -ItemType Directory > $null
New-Item -Path ${BuildDir}\DRFront\packages\Ookii.Dialogs.Wpf.5.0.1 -ItemType Directory > $null
Copy-Item -Recurse ${PSScriptRoot}\DRFront\Repo\* -Destination ${BuildDir}\DRFront
Copy-Item $OokiiLocal -Destination ${BuildDir}\DRFront\packages\Ookii.Dialogs.Wpf.5.0.1\Ookii.Dialogs.Wpf.5.0.1.nupkg
Expand-Archive -Path $OokiiLocal -DestinationPath ${BuildDir}\DRFront\packages\Ookii.Dialogs.Wpf.5.0.1
Set-Location ${BuildDir}\DRFront
msbuild -p:Configuration=Release

Write-Host "PC 側 Connector アプリをビルドします．"
New-Item -Path ${BuildDir}\Connector -ItemType Directory > $null
Copy-Item -Recurse ${PSScriptRoot}\Connector\Client\* -Destination ${BuildDir}\Connector
Set-Location ${BuildDir}\Connector
msbuild -p:Configuration=Release

Write-Host "svinst_port をビルドします．"
New-Item -Path ${BuildDir}\svinst_port -ItemType Directory > $null
Copy-Item -Recurse ${PSScriptRoot}\svinst_port\* -Destination ${BuildDir}\svinst_port
Set-Location ${BuildDir}\svinst_port
cargo build --release

Set-Location $OriginalWD

# Copy Files to Dist
Write-Host "必要なファイルを Dist にコピーします．"
Copy-Item ${PSScriptRoot}\COPYING -Destination ${DistDir}\COPYING
Copy-Item ${PSScriptRoot}\Manual\main.pdf -Destination ${DistDir}\UserManual.pdf
Expand-Archive -Path $WinSCPLocal -DestinationPath ${DistDir}\WinSCP
Expand-Archive -Path $WinSCPJALocal -DestinationPath ${DistDir}\WinSCP
New-Item -Path ${DistDir}\DRFront -ItemType Directory > $null
Copy-Item ${PSScriptRoot}\DRFront\COPYING -Destination ${DistDir}\DRFront\COPYING
Copy-Item ${PSScriptRoot}\DRFront\README.md -Destination ${DistDir}\DRFront\README.md
Copy-Item ${BuildDir}\DRFront\bin\Release\DRFront.exe -Destination ${DistDir}\DRFront\DRFront.exe
Copy-Item ${BuildDir}\DRFront\bin\Release\Ookii.Dialogs.Wpf.dll -Destination ${DistDir}\DRFront\Ookii.Dialogs.Wpf.dll
Copy-Item -Recurse ${PSScriptRoot}\DRFront\Boards -Destination ${DistDir}\DRFront\
New-Item -Path ${DistDir}\DRFront\ext -ItemType Directory > $null
Copy-Item ${BuildDir}\svinst_port\target\release\svinst_port.exe -Destination ${DistDir}\DRFront\ext\svinst_port.exe
New-Item -Path ${DistDir}\DRFront\sources -ItemType Directory > $null
Compress-Archive -Path ${PSScriptRoot}\DRFront\Repo\* -DestinationPath ${DistDir}\DRFront\sources\DRFront.zip
Compress-Archive -Path ${PSScriptRoot}\DRFront\BaseDesign\* -DestinationPath ${DistDir}\DRFront\sources\BaseDesign.zip
Compress-Archive -Path ${PSScriptRoot}\DRFront\BaseDesign_RC\* -DestinationPath ${DistDir}\DRFront\sources\BaseDesign_RC.zip
New-Item -Path ${DistDir}\Connector -ItemType Directory > $null
New-Item -Path ${DistDir}\Connector\Client -ItemType Directory > $null
Copy-Item ${BuildDir}\Connector\bin\Release\Connector.exe -Destination ${DistDir}\Connector\Client\Connector.exe
New-Item -Path ${DistDir}\Connector\Client\source -ItemType Directory > $null
Compress-Archive -Path ${PSScriptRoot}\Connector\Client\* -DestinationPath ${DistDir}\Connector\Client\source\Connector_client.zip
New-Item -Path ${DistDir}\Connector\Server -ItemType Directory > $null
Copy-Item ${PSScriptRoot}\Connector\Server\connector_serv.py -Destination ${DistDir}\Connector\Server\connector_serv.py
Compress-Archive -Path ${DistDir}\* -DestinationPath ${PSScriptRoot}\SawareruSys_dist.zip -Force
Compress-Archive -Path ${DistDir}\DRFront\* -DestinationPath ${PSScriptRoot}\DRFront_dist.zip -Force

Write-Host "配布パッケージの作成が完了しました．"
Pause