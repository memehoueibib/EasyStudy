import Supabase
import Foundation

class AuthService {
    static let shared = AuthService()

    private let client = SupabaseManager.shared.getClient()
    var supabaseClient: SupabaseClient {
        client
    }

    private init() {}

    // Inscription
    func signUp(email: String, password: String) async throws -> String {
        let result = try await client.auth.signUp(email: email, password: password)
        return "Utilisateur créé : \(result.user.email ?? "Inconnu")"
    }

    // Connexion
    func signIn(email: String, password: String) async throws -> String {
        let result = try await client.auth.signIn(email: email, password: password)
        return "Connexion réussie pour : \(result.user.email ?? "Inconnu")"
    }

    // Déconnexion
    func signOut() async throws -> String {
        try await client.auth.signOut()
        return "Déconnexion réussie"
    }

    // Récupération des catégories
    func fetchCategories() async throws -> [Category] {
        let response: PostgrestResponse<[Category]> = try await client
            .from("categories")
            .select()
            .execute()
        return response.value
    }

    // Ajout d'une catégorie
    func addCategory(name: String) async throws -> Category {
        let session = try await client.auth.session
        let user = session.user

        let newCategoryData = InsertCategory(name: name, created_by: user.id)
        let response: PostgrestResponse<Category> = try await client
            .from("categories")
            .insert(newCategoryData)
            .select()
            .single()
            .execute()

        return response.value
    }

    // Récupération des discussions
    func fetchDiscussions(for categoryId: UUID) async throws -> [Discussion] {
        let response: PostgrestResponse<[Discussion]> = try await client
            .from("discussions")
            .select()
            .eq("category_id", value: categoryId) // Retirer 'value:'
            .execute()

        return response.value
    }

    // Récupération des discussions utilisateur (si vous avez cette RPC)
    func fetchUserDiscussions(userId: UUID) async throws -> [Discussion] {
        let response: PostgrestResponse<[Discussion]> = try await client
            .rpc("get_user_discussions", params: ["user_id": userId])
            .execute()

        return response.value
    }

    // Ajout d'une discussion
    func addDiscussion(title: String, categoryId: UUID) async throws -> Discussion {
        let session = try await client.auth.session
        let user = session.user

        let newDiscussion = InsertDiscussion(title: title, category_id: categoryId, creator_id: user.id)
        let response: PostgrestResponse<Discussion> = try await client
            .from("discussions")
            .insert(newDiscussion)
            .select()
            .single()
            .execute()

        return response.value
    }

    // Récupération des messages
    func fetchMessages(for discussionId: UUID) async throws -> [Message] {
        let response: PostgrestResponse<[Message]> = try await client
            .from("messages")
            .select()
            .eq("discussion_id", value: discussionId) // Retirer 'value:'
            .execute()

        return response.value
    }
    
    func fetchNotifications(for userId: UUID) async throws -> [NotificationItem] {
        let response: PostgrestResponse<[NotificationItem]> = try await client
            .from("notifications")
            .select()
            .eq("user_id", value: userId)
            .order("created_at", ascending: false)
            .execute()
        
        return response.value
    }
    
    // Insère l'entrée dans la table users après la création du compte dans auth.users
    func insertUserEntry(name: String) async throws {
        let session = try await client.auth.session
        let user = session.user

        // Insertion dans la table users
        let data: [String: AnyEncodable] = [
            "id": AnyEncodable(user.id),
            "name": AnyEncodable(name),
            "email": AnyEncodable(user.email ?? "")
        ]

        _ = try await client
            .from("users")
            .insert(data)
            .execute()
    }

    // Récupère les infos du profil de l'utilisateur
    func fetchUserProfile() async throws -> (id: UUID, name: String, email: String?) {
        let session = try await client.auth.session
        let user = session.user

        let response = try await client
            .from("users")
            .select()
            .eq("id", value: user.id)
            .single()
            .execute()

        struct UserRow: Codable {
            let id: UUID
            let name: String?
            let email: String?
        }

        let userRow = try response.decoded(to: UserRow.self)
        return (userRow.id, userRow.name ?? "", userRow.email)
    }

    // Met à jour le nom de l'utilisateur
    func updateUserName(_ name: String) async throws {
        let session = try await client.auth.session
        let user = session.user

        let updates: [String: AnyEncodable] = [
            "name": AnyEncodable(name)
        ]

        _ = try await client
            .from("users")
            .update(updates)
            .eq("id", value: user.id)
            .execute()
    }

    // Envoi d'un message
    func sendMessage(content: String, discussionId: UUID) async throws -> Message {
        let session = try await client.auth.session
        let user = session.user

        let newMessage = InsertMessage(content: content, discussion_id: discussionId, author_id: user.id)
        let response: PostgrestResponse<Message> = try await client
            .from("messages")
            .insert(newMessage)
            .select()
            .single()
            .execute()

        return response.value
    }
}
