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
- Tailwind CSS CLI

#### Installing Tailwind CSS CLI

**macOS (Homebrew):**
```bash
brew install tailwindcss
```

**Linux/FreeBSD (Standalone Binary):**
```bash
# Download the latest release for your platform
# Linux x64:
curl -sL https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 -o tailwindcss
# Linux arm64:
# curl -sL https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-arm64 -o tailwindcss

# Make it executable
chmod +x tailwindcss

# Move to a directory in your PATH
sudo mv tailwindcss /usr/local/bin/
```

**Alternative: NPM (Cross-platform):**
```bash
npm install -g tailwindcss
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

### Native Deployment

1. Build CSS assets: `./build-css.sh`
2. Build Swift project: `swift build -c release`
3. Run migrations: `swift run -c release SzynaV migrate`
4. Start server: `swift run -c release`

### Docker Deployment

The Dockerfile automatically handles Tailwind CSS installation and CSS building:

```bash
# Build the Docker image
docker build -t szyna-v .

# Run with Docker Compose (includes database)
docker-compose up -d
```

The Docker build process automatically:
- Installs Tailwind CSS via NPM
- Builds the CSS assets during the build phase
- Creates an optimized production image

## See More

- [Vapor Website](https://vapor.codes)
- [Vapor Documentation](https://docs.vapor.codes)
- [Tailwind CSS](https://tailwindcss.com)
- [Vapor GitHub](https://github.com/vapor)
