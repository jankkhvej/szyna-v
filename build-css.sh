#!/bin/bash

# Build Tailwind CSS for SzynaV
echo "Building Tailwind CSS..."

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

# Create output directory if it doesn't exist
mkdir -p Public/css

# Build CSS with Tailwind CLI
echo "Using tailwindcss: $(which tailwindcss)"
if tailwindcss -o Public/css/styles.css --minify; then
    echo "✅ CSS built successfully at Public/css/styles.css"
    echo "📦 File size: $(du -h Public/css/styles.css | cut -f1)"
else
    echo "❌ Failed to build CSS"
    exit 1
fi 