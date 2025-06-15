import Fluent
import Vapor
import Foundation

struct TodoController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        // Web routes
        routes.get("todos", use: self.webIndex)
        
        // API routes
        let api = routes.grouped("api", "todos")
        api.get(use: self.index)
        api.post(use: self.create)
        api.group(":todoID") { todo in
            todo.delete(use: self.delete)
        }
        
        // Also support direct API access without /api prefix for backward compatibility
        let todos = routes.grouped("todos")
        todos.post(use: self.create)
        todos.group(":todoID") { todo in
            todo.delete(use: self.delete)
        }
    }

    // MARK: - Web Routes
    
    @Sendable
    func webIndex(req: Request) async throws -> View {
        let todos = try await Todo.query(on: req.db)
            .sort(\.$createdAt, .descending)
            .all()
        
        struct TodoContext: Encodable {
            let title: String
            let todos: [TodoDTO]
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
        
        let context = TodoContext(
            title: "Todo List",
            todos: todos.map { $0.toDTO() },
            showHeader: false,
            showFlashMessages: true,
            navItems: [
                NavItem(title: "Home", url: "/", active: false),
                NavItem(title: "Todos", url: "/todos", active: true),
                NavItem(title: "API Docs", url: "/api/docs", active: false)
            ],
            now: Date()
        )
        
        return try await req.view.render("todos/index", context)
    }

    // MARK: - API Routes
    
    @Sendable
    func index(req: Request) async throws -> [TodoDTO] {
        try await Todo.query(on: req.db)
            .sort(\.$createdAt, .descending)
            .all()
            .map { $0.toDTO() }
    }

    @Sendable
    func create(req: Request) async throws -> TodoDTO {
        let todoDTO = try req.content.decode(TodoDTO.self)
        
        guard let title = todoDTO.title, !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw Abort(.badRequest, reason: "Title is required and cannot be empty")
        }
        
        let todo = Todo(title: title.trimmingCharacters(in: .whitespacesAndNewlines))
        try await todo.save(on: req.db)
        
        return todo.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let todoID = req.parameters.get("todoID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid todo ID")
        }
        
        guard let todo = try await Todo.find(todoID, on: req.db) else {
            throw Abort(.notFound, reason: "Todo not found")
        }

        try await todo.delete(on: req.db)
        return .noContent
    }
}
