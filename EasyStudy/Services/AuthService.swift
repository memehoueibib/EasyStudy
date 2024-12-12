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

        // Pass the userData dictionary to the signUp method
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
    
    func getUsername() async throws -> String {
        let session = try await client.auth.session
        let user = session.user
  
        if let usernameJSON = user.userMetadata["username"],
           case let .string(username) = usernameJSON {
            return username
        } else {
            return "Inconnu"
        }
    }

    // Récupération des catégories
    func fetchCategories() async throws -> [Category] {
        let response: PostgrestResponse<[Category]> = try await client
            .from("categories")
            .select("""
            *,
            users(id, username, email)
            """)
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
            .eq("category_id", value: categoryId)
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
            .select("""
            *,
            users(id, username, email)
            """)
            .eq("discussion_id", value: discussionId)
            .execute()

        return response.value
    }

    // Récupération des notifications
    func fetchNotifications(for userId: UUID) async throws -> [NotificationItem] {
        let response: PostgrestResponse<[NotificationItem]> = try await client
            .from("notifications")
            .select()
            .eq("user_id", value: userId)
            .order("created_at", ascending: false)
            .execute()

        return response.value
    }

    // Structs pour insertion / mise à jour
    struct InsertUser: Encodable {
        let id: UUID
        let name: String
        let email: String
    }

    struct UpdateUserName: Encodable {
        let name: String
    }

    // Insère l'entrée dans la table users
    func insertUserEntry(name: String) async throws {
        let session = try await client.auth.session
        let user = session.user

        let newUser = InsertUser(id: user.id, name: name, email: user.email ?? "")
        _ = try await client
            .from("users")
            .insert(newUser)
            .execute()
    }

    struct UserRow: Codable {
        let id: UUID
        let name: String?
        let email: String?
    }

    // Récupère les infos du profil de l'utilisateur
    func fetchUserProfile() async throws -> (id: UUID, name: String, email: String?) {
        let session = try await client.auth.session
        let user = session.user

        let response: PostgrestResponse<UserRow> = try await client
            .from("users")
            .select()
            .eq("id", value: user.id)
            .single()
            .execute()

        let userRow = response.value
        return (userRow.id, userRow.name ?? "", userRow.email)
    }

    // Met à jour le nom de l'utilisateur
    func updateUserName(_ name: String) async throws {
        let session = try await client.auth.session
        let user = session.user

        let updateData = UpdateUserName(name: name)
        _ = try await client
            .from("users")
            .update(updateData)
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
