@echo off
title Python + Jupyter + VS Code Setup
color 0A

echo ==============================================
echo    PYTHON + JUPYTER + VSCODE SETUP
echo ==============================================
echo.

REM ------------------------------------------------
REM Check Python
REM ------------------------------------------------
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH.
    echo Please install Python from:
    echo https://www.python.org/downloads/
    pause
    exit /b
)

echo Python found.
python --version
echo.

REM ------------------------------------------------
REM Create Virtual Environment
REM ------------------------------------------------
if not exist ".venv" (
    echo Creating virtual environment...
    python -m venv .venv
) else (
    echo Virtual environment already exists.
)

echo.

REM ------------------------------------------------
REM Activate Environment
REM ------------------------------------------------
call .venv\Scripts\activate

echo Virtual environment activated.
echo.

REM ------------------------------------------------
REM Upgrade pip
REM ------------------------------------------------
echo Upgrading pip...
python -m pip install --upgrade pip

echo.

REM ------------------------------------------------
REM Install Jupyter and Packages
REM ------------------------------------------------
echo Installing Jupyter...
pip install ^
notebook ^
jupyter ^
jupyterlab ^
ipykernel ^
numpy ^
pandas ^
matplotlib ^
plotly ^
scikit-learn ^
scipy ^
openpyxl ^
xlrd ^
xlsxwriter ^
statsmodels ^
dash ^
bokeh ^
panel ^
hvplot ^
streamlit ^
requests ^
beautifulsoup4 ^
lxml ^
pillow

echo.

REM ------------------------------------------------
REM Register Kernel
REM ------------------------------------------------
echo Registering Jupyter kernel...
python -m ipykernel install --user --name=myenv --display-name "Python (myenv)"

echo.

REM ------------------------------------------------
REM Verify Installation
REM ------------------------------------------------
echo Installed versions:
python --version
pip --version
jupyter --version

echo.

echo Available kernels:
jupyter kernelspec list

echo.

REM ------------------------------------------------
REM Open VS Code
REM ------------------------------------------------
where code >nul 2>&1
if errorlevel 1 (
    echo VS Code command not found.
    echo Open VS Code manually and open this folder.
) else (
    echo Opening VS Code...
    code .
)

echo.

REM ------------------------------------------------
REM Launch Jupyter Notebook
REM ------------------------------------------------
choice /M "Do you want to start Jupyter Notebook now"
if errorlevel 2 goto END

start "" cmd /k "call .venv\Scripts\activate && jupyter notebook"

:END
echo.
echo ==============================================
echo Setup Complete!
echo ==============================================
echo.
echo To use later:
echo.
echo 1. Open Command Prompt
echo 2. cd to your project folder
echo 3. Activate the environment:
echo    .venv\Scripts\activate
echo 4. Start Jupyter:
echo    jupyter notebook
echo 5. Or open VS Code:
echo    code .
echo.
pause