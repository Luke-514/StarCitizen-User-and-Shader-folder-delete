@echo off

echo --------------------------------------------------------------------------------------------------------------
echo Disclaimer
echo Use this batch file at your own risk.
echo.

echo Usage Notes
echo Although this batch file is compatible with both LIVE/PTU
echo If PTU is testing a LIVE minor patch, both shader folders will be deleted.
echo Example of a minor patch) LIVE: 3.17.4 PTU: 3.17.5
echo Example of a major patch) LIVE: 3.17.5 PTU: 3.18.0
echo.
echo The folder will be completely deleted.
echo Please check targeted folder names carefully before running the batch.
echo.
echo Please back up your settings if you need to, as they will be erased.
echo.

echo creator 
echo Luke514 Twitter:@rx_luke Discord:Shadow514#0642
echo --------------------------------------------------------------------------------------------------------------
echo.

set /P CHK="Which folder do you want to delete, LIVE or PTU? (live/ptu)"

if /i %CHK%==live (
  set PLYVER=LIVE
) else if /i %CHK%==l (
  set PLYVER=LIVE
) else if /i %CHK%==ptu (
  set PLYVER=PTU
) else if /i %CHK%==p (
  set PLYVER=PTU
) else (
  echo An unexpected character was entered.
  echo Deletion process is aborted.
  pause
  EXIT
)

set COUNT=0

for /f "tokens=*" %%i in ('findstr /v "{ ( ) js: Error libraryFolder ." %APPDATA%\rsilauncher\log.log ^| findstr "\\"') do set LIBPATH=%%~i
set LIBPATH=%LIBPATH:\\=\%
set USRDIR=dir /a:d /s /b "%LIBPATH%\StarCitizen\%PLYVER%\USER"*
for %%i in ("%LIBPATH%") do set STUSRPATH=%%~si
set STUSRDIR=dir /a:d /s /b "%STUSRPATH%\StarCitizen\%PLYVER%\USER"*

for /f "tokens=3" %%i in ('findstr "Branch:" "%LIBPATH%\StarCitizen\%PLYVER%\Game.log"') do set BRANCH=%%i
set SHDDIR=dir /a:d /s /b "%LOCALAPPDATA%\Star Citizen\%BRANCH%"*
for %%i in ("%LOCALAPPDATA%\Star Citizen\%BRANCH%") do set STSHDPATH=%%~si
set STSHDDIR=dir /a:d /s /b "%STSHDPATH%"*

echo Subjects for deletion include
echo.

echo User folder
%USRDIR% 2>nul
if %errorlevel% neq 0 (
  echo User folder is missing
  set /a COUNT=%COUNT%+1
)
echo.

echo Shader folder
%SHDDIR% 2>nul
if %errorlevel% neq 0 (
  echo Shader folder is missing
  set /a COUNT=%COUNT%+2
)
echo.

if %COUNT% equ 3 (
  echo The folder to be deleted does not exist, so the process is terminated.
  pause
  EXIT
)

set /P CHK="Are you sure you want to perform the deletion? (yes/no)"

if /i %CHK%==yes (goto CONTINUE)
if /i %CHK%==y (goto CONTINUE)

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