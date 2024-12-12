import Supabase
import Foundation

class AuthService {
    static let shared = AuthService()

    private let client = SupabaseManager.shared.getClient()
    var supabaseClient: SupabaseClient {
        client
    }
    
    var currentUserID: UUID? // Add a property to hold the current user's ID
    var currentUserEmail: String?

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
        currentUserID = result.user.id
        currentUserEmail = result.user.email
        return "Connexion réussie pour : \(result.user.email ?? "Inconnu")"
    }

    // Déconnexion
    func signOut() async throws -> String {
        try await client.auth.signOut()
        currentUserID = nil
        currentUserEmail = nil
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

    struct UpdateUserName: Encodable {
        let username: String
    }

    // Insère l'entrée dans la table users
    func insertUserEntry(name: String) async throws {
        let session = try await client.auth.session
        let user = session.user

        let newUser = InsertUser(id: user.id, username: name, email: user.email ?? "")
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
    func fetchUserProfile() async throws -> User {
        let session = try await client.auth.session
        let user = session.user

        let response: PostgrestResponse<User> = try await client
            .from("users")
            .select()
            .eq("id", value: user.id)
            .single()
            .execute()

        return response.value
    }

    // Met à jour le nom de l'utilisateur
    func updateUserName(_ username: String) async throws {
        let session = try await client.auth.session
        let user = session.user

        let updateData = UpdateUserName(username: username)
        _ = try await client
            .from("users")
            .update(updateData)
            .eq("id", value: user.id)
            .execute()
    }


}
