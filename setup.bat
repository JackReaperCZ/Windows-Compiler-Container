@echo off
setlocal

:: 1. Check for Docker
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Docker not found! Please install Docker Desktop.
    pause
    exit /b
)

echo [1/3] Building Windows Compiler Image...
docker build -t win-builder .

:: 2. Create bin folder in User Profile
set "BIN_DIR=%USERPROFILE%\bin"
if not exist "%BIN_DIR%" (
    mkdir "%BIN_DIR%"
    echo Created directory: %BIN_DIR%
)

:: 3. Create the wcc.bat command
echo @echo off > "%BIN_DIR%\wcc.bat"
echo docker run --rm -v "%%cd%%:/src" win-builder >> "%BIN_DIR%\wcc.bat"
echo [2/3] Created wcc command in %BIN_DIR%

:: 4. Add to PATH (only if not already there)
echo %PATH% | findstr /I /C:"%BIN_DIR%" >nul
if %errorlevel% neq 0 (
    echo [3/3] Adding %BIN_DIR% to User PATH...
    setx PATH "%PATH%;%BIN_DIR%"
    echo [SUCCESS] Path updated.
) else (
    echo [3/3] %BIN_DIR% is already in your PATH.
)

echo.
echo ---------------------------------------------------------
echo RESTART YOUR CMD WINDOW for changes to take effect.
echo ---------------------------------------------------------
pause