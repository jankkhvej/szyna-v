# SzynaV Application Icons

This directory contains all the necessary icon files for the SzynaV web application.

## Generated Icons

### Favicon
- `favicon.ico` - Multi-size ICO file (16x16, 32x32, 48x48)

### Apple Touch Icons
- `apple-touch-icon.png` - Default Apple touch icon (180x180)
- `apple-touch-icon-precomposed.png` - Precomposed Apple touch icon (180x180)
- Various sizes in `images/icons/` directory (57x57 to 180x180)

### Android Chrome Icons
- `images/icons/android-chrome-192x192.png` - Android Chrome icon (192x192)
- `images/icons/android-chrome-512x512.png` - Android Chrome icon (512x512)

### Web App Manifest
- `images/icons/site.webmanifest` - Web app manifest for PWA support

### Microsoft Tiles
- `images/icons/mstile-150x150.png` - Microsoft tile icon (150x150)
- `images/icons/browserconfig.xml` - Browser configuration for Windows tiles

## Icon Design

The icons feature:
- **Design**: Letter "S" for SzynaV on a blue gradient background
- **Colors**: Primary blue (#2563eb) with lighter gradient (#3b82f6)
- **Style**: Modern rounded rectangle with clean typography
- **Theme**: Matches the application's Tailwind CSS primary color scheme

## Browser Support

These icons provide comprehensive support for:
- ✅ All modern browsers (Chrome, Firefox, Safari, Edge)
- ✅ iOS Safari (all iPhone/iPad sizes)
- ✅ Android Chrome
- ✅ Windows tiles (Microsoft Edge)
- ✅ Progressive Web App (PWA) support

## Implementation

The icons are automatically included in all pages through the base Leaf template (`Resources/Views/base.leaf`) with proper meta tags and link elements.

## File Structure

```
Public/
├── favicon.ico                    # Main favicon
├── apple-touch-icon.png          # Default Apple touch icon
├── apple-touch-icon-precomposed.png
└── images/icons/
    ├── favicon-16x16.png
    ├── favicon-32x32.png
    ├── apple-touch-icon-*.png     # Various Apple icon sizes
    ├── android-chrome-*.png       # Android icons
    ├── mstile-150x150.png        # Microsoft tile
    ├── site.webmanifest          # Web app manifest
    └── browserconfig.xml         # Browser config
```

## Regenerating Icons

If you need to regenerate the icons with a different design:

1. Create a new icon generation script
2. Update the base design and colors as needed
3. Generate all required sizes
4. Replace files in this directory
5. Update the web manifest if needed

The current icons eliminate all 404 errors for common icon requests and provide a professional appearance across all platforms and devices. 