# Random DISM Commands


## Start Network on WInPE booted machine
```
    startnet.cmd
```

## Get list of index of install WIM
```
powershell Get-WindowsImage -ImagePath "C:\Installs\Windows11\23H2\install.wim"
```

## Enterprise Image
```
Dism /export-image /sourceimagefile:C:\Installs\Windows11\23H2\install.wim /sourceindex:3 /destinationimagefile:C:\Images\Images\Enterprise.wim
```

## Education Image
```
Dism /export-image /sourceimagefile:C:\Installs\Windows11\23H2\install.wim /sourceindex:1 /destinationimagefile:C:\Images\Images\Education.wim
```

## Pro Image
```
Dism /export-image /sourceimagefile:C:\Installs\Windows11\23H2\install.wim /sourceindex:5 /destinationimagefile:C:\Images\Images\Pro.wim
```

---

## Mount Install.WIM
```
Dism /Mount-Image /ImageFile:"C:\images\images\install.wim"  /index:3 /MountDir:"C:\mount"
```

## Unmount Install.WIM
```
Dism /Unmount-Image /MountDir:"C:\mount" /commit
```

## capture Image
```
dism /capture-image /imagefile:z:\images\edtechjeff.wim /capturedir:c:\ /name:"custom image" /Compress:Max
```

## Add Drivers to mounted WIM
```
DISM /Image:C:\Mount /Add-Driver /Driver:C:\drivers\production\ /recurse /ForceUnsigned
```

## Pull device drivers from machine and export to c:\temp
```
dism /online /Export-Driver /Destination:c:\temp
```

## Get listing of package
```
dism /Image:C:\images\mount /Get-Provisionedappxpackages
```

## remove AppxPackages
*Note: These package names are different based on version. IE Pro versus Enterprise

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.BingNews_4.2.27001.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.BingWeather_4.53.33420.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.GamingApp_2021.427.138.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.MicrosoftOfficeHub_18.2204.1141.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.MicrosoftSolitaireCollection_4.12.3171.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.People_2020.901.1724.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.WindowsMaps_2022.2202.6.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.YourPhone_1.22022.147.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.ZuneMusic_11.2202.46.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.ZuneVideo_2019.22020.10021.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.Xbox.TCUI_1.23.28004.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxGameOverlay_1.47.2385.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxGamingOverlay_2.622.3232.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxIdentityProvider_12.50.6001.0_neutral_~_8wekyb3d8bbwe
```

```
dism /image:\images\mount /Remove-Provisionedappxpackage /PackageName:Microsoft.XboxSpeechToTextOverlay_1.17.29001.0_neutral_~_8wekyb3d8bbwe
```

---

- Mirror the System drive so that you have a directory with the following path sources\$OEM$\$$\Setup\Scripts (C:\Windows\Setup\Scripts)
- In regards to the scripts being run from the unattend.xml file, you simply have to call the scripts from %SystemDrive%\WinDir\Setup\Scripts