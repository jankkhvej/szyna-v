import Fluent

struct AddTimestampsToTodo: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("todos")
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .update()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("todos")
            .deleteField("created_at")
            .deleteField("updated_at")
            .update()
    }
} 