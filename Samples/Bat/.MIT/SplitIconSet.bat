@echo off
setlocal enabledelayedexpansion

REM === INPUT FILE ===
set INPUT=IconSet.png
set OUTPUT_DIR=output_tiles

REM === ASK USER FOR TILE SIZE ===
set /p TILE_W=Enter tile width (px): 
set /p TILE_H=Enter tile height (px): 

REM === CREATE OUTPUT DIR ===
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo.
echo Splitting %INPUT% into %TILE_W%x%TILE_H% tiles...
echo.

REM === SPLIT ===
magick "%INPUT%" -crop %TILE_W%x%TILE_H% +repage "%OUTPUT_DIR%\tile_%%03d.png"

echo.
echo Done.
pause
