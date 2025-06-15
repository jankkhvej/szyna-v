# Swift Vapor Modern Project Rule

## Project Overview
Swift 6.1 project using Vapor 4 framework with:
- Fluent ORM with SQLite database
- Leaf templating engine
- Tailwind CSS for styling
- Cross-platform support:
  - macOS 13+ (Apple Silicon)
  - Linux (x86_64, aarch64)
  - FreeBSD 14 (x86_64, aarch64)

## Project Structure
```
.
├── Sources/
│   └── SzynaV/
│       ├── Controllers/    # Route handlers and business logic
│       ├── Models/         # Fluent models
│       ├── Migrations/     # Database migrations
│       ├── configure.swift # App configuration
│       └── routes.swift    # Route definitions
├── Resources/
│   ├── Views/             # Leaf templates
│   └── Public/            # Static assets (CSS, JS, images)
└── Tests/                 # Unit and integration tests
```

## Key Dependencies
- Vapor: ^4.115.0
- Fluent: ^4.9.0
- FluentSQLiteDriver: ^4.6.0
- Leaf: ^4.3.0
- SwiftNIO: ^2.65.0

## Third-Party Tools and Build Systems

### STRICTLY PROHIBITED
- **Node.js, npm, yarn, pnpm** - JavaScript toolchains are HIGHLY DISCOURAGED
- **Webpack, Vite, Rollup, Parcel** - JavaScript build tools are forbidden
- **Any JavaScript framework** for build processes (React, Vue, Angular build tools)
- **Third-party binaries from any source** - No direct downloads from GitHub releases, websites, or curl installs
- **Package managers other than Homebrew** - No manual binary installations

### REQUIRED APPROACH
- **Homebrew ONLY** for all third-party tool installations
- **System package managers** on Linux (apt, yum, pacman) as secondary option
- **Swift Package Manager** for Swift dependencies only
- **Native tools** whenever possible (prefer Swift/system tools over external dependencies)

### CSS/Frontend Build Process
- Use **Tailwind CSS CLI via Homebrew**: `brew install tailwindcss`
- Generate production-ready CSS with local build scripts
- NO CDN dependencies in production
- Build scripts: `build-css.sh` and `watch-css.sh` for development
- CSS output: `Public/css/styles.css` (served as static asset)

### Approved Installation Methods
```bash
# ✅ CORRECT - Use Homebrew
brew install tailwindcss
brew install imagemagick
brew install sqlite

# ❌ WRONG - Never do this
curl -sL https://example.com/binary | bash
npm install -g some-tool
wget https://releases.github.com/tool/binary
```

## Development Guidelines

### Models
- All models must:
  - Conform to `Model` and `Content` protocols
  - Use UUID as primary key with `@ID` property wrapper
  - Implement `Timestampable` protocol for automatic created/updated timestamps
  - Store all datetime values in UTC
  - Use UTF-8 encoding for all text fields
  - Define relationships using `@Parent`, `@Children`, or `@Siblings`

Example:
```swift
final class User: Model, Content, Timestampable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
```

### Database
- Use migrations for all schema changes
- All tables must have:
  - UUID primary key
  - `created_at` timestamp (UTC)
  - `updated_at` timestamp (UTC)
- All text/varchar columns must use UTF-8 encoding
- Implement proper indexing for performance

Example:
```swift
struct CreateUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("created_at", .datetime, .required)
            .field("updated_at", .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
```

### Controllers
- Keep controllers focused and single-responsibility
- Use async/await for asynchronous operations
- Handle errors appropriately using Vapor's error handling system
- Return appropriate HTTP status codes

Example:
```swift
struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: index)
        users.post(use: create)
    }
    
    func index(req: Request) async throws -> [User] {
        try await User.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> User {
        let user = try req.content.decode(User.self)
        try await user.save(on: req.db)
        return user
    }
}
```

### Views
- Use Leaf templates for server-side rendering
- Organize templates in logical directories
- Use Tailwind CSS classes for styling (locally built, NO CDN)
- Keep templates DRY using Leaf's template inheritance
- Reference local CSS: `<link rel="stylesheet" href="/css/styles.css">`
- NEVER use CDN links like `cdn.tailwindcss.com`

Example:
```html
#base("layout") {
    <div class="container mx-auto px-4">
        <h1 class="text-2xl font-bold mb-4">#(title)</h1>
        #for(user in users) {
            <div class="bg-white shadow rounded p-4 mb-4">
                <h2 class="text-xl">#(user.name)</h2>
            </div>
        }
    </div>
}
```

### CSS Build Process
- Build CSS before deployment: `./build-css.sh`
- Development with auto-rebuild: `./watch-css.sh`
- CSS file served from: `Public/css/styles.css`
- Use standard Tailwind classes (blue-* instead of custom primary-* colors)

### Testing
- Write unit tests for business logic
- Include integration tests for API endpoints
- Use Vapor's testing utilities
- Mock external dependencies when appropriate

### Security
- Use environment variables for sensitive data
- Implement proper authentication and authorization
- Sanitize user input
- Use HTTPS in production
- Follow OWASP security guidelines

### Performance
- Use connection pooling for database connections
- Implement caching where appropriate
- Optimize database queries
- Use async/await for concurrent operations

## Platform-Specific Considerations

### macOS
- Use native macOS features when available
- Follow Apple's Human Interface Guidelines
- Support only Apple Silicon architectures

### Linux
- Test on Debian-based distributions (Ubuntu, Debian)
- Support architectures:
  - x86_64 (Intel/AMD 64-bit)
  - aarch64 (ARM 64-bit)
- Use platform-agnostic file paths
- Handle Linux-specific environment variables
- Consider systemd for service management

### FreeBSD
- Test on FreeBSD 14 version
- Support architectures:
  - x86_64 (Intel/AMD 64-bit)
  - aarch64 (ARM 64-bit)
- Use platform-agnostic file paths
- Handle FreeBSD-specific environment variables
- Consider rc.d for service management

### Cross-Platform Development
- Use platform-agnostic APIs when possible
- Test on all target platforms
- Handle platform-specific differences in:
  - File system paths
  - Environment variables
  - Process management
  - System services
- Use Docker for consistent development environment
- Implement platform-specific logging when necessary

## Deployment
- Use Docker for containerization
- Implement proper logging
- Set up monitoring and alerting
- Use environment-specific configurations
- Follow CI/CD best practices

## Development Workflow

### Project Setup
1. **Install dependencies via Homebrew ONLY**:
   ```bash
   brew install tailwindcss
   ```

2. **Build CSS assets** (required before running):
   ```bash
   ./build-css.sh
   ```

3. **Run database migrations**:
   ```bash
   swift run SzynaV migrate
   ```

4. **Start development**:
   ```bash
   # Terminal 1: Watch CSS changes
   ./watch-css.sh
   
   # Terminal 2: Run server
   swift run
   ```

### Production Deployment
1. Build CSS: `./build-css.sh`
2. Build Swift: `swift build -c release`
3. Run migrations: `swift run -c release SzynaV migrate`
4. Start server: `swift run -c release`

### File Structure Requirements
```
.
├── Public/css/styles.css    # Generated CSS (never commit source)
├── build-css.sh            # CSS build script
├── watch-css.sh            # CSS watch script
└── Resources/Views/        # Templates with local CSS references
```

## Best Practices
1. Use Swift's type system effectively
2. Follow SOLID principles
3. Write self-documenting code
4. Use meaningful variable and function names
5. Add comments for complex logic
6. Keep functions small and focused
7. Use proper error handling
8. Implement logging for debugging
9. Follow RESTful API design principles
10. Use proper HTTP methods and status codes
11. **NEVER introduce JavaScript toolchains**
12. **Always use Homebrew for third-party tools**
13. **Build CSS locally, never use CDNs in production**
14. **Prefer native Swift solutions over external dependencies** 