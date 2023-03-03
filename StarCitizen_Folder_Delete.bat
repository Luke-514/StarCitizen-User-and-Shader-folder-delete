@echo off

echo --------------------------------------------------------------------------------------------------------------
echo 免責事項
echo 本バッチファイルの使用によって発生した、いかなる損害に対しても作者は一切の責任を負いません
echo;

echo 利用上の注意
echo 本バッチファイルは主にLiveバージョンで動作しますが、
echo %AppData%/../Local/Star Citizen下の
echo シェーダーフォルダを削除するため、PTUバージョンにも影響します
echo;
echo 削除対象に表示されたフォルダは中身ごと完全削除しますので、
echo 表示された対象をよく確認してから削除を実施してください
echo;

echo 作者 
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

echo 削除対象は以下です
echo;

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

set /P CHK="削除を実行してもよろしいですか？ (y/n)"

if /i %CHK%==y (goto CONTINUE)
if /i %CHK%==yes (goto CONTINUE)

echo 削除処理を中止します
pause
exit

:CONTINUE

if %COUNT% neq 1 (
  for /f %%i in ('%STUSRDIR%') do rmdir /s /q %%i
  if %errorlevel% lss 2 echo ユーザーフォルダを削除しました
)

if %COUNT% neq 2 (
  for /f %%i in ('%STSHDDIR%') do rmdir /s /q %%i
  if %errorlevel% equ 0 echo シェーダーフォルダを削除しました
)

pause