@echo off

set /P CHK="LIVE��PTU�A�ǂ���̐ݒ���o�b�N�A�b�v���܂����H (live/ptu)"

if /i %CHK%==live (
  set PLYVER=LIVE
) else if /i %CHK%==l (
  set PLYVER=LIVE
) else if /i %CHK%==ptu (
  set PLYVER=PTU
) else if /i %CHK%==p (
  set PLYVER=PTU
) else (
  echo �\�����Ȃ����������͂���܂���
  echo �o�b�N�A�b�v�����𒆎~���܂�
  pause
  EXIT
)

for /f "tokens=*" %%i in ('findstr /v "{ ( ) js: Error libraryFolder ." %APPDATA%\rsilauncher\log.log ^| findstr "\\"') do set LIBPATH=%%~i
set LIBPATH=%LIBPATH:\\=\%
set USRDIR=dir /s /b "%LIBPATH%\StarCitizen\%PLYVER%\USER\Client\0\Controls\Mappings\*"*
for %%i in ("%LIBPATH%") do set STUSRPATH=%%~si
set STUSRDIR=%STUSRPATH%\StarCitizen\%PLYVER%\USER\Client\0\Controls\Mappings

echo;
echo �o�b�N�A�b�v�Ώۂ͈ȉ��ł�
echo;

%USRDIR% 2>nul
echo;

set /P CHK="�o�b�N�A�b�v�����s���Ă���낵���ł����H (yes/no)"

if /i %CHK%==yes (goto CONTINUE)
if /i %CHK%==y (goto CONTINUE)

echo �o�b�N�A�b�v�����𒆎~���܂�
pause
exit

:CONTINUE

robocopy %STUSRDIR% .\StarCitizenKeyConfigBackup\%PLYVER% /r:1 /w:1 > nul
echo;
if %errorlevel% leq 7 echo �ݒ��.\StarCitizenKeyConfigBackup\%PLYVER%�Ƀo�b�N�A�b�v���܂���
if %errorlevel% geq 8 echo �o�b�N�A�b�v���������s���܂���

pause