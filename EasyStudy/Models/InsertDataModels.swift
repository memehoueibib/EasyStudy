import Foundation

struct InsertCategory: Encodable {
    let name: String
    let created_by: UUID
}

struct InsertDiscussion: Encodable {
    let title: String
    let category_id: UUID
    let creator_id: UUID
}

struct InsertMessage: Encodable {
    let content: String
    let discussion_id: UUID
    let author_id: UUID
}

struct InsertUser: Encodable {
    let id: UUID
    let username: String
    let email: String
}

struct UpdateUserName: Encodable {
    let name: String
}

