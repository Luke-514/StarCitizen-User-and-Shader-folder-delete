@echo off

set /P CHK="LIVE��PTU�A�ǂ���̐ݒ�����X�g�A���܂����H (live/ptu)"

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
  echo ���X�g�A�����𒆎~���܂�
  pause
  EXIT
)

for /f "tokens=*" %%i in ('findstr /v "{ ( ) js: Error libraryFolder ." %APPDATA%\rsilauncher\log.log ^| findstr "\\"') do set LIBPATH=%%~i
set LIBPATH=%LIBPATH:\\=\%
set USRDIR=dir /s /b "%LIBPATH%\StarCitizen\%PLYVER%\USER\Client\0\Controls\Mappings\*"*
for %%i in ("%LIBPATH%") do set STUSRPATH=%%~si
set STUSRDIR=%STUSRPATH%\StarCitizen\%PLYVER%\USER\Client\0\Controls\Mappings
set RESDIR=dir /s /b ".\StarCitizenKeyConfigBackup\%PLYVER%\*"*

echo;
echo ���X�g�A�Ώۂ͈ȉ��ł�
echo;

%RESDIR% 2>nul
echo;

set /P CHK="���X�g�A�����s���Ă���낵���ł����H (yes/no)"

if /i %CHK%==yes (goto CONTINUE)
if /i %CHK%==y (goto CONTINUE)

echo ���X�g�A�����𒆎~���܂�
pause
exit

:CONTINUE

robocopy .\StarCitizenKeyConfigBackup\%PLYVER% %STUSRDIR% /r:1 /w:1 > nul
echo;
if %errorlevel% leq 7 (
  echo �ݒ�����X�g�A���܂���
  echo �Q�[��������v���t�@�C����ݒ肵�Ă�������
  echo;
)
if %errorlevel% geq 8 echo ���X�g�A���������s���܂���

pause