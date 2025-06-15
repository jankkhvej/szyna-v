# Leaf Templates Documentation

## Base Template (`base.leaf`)

The base template provides a complete HTML structure with Tailwind CSS, dark/light theme support, and responsive navigation.

### Features

- **Automatic Theme Detection**: Detects OS preference (dark/light mode)
- **Manual Theme Toggle**: Button to switch between themes
- **Responsive Design**: Mobile-first design with responsive navigation
- **Flash Messages**: Built-in support for success, error, and info messages
- **Customizable Navigation**: Support for dynamic navigation items
- **Footer Links**: Configurable footer links
- **Smooth Transitions**: CSS transitions for theme changes

### Usage

To use the base template, extend it in your Leaf templates:

```html
#extend("base"):
    #export("body"):
        <!-- Your page content here -->
    #endexport
#endextend
```

### Available Variables

#### Required Variables
- `title`: Page title (appears in browser tab and header)

#### Optional Variables
- `subtitle`: Subtitle text (appears below main title in header)
- `showHeader`: Boolean to show/hide the page header section
- `showFlashMessages`: Boolean to show/hide flash message area
- `navItems`: Array of navigation items
- `footerLinks`: Array of footer links
- `additionalHead`: Additional HTML for the `<head>` section
- `additionalScripts`: Additional JavaScript code

#### Flash Message Variables
- `successMessage`: Success message text
- `errorMessage`: Error message text  
- `infoMessage`: Info message text

### Navigation Items Structure

```swift
struct NavItem {
    let title: String
    let url: String
    let active: Bool
}
```

Example in Swift controller:
```swift
let context = [
    "title": "Home",
    "navItems": [
        ["title": "Home", "url": "/", "active": true],
        ["title": "About", "url": "/about", "active": false],
        ["title": "Contact", "url": "/contact", "active": false]
    ]
]
```

### Footer Links Structure

```swift
struct FooterLink {
    let title: String
    let url: String
}
```

Example:
```swift
let context = [
    "footerLinks": [
        ["title": "Privacy", "url": "/privacy"],
        ["title": "Terms", "url": "/terms"],
        ["title": "Support", "url": "/support"]
    ]
]
```

### Theme System

The theme system works in three ways:

1. **Automatic Detection**: Detects OS preference on first visit
2. **Manual Override**: User can click theme toggle to override
3. **Persistence**: Remembers user's choice in localStorage

#### Theme Classes

Use Tailwind's dark mode classes:
- `dark:bg-gray-900` - Dark background
- `dark:text-white` - Dark text color
- `dark:border-gray-700` - Dark borders

### Flash Messages

Flash messages are automatically styled and will auto-hide after 5 seconds:

```swift
// In your controller
req.flash["success"] = "Operation completed successfully!"
req.flash["error"] = "Something went wrong!"
req.flash["info"] = "Please note this information."
```

### Custom Styling

The base template includes:
- Custom primary color palette (blue theme)
- Smooth transitions for theme changes
- Custom scrollbar styling
- Responsive breakpoints

### Example Usage

```html
#extend("base"):
    #export("body"):
        <div class="max-w-4xl mx-auto">
            <div class="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6">
                <h2 class="text-2xl font-bold text-gray-900 dark:text-white mb-4">
                    Welcome to My Page
                </h2>
                <p class="text-gray-600 dark:text-gray-300">
                    This content will automatically adapt to light and dark themes.
                </p>
            </div>
        </div>
    #endexport
#endextend
```

### Best Practices

1. Always use dark mode variants for colors
2. Test in both light and dark themes
3. Use semantic color classes (e.g., `text-gray-600 dark:text-gray-300`)
4. Keep navigation items array updated
5. Use flash messages for user feedback
6. Test responsive design on mobile devices 