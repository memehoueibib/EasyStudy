//
//  CategoryService.swift
//  EasyStudy
//
//  Created by Vladimir Kremnev on 12/12/2024.
//

import Supabase
import Foundation

class CategoryService {
    static let shared = CategoryService()

    private let client = SupabaseManager.shared.getClient()
    var supabaseClient: SupabaseClient {
        client
    }
    
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
            .select("""
            *,
            users(id, username, email)
            """)
            .single()
            .execute()

        return response.value
    }
}
