@echo off

echo �Ɛӎ���
echo �{�X�N���v�g�̎g�p�ɂ���Ĕ��������A�����Ȃ鑹�Q�ɑ΂��Ă��J���҂͈�؂̐ӔC�𕉂��܂���
echo;

echo ���p��̒���
echo �{�X�N���v�g��Star Citizen Live�o�[�W�������A
echo �C���X�g�[���悪�f�t�H���g�ł���ꍇ�ɂ����Ή����Ă���܂���
echo �܂��A�폜�Ώۂɕ\�����ꂽ�t�H���_�𒆐g���Ɗ��S�폜���܂��̂ŁA
echo �\�����ꂽ�Ώۂ��悭�m�F���Ă���폜�����{���Ă�������
echo;

echo ��� 
echo Luke514 Twitter:@rx_luke Discord:Shadow514#0642
echo;

set COUNT=0
set USRDIR=dir /a:d /s /b C:\PROGRA~1\ROBERT~1\StarCitizen\PTU\USER*
set SHDDIR=dir /a:d /s /b %APPDATA%\..\Local\STARCI~1\sc-alpha*

echo �폜�Ώۂ͈ȉ��ł�

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

set /P CHK="�폜�����s���Ă���낵���ł��� (y/n)�H"

if /i {%CHK%}=={y} (goto :continue)
if /i {%CHK%}=={yes} (goto :continue)

echo �폜�����𒆎~���܂�
pause
exit

:continue

if %COUNT% neq 1 (
  for /f %%i in ('%USRDIR%') do rmdir /s /q %%i
  if %errorlevel% lss 2 echo ���[�U�[�t�H���_���폜���܂���
)

if %COUNT% neq 2 (
  for /f %%i in ('%SHDDIR%') do rmdir /s /q %%i
  if %errorlevel% equ 0 echo �V�F�[�_�[�t�H���_���폜���܂���
)

pause