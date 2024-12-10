import Supabase

class AuthService {
    static let shared = AuthService() // Singleton

    private let client = SupabaseManager.shared.getClient()

    private init() {}

    // Fonction d'inscription
    func signUp(email: String, password: String) async throws -> String {
        do {
            let result = try await client.auth.signUp(email: email, password: password)
            // Suppression du "?" car "user" n'est pas optionnel
            return "Utilisateur créé : \(String(describing: result.user.email))"
        } catch {
            throw error
        }
    }

    // Fonction de connexion
    func signIn(email: String, password: String) async throws -> String {
        do {
            let result = try await client.auth.signIn(email: email, password: password)
            // Suppression du "?" car "user" n'est pas optionnel
            return "Connexion réussie pour : \(String(describing: result.user.email))"
        } catch {
            throw error
        }
    }

    // Fonction de déconnexion
    func signOut() async throws -> String {
        do {
            try await client.auth.signOut()
            return "Déconnexion réussie"
        } catch {
            throw error
        }
    }
}
