Create a text file and add this into it   
@echo off
cls
:start
echo.
echo 1. Display Index
echo 2. Extract Image
echo 3. Mount Image
echo 4. UnMount Image
echo.
echo.

set /p x=Pick:
IF '%x%' == '%x%' GOTO Item_%x%
:Item_1
SET /P WindowsVersion=Enter what version of windows [e.g. 10 or 11]
SET /P WindowsRelease=Enter what release version of windows [e.g. 22H2]
powershell -command Get-WindowsImage -ImagePath "E:\Images\Source\Windows%WindowsVersion%\%WindowsRelease%\install.wim"
GOTO Start

:Item_2
SET /P WindowsVersion=Enter what version of windows [e.g. 10 or 11]
SET /P WindowsRelease=Enter what release version of windows [e.g. 22H2]
SET /P Index=Enter Index Number for your version [e.g. 3 for Enterprise]
SET /P NameofWIM=Enter name for the WIM [e.g. Enterprise]
Dism /export-image /sourceimagefile:E:\Images\Source\Windows%WindowsVersion%\%WindowsRelease%\install.wim /sourceindex:%Index% /destinationimagefile:E:\Images\Images\%NameofWIM%.wim
GOTO Start

:Item_3
REM #########################################################
REM Mount Image
REM #########################################################

:MountImage
@echo off
CLS
COLOR 1F
setlocal EnableDelayedExpansion
SET IMAGEDRIVE="%imagedrive%"

:: Create an array of files
set i=0
for %%a in (\images\images\*) do (
    set /A i+=1
    set "file[!i!]=%%~a"
)

ECHO =========================================================
ECHO Please select the image you want to mount         
ECHO =========================================================

:: Display menu
echo Select a file:
for /L %%i in (1,1,%i%) do echo %%i. !file[%%i]!

:: Get user selection
set /P "choice=Enter your choice: "

:: Check if the choice is empty
if not defined choice (
    echo Invalid input, please do not leave the input empty.
    goto MountImage
)

:: Check if the choice is a number
echo %choice%|findstr /R "^[0-9]*$">nul
if %errorlevel% neq 0 (
    echo Invalid input, please enter a number.
    goto MountImage
)

:: Check if the choice is within the valid range
set "selectedFile=!file[%choice%]!"
if not defined selectedFile (
    echo Invalid choice, please try again.
    goto MountImage
)

cls
echo You selected: %selectedFile%

:: Now you can use the variable %selectedFile% in your script

ECHO Dism /Mount-Image /ImageFile:%selectedFile%  /index:1 /MountDir:\images\mount"
Dism /Mount-Image /ImageFile:%selectedFile%  /index:1 /MountDir:\images\mount
pause

GOTO Start


@echo off
setlocal

:: Prompt the user
echo Do you want to proceed? (Y/N)
choice /c YN /n

:: Check the user's choice
if errorlevel 2 (
    echo You chose NO.
) else (
    echo You chose YES.
)

endlocal
:Item_4
REM #########################################################
REM Commit or Discard Image
REM #########################################################
cls
@echo off
setlocal EnableDelayedExpansion

ECHO =========================================================
ECHO Commit or Discard Image                
ECHO =========================================================

:UnmountMenu
:: Display menu
echo Please select an option:
echo 1. Commit Image
echo 2. Discard Image

:: Get user selection
set /P "choice=Enter your choice: "

:: Check if the choice is empty
if not defined choice (
    echo Invalid input, please do not leave the input empty.
    goto UnmountMenu
)

:: Check if the choice is alphanumeric
echo %choice%|findstr /R "^[a-zA-Z0-9]*$">nul
if %errorlevel% neq 0 (
    echo Invalid input, please enter an alphanumeric option.
    goto UnmountMenu
)

:: Check if the choice is one of the valid options
if not "%choice%"=="1" if not "%choice%"=="2" (
    echo Invalid choice, please try again.
    goto UnmountMenu
)

echo You selected: Option %choice%

:: Now you can use the variable %choice% in your script

:: Add if else statement for different commands

cls

if "%choice%"=="1" (
    echo Running command to Approve Drivers
    Dism /Unmount-Image /MountDir:\images\mount /commit
) else (
    echo Running command for Discard Drivers
    Dism /Unmount-Image /MountDir:\images\mount /discard
)
cls
goto start

