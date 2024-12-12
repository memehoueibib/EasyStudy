//
//  CategoryService.swift
//  EasyStudy
//
//  Created by Vladimir Kremnev on 12/12/2024.
//

import Supabase
import Foundation

class DiscussionService {
    static let shared = DiscussionService()

    private let client = SupabaseManager.shared.getClient()
    var supabaseClient: SupabaseClient {
        client
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
        print (response)
        return response.value
    }
    
    // Envoi d'un message
    func sendMessage(content: String, discussionId: UUID) async throws -> Message {
        let session = try await client.auth.session
        let user = session.user

        let newMessage = InsertMessage(content: content, discussion_id: discussionId, author_id: user.id)
        let response: PostgrestResponse<Message> = try await client
            .from("messages")
            .insert(newMessage)
            .select("""
            *,
            users(id, username, email)
            """)
            .single()
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
}
