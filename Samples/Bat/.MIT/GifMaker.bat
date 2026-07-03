@echo off
setlocal

REM =====================================================
REM 🧠 USER PROMPT INPUTS
REM =====================================================

set /p INPUT_DIR=Enter input folder (PNG frames): 
set /p OUTPUT=Enter output GIF filename (e.g. out.gif): 
set /p DELAY=Enter frame delay (e.g. 5): 

REM Default loop setting
set LOOP=0

REM =====================================================
REM 🔍 VALIDATION
REM =====================================================

if not exist "%INPUT_DIR%" (
    echo [ERROR] Folder "%INPUT_DIR%" does not exist.
    pause
    exit /b
)

if "%OUTPUT%"=="" (
    set OUTPUT=output.gif
)

if "%DELAY%"=="" (
    set DELAY=5
)

echo.
echo [INFO] Input folder : %INPUT_DIR%
echo [INFO] Output file  : %OUTPUT%
echo [INFO] Frame delay  : %DELAY%
echo.

REM =====================================================
REM 🎬 GENERATE GIF
REM =====================================================

magick convert ^
    -delay %DELAY% ^
    -loop %LOOP% ^
    "%INPUT_DIR%\*.png" ^
    "%OUTPUT%"

REM =====================================================
REM ✅ DONE
REM =====================================================

echo.
echo [DONE] GIF created: %OUTPUT%
pause
