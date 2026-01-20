@echo off
REM This script converts JPG or PNG files to WebP format and resizes them using FFmpeg in an infinite loop with a default height of 500.

:loop
REM Prompt for the input file name
set /p inputFile=Enter the name of the input file (with extension, or type 'exit' to quit): 

REM Remove quotes from the input file name
set inputFile=%inputFile:"=%

REM Check if the user wants to exit
if /i "%inputFile%"=="exit" (
    echo Exiting the script.
    pause
    exit /b
)

REM Check if the file exists
if not exist "%inputFile%" (
    echo File "%inputFile%" does not exist.
    goto loop
)

REM Prompt for the desired output height with a default of 500
set "outputHeight="
set /p outputHeight=Enter the desired output height (default is 500): 
if "%outputHeight%"=="" set outputHeight=500

REM Extract the file name without extension and the extension
for %%f in ("%inputFile%") do (
    set "fileName=%%~nf"
    set "fileExt=%%~xf"
)

REM Convert and resize the file to WebP format
set outputFile=%fileName%-%outputHeight%px.webp
ffmpeg -i "%inputFile%" -vf "scale=-1:%outputHeight%" -q:v 80 "%outputFile%"

echo Conversion and resizing completed. The output file is "%outputFile%".
echo.

goto loop
