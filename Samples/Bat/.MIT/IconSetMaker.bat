@echo off
setlocal

set "OUT=%cd%\PNG"

if not exist "%OUT%" mkdir "%OUT%"

echo Collecting PNG files...

for /r "%cd%" %%F in (*.png) do (
    REM Skip output folder itself to avoid recursion issues
    echo %%F | find /i "\PNG\" >nul
    if errorlevel 1 (
        copy "%%F" "%OUT%" >nul
    )
)

echo Done. PNG files copied to:
echo %OUT%
pause

@echo off
setlocal enabledelayedexpansion

REM Output file
set OUT=IconSet.png

REM Temp folder
set TMP=_iconset_tmp
if exist "%TMP%" rmdir /s /q "%TMP%"
mkdir "%TMP%"

echo Processing PNG files...

set i=0

REM Copy + resize all PNGs to temp numbered sequence
for %%F in (PNG\*.png) do (
    magick "%%F" -resize 32x32 "%TMP%\!i!.png"
    set /a i+=1
)

if %i%==0 (
    echo No PNG files found.
    pause
    exit /b
)

echo Total icons: %i%

REM Calculate grid size (fixed 16 columns, RPG Maker standard)
set cols=16

REM Build sprite sheet
magick montage "%TMP%\*.png" ^
  -tile %cols%x ^
  -geometry 32x32+0+0 ^
  -background none ^
  "%OUT%"

echo Done: %OUT%
rmdir /s /q "%TMP%"
pause
