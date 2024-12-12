import SwiftUI

struct DiscussionView: View {
    let discussion: Discussion
    @State private var messages: [Message] = []
    @State private var newMessage: String = ""
    @State private var isLoading = true
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading messages...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if messages.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "bubble.middle.bottom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    Text("No messages yet")
                        .foregroundColor(.gray)
                }
                .padding()
            } else {
                List(messages) { message in
                    messageRow(message)
                }
                .listStyle(InsetGroupedListStyle())
            }

            messageInputBar
                .padding()
        }
        .navigationTitle(discussion.title)
        .onAppear {
            fetchMessages()
        }
    }

    private func fetchMessages() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                messages = try await AuthService.shared.fetchMessages(for: discussion.id)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
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
                errorMessage = error.localizedDescription
            }
        }
    }

    @ViewBuilder
    private func messageRow(_ message: Message) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
                Text("Author: \(message.users.username)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }

            Text(message.content)
                .font(.body)
                .foregroundColor(.primary)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)

            if let dateString = message.created_at,
               let date = parseISODate(dateString) {
                Text(formatDate(date))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private var messageInputBar: some View {
        HStack {
            TextField("Write a message...", text: $newMessage)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            Button(action: sendMessage) {
                Image(systemName: "paperplane.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(newMessage.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(newMessage.isEmpty)
        }
    }

    private func parseISODate(_ isoString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: isoString)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
