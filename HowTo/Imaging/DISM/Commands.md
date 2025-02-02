# Random DISM Commands

## Get list of index of install wim
`powershell Get-WindowsImage -ImagePath "C:\Installs\Windows11\23H2\install.wim"`
#############################################################################################################
Enterprise Image
Dism /export-image /sourceimagefile:C:\Installs\Windows11\23H2\install.wim /sourceindex:3 /destinationimagefile:C:\Images\Images\Enterprise.wim
Dism /Mount-Image /ImageFile:C:\Images\Images\Enterprise.wim  /index:1 /MountDir:"C:\mount"
Dism /Unmount-Image /MountDir:"C:\mount" /commit
##############################################################################################################
Education Image
Dism /export-image /sourceimagefile:C:\Installs\Windows11\23H2\install.wim /sourceindex:1 /destinationimagefile:C:\Images\Images\Education.wim
Dism /Mount-Image /ImageFile:C:\Images\Images\Education.wim  /index:1 /MountDir:"C:\mount"
Dism /Unmount-Image /MountDir:"C:\mount" /commit
##############################################################################################################
Pro Image
Dism /export-image /sourceimagefile:C:\Installs\Windows11\23H2\install.wim /sourceindex:5 /destinationimagefile:C:\Images\Images\Pro.wim
Dism /Mount-Image /ImageFile:C:\Images\Images\Pro.wim  /index:1 /MountDir:"C:\mount"
Dism /Unmount-Image /MountDir:"C:\mount" /commit
##############################################################################################################
Mount
Dism /Mount-Image /ImageFile:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe.wim"  /index:1 /MountDir:"C:\WinPE_amd64\mount"
Dism /Unmount-Image /MountDir:"C:\WinPE_amd64\mount" /commit
##############################################################################################################
CustomInstallXPs
Dism /Mount-Image /ImageFile:C:\Images\Images\DellXPS9570-Enterprise.wim  /index:1 /MountDir:"C:\mount"
Dism /Unmount-Image /MountDir:"C:\mount" /commit
##############################################################################################################
Mount Install.wim
Dism /Mount-Image /ImageFile:"C:\images\images\install.wim"  /index:3 /MountDir:"C:\mount"

Unmount Install.wim
Dism /Unmount-Image /MountDir:"C:\mount" /commit
##############################################################################################################
Create Working Files
copype amd64  c:\WinPE
##############################################################################################################
make ISO
MakeWinPEMedia /ISO c:\WinPE C:\WinPE\WinPE_amd64.iso
##############################################################################################################
capture Image
dism /capture-image /imagefile:z:\images\edtechjeff.wim /capturedir:c:\ /name:"custom image" /Compress:Max
#############################################################################################################
Add Drivers to boot.wim
Dism /Mount-Image /ImageFile:P:\sources\boot.wim  /index:1 /MountDir:"C:\mount"
DISM /Image:C:\Mount /Add-Driver /Driver:C:\drivers\production\ /recurse /ForceUnsigned
Dism /Unmount-Image /MountDir:"C:\mount" /commit
#############################################################################################################
Insert Drivers
Dism /Mount-Image /ImageFile:C:\Images\Images\Pro-23H2-Dell7450.wim  /index:1 /MountDir:"C:\mount"
DISM /Image:C:\Mount /Add-Driver /Driver:C:\drivers\Latitude-7450\Win11\x64 /recurse
Dism /Unmount-Image /MountDir:"C:\mount" /commit
##############################################################################################################
WinRE Insert Drivers
Dism /Mount-Image /ImageFile:C:\mount\Windows\System32\Recovery\Winre.wim  /index:1 /MountDir:"C:\WinREMount"
DISM /Image:C:\WinREMount /Add-Driver /Driver:C:\drivers\WinPE /recurse
Dism /Unmount-Image /MountDir:"C:\WinREMount" /commit
##############################################################################################################

Get listing of package

Dism /Mount-Image /ImageFile:C:\Images\Images\PRO-7450.wim  /index:1 /MountDir:"C:\images\mount"
dism /Image:C:\images\mount /Get-Provisionedappxpackages
Dism /Unmount-Image /MountDir:"C:\images\Mount" /commit

remove AppxPackages
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.BingNews_4.2.27001.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.BingWeather_4.53.33420.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.GamingApp_2021.427.138.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.MicrosoftOfficeHub_18.2204.1141.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.MicrosoftSolitaireCollection_4.12.3171.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.People_2020.901.1724.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.WindowsMaps_2022.2202.6.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.YourPhone_1.22022.147.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.ZuneMusic_11.2202.46.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.ZuneVideo_2019.22020.10021.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.Xbox.TCUI_1.23.28004.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxGameOverlay_1.47.2385.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxGamingOverlay_2.622.3232.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxIdentityProvider_12.50.6001.0_neutral_~_8wekyb3d8bbwe

dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_~_8wekyb3d8bbwe
##############################################################################################################
Sample Menu

Create a text file and add this into it   
@echo off
cls
:start
echo.
echo 1. Map Network Drive
echo 2. Im Done Shut it Down O_O
echo 3. I want to Restart this Computer
echo.
echo.

set /p x=Pick:
IF '%x%' == '%x%' GOTO Item_%x%
:Item_1
start /MIN /D"X:\Windows\system32" cmd.exe "net use i: \\192.168.1.220\installs /user:administrator"
GOTO Start

:Item_2
wpeutil shutdown

:Item_3
wpeutil reboot
#############################################################################################################
https://www.youtube.com/watch?v=RQwCuu7dBIY&t=407s
#############################################################################################################
Notes
Extract the ISO/Windows installation media to a folder
Create a folder inside sources\ directorie(s) of the extracted installation media called $OEM$
Mirror the System drive so that you have a directory with the following path sources\$OEM$\$$\Setup\Scripts (C:\Windows\Setup\Scripts)
The $OEM$ folder mirrors the system drive so anything inside these folders gets copied across during setup. In regards to the scripts being run from the autounattend.xml file, you simply have to call the scripts from %SystemDrive%\WinDir\Setup\Scripts