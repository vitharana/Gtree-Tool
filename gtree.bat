@echo off
setlocal enabledelayedexpansion

:: Capture the current directory from where user runs `gtree`
set "TARGET_DIR=%cd%"

:: Get the folder name from the current path
for %%F in ("%TARGET_DIR%") do set "FOLDER_NAME=%%~nxF"

:: Use PowerShell to get the folder creation date
for /f "delims=" %%C in ('powershell -command "(Get-Item \"%TARGET_DIR%\").CreationTime.ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set "CREATION_DATE=%%C"

:: Define output file name
set "OUTFILE=%TARGET_DIR%\tree_output.txt"

:: Write folder name and creation date to the top of the output file
(
    echo Folder: %FOLDER_NAME%
    echo Created: %CREATION_DATE%
    echo.
) > "%OUTFILE%"

:: Append the tree output to the file
echo Generating tree for: %TARGET_DIR%
tree /f /a "%TARGET_DIR%" >> "%OUTFILE%"

echo Tree saved to: %OUTFILE%
pause
