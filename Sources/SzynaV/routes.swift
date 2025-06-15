import Fluent
import Vapor
import Foundation

func routes(_ app: Application) throws {
    app.get(use: indexHandler)
    app.get("api", "docs", use: apiDocsHandler)

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: TodoController())
}

@Sendable
func indexHandler(req: Request) async throws -> View {
    struct IndexContext: Encodable {
        let title: String
        let showHeader: Bool
        let showFlashMessages: Bool
        let navItems: [NavItem]
        let now: Date
    }
    
    struct NavItem: Encodable {
        let title: String
        let url: String
        let active: Bool
    }
    
    let context = IndexContext(
        title: "Welcome to SzynaV",
        showHeader: false,
        showFlashMessages: false,
        navItems: [
            NavItem(title: "Home", url: "/", active: true),
            NavItem(title: "Todos", url: "/todos", active: false),
            NavItem(title: "API Docs", url: "/api/docs", active: false)
        ],
        now: Date()
    )
    return try await req.view.render("index", context)
}

@Sendable
func apiDocsHandler(req: Request) async throws -> View {
    struct ApiDocsContext: Encodable {
        let title: String
        let showHeader: Bool
        let showFlashMessages: Bool
        let navItems: [NavItem]
        let now: Date
    }
    
    struct NavItem: Encodable {
        let title: String
        let url: String
        let active: Bool
    }
    
    let context = ApiDocsContext(
        title: "API Documentation",
        showHeader: false,
        showFlashMessages: false,
        navItems: [
            NavItem(title: "Home", url: "/", active: false),
            NavItem(title: "Todos", url: "/todos", active: false),
            NavItem(title: "API Docs", url: "/api/docs", active: true)
        ],
        now: Date()
    )
    return try await req.view.render("api-docs", context)
}
