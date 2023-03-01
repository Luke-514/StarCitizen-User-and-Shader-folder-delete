@echo off

echo 免責事項
echo 本スクリプトの使用によって発生した、いかなる損害に対しても開発者は一切の責任を負いません
echo;

echo 利用上の注意
echo 本スクリプトはStar Citizen Liveバージョンかつ、
echo インストール先がデフォルトである場合にしか対応しておりません
echo また、削除対象に表示されたフォルダを中身ごと完全削除しますので、
echo 表示された対象をよく確認してから削除を実施してください
echo;

echo 作者 
echo Luke514 Twitter:@rx_luke Discord:Shadow514#0642
echo;

set COUNT=0
set USRDIR=dir /a:d /s /b C:\PROGRA~1\ROBERT~1\StarCitizen\PTU\USER*
set SHDDIR=dir /a:d /s /b %APPDATA%\..\Local\STARCI~1\sc-alpha*

echo 削除対象は以下です

echo ユーザーフォルダ
%USRDIR% 2>nul
if %errorlevel% neq 0 (
  echo ユーザーフォルダがありません
  set /a COUNT=%COUNT%+1
)
echo;

echo シェーダーフォルダ
%SHDDIR% 2>nul
if %errorlevel% neq 0 (
  echo シェーダーフォルダがありません
  set /a COUNT=%COUNT%+2
)
echo;

if %COUNT% equ 3 (
  echo 削除対象のフォルダが存在しないため、処理を終了します
  pause
  EXIT
)

set /P CHK="削除を実行してもよろしいですか (y/n)？"

if /i {%CHK%}=={y} (goto :continue)
if /i {%CHK%}=={yes} (goto :continue)

echo 削除処理を中止します
pause
exit

:continue

if %COUNT% neq 1 (
  for /f %%i in ('%USRDIR%') do rmdir /s /q %%i
  if %errorlevel% lss 2 echo ユーザーフォルダを削除しました
)

if %COUNT% neq 2 (
  for /f %%i in ('%SHDDIR%') do rmdir /s /q %%i
  if %errorlevel% equ 0 echo シェーダーフォルダを削除しました
)

pause
