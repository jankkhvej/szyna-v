#!/bin/bash

# Build Tailwind CSS for SzynaV
echo "Building Tailwind CSS..."

# Create output directory if it doesn't exist
mkdir -p Public/css

# Build CSS with Tailwind CLI
tailwindcss -o Public/css/styles.css --minify

echo "✅ CSS built successfully at Public/css/styles.css"
echo "📦 File size: $(du -h Public/css/styles.css | cut -f1)" 