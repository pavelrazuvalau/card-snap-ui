#!/bin/bash
# Card Snap Wallet - Quick Web Development Server
# Simple script for local web development

echo "🚀 Card Snap Wallet - Web Development Server"
echo "============================================="
echo ""

echo "Available commands:"
echo "1. Run in Chrome (hot reload)"
echo "2. Run in Edge" 
echo "3. Build static files"
echo "4. Run tests"
echo ""

read -p "Choose option (1-4): " choice

case $choice in
    1)
        echo "🌐 Starting in Chrome with hot reload..."
        flutter run -d chrome
        ;;
    2)
        echo "🌐 Starting in Edge..."
        flutter run -d edge
        ;;
    3)
        echo "🔨 Building static web files..."
        flutter build web
        echo ""
        echo "✅ Build complete! Files are in build/web/"
        echo "🌐 Open build/web/index.html in your browser"
        ;;
    4)
        echo "🧪 Running tests..."
        flutter test
        ;;
    *)
        echo "❌ Invalid choice. Starting default (Chrome)..."
        flutter run -d chrome
        ;;
esac
