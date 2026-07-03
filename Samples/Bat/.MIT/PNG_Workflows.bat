@echo off
setlocal EnableDelayedExpansion

:: =========================
:: MAIN MENU
:: =========================

:MENU
cls
echo ==========================================
echo   RPG MAKER PNG WORKFLOW ENGINE
echo   ImageMagick Multi-Pipeline System
echo ==========================================
echo.
echo  1  Clean + Normalize + Optimize
echo  2  Resize + Square + Center
echo  3  Batch Folder Standardizer
echo  4  Pixel Art Converter
echo  5  Transparency Repair
echo  6  Tile Standardizer
echo  7  Sprite Cleanup
echo  8  Preview Generator
echo  9  Backup + Process + Export
echo 10  Recursive Asset Compiler
echo 11  Retro Pixel Pipeline
echo 12  Ice Variant Generator
echo 13  Fire Variant Generator
echo 14  Night Variant Generator
echo 15  Damage State Generator
echo 16  UI Disabled Generator
echo 17  Hue Variant Generator
echo 18  Palette Mutation System
echo 19  Glow Generator
echo 20  Outline Generator
echo 21  Horizontal Strip Builder
echo 22  Grid Spritesheet Builder
echo 23  Sheet Splitter
echo 24  Character Sheet Standardizer
echo 25  Enemy Scaling Pipeline
echo 26  Icon Sheet Compiler
echo 27  Frame Renumbering
echo 28  Sprite Variant Generator
echo 29  Animation Pack Builder
echo 30  Tile Variation Generator
echo 31  Button Generator
echo 32  UI Greyscale Converter
echo 33  Icon Padding Normalizer
echo 34  Label Stamping System
echo 35  UI Pack Compiler
echo 36  Disabled State Builder
echo 37  HUD Standardizer
echo 38  UI Theme Variants
echo 39  Full Asset Pack Compiler
echo 40  Procedural Damage Variants
echo 41  Visual Diff QA
echo 42  Corruption Detector
echo 43  Compression Optimization
echo 44  Multi-Variant Engine
echo 45  Asset Versioning System
echo 46  RPG Maker Export Pipeline
echo 47  Master Pipeline Orchestrator
echo 48  Batch Folder Export Pipeline
echo 49  Fast Preview Pipeline
echo 50  EXIT
echo.
set /p choice=Select workflow:

if "%choice%"=="1" goto wf1
if "%choice%"=="2" goto wf2
if "%choice%"=="3" goto wf3
if "%choice%"=="4" goto wf4
if "%choice%"=="5" goto wf5
if "%choice%"=="6" goto wf6
if "%choice%"=="7" goto wf7
if "%choice%"=="8" goto wf8
if "%choice%"=="9" goto wf9
if "%choice%"=="10" goto wf10
if "%choice%"=="11" goto wf11
if "%choice%"=="12" goto wf12
if "%choice%"=="13" goto wf13
if "%choice%"=="14" goto wf14
if "%choice%"=="15" goto wf15
if "%choice%"=="16" goto wf16
if "%choice%"=="17" goto wf17
if "%choice%"=="18" goto wf18
if "%choice%"=="19" goto wf19
if "%choice%"=="20" goto wf20
if "%choice%"=="21" goto wf21
if "%choice%"=="22" goto wf22
if "%choice%"=="23" goto wf23
if "%choice%"=="24" goto wf24
if "%choice%"=="25" goto wf25
if "%choice%"=="26" goto wf26
if "%choice%"=="27" goto wf27
if "%choice%"=="28" goto wf28
if "%choice%"=="29" goto wf29
if "%choice%"=="30" goto wf30
if "%choice%"=="31" goto wf31
if "%choice%"=="32" goto wf32
if "%choice%"=="33" goto wf33
if "%choice%"=="34" goto wf34
if "%choice%"=="35" goto wf35
if "%choice%"=="36" goto wf36
if "%choice%"=="37" goto wf37
if "%choice%"=="38" goto wf38
if "%choice%"=="39" goto wf39
if "%choice%"=="40" goto wf40
if "%choice%"=="41" goto wf41
if "%choice%"=="42" goto wf42
if "%choice%"=="43" goto wf43
if "%choice%"=="44" goto wf44
if "%choice%"=="45" goto wf45
if "%choice%"=="46" goto wf46
if "%choice%"=="47" goto wf47
if "%choice%"=="48" goto wf48
if "%choice%"=="49" goto wf49
if "%choice%"=="50" exit

goto MENU


:: =========================
:: CORE WORKFLOW FUNCTIONS
:: =========================

:input
set /p IN=Input file or folder:
exit /b

:size
set /p SIZE=Size (e.g. 48x48):
exit /b

:overlay
set /p OVER=Overlay image:
exit /b


:: =========================
:: WORKFLOWS 1–10
:: =========================

:wf1
set /p IN=Input:
magick "%IN%" -strip -alpha on -channel A -blur 0x0.5 "%IN%_clean.png"
magick "%IN%_clean.png" -define png:compression-level=9 "%IN%_opt.png"
goto MENU

:wf2
set /p IN=Input:
set /p SIZE=Size:
magick "%IN%" -resize %SIZE% -gravity center -background transparent -extent %SIZE% "%IN%_std.png"
goto MENU

:wf3
set /p FOLDER=Folder:
for %%f in (%FOLDER%\*.png) do (
  magick "%%f" -resize 48x48 -strip "%%f_std.png"
)
goto MENU

:wf4
set /p IN=Input:
magick "%IN%" -colors 256 -ordered-dither o8x8 "%IN%_pixel.png"
goto MENU

:wf5
set /p IN=Input:
magick "%IN%" -fuzz 10%% -transparent white -alpha on "%IN%_alpha.png"
goto MENU

:wf6
set /p IN=Input:
magick "%IN%" -resize 144x192 -gravity center -extent 144x192 "%IN%_tile.png"
goto MENU

:wf7
set /p IN=Input:
magick "%IN%" -colorspace Gray -strip "%IN%_clean.png"
goto MENU

:wf8
set /p IN=Input:
magick "%IN%" -resize 25%% "%IN%_preview.png"
goto MENU

:wf9
set /p FOLDER=Folder:
xcopy "%FOLDER%\*.png" backup\ /y
for %%f in (%FOLDER%\*.png) do magick "%%f" -strip "%%f_opt.png"
goto MENU

:wf10
set /p FOLDER=Folder:
for /r %%f in (*.png) do magick "%%f" -resize 48x48 "%%f_out.png"
goto MENU


:: =========================
:: WORKFLOWS 11–20 (STYLE)
:: =========================

:wf11
set /p IN=Input:
magick "%IN%" -colors 16 -ordered-dither o8x8 "%IN%_retro.png"
goto MENU

:wf12
set /p IN=Input:
magick "%IN%" -fill cyan -tint 40%% "%IN%_ice.png"
goto MENU

:wf13
set /p IN=Input:
set /p OVER=Overlay:
magick "%IN%" "%OVER%" -compose multiply -composite "%IN%_fire.png"
goto MENU

:wf14
set /p IN=Input:
magick "%IN%" -brightness-contrast -40x-10 "%IN%_night.png"
goto MENU

:wf15
set /p IN=Input:
magick "%IN%" -blur 0x2 -noise 10 "%IN%_damage.png"
goto MENU

:wf16
set /p IN=Input:
magick "%IN%" -colorspace Gray "%IN%_disabled.png"
goto MENU

:wf17
set /p IN=Input:
magick "%IN%" -modulate 100,120,100 "%IN%_hue.png"
goto MENU

:wf18
set /p IN=Input:
magick "%IN%" +dither -colors 16 "%IN%_palette.png"
goto MENU

:wf19
set /p IN=Input:
magick "%IN%" ( +clone -blur 0x8 ) -compose screen -composite "%IN%_glow.png"
goto MENU

:wf20
set /p IN=Input:
magick "%IN%" ( +clone -threshold 50% ) -morphology edgeout diamond "%IN%_outline.png"
goto MENU


:: =========================
:: WORKFLOWS 21–30 (SPRITES)
:: =========================

:wf21
set /p FOLDER=Folder:
magick %FOLDER%\*.png +append sheet.png
goto MENU

:wf22
set /p FOLDER=Folder:
set /p COLS=Columns:
magick montage %FOLDER%\*.png -tile %COLS%x -geometry 48x48 sheet.png
goto MENU

:wf23
set /p IN=Sheet:
set /p SIZE=Tile size:
magick "%IN%" -crop %SIZE% frame_%%02d.png
goto MENU

:wf24
set /p IN=Input:
magick "%IN%" -resize 144x192 "%IN%_char.png"
goto MENU

:wf25
set /p IN=Input:
magick "%IN%" -resize 300%% "%IN%_enemy.png"
goto MENU

:wf26
set /p FOLDER=Folder:
magick montage %FOLDER%\*.png -tile 16x -geometry 32x32 iconsheet.png
goto MENU

:wf27
ren *.png sprite_*.png
goto MENU

:wf28
set /p IN=Input:
magick "%IN%" -modulate 100,110,100 "%IN%_var.png"
goto MENU

:wf29
set /p FOLDER=Folder:
magick montage %FOLDER%\*.png -geometry 48x48 animsheet.png
goto MENU

:wf30
set /p IN=Input:
magick "%IN%" -modulate 100,120,100 "%IN%_tilevar.png"
goto MENU


:: =========================
:: WORKFLOWS 31–40 (UI)
:: =========================

:wf31
set /p BASE=Base:
set /p TEXT=Text:
magick "%BASE%" -gravity center -annotate 0 "%TEXT%" "%BASE%_btn.png"
goto MENU

:wf32
set /p IN=Input:
magick "%IN%" -colorspace Gray "%IN%_ui.png"
goto MENU

:wf33
set /p IN=Input:
magick "%IN%" -gravity center -extent 64x64 "%IN%_pad.png"
goto MENU

:wf34
set /p IN=Input:
set /p TEXT=Label:
magick "%IN%" -annotate +5+5 "%TEXT%" "%IN%_label.png"
goto MENU

:wf35
set /p FOLDER=Folder:
for %%f in (%FOLDER%\*.png) do magick "%%f" -resize 64x64 "%%f_ui.png"
goto MENU

:wf36
set /p IN=Input:
magick "%IN%" -colorspace Gray -blur 0x1 "%IN%_disabled.png"
goto MENU

:wf37
set /p IN=Input:
magick "%IN%" -resize 100%% "%IN%_hud.png"
goto MENU

:wf38
set /p IN=Input:
magick "%IN%" -modulate 100,110,100 "%IN%_theme.png"
goto MENU

:wf39
set /p FOLDER=Folder:
for %%f in (%FOLDER%\*.png) do magick "%%f" -strip "%%f_pack.png"
goto MENU

:wf40
set /p IN=Input:
magick "%IN%" -blur 0x2 -noise 5 "%IN%_damagevar.png"
goto MENU


:: =========================
:: WORKFLOWS 41–50 (ADVANCED)
:: =========================

:wf41
set /p A=Image A:
set /p B=Image B:
magick compare "%A%" "%B%" diff.png
goto MENU

:wf42
set /p IN=Input:
magick identify "%IN%"
goto MENU

:wf43
set /p IN=Input:
magick "%IN%" -define png:compression-level=9 "%IN%_compressed.png"
goto MENU

:wf44
set /p IN=Input:
magick "%IN%" -modulate 100,115,100 "%IN%_variant.png"
goto MENU

:wf45
set /p IN=Input:
magick "%IN%" -pointsize 12 -annotate +5+5 "v1.0" "%IN%_v.png"
goto MENU

:wf46
set /p IN=Input:
magick "%IN%" -resize 48x48 "%IN%_rpg.png"
magick "%IN%_rpg.png" -strip "%IN%_rpg_opt.png"
goto MENU

:wf47
echo Running full pipeline...
echo (resize -> clean -> optimize -> variant)
set /p IN=Input:
magick "%IN%" -strip "%IN%_tmp.png"
magick "%IN%_tmp.png" -resize 48x48 "%IN%_tmp2.png"
magick "%IN%_tmp2.png" -define png:compression-level=9 "%IN%_final.png"
del "%IN%_tmp.png" "%IN%_tmp2.png"
goto MENU

:wf48
set /p FOLDER=Folder:
for %%f in (%FOLDER%\*.png) do (
  magick "%%f" -resize 48x48 "%%f_export.png"
)
goto MENU

:wf49
set /p IN=Input:
magick "%IN%" -resize 25%% "%IN%_preview.png"
goto MENU

:wf50
exit
