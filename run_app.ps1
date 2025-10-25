# Card Snap Wallet - Windows Launcher
# PowerShell script for reliable app launching

Write-Host "Card Snap Wallet - Windows Launcher" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check if Flutter is available
try {
    $flutterVersion = flutter --version 2>$null
    Write-Host "Flutter detected" -ForegroundColor Green
} catch {
    Write-Host "Flutter not found. Please install Flutter first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Available launch options:" -ForegroundColor Yellow
Write-Host "1. Chrome (hot reload) - RECOMMENDED" -ForegroundColor White
Write-Host "2. Edge (hot reload)" -ForegroundColor White
Write-Host "3. Build static files for Firefox" -ForegroundColor White
Write-Host "4. Run tests" -ForegroundColor White
Write-Host "5. Check Flutter setup" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Choose option (1-5)"

switch ($choice) {
    "1" {
        Write-Host "Starting in Chrome..." -ForegroundColor Blue
        flutter run -d chrome
    }
    "2" {
        Write-Host "Starting in Edge..." -ForegroundColor Blue
        flutter run -d edge
    }
    "3" {
        Write-Host "Building static web files for Firefox..." -ForegroundColor Blue
        flutter build web
        Write-Host ""
        Write-Host "Build complete!" -ForegroundColor Green
        Write-Host "Files are in build/web/" -ForegroundColor Yellow
        Write-Host "Open build/web/index.html in Firefox" -ForegroundColor Yellow
    }
    "4" {
        Write-Host "Running tests..." -ForegroundColor Blue
        flutter test
    }
    "5" {
        Write-Host "Checking Flutter setup..." -ForegroundColor Blue
        flutter doctor
    }
    default {
        Write-Host "Invalid choice. Starting default (Chrome)..." -ForegroundColor Red
        flutter run -d chrome
    }
}

Write-Host ""
Write-Host "Press Enter to exit..." -ForegroundColor Gray
Read-Host