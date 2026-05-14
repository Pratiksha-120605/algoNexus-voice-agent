@echo off
setlocal

echo.
echo    🚀 Starting BrainBack.AI BankBot...
echo    ------------------------------------
echo.

:: 1. Ensure Ollama is running
echo [1/2] Checking Ollama server...
curl -s http://localhost:11434/api/tags >nul 2>&1
if %errorlevel% neq 0 (
    echo      Ollama is not running. Attempting to start it...
    start "" "ollama serve"
    timeout /t 5 >nul
) else (
    echo      Ollama is online.
)

:: 2. Launch Flask App
echo [2/2] Launching application...
echo.

:: Activate Venv and Run
call backend\venv\Scripts\activate
python run.py

pause
