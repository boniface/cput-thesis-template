@echo off
setlocal

set "MAIN_FILE=%MAIN_FILE%"
if "%MAIN_FILE%"=="" set "MAIN_FILE=cput-thesis.tex"

set "COMPILER=%~1"
if "%COMPILER%"=="" set "COMPILER=xelatex"

if /I "%COMPILER%"=="pdflatex" goto valid_compiler
if /I "%COMPILER%"=="xelatex" goto valid_compiler
if /I "%COMPILER%"=="lualatex" goto valid_compiler

echo Usage: compile.bat [pdflatex^|xelatex^|lualatex]
exit /b 2

:valid_compiler
for %%F in ("%MAIN_FILE%") do set "BASE_NAME=%%~nF"

echo Compiling %MAIN_FILE% using %COMPILER%...

%COMPILER% -interaction=nonstopmode -halt-on-error "%MAIN_FILE%"
if errorlevel 1 exit /b 1

if exist "%BASE_NAME%.bcf" (
    biber "%BASE_NAME%"
    if errorlevel 1 exit /b 1
)

%COMPILER% -interaction=nonstopmode -halt-on-error "%MAIN_FILE%"
if errorlevel 1 exit /b 1

%COMPILER% -interaction=nonstopmode -halt-on-error "%MAIN_FILE%"
if errorlevel 1 exit /b 1

echo Compilation complete.
