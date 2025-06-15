#!/bin/bash

# Watch and rebuild Tailwind CSS for SzynaV

# Check if tailwindcss is installed
if ! command -v tailwindcss &> /dev/null; then
    echo "❌ Error: tailwindcss command not found"
    echo ""
    echo "Please install Tailwind CSS CLI:"
    echo ""
    echo "macOS (Homebrew):     brew install tailwindcss"
    echo "Linux/FreeBSD:       Download from https://github.com/tailwindlabs/tailwindcss/releases"
    echo "Cross-platform:      npm install -g tailwindcss"
    echo ""
    exit 1
fi

echo "👀 Watching for changes in templates..."
echo "🔄 CSS will rebuild automatically when templates change"
echo "Using tailwindcss: $(which tailwindcss)"
echo "Press Ctrl+C to stop"

# Create output directory if it doesn't exist
mkdir -p Public/css

# Watch for changes and rebuild
tailwindcss -o Public/css/styles.css --watch --minify 