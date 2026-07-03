@echo off
setlocal EnableDelayedExpansion

:: Ask for file name
set /p INPUT=Enter image file name (with extension): 

:: Check file exists
if not exist "%INPUT%" (
    echo File not found: %INPUT%
    pause
    exit /b
)

if not exist output mkdir output

echo Generating mutations for %INPUT%...
if not exist output mkdir output

echo Generating mutations...

:: 1
magick "%INPUT%" -modulate 100,150,100 output\01_saturated.png

:: 2
magick "%INPUT%" -modulate 100,50,100 output\02_muted.png

:: 3
magick "%INPUT%" -modulate 120,100,100 output\03_bright.png

:: 4
magick "%INPUT%" -modulate 80,100,100 output\04_dark.png

:: 5
magick "%INPUT%" -modulate 100,100,40 output\05_hue40.png

:: 6
magick "%INPUT%" -modulate 100,100,80 output\06_hue80.png

:: 7
magick "%INPUT%" -modulate 100,100,120 output\07_hue120.png

:: 8
magick "%INPUT%" -modulate 100,100,160 output\08_hue160.png

:: 9
magick "%INPUT%" -modulate 100,100,200 output\09_hue200.png

:: 10
magick "%INPUT%" -modulate 100,100,240 output\10_hue240.png

:: 11
magick "%INPUT%" -modulate 100,100,280 output\11_hue280.png

:: 12
magick "%INPUT%" -modulate 100,100,320 output\12_hue320.png

:: 13
magick "%INPUT%" -negate output\13_negative.png

:: 14
magick "%INPUT%" -solarize 50%% output\14_solar.png

:: 15
magick "%INPUT%" -sepia-tone 80%% output\15_sepia.png

:: 16
magick "%INPUT%" -contrast output\16_contrast.png

:: 17
magick "%INPUT%" -contrast -contrast output\17_highcontrast.png

:: 18
magick "%INPUT%" +sigmoidal-contrast 8x50%% output\18_sigmoid.png

:: 19
magick "%INPUT%" -gamma 0.7 output\19_gamma07.png

:: 20
magick "%INPUT%" -gamma 1.5 output\20_gamma15.png

:: 21
magick "%INPUT%" -fill red -colorize 20 output\21_red.png

:: 22
magick "%INPUT%" -fill blue -colorize 20 output\22_blue.png

:: 23
magick "%INPUT%" -fill green -colorize 20 output\23_green.png

:: 24
magick "%INPUT%" -fill purple -colorize 25 output\24_purple.png

:: 25
magick "%INPUT%" -fill orange -colorize 25 output\25_orange.png

:: 26
magick "%INPUT%" -fill cyan -colorize 30 output\26_cyan.png

:: 27
magick "%INPUT%" -fill yellow -colorize 20 output\27_yellow.png

:: 28
magick "%INPUT%" -fill magenta -colorize 30 output\28_magenta.png

:: 29
magick "%INPUT%" -normalize output\29_normalize.png

:: 30
magick "%INPUT%" -auto-level output\30_autolevel.png

:: 31
magick "%INPUT%" -level 10%%,90%% output\31_level.png

:: 32
magick "%INPUT%" -brightness-contrast 20x30 output\32_bc1.png

:: 33
magick "%INPUT%" -brightness-contrast -20x30 output\33_bc2.png

:: 34
magick "%INPUT%" -brightness-contrast 40x60 output\34_bc3.png

:: 35
magick "%INPUT%" -colors 32 output\35_32colors.png

:: 36
magick "%INPUT%" -colors 16 output\36_16colors.png

:: 37
magick "%INPUT%" -colors 8 output\37_8colors.png

:: 38
magick "%INPUT%" -ordered-dither o8x8 output\38_dither.png

:: 39
magick "%INPUT%" -ordered-dither checks output\39_checks.png

:: 40
magick "%INPUT%" -charcoal 1 output\40_charcoal.png

:: 41
magick "%INPUT%" -edge 1 output\41_edge.png

:: 42
magick "%INPUT%" -emboss 1 output\42_emboss.png

:: 43
magick "%INPUT%" -swirl 45 output\43_swirl.png

:: 44
magick "%INPUT%" -implode 0.3 output\44_implode.png

:: 45
magick "%INPUT%" -wave 2x20 output\45_wave.png

:: 46
magick "%INPUT%" -paint 2 output\46_paint.png

:: 47
magick "%INPUT%" -shade 120x30 output\47_shade.png

:: 48
magick "%INPUT%" -evaluate multiply 1.3 output\48_multiply.png

:: 49
magick "%INPUT%" -evaluate divide 1.4 output\49_divide.png

:: 50
magick "%INPUT%" -modulate 110,170,250 -contrast -gamma 0.8 output\50_alien.png

echo.
echo Finished.
echo Results are in the OUTPUT folder.
pause
