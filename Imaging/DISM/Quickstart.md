# Quick Start

---

- On server create extra 100GB for images folder

- [Download Files](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/system-builder-deployment?view=windows-11#extract-imageszip)

- extract contents from zip to the new drive just keep the name of images

- share the images folder 


- Install ADK and install

- Create the following folders in images
    - Drivers
    - Source
    - Unattend
    - WinREMount

- Delete the following Files and Folder
    - Projects
    - Windows
    - WinPE
    - CreateImage
    - CreateProject
    - UpdateInboxApps

- Go into the Scripts folder and delete the following files and or folders
    - AutoPilot
    - Apply-Recovery

- Back at the images folder

- In the drivers folder create the following folders
    - WinPE
    - RSTAT
    - Any other driver folders for your specific models

- In the source folder create a structure that will keep track of what version you are deploying IE

- Source
    - Windows11
        - 24H2

- [Download the command file and put in the images folder change the extension to .CMD](MaintenanceTaskV2.txt)

- [Download this file and put in the scripts folder and change the extension to .PS1](RemoveWindowsPackages.txt)

- [Download this file and put in the scripts folder and change the extension to .CMD. You will be replacing the one that is in there already](CaptureImage.txt)

- Now we have a base of what we need. You will need to download the WinPE drivers based on what manufacture you have. I am going with dell;

- [DellDriverPack](https://www.dell.com/support/kbdoc/en-us/000211541/winpe-11-driver-pack)

- extract the files from the cab with the following command adjusting to the name and path to where you want to extract, in our case it will be:
    - expand "WinPE11.0-Drivers-A05-TPKY4.cab" -f:* F:\Images\Drivers\WinPE

- [Download this for the Intel Rapid Storage Driver](https://www.intel.com/content/www/us/en/download/19512/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-10th-and-11th-gen-platforms.html)

- extract the drivers 
    - SetupRST.exe -extractdrivers F:\Images\Drivers\RSTAT

- Download ISO for Windows 11
    - Open up the ISO
    - go to sources
    - copy the Install.WIM to the correct folder
        f:\source\11\24H2
---

# Inject VirtIO Drivers for Scale

[Link to article with source information](https://portal.nutanix.com/page/documents/kbs/details?targetId=kA00e000000bt28CAA)

# Make WIM into ISO

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







