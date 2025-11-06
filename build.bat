@echo off
echo ========================================
echo Building RestMan Project
echo ========================================

echo.
echo Cleaning previous build...
if exist target rmdir /s /q target

echo.
echo Compiling Java sources...
if not exist target\classes mkdir target\classes

dir /s /b src\main\java\*.java > sources.txt
javac -cp "src\main\webapp\WEB-INF\lib\*" -d target\classes @sources.txt
del sources.txt

if errorlevel 1 (
    echo.
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)

echo.
echo Copying resources...
xcopy /s /y src\main\webapp target\webapp\

echo.
echo Build completed successfully!
echo Output: target\classes\
pause
