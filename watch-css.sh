#!/bin/bash

# Watch and rebuild Tailwind CSS for SzynaV
echo "👀 Watching for changes in templates..."
echo "🔄 CSS will rebuild automatically when templates change"
echo "Press Ctrl+C to stop"

# Create output directory if it doesn't exist
mkdir -p Public/css

# Watch for changes and rebuild
tailwindcss -o Public/css/styles.css --watch --minify 