#!/bin/bash
# Card Snap UI - Quick Web Development Server
# Simple script for local web development with multi-browser support

echo "🚀 Card Snap Wallet - Web Development Server"
echo "============================================="
echo ""

# 🧠 Detect platform to show appropriate browser options
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - show all browsers including Safari and Edge
    echo "Available commands:"
    echo "1. Chrome (hot reload) - RECOMMENDED"
    echo "2. Safari (hot reload)"
    echo "3. Edge (hot reload)"
    echo "4. Build for Firefox (build static files)"
    echo "5. Run tests"
    echo ""
    read -p "Choose option (1-5): " choice
    
    case $choice in
        1)
            echo "🌐 Starting in Chrome..."
            flutter run -d chrome
            ;;
        2)
            echo "🧭 Starting in Safari..."
            flutter run -d safari
            ;;
        3)
            echo "🌐 Starting in Edge..."
            flutter run -d edge
            ;;
        4)
            echo "🦊 Building for Firefox..."
            flutter build web
            echo ""
            echo "✅ Build complete! Files are in build/web/"
            echo "🌐 To open in Firefox:"
            echo "   firefox build/web/index.html"
            ;;
        5)
            echo "🧪 Running tests..."
            flutter test
            ;;
        *)
            echo "❌ Invalid choice. Starting default (Chrome)..."
            flutter run -d chrome
            ;;
    esac
else
    # Linux - Chrome and Edge only (Firefox requires build step)
    echo "Available commands:"
    echo "1. Chrome (hot reload) - RECOMMENDED"
    echo "2. Edge (hot reload)"
    echo "3. Build for Firefox (build static files)"
    echo "4. Run tests"
    echo ""
    read -p "Choose option (1-4): " choice
    
    case $choice in
        1)
            echo "🌐 Starting in Chrome..."
            flutter run -d chrome
            ;;
        2)
            echo "🌐 Starting in Edge..."
            flutter run -d edge
            ;;
        3)
            echo "🦊 Building for Firefox..."
            flutter build web
            echo ""
            echo "✅ Build complete! Files are in build/web/"
            echo "🌐 To open in Firefox:"
            echo "   firefox build/web/index.html"
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
fi
