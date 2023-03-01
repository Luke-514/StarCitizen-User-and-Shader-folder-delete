@echo off

echo Disclaimer
echo The developer will not be liable for any damages caused by the use of this script.
echo;

echo Usage Notes
echo This script is only supported for the Star Citizen Live version
echo and the default installation location.
echo In addition, since the contents of the folder displayed as the target for deletion will be completely deleted, 
echo please check the displayed target carefully before carrying out the deletion.
echo;

echo author 
echo Luke514 Twitter:@rx_luke Discord:Shadow514#0642
echo;

set COUNT=0
set USRDIR=dir /a:d /s /b C:\PROGRA~1\ROBERT~1\StarCitizen\LIVE\USER*
set SHDDIR=dir /a:d /s /b %APPDATA%\..\Local\STARCI~1\sc-alpha*

echo Subjects for deletion include

echo User folder
%USRDIR% 2>nul
if %errorlevel% neq 0 (
  echo User folder is missing
  set /a COUNT=%COUNT%+1
)
echo;

echo Shader folder
%SHDDIR% 2>nul
if %errorlevel% neq 0 (
  echo Shader folder is missing
  set /a COUNT=%COUNT%+2
)
echo;

if %COUNT% equ 3 (
  echo The folder to be deleted does not exist, so the process is terminated.
  pause
  EXIT
)

set /P CHK="Are you sure you want to perform the deletion? (y/n)"

if /i {%CHK%}=={y} (goto :continue)
if /i {%CHK%}=={yes} (goto :continue)

echo Deletion process is aborted.
pause
exit

:continue

if %COUNT% neq 1 (
  for /f %%i in ('%USRDIR%') do rmdir /s /q %%i
  if %errorlevel% lss 2 echo Deleted user folder
)

if %COUNT% neq 2 (
  for /f %%i in ('%SHDDIR%') do rmdir /s /q %%i
  if %errorlevel% equ 0 echo Deleted shader folder
)

pause