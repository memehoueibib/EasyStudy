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
                emptyStateView
            } else {
                messageList
            }

            messageInputBar
                .padding()
                .background(Color(UIColor.systemGroupedBackground)) // Subtle background for input bar
        }
        .background(Color.white) // Keep the background white
        .navigationTitle(discussion.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchMessages()
        }
    }

    // MARK: - Fetch Messages
    private func fetchMessages() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                messages = try await DiscussionService.shared.fetchMessages(for: discussion.id)
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
                let message = try await DiscussionService.shared.sendMessage(content: newMessage, discussionId: discussion.id)
                messages.append(message)
                newMessage = ""
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.middle.bottom")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)

            Text("No messages yet")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }

    // MARK: - Message List
    private var messageList: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(spacing: 10) {
                    ForEach(messages) { message in
                        messageRow(message)
                            .id(message.id) // For scrolling to the latest message
                    }
                }
                .padding(.horizontal)
               
            }
        }
    }

    // MARK: - Message Row
    @ViewBuilder
    private func messageRow(_ message: Message) -> some View {
        HStack {
            if message.author_id == AuthService.shared.currentUserID {
                Spacer()

                VStack(alignment: .trailing, spacing: 8) {
                    Text("You")
                        .font(.caption)
                        .foregroundColor(.blue)

                    Text(message.content)
                        .font(.body)
                        .padding(10)
                        .background(Color(red: 0.58, green: 0.0, blue: 0.83))
                        .foregroundColor(.white)
                        .cornerRadius(12)

                    if let dateString = message.created_at,
                       let date = parseISODate(dateString) {
                        Text(formatDate(date))
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83))
                            .font(.title3)

                        Text(message.users.username )
                            .font(.caption)
                            .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83))
                    }

                    Text(message.content)
                        .font(.body)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)

                    if let dateString = message.created_at,
                       let date = parseISODate(dateString) {
                        Text(formatDate(date))
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }

    // MARK: - Message Input Bar
    private var messageInputBar: some View {
        HStack {
            TextField("Write a message...", text: $newMessage)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

            Button(action: sendMessage) {
                Image(systemName: "paperplane.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(newMessage.isEmpty ? Color.gray : Color(red: 0.58, green: 0.0, blue: 0.83))
                    .cornerRadius(12)
            }
            .disabled(newMessage.isEmpty)
        }
    }

    // MARK: - Date Utilities
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
