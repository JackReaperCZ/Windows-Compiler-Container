@echo off
setlocal enabledelayedexpansion

set "BIN_DIR=%USERPROFILE%\bin"
set "TARGET_FILE=%BIN_DIR%\wcc.bat"

echo [1/3] Cleaning up files...
if exist "%TARGET_FILE%" (
    del "%TARGET_FILE%"
    echo Deleted %TARGET_FILE%
)

echo [2/3] Removing Docker image 'win-builder'...
docker rmi win-builder -f

echo [3/3] Cleaning Environment Variables...
:: This part is a bit complex in Batch; it pulls the current User Path
for /f "tokens=2*" %%A in ('reg query "HKCU\Environment" /v Path') do set "OLD_PATH=%%B"

:: Remove our specific bin directory from that string
set "NEW_PATH=!OLD_PATH:%BIN_DIR%=!"
:: Clean up potential double semicolons
set "NEW_PATH=!NEW_PATH:;;=;!"

setx PATH "!NEW_PATH!"

echo.
echo ---------------------------------------------------------
echo UNINSTALL COMPLETE. 
echo Restart your CMD window to finalize changes.
echo ---------------------------------------------------------
pause