import SwiftUI

struct DiscussionView: View {
    let discussion: Discussion
    @State private var messages: [Message] = []
    @State private var newMessage: String = ""

    var body: some View {
        VStack {
            if messages.isEmpty {
                Text("No messages yet")
                    .padding()
            } else {
                List(messages) { message in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Author ID: \(message.author_id.uuidString)")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(message.content)
                            .font(.body)
                            .foregroundColor(.black)
                        if let createdAt = message.created_at {
                            Text(createdAt)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }

            HStack {
                TextField("Write a message...", text: $newMessage)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle(discussion.title)
        .onAppear {
            fetchMessages()
        }
    }

    private func fetchMessages() {
        Task {
            do {
                messages = try await AuthService.shared.fetchMessages(for: discussion.id)
            } catch {
                print("Erreur lors de la récupération des messages : \(error)")
            }
        }
    }

    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        Task {
            do {
                let message = try await AuthService.shared.sendMessage(content: newMessage, discussionId: discussion.id)
                messages.append(message)
                newMessage = ""
            } catch {
                print("Erreur lors de l'envoi du message : \(error)")
            }
        }
    }
}
