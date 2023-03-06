@echo off

echo --------------------------------------------------------------------------------------------------------------
echo Disclaimer
echo Use this batch file at your own risk.
echo;

echo Usage Notes
echo This batch file mainly works for Live version,
echo but also affects PTU version as it deletes shader folders under 
echo %AppData%/../Local/Star Citizen
echo;
echo The folder will be completely deleted.
echo Please check targeted folder names carefully before running the batch.
echo;

echo creator 
echo Luke514 Twitter:@rx_luke Discord:Shadow514#0642
echo --------------------------------------------------------------------------------------------------------------
echo;

set PLYVER=LIVE

set COUNT=0

for /f "tokens=*" %%i in ('findstr /v "{ ( ) js: Error libraryFolder ." %APPDATA%\rsilauncher\log.log ^| findstr "\\"') do set LIBPATH=%%~i
set LIBPATH=%LIBPATH:\\=\%
set USRDIR=dir /a:d /s /b "%LIBPATH%\StarCitizen\%PLYVER%\USER"*
for %%i in ("%LIBPATH%") do set STUSRPATH=%%~si
set STUSRDIR=dir /a:d /s /b "%STUSRPATH%\StarCitizen\%PLYVER%\USER"*

set SHDDIR=dir /a:d /s /b "%APPDATA%\..\Local\Star Citizen\sc-alpha"*
for %%i in ("%APPDATA%\..\Local\Star Citizen\sc-alpha") do set STSHDPATH=%%~si
set STSHDDIR=dir /a:d /s /b "%STSHDPATH%"*

echo Subjects for deletion include
echo;

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

if /i %CHK%==y (goto CONTINUE)
if /i %CHK%==yes (goto CONTINUE)

echo Deletion process is aborted.
pause
exit

:CONTINUE

if %COUNT% neq 1 (
  for /f %%i in ('%STUSRDIR%') do rmdir /s /q %%i
  if %errorlevel% lss 2 echo Deleted user folder
)

if %COUNT% neq 2 (
  for /f %%i in ('%STSHDDIR%') do rmdir /s /q %%i
  if %errorlevel% equ 0 echo Deleted shader folder
)

pause