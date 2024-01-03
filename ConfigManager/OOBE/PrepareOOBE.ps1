Start-Process -FilePath "C:\Windows\ccmsetup\ccmsetup.exe" -ArgumentList "/Uninstall"
Start-Sleep -Seconds 60
Wait-Process -Name "ccmsetup" -ErrorAction SilentlyContinue
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\CCM -Recurse -Force -EA SilentlyContinue
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\CCMSetup -Recurse -Force -EA SilentlyContinue
Remove-Item -Path HKLM:\SOFTWARE\Microsoft\SMS -Recurse -Force -EA SilentlyContinue
Remove-item -Path HKLM:\SOFTWARE\Microsoft\DeviceManageabilityCSP -Recurse -Force -EA SilentlyContinue
Remove-Item -Path C:\Windows\CCM -Recurse -Force -EA SilentlyContinue
Remove-Item -Path C:\Windows\CCMCache -Recurse -Force -EA SilentlyContinue
Remove-Item -Path C:\Windows\CCMSetup -Recurse -Force -EA SilentlyContinue
Remove-Item -Path C:\Windows\SMSCFG.ini -Force -EA SilentlyContinue
Remove-item -Path C:\Windows\sms*.mif -Force -EA SilentlyContinue
Start-Process -FilePath "C:\windows\system32\sysprep\sysprep.exe" -ArgumentList "/oobe"
