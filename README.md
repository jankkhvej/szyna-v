# SzynaV

💧 A modern Swift Vapor application with Fluent database, Leaf templating, and production-ready Tailwind CSS.

## Features

- **Swift 6.1** with Vapor 4 framework
- **SQLite database** with Fluent ORM
- **Leaf templating** with dark/light theme support
- **Production-ready Tailwind CSS** (no CDN dependency)
- **Comprehensive API documentation** at `/api/docs`
- **Cross-platform support** (macOS, Linux, FreeBSD)
- **Complete icon set** with PWA manifest
- **Responsive design** with mobile navigation

## Getting Started

### Prerequisites

- Swift 6.1+
- Tailwind CSS CLI (installed via Homebrew)

```bash
brew install tailwindcss
```

### Building the Project

1. **Build CSS assets** (required for production):
```bash
./build-css.sh
```

2. **Build the Swift project**:
```bash
swift build
```

3. **Run database migrations**:
```bash
swift run SzynaV migrate
```

4. **Start the server**:
```bash
swift run
```

The application will be available at `http://127.0.0.1:8080`

### Development

For development with automatic CSS rebuilding:

```bash
# Terminal 1: Watch and rebuild CSS on changes
./watch-css.sh

# Terminal 2: Run the server
swift run
```

### Testing

To execute tests:
```bash
swift test
```

## API Endpoints

- `GET /` - Home page
- `GET /todos` - Todo management interface
- `GET /api/docs` - API documentation
- `GET /api/todos` - Get all todos (JSON)
- `POST /api/todos` - Create todo (JSON)
- `DELETE /api/todos/{id}` - Delete todo

## Project Structure

```
.
├── Sources/SzynaV/          # Swift source code
│   ├── Controllers/         # Route handlers
│   ├── Models/             # Fluent models
│   └── Migrations/         # Database migrations
├── Resources/Views/         # Leaf templates
├── Public/                 # Static assets
│   ├── css/               # Generated CSS
│   └── images/            # Icons and images
├── build-css.sh           # CSS build script
└── watch-css.sh           # CSS watch script
```

## Production Deployment

1. Build CSS assets: `./build-css.sh`
2. Build Swift project: `swift build -c release`
3. Run migrations: `swift run -c release SzynaV migrate`
4. Start server: `swift run -c release`

## See More

- [Vapor Website](https://vapor.codes)
- [Vapor Documentation](https://docs.vapor.codes)
- [Tailwind CSS](https://tailwindcss.com)
- [Vapor GitHub](https://github.com/vapor)
