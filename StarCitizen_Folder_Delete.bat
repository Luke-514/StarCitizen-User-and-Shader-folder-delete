@echo off

echo --------------------------------------------------------------------------------------------------------------
echo �Ɛӎ���
echo �{�o�b�`�t�@�C���̎g�p�ɂ���Ĕ��������A�����Ȃ鑹�Q�ɑ΂��Ă���҂͈�؂̐ӔC�𕉂��܂���
echo;

echo ���p��̒���
echo �{�o�b�`�t�@�C���͎��Live�o�[�W�����œ��삵�܂����A
echo %AppData%/../Local/Star Citizen����
echo �V�F�[�_�[�t�H���_���폜���邽�߁APTU�o�[�W�����ɂ��e�����܂�
echo;
echo �폜�Ώۂɕ\�����ꂽ�t�H���_�͒��g���Ɗ��S�폜���܂��̂ŁA
echo �\�����ꂽ�Ώۂ��悭�m�F���Ă���폜�����{���Ă�������
echo;

echo ��� 
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

echo �폜�Ώۂ͈ȉ��ł�
echo;

echo ���[�U�[�t�H���_
%USRDIR% 2>nul
if %errorlevel% neq 0 (
  echo ���[�U�[�t�H���_������܂���
  set /a COUNT=%COUNT%+1
)
echo;

echo �V�F�[�_�[�t�H���_
%SHDDIR% 2>nul
if %errorlevel% neq 0 (
  echo �V�F�[�_�[�t�H���_������܂���
  set /a COUNT=%COUNT%+2
)
echo;

if %COUNT% equ 3 (
  echo �폜�Ώۂ̃t�H���_�����݂��Ȃ����߁A�������I�����܂�
  pause
  EXIT
)

set /P CHK="�폜�����s���Ă���낵���ł����H (y/n)"

if /i %CHK%==y (goto CONTINUE)
if /i %CHK%==yes (goto CONTINUE)

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