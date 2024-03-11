@echo off

echo --------------------------------------------------------------------------------------------------------------
echo 免責事項
echo 本バッチファイルの使用によって発生した、いかなる損害に対しても作者は一切の責任を負いません
echo.

echo 利用上の注意
echo 本バッチファイルはLIVE/PTUの両方に対応していますが、
echo PTUがLIVEのマイナーパッチをテストしている場合は、両方のシェーダーフォルダが削除されます。
echo マイナーパッチの例) LIVE: 3.17.4 PTU: 3.17.5
echo メジャーパッチの例) LIVE: 3.17.5 PTU: 3.18.0
echo.
echo 削除対象に表示されたフォルダは中身ごと完全削除しますので、
echo 表示された対象をよく確認してから削除を実施してください
echo.
echo 操作設定等は消去されますので、必要な方はバックアップしてください
echo.

echo 作者 
echo Luke514 Twitter:@rx_luke
echo --------------------------------------------------------------------------------------------------------------
echo.

set /P CHK="LIVE、PTU、EPTUのうち、どのフォルダを削除しますか？ (live/ptu/eptu)"

if /i %CHK%==live (
  SET PLYVER=LIVE
) else if /i %CHK%==l (
  SET PLYVER=LIVE
) else if /i %CHK%==ptu (
  SET PLYVER=PTU
) else if /i %CHK%==p (
  SET PLYVER=PTU
) else if /i %CHK%==eptu (
  SET PLYVER=EPTU
) else if /i %CHK%==ep (
  SET PLYVER=EPTU
) else (
  echo.
  echo 予期しない文字が入力されました
  echo 処理を中止します
  echo.
  pause
  EXIT
)

set COUNT=0

for /f "tokens=*" %%i in ('findstr "libraryFolder" %APPDATA%\rsilauncher\logs\log.log') do SET LIBPATH=%%~i
SET LIBPATH=%LIBPATH:libraryFolder": "=%
SET LIBPATH=%LIBPATH:",=%
set LIBPATH=%LIBPATH:\\=\%
set USRDIR=dir /a:d /s /b "%LIBPATH%\StarCitizen\%PLYVER%\USER"*
for %%i in ("%LIBPATH%") do set STUSRPATH=%%~si
set STUSRDIR=dir /a:d /s /b "%STUSRPATH%\StarCitizen\%PLYVER%\USER"*

for /f "tokens=3" %%i in ('findstr "Branch:" "%LIBPATH%\StarCitizen\%PLYVER%\Game.log"') do set BRANCH=%%i
set SHDDIR=dir /a:d /s /b "%LOCALAPPDATA%\Star Citizen\%BRANCH%"*
for %%i in ("%LOCALAPPDATA%\Star Citizen\%BRANCH%") do set STSHDPATH=%%~si
set STSHDDIR=dir /a:d /s /b "%STSHDPATH%"*

echo 削除対象は以下です
echo.

echo ユーザーフォルダ
%USRDIR% 2>nul
if %errorlevel% neq 0 (
  echo ユーザーフォルダがありません
  set /a COUNT=%COUNT%+1
)
echo.

echo シェーダーフォルダ
%SHDDIR% 2>nul
if %errorlevel% neq 0 (
  echo シェーダーフォルダがありません
  set /a COUNT=%COUNT%+2
)
echo.

if %COUNT% equ 3 (
  echo 削除対象のフォルダが存在しないため、処理を終了します
  pause
  EXIT
)

set /P CHK="削除を実行してもよろしいですか？ (yes/no)"

if /i %CHK%==yes (goto CONTINUE)
if /i %CHK%==y (goto CONTINUE)

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