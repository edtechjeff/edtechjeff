# Inject VirtIO Drivers for Scale and Make ISO

[Link to article with source information](https://portal.nutanix.com/page/documents/kbs/details?targetId=kA00e000000bt28CAA)


## Make Directories
mkdir F:\VirtIO\windows_temp,F:\VirtIO\mountBoot,F:\VirtIO\mountInstall,F:\BaseISO,F:\VirtIODrivers

## Copy Contents of Mounted CD to BaseISO Folder

## Copy VirtIO drivers to the VirtIODrivers

## Copies files to correct folders
Copy-Item F:\BaseISO\* F:\VirtIO\windows_temp\ -Recurse

## Set Permissions
attrib -r F:\BaseISO\sources\*.wim /s

## Look up Index number for install.WIM
Get-WindowsImage -ImagePath F:\VirtIO\windows_temp\sources\install.wim

## Look up Index number for boot.wim
Get-WindowsImage -ImagePath f:\VirtIO\windows_temp\sources\boot.wim

## Mount boot.wim
Mount-windowsImage -Path F:\VirtIO\mountBoot\ -ImagePath F:\VirtIO\windows_temp\sources\boot.wim -Index 2

## Inject Drivers to boot.wim
Add-WindowsDriver -Path F:\VirtIO\mountBoot\ -Driver "F:\VirtIODrivers" -Recurse

## Unmount boot.wim
Dismount-windowsImage -Path F:\VirtIO\mountBoot\ -Save

## Mount install.wim 
Mount-WindowsImage -Path F:\VirtIO\mountInstall\ -ImagePath F:\VirtIO\windows_temp\sources\install.wim -Index 2

## Inject drivers into install.wim
Add-WindowsDriver -Path f:\VirtIO\mountInstall\ -Driver "F:\VirtIODrivers" -Recurse

## Unmount install.wim
Dismount-windowsImage -Path F:\VirtIO\mountBoot\ -Save

## Create ISO
oscdimg -lWindows11-VirtIO -m -u2 -bF:\VirtIO\windows_temp\boot\etfsboot.com F:\VirtIO\windows_temp\ F:\VirtIO\Windows11-VirtIO.iso