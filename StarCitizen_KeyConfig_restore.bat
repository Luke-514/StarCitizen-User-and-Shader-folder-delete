@echo off

set /P CHK="LIVEかPTU、どちらの設定をリストアしますか？ (live/ptu)"

if /i %CHK%==live (
  set PLYVER=LIVE
) else if /i %CHK%==l (
  set PLYVER=LIVE
) else if /i %CHK%==ptu (
  set PLYVER=PTU
) else if /i %CHK%==p (
  set PLYVER=PTU
) else (
  echo 予期しない文字が入力されました
  echo リストア処理を中止します
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
echo リストア対象は以下です
echo;

%RESDIR% 2>nul
echo;

set /P CHK="リストアを実行してもよろしいですか？ (yes/no)"

if /i %CHK%==yes (goto CONTINUE)
if /i %CHK%==y (goto CONTINUE)

echo リストア処理を中止します
pause
exit

:CONTINUE

robocopy .\StarCitizenKeyConfigBackup\%PLYVER% %STUSRDIR% /r:1 /w:1 > nul
echo;
if %errorlevel% leq 7 (
  echo 設定をリストアしました
  echo ゲーム内からプロファイルを設定してください
  echo;
)
if %errorlevel% geq 8 echo リストア処理が失敗しました

pause