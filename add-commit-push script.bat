@echo off
setlocal enabledelayedexpansion

:: Define color codes for pretty output (Windows 10+)
for /f "delims=" %%A in ('powershell -Command "Write-Host [32m"') do set greenColor=%%A
for /f "delims=" %%A in ('powershell -Command "Write-Host [31m"') do set redColor=%%A
set resetColor=

:: Prompt for commit message
set "defaultMsg=Update"
set /p "commitMsg=Enter commit message [default: %defaultMsg%]: "
if "!commitMsg!"=="" set "commitMsg=%defaultMsg%"

echo.
echo %greenColor%[1/3] Adding changes...%resetColor%
git add .
if errorlevel 1 (
    echo %redColor%Error during 'git add'. Aborting.%resetColor%
    exit /b 1
)

echo %greenColor%[2/3] Committing with message: "!commitMsg!"%resetColor%
git commit -m "!commitMsg!"
if errorlevel 1 (
    echo %redColor%Error during 'git commit'. Aborting.%resetColor%
    exit /b 1
)

echo %greenColor%[3/3] Pushing to remote...%resetColor%
git push
if errorlevel 1 (
    echo %redColor%Error during 'git push'. Aborting.%resetColor%
    exit /b 1
)

echo.
echo %greenColor%Git add-commit-push process completed successfully!%resetColor%
echo.
pause