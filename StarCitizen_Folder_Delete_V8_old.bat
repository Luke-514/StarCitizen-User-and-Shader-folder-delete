@echo off

echo --------------------------------------------------------------------------------------------------------------
echo �Ɛӎ���
echo �{�o�b�`�t�@�C���̎g�p�ɂ���Ĕ��������A�����Ȃ鑹�Q�ɑ΂��Ă���҂͈�؂̐ӔC�𕉂��܂���
echo.

echo ���p��̒���
echo �{�o�b�`�t�@�C����LIVE/PTU�̗����ɑΉ����Ă��܂����A
echo PTU��LIVE�̃}�C�i�[�p�b�`���e�X�g���Ă���ꍇ�́A�����̃V�F�[�_�[�t�H���_���폜����܂��B
echo �}�C�i�[�p�b�`�̗�) LIVE: 3.17.4 PTU: 3.17.5
echo ���W���[�p�b�`�̗�) LIVE: 3.17.5 PTU: 3.18.0
echo.
echo �폜�Ώۂɕ\�����ꂽ�t�H���_�͒��g���Ɗ��S�폜���܂��̂ŁA
echo �\�����ꂽ�Ώۂ��悭�m�F���Ă���폜�����{���Ă�������
echo.
echo ����ݒ蓙�͏�������܂��̂ŁA�K�v�ȕ��̓o�b�N�A�b�v���Ă�������
echo.

echo ��� 
echo Luke514 Twitter:@rx_luke
echo --------------------------------------------------------------------------------------------------------------
echo.

set /P CHK="LIVE��PTU�A�ǂ���̃t�H���_���폜���܂����H (live/ptu)"

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
  echo �폜�����𒆎~���܂�
  pause
  EXIT
)

set COUNT=0

for /f "tokens=*" %%i in ('findstr /v "{ ( ) js: Error libraryFolder ." %APPDATA%\rsilauncher\logs\log.log ^| findstr "\\"') do set LIBPATH=%%~i
set LIBPATH=%LIBPATH:\\=\%
set USRDIR=dir /a:d /s /b "%LIBPATH%\StarCitizen\%PLYVER%\USER"*
for %%i in ("%LIBPATH%") do set STUSRPATH=%%~si
set STUSRDIR=dir /a:d /s /b "%STUSRPATH%\StarCitizen\%PLYVER%\USER"*

for /f "tokens=3" %%i in ('findstr "Branch:" "%LIBPATH%\StarCitizen\%PLYVER%\Game.log"') do set BRANCH=%%i
set SHDDIR=dir /a:d /s /b "%LOCALAPPDATA%\Star Citizen\%BRANCH%"*
for %%i in ("%LOCALAPPDATA%\Star Citizen\%BRANCH%") do set STSHDPATH=%%~si
set STSHDDIR=dir /a:d /s /b "%STSHDPATH%"*

echo �폜�Ώۂ͈ȉ��ł�
echo.

echo ���[�U�[�t�H���_
%USRDIR% 2>nul
if %errorlevel% neq 0 (
  echo ���[�U�[�t�H���_������܂���
  set /a COUNT=%COUNT%+1
)
echo.

echo �V�F�[�_�[�t�H���_
%SHDDIR% 2>nul
if %errorlevel% neq 0 (
  echo �V�F�[�_�[�t�H���_������܂���
  set /a COUNT=%COUNT%+2
)
echo.

if %COUNT% equ 3 (
  echo �폜�Ώۂ̃t�H���_�����݂��Ȃ����߁A�������I�����܂�
  pause
  EXIT
)

set /P CHK="�폜�����s���Ă���낵���ł����H (yes/no)"

if /i %CHK%==yes (goto CONTINUE)
if /i %CHK%==y (goto CONTINUE)

echo �폜�����𒆎~���܂�
pause
exit

:CONTINUE

if %COUNT% neq 1 (
  for /f %%i in ('%STUSRDIR%') do rmdir /s /q %%i
  if %errorlevel% lss 2 echo ���[�U�[�t�H���_���폜���܂���
)

if %COUNT% neq 2 (
  for /f %%i in ('%STSHDDIR%') do rmdir /s /q %%i
  if %errorlevel% equ 0 echo �V�F�[�_�[�t�H���_���폜���܂���
)

pause