@ECHO off
REM Copyright 2025 Mehdi Dimyadi
REM Use of this source code is governed by a BSD-style license that can be
REM found in the LICENSE file.

REM Check for administrative privileges
:CHECK_PRIVILEGES
NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Please run this script as an administrator.
    PAUSE
    PowerShell -Command "Start-Process '%0' -Verb RunAs"
    EXIT /B
)

TITLE Flutter Setup Console

REM "%~dp0" is the directory of this file including trailing backslash
SET PATH=%~dp0bin;%PATH%

REM Fix Git ownership issue automatically
git config --global --add safe.directory D:/Android/FlutterSDK

:MENU
CLS
ECHO.
ECHO ##############################################
ECHO #            Flutter Setup Menu              #
ECHO #               Mehdi Dimyadi                #
ECHO #           @mehdimyadi on GitHub            #
ECHO ##############################################
ECHO.
ECHO 1. Disable Flutter telemetry
ECHO 2. Accept Android licenses
ECHO 3. Set Android SDK path
ECHO 4. Set Android Studio path
ECHO 5. Force upgrade Flutter packages
ECHO 6. Run Flutter doctor
ECHO 7. Upgrade Flutter
ECHO 8. Disabling Visual Studio Check for Mobile-Only Projects
ECHO 9. Exit
ECHO.
SET /P CHOICE=Type the number of your choice and press Enter: 

IF "%CHOICE%"=="1" GOTO DISABLE_TELEMETRY
IF "%CHOICE%"=="2" GOTO ACCEPT_LICENSES
IF "%CHOICE%"=="3" GOTO SET_SDK_PATH
IF "%CHOICE%"=="4" GOTO SET_STUDIO_PATH
IF "%CHOICE%"=="5" GOTO FORCE_UPGRADE
IF "%CHOICE%"=="6" GOTO RUN_DOCTOR
IF "%CHOICE%"=="7" GOTO UPGRADE_FLUTTER
IF "%CHOICE%"=="8" GOTO DISABLE_VB_CHECK
IF "%CHOICE%"=="9" GOTO EXIT
ECHO Invalid choice. Please select a number from 1 to 9.
PAUSE
GOTO MENU

:DISABLE_TELEMETRY
CLS
ECHO Disabling Flutter telemetry...
FOR /F "usebackq delims=" %%a IN (`flutter config --no-analytics`) DO ECHO %%a
ECHO.
PAUSE
GOTO MENU

:ACCEPT_LICENSES
CLS
ECHO Accepting Android licenses...
FOR /F "usebackq delims=" %%a IN (`flutter doctor --android-licenses`) DO ECHO %%a
ECHO.
PAUSE
GOTO MENU

:SET_SDK_PATH
CLS
REM Call PowerShell to select Android SDK directory
ECHO Selecting Android SDK path...
FOR /F "usebackq delims=" %%I IN (`powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog; $folderBrowser.Description = 'Select the Android SDK directory'; $folderBrowser.ShowDialog() | Out-Null; $folderBrowser.SelectedPath"`) DO SET "SDK_DIR=%%I"
IF NOT "%SDK_DIR%"=="" (
    FOR /F "usebackq delims=" %%a IN (`flutter config --android-sdk="%SDK_DIR%"`) DO ECHO %%a
    ECHO Android SDK path set successfully.
) ELSE (
    ECHO No directory selected.
)
PAUSE
GOTO MENU

:SET_STUDIO_PATH
CLS
REM Call PowerShell to select Android Studio directory
ECHO Selecting Android Studio path...
FOR /F "usebackq delims=" %%I IN (`powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog; $folderBrowser.Description = 'Select the Android Studio directory'; $folderBrowser.ShowDialog() | Out-Null; $folderBrowser.SelectedPath"`) DO SET "STUDIO_DIR=%%I"
IF NOT "%STUDIO_DIR%"=="" (
    FOR /F "usebackq delims=" %%a IN (`flutter config --android-studio-dir="%STUDIO_DIR%"`) DO ECHO %%a
    ECHO Android Studio path set successfully.
) ELSE (
    ECHO No directory selected.
)
PAUSE
GOTO MENU

:FORCE_UPGRADE
CLS
ECHO Forcing Flutter package upgrade...
FOR /F "usebackq delims=" %%a IN (`flutter pub upgrade --major-versions`) DO ECHO %%a
ECHO Flutter packages upgraded.
PAUSE
GOTO MENU

:RUN_DOCTOR
CLS
ECHO Running Flutter Doctor...
FOR /F "usebackq delims=" %%a IN (`flutter doctor`) DO ECHO %%a
ECHO Flutter Doctor completed.
PAUSE
GOTO MENU

:UPGRADE_FLUTTER
CLS
ECHO Upgrading Flutter...
FOR /F "usebackq delims=" %%a IN (`flutter upgrade`) DO ECHO %%a
ECHO Flutter upgraded.
PAUSE
GOTO MENU

:DISABLE_VB_CHECK
CLS
ECHO Disabling Visual Studio check...
FOR /F "usebackq delims=" %%a IN (`flutter config --no-enable-windows-desktop`) DO ECHO %%a
ECHO Visual Studio check disabled.
PAUSE
GOTO MENU

:EXIT
EXIT
