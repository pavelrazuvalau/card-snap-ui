@echo off
echo Card Snap Wallet - Web Development Server
echo =============================================
echo.
echo Available commands:
echo 1. Run in Chrome (hot reload)
echo 2. Run in Edge
echo 3. Build static files
echo 4. Run tests
echo.
set /p choice="Choose option (1-4): "

if "%choice%"=="1" goto chrome
if "%choice%"=="2" goto edge
if "%choice%"=="3" goto build
if "%choice%"=="4" goto test
goto default

:chrome
echo Starting in Chrome with hot reload...
flutter run -d chrome
goto end

:edge
echo Starting in Edge...
flutter run -d edge
goto end

:build
echo Building static web files...
flutter build web
echo.
echo Build complete! Files are in build/web/
echo Open build/web/index.html in your browser
goto end

:test
echo Running tests...
flutter test
goto end

:default
echo Invalid choice. Starting default (Chrome)...
flutter run -d chrome
goto end

:end
pause
