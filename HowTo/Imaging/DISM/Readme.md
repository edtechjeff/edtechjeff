# Quick Start Instructions
---

In this article we are going to cover how to setup a WDS server to PXE boot and utilize the ADK also. I found this great [article](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/system-builder-deployment?view=windows-11) that I got the original idea from and base files.  

---

Here is a listing of items and things you need to have

 - Server Setup, can be virtual or physical
 - Create extra 100GB disk for images folder
 - Create 4GB disk for boot image creation
 - ADK downloaded on the server
 - Windows ISO

---

Once you get the server built 


- [Download Files](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/system-builder-deployment?view=windows-11#extract-imageszip)

- Extract contents from zip to the new drive just keep the name of images

- Share the images folder 

- Download the ADK's for Windows and install

- Create the following folders in images
    - Drivers
    - Source
    - Unattend
    - WinREMount

- Delete the following Files and Folder (You can keep these, but I like to clean things up)
    - Projects
    - Windows
    - WinPE
    - CreateImage
    - CreateProject
    - UpdateInboxApps

- Go into the Scripts folder and delete the following files and or folders (You can keep these, but I like to clean things up)
    - AutoPilot
    - Apply-Recovery

- Go back at the images folder

- In the drivers folder create the following folders
    - WinPE
    - RSTAT
    - Any other driver folders for your specific models

- In the source folder create a structure that will keep track of what version you are deploying IE

- Source
    - Windows11
        - 23H2
        - 24H2
        - NEXT Version
---


- [Download the command file and put in the images folder change the extension to .CMD](MaintenanceTaskV2.txt)

- [Download this file and put in the scripts folder and change the extension to .PS1](RemovePackages.txt)

- [Download this file and put in the scripts folder and change the extension to .CMD. You will be replacing the one that is in there already](CaptureImage.txt)

- Now we have a base of what we need. You will need to download the WinPE drivers based on what manufacture you have. I am going with dell. The WinPE drivers are important part and you will need these. They will be injected into the WIM files 

- [DellDriverPack](https://www.dell.com/support/kbdoc/en-us/000211541/winpe-11-driver-pack)

- You will need to extract the files from the cab with the following command adjusting to the name and path to where you want to extract, in our case it will be:
    - expand "WinPE11.0-Drivers-A05-TPKY4.cab" -f:* F:\Images\Drivers\WinPE

The next driver is what is call the Intel Rapid Storage Driver. This driver is important because, from what I am seeing with Dell, the storage controller is set to RAID even though there might not be a raid setup. You can manually set it to AHCI but just by adding this driver will avoid this issue. 

- [Download this for the Intel Rapid Storage Driver](https://www.intel.com/content/www/us/en/download/19512/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-10th-and-11th-gen-platforms.html)

- Use the following extract the drivers 
    - SetupRST.exe -extractdrivers F:\Images\Drivers\RSTAT

- Download ISO for Windows 11
    - Open up the ISO
    - go to sources
    - copy the Install.WIM to the correct folder
        f:\source\11\24H2
---

## This pretty well gets you a basic setup for Imaging Windows 11 with WDS. Along with this article I will be posting more information on how to use what I have came up with based on the scripts and what ways you can use it. But for now hope this helps get you. Refer to the original article with more information on the scripts and original intended purpose and how it all works. Again I will post how I have been using it. Till then keep on learning something new. 








