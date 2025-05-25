@echo off
TITLE Node.js Without Admin

:: Set the path to Node.js (see #README.md for instructions)
SET NODE_PATH=C:\Users\YourUsername\Desktop\node-v22.15.1-win-x64

:: Check if Node.js exists at the specified path
IF NOT EXIST "%NODE_PATH%\node.exe" (
    COLOR 0C
    ECHO ERROR: Node.js not found at %NODE_PATH%
    ECHO Please edit this batch file to correct the NODE_PATH.
    PAUSE
    EXIT /B 1
)

:MAIN_MENU
CLS
COLOR 0A
ECHO ========================================
ECHO      Node.js Without Admin
ECHO ========================================
ECHO.
ECHO  Choose a directory option:
ECHO.
ECHO  [1] Use current directory (%CD%)
ECHO  [2] Enter a custom directory
ECHO  [3] Exit
ECHO.
CHOICE /C 123 /N /M "Enter your choice (1-3): "

IF ERRORLEVEL 3 GOTO :EOF
IF ERRORLEVEL 2 GOTO CUSTOM_DIR
IF ERRORLEVEL 1 GOTO CURRENT_DIR

:CUSTOM_DIR
CLS
ECHO ========================================
ECHO    Enter Custom Directory
ECHO ========================================
ECHO.
SET "CUSTOM_DIR="
SET /P CUSTOM_DIR="Enter the path (e.g., C:\Users\YourUsername\Documents\Dev\Website): "

:: If user entered nothing, go back to main menu
IF "%CUSTOM_DIR%"=="" GOTO MAIN_MENU

:: Remove quotes if present
SET CUSTOM_DIR=%CUSTOM_DIR:"=%

:: Check if directory exists
IF NOT EXIST "%CUSTOM_DIR%\" (
    ECHO.
    ECHO Directory does not exist. Would you like to create it?
    CHOICE /C YN /N /M "Create directory (Y/N)? "
    IF ERRORLEVEL 2 GOTO MAIN_MENU
    
    ECHO Creating directory...
    MKDIR "%CUSTOM_DIR%" 2>NUL
    IF ERRORLEVEL 1 (
        ECHO Failed to create directory. Check the path and permissions.
        PAUSE
        GOTO MAIN_MENU
    )
)

:: Change to the directory
CD /D "%CUSTOM_DIR%" 2>NUL
IF ERRORLEVEL 1 (
    ECHO Failed to change to directory. Check the path and permissions.
    PAUSE
    GOTO MAIN_MENU
)

GOTO TOOL_MENU

:CURRENT_DIR
:: Already in current directory, proceed to tool menu
GOTO TOOL_MENU

:TOOL_MENU
CLS
COLOR 0B
ECHO ========================================
ECHO    Node.js Tools
ECHO ========================================
ECHO  Current directory: %CD%
ECHO ========================================
ECHO.
:: Check for package.json to offer quick script running
SET HAS_PACKAGE_JSON=0
IF EXIST "package.json" SET HAS_PACKAGE_JSON=1

ECHO  Choose a tool to run:
ECHO.
ECHO  [1] Run Node.js Command (node)
ECHO  [2] Run NPM Command (npm)
ECHO  [3] Run NPX Command (npx)
ECHO  [4] Back to directory selection
ECHO  [5] Exit
ECHO.
CHOICE /C 12378 /N /M "Enter your choice (1-3, 7-8): "

IF ERRORLEVEL 5 GOTO :EOF
IF ERRORLEVEL 4 GOTO MAIN_MENU
IF ERRORLEVEL 3 GOTO RUN_NPX
IF ERRORLEVEL 2 GOTO RUN_NPM
IF ERRORLEVEL 1 GOTO RUN_NODE

:RUN_NODE
CLS
ECHO ========================================
ECHO    Running Node.js
ECHO ========================================
ECHO  Current directory: %CD%
ECHO ========================================
ECHO.
SET /P NODE_ARGS="Enter node command (or press Enter for REPL): "

ECHO.
ECHO Running: node %NODE_ARGS%
ECHO.
:: Check if REPL is requested (no arguments)
IF "%NODE_ARGS%"=="" (
    :: Create a temporary batch file with PATH set and run it
    ECHO @echo off > temp_node.bat
    ECHO SET "PATH=%NODE_PATH%;%%PATH%%" >> temp_node.bat
    ECHO "%NODE_PATH%\node" >> temp_node.bat
    START "Node.js REPL" CMD /K temp_node.bat
    DEL temp_node.bat
) ELSE (
    :: Create a temporary batch file with PATH set and run it
    ECHO @echo off > temp_node.bat
    ECHO SET "PATH=%NODE_PATH%;%%PATH%%" >> temp_node.bat
    ECHO "%NODE_PATH%\node" %NODE_ARGS% >> temp_node.bat
    ECHO pause >> temp_node.bat
    START /WAIT "" temp_node.bat
    DEL temp_node.bat
)
GOTO TOOL_MENU

:RUN_NPM
CLS
ECHO ========================================
ECHO    Running NPM
ECHO ========================================
ECHO  Current directory: %CD%
ECHO ========================================
ECHO.
SET /P NPM_ARGS="Enter npm command (e.g., install express, run dev): "

ECHO.
ECHO Running: npm %NPM_ARGS%
ECHO.
:: Create a temporary batch file with PATH set and run it
ECHO @echo off > temp_npm.bat
ECHO SET "PATH=%NODE_PATH%;%%PATH%%" >> temp_npm.bat
ECHO "%NODE_PATH%\npm" %NPM_ARGS% >> temp_npm.bat
ECHO echo. >> temp_npm.bat
ECHO echo Command completed. Press any key to continue... >> temp_npm.bat
ECHO pause > nul >> temp_npm.bat
START /WAIT "" temp_npm.bat
DEL temp_npm.bat
GOTO TOOL_MENU

:RUN_NPX
CLS
ECHO ========================================
ECHO    Running NPX
ECHO ========================================
ECHO  Current directory: %CD%
ECHO ========================================
ECHO.
SET /P NPX_ARGS="Enter npx command (e.g., create-next-app frontend): "

ECHO.
ECHO Running: npx %NPX_ARGS%
ECHO.
:: Create a temporary batch file with PATH set and run it
ECHO @echo off > temp_npx.bat
ECHO SET "PATH=%NODE_PATH%;%%PATH%%" >> temp_npx.bat
ECHO "%NODE_PATH%\npx" %NPX_ARGS% >> temp_npx.bat
ECHO echo. >> temp_npx.bat
ECHO echo Command completed. Press any key to continue... >> temp_npx.bat
ECHO pause > nul >> temp_npx.bat
START /WAIT "" temp_npx.bat
DEL temp_npx.bat
GOTO TOOL_MENU
