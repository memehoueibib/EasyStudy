import Foundation

struct Category: Codable, Identifiable {
    let id: UUID
    let name: String
    let created_at: String?
    let created_by: UUID?
}

struct Discussion: Codable, Identifiable {
    let id: UUID
    let title: String
    let category_id: UUID
    let creator_id: UUID
    let created_at: String?
}

struct Message: Codable, Identifiable {
    let id: UUID
    let discussion_id: UUID
    let author_id: UUID
    let content: String
    let created_at: String?
}

struct NotificationItem: Codable, Identifiable {
    let id: UUID
    let user_id: UUID
    let message: String
    let created_at: String?
}
