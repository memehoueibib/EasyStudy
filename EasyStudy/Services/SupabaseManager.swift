import Supabase
import Foundation

class SupabaseManager {
    static let shared = SupabaseManager()

    private let client: SupabaseClient

    private init() {
        let supabaseURL = URL(string: "https://dbjarhbtrxqgdzebbaqy.supabase.co")! // Remplacez par votre URL Supabase
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRiamFyaGJ0cnhxZ2R6ZWJiYXF5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4MzQ4MDQsImV4cCI6MjA0OTQxMDgwNH0.dCEsLZNrtBz0_LvRc7Vffi2srJgrZwic-dELdyhcnYU" // Remplacez par votre clé Anon
        client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }

    func getClient() -> SupabaseClient {
        return client
    }
}
