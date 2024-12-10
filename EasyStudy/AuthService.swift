import Supabase

class AuthService {
    static let shared = AuthService()

    private let client = SupabaseManager.shared.getClient()

    // Fonction d'inscription
    func signUp(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        client.auth.signUp(email: email, password: password) { result in
            switch result {
            case .success(let user):
                completion(.success("Utilisateur créé : \(user.email ?? "")"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Fonction de connexion
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        client.auth.signIn(email: email, password: password) { result in
            switch result {
            case .success(let session):
                completion(.success("Connexion réussie pour : \(session.user.email ?? "")"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Fonction de déconnexion
    func signOut(completion: @escaping (Result<String, Error>) -> Void) {
        client.auth.signOut { result in
            switch result {
            case .success:
                completion(.success("Déconnexion réussie"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
