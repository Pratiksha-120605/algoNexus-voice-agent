@echo off
setlocal enabledelayedexpansion

echo.
echo ======================================================
echo    BrainBack.AI -- BankBot (Windows Setup)
echo ======================================================
echo.

:: 1. Check for Python
echo [1/5] Checking Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH.
    pause
    exit /b 1
)
echo      OK.

:: 2. Create Virtual Environment
echo [2/5] Setting up Virtual Environment (venv)...
if not exist "backend\venv" (
    python -m venv backend\venv
    echo      Created venv in backend\venv.
) else (
    echo      Venv already exists.
)

:: 3. Install Requirements
echo [3/5] Installing dependencies...
call backend\venv\Scripts\activate
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install requirements.
    pause
    exit /b 1
)
echo      OK.

:: 4. Pull Ollama Model
echo [4/5] Setting up Ollama model...
echo      Pulling phi3:mini (this may take a few minutes if not already downloaded)...
ollama pull phi3:mini
if %errorlevel% neq 0 (
    echo [WARNING] Could not pull model automatically. 
    echo           Please ensure Ollama is running and run 'ollama pull phi3:mini' manually.
) else (
    echo      OK.
)

:: 5. Pre-cache Whisper Model
echo [5/5] Pre-caching Whisper model...
python -c "from faster_whisper import WhisperModel; print('      Downloading Whisper small...'); WhisperModel('small', device='cpu', compute_type='int8'); print('      Done.')"
echo      OK.

echo.
echo ======================================================
echo    SETUP COMPLETE
echo ======================================================
echo.
echo To start the application, run: scripts\start_windows.bat
echo.
pause
