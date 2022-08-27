@echo off
@setlocal enableextensions
@setlocal EnableDelayedExpansion
@cd /d "%~dp0"

@Title Replace or restore system notepad
mode con: cols=120 lines=30
echo Please wait...


For /f "tokens=1,2,3,4 USEBACKQ delims=," %%a in (`"%SystemRoot%\System32\whoami.exe /groups /fo csv /nh"`) Do (
	If %%c == "S-1-16-12288" Set RunAsAdmin=True
)

If not "%RunAsAdmin%" == "True" (
	echo Error: Please run as administrator.
	echo.
	goto Exit
)

:Select
Set ConfirmPrompt=
cls
echo.
echo ______________________________________________
echo.
echo 1. Replace system notepad
echo 2. Restore system notepad
echo 3. Exit
echo.
echo ______________________________________________
echo.
Set /p ConfirmPrompt=Enter your selection: 
If /i "%ConfirmPrompt%"=="1" goto ReplaceSN
If /i "%ConfirmPrompt%"=="2" goto RestoreSN
If /i "%ConfirmPrompt%"=="3" goto Exit
goto Select

:ReplaceSN
echo.
echo Replacing system notepad ...
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" 
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /f /v "Debugger" /t REG_SZ /d "\"%~dp0Notepad3.exe\" /z" >NUL 2>NUL
goto Exit

:RestoreSN
echo.
echo Restoring system notepad ...
REM taskkill /f /im notepad* >NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /f
REM reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /f
goto Exit

:Exit
Echo Goodbye!
Pause
Exit
