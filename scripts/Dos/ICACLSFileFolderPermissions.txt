@echo off

:: Define the folder path
set "folderPath=C:\Path\To\Your\Folder"

:: Deny the group permission to delete the folder (prevents moving)
icacls "%folderPath%" /deny _sec_cannotmovefolders:(DE)

:: Allow the group to create and edit files within the folder
icacls "%folderPath%" /grant _sec_cannotmovefolders:(M)

:: Allow the group to traverse folders and list contents (for the current folder only)
icacls "%folderPath%" /grant _sec_cannotmovefolders:(RX)
