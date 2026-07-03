@echo off
setlocal EnableDelayedExpansion

:MENU
cls
echo ===============================
echo   PNG MAGICK TOOLKIT (RPG)
echo ===============================
echo.
echo 1  - Resize image
echo 2  - Normalize (strip metadata)
echo 3  - Force square canvas
echo 4  - Convert to 256 colors
echo 5  - Dither pixel style
echo 6  - Sharpen image
echo 7  - Add glow effect
echo 8  - Add outline
echo 9  - Horizontal spritesheet
echo 10 - Grid spritesheet
echo 11 - Split spritesheet
echo 12 - Center in tile
echo 13 - Transparent fix
echo 14 - Character sheet resize
echo 15 - Enemy scale up
echo 16 - Icon sheet pack
echo 17 - Batch process folder resize
echo 18 - Batch strip metadata
echo 19 - Hue shift
echo 20 - Ice tint
echo 21 - Fire overlay blend
echo 22 - Darken night version
echo 23 - Greyscale UI
echo 24 - Add text label
echo 25 - Compare images
echo 26 - Export optimized PNG
echo 27 - Preview resize
echo 28 - Add version stamp
echo 29 - Split batch rename
echo 30 - Folder recursive resize
echo 31 - Remove alpha noise
echo 32 - Add blur damage effect
echo 33 - Multiply splatter overlay
echo 34 - Tile variation generator
echo 35 - Random palette reduce
echo 36 - Sprite glow clone
echo 37 - Corrupt test (identify)
echo 38 - Dimension check
echo 39 - Backup folder
echo 40 - Clean temp folder
echo 41 - Auto center UI button
echo 42 - Generate disabled UI
echo 43 - Export 16-color retro
echo 44 - Pixel sharpen pass
echo 45 - Crop frames
echo 46 - Montage packer
echo 47 - Auto rename prefix
echo 48 - Identify info dump
echo 49 - Batch compress PNG
echo 50 - EXIT
echo.
set /p choice=Select option:

if "%choice%"=="1" goto resize
if "%choice%"=="2" goto strip
if "%choice%"=="3" goto square
if "%choice%"=="4" goto colors
if "%choice%"=="5" goto dither
if "%choice%"=="6" goto sharpen
if "%choice%"=="7" goto glow
if "%choice%"=="8" goto outline
if "%choice%"=="9" goto hsheet
if "%choice%"=="10" goto gsheet
if "%choice%"=="11" goto split
if "%choice%"=="12" goto center
if "%choice%"=="13" goto transfix
if "%choice%"=="14" goto charsheet
if "%choice%"=="15" goto enemy
if "%choice%"=="16" goto icons
if "%choice%"=="17" goto batchresize
if "%choice%"=="18" goto batchstrip
if "%choice%"=="19" goto hue
if "%choice%"=="20" goto ice
if "%choice%"=="21" goto fire
if "%choice%"=="22" goto night
if "%choice%"=="23" goto gray
if "%choice%"=="24" goto text
if "%choice%"=="25" goto compare
if "%choice%"=="26" goto export
if "%choice%"=="27" goto preview
if "%choice%"=="28" goto version
if "%choice%"=="29" goto rename
if "%choice%"=="30" goto recursive
if "%choice%"=="31" goto noisealpha
if "%choice%"=="32" goto damageblur
if "%choice%"=="33" goto splatter
if "%choice%"=="34" goto variants
if "%choice%"=="35" goto palette
if "%choice%"=="36" goto glowclone
if "%choice%"=="37" goto corrupt
if "%choice%"=="38" goto dimcheck
if "%choice%"=="39" goto backup
if "%choice%"=="40" goto clean
if "%choice%"=="41" goto uibutton
if "%choice%"=="42" goto uigrey
if "%choice%"=="43" goto retro
if "%choice%"=="44" goto sharp2
if "%choice%"=="45" goto crop
if "%choice%"=="46" goto montage
if "%choice%"=="47" goto prefix
if "%choice%"=="48" goto info
if "%choice%"=="49" goto compress
if "%choice%"=="50" exit

goto MENU


:: =========================
:: CORE OPERATIONS
:: =========================

:resize
set /p in=Input file:
set /p size=Size (e.g. 48x48):
magick "%in%" -resize %size% "%in%_resized.png"
goto MENU

:strip
set /p in=Input file:
magick "%in%" -strip "%in%_clean.png"
goto MENU

:square
set /p in=Input file:
set /p size=Canvas size:
magick "%in%" -resize %size% -gravity center -background transparent -extent %size% "%in%_square.png"
goto MENU

:colors
set /p in=Input file:
magick "%in%" -colors 256 "%in%_256.png"
goto MENU

:dither
set /p in=Input file:
magick "%in%" -ordered-dither o8x8 "%in%_dither.png"
goto MENU

:sharpen
set /p in=Input file:
magick "%in%" -sharpen 0x1 "%in%_sharp.png"
goto MENU

:glow
set /p in=Input file:
magick "%in%" ( +clone -blur 0x8 ) -compose over -composite "%in%_glow.png"
goto MENU

:outline
set /p in=Input file:
magick "%in%" ( +clone -threshold 50% ) -morphology edgeout diamond "%in%_outline.png"
goto MENU

:hsheet
set /p pattern=Pattern (*.png):
magick %pattern% +append sheet.png
goto MENU

:gsheet
set /p pattern=Pattern (*.png):
set /p cols=Columns:
magick montage %pattern% -tile %cols%x -geometry 48x48 sheet.png
goto MENU

:split
set /p in=Spritesheet:
set /p size=Tile size:
magick "%in%" -crop %size% frame_%%02d.png
goto MENU

:center
set /p in=Input file:
set /p size=Tile size:
magick "%in%" -gravity south -extent %size% "%in%_center.png"
goto MENU

:transfix
set /p in=Input file:
magick "%in%" -fuzz 10%% -transparent white "%in%_fix.png"
goto MENU

:charsheet
set /p in=Character sheet:
magick "%in%" -resize 144x192 "%in%_char.png"
goto MENU

:enemy
set /p in=Enemy sprite:
magick "%in%" -resize 300%% "%in%_enemy.png"
goto MENU

:icons
set /p folder=Folder:
magick montage "%folder%\*.png" -tile 16x -geometry 32x32 iconsheet.png
goto MENU

:: =========================
:: EFFECTS
:: =========================

:hue
set /p in=Input:
magick "%in%" -modulate 100,120,100 "%in%_hue.png"
goto MENU

:ice
set /p in=Input:
magick "%in%" -fill cyan -tint 40%% "%in%_ice.png"
goto MENU

:fire
set /p in=Input:
set /p overlay=Overlay PNG:
magick "%in%" "%overlay%" -compose multiply -composite "%in%_fire.png"
goto MENU

:night
set /p in=Input:
magick "%in%" -brightness-contrast -40x-10 "%in%_night.png"
goto MENU

:gray
set /p in=Input:
magick "%in%" -colorspace Gray "%in%_gray.png"
goto MENU

:text
set /p in=Input:
set /p msg=Text:
magick "%in%" -gravity south -pointsize 12 -annotate 0 "%msg%" "%in%_text.png"
goto MENU

:compare
set /p a=Image A:
set /p b=Image B:
magick compare "%a%" "%b%" diff.png
goto MENU

:export
set /p in=Input:
magick "%in%" -define png:compression-level=9 "%in%_opt.png"
goto MENU

:preview
set /p in=Input:
magick "%in%" -resize 25%% "%in%_preview.png"
goto MENU

:version
set /p in=Input:
set /p v=Version:
magick "%in%" -pointsize 12 -annotate +5+5 "v%v%" "%in%_v.png"
goto MENU

:rename
ren *.png sprite_*.png
goto MENU

:recursive
set /p size=Resize size:
for /r %%f in (*.png) do magick "%%f" -resize %size% "%%f_resized.png"
goto MENU

:noisealpha
set /p in=Input:
magick "%in%" -alpha on -channel A -blur 0x0.5 "%in%_alpha.png"
goto MENU

:damageblur
set /p in=Input:
magick "%in%" -blur 0x2 "%in%_damage.png"
goto MENU

:splatter
set /p in=Input:
set /p overlay=Overlay:
magick "%in%" "%overlay%" -compose multiply -composite "%in%_splatter.png"
goto MENU

:variants
set /p in=Input:
magick "%in%" -modulate 100,110,100 "%in%_var.png"
goto MENU

:palette
set /p in=Input:
magick "%in%" +dither -colors 16 "%in%_palette.png"
goto MENU

:glowclone
set /p in=Input:
magick "%in%" ( +clone -blur 0x6 ) -compose screen -composite "%in%_glow2.png"
goto MENU

:corrupt
set /p in=Input:
magick identify "%in%"
goto MENU

:dimcheck
magick identify *.png
goto MENU

:backup
xcopy *.png backup\ /y
goto MENU

:clean
del temp\*.png
goto MENU

:uibutton
set /p base=Base image:
set /p text=Text:
magick "%base%" -gravity center -annotate 0 "%text%" "%base%_btn.png"
goto MENU

:uigrey
set /p in=Input:
magick "%in%" -colorspace Gray "%in%_disabled.png"
goto MENU

:retro
set /p in=Input:
magick "%in%" -colors 16 "%in%_retro.png"
goto MENU

:sharp2
set /p in=Input:
magick "%in%" -sharpen 0x2 "%in%_sharp2.png"
goto MENU

:crop
set /p in=Input:
set /p size=Crop size:
magick "%in%" -crop %size% frame_%%02d.png
goto MENU

:montage
set /p folder=Folder:
magick montage "%folder%\*.png" -geometry 48x48 sheet.png
goto MENU

:prefix
set /p pre=Prefix:
ren *.png %pre%_*.png
goto MENU

:info
magick identify -verbose *
goto MENU

:compress
set /p in=Input:
magick "%in%" -define png:compression-level=9 "%in%_compressed.png"
goto MENU
