import Supabase
import Foundation

class SupabaseManager {
    static let shared = SupabaseManager()

    private let client: SupabaseClient

    private init() {
        let supabaseURL = URL(string: "")! 
        let supabaseKey = "" 
        client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }

    func getClient() -> SupabaseClient {
        return client
    }
}
