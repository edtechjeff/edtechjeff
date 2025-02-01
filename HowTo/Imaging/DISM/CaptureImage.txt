@ECHO off
Color 1f
ECHO =========================================================
ECHO EDT 11 - Image Capture .wim file Framework Script                
ECHO Copyright (C) Microsoft Corporation. All rights reserved.
ECHO =========================================================
ECHO.
Create a text file and add this into it   
@echo off
cls
@SET /P CUSTOMERNAME=(Name Of Customer - No Spaces):

DISM /Capture-Image /ImageFile:z:\Images\%CUSTOMERNAME%.wim /CaptureDir:C:\ /Name:%CUSTOMERNAME%