import SwiftUI

struct ChatScreen: View {
    @State private var discussions: [Discussion] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(spacing: 20) {
                    headerView
                    
                    contentView
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    fetchUserDiscussions()
                }
                .navigationBarHidden(true)
            }
        }
    }

    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Image(systemName: "bubble.left.and.bubble.right.fill")
                .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83))
                .font(.title)
            Text("My Discussions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding(.top, 20)
    }

    // MARK: - Content View
    private var contentView: some View {
        Group {
            if isLoading {
                ProgressView("Loading discussions...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if discussions.isEmpty {
                emptyStateView
            } else {
                discussionList
            }
        }
    }

    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bubble.left")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Text("No discussions yet")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }

    // MARK: - Discussion List
    private var discussionList: some View {
        ScrollView {
            VStack(spacing: 20) { // Increased spacing between bubbles
                ForEach(discussions) { discussion in
                    NavigationLink(destination: DiscussionView(discussion: discussion)) {
                        discussionRow(for: discussion)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove underline and default button styles
                }
            }
            .padding(.vertical, 16) // Add padding at the top and bottom of the list
            .padding(.horizontal, 16) // Add padding for horizontal alignment
        }
    }


    // MARK: - Discussion Row
    private func discussionRow(for discussion: Discussion) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) { // Slightly increased spacing between title and date
                Text(discussion.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                if let createdAt = discussion.created_at,
                   let date = parseISODate(createdAt) {
                    Text(formatDate(date))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding(16) // Add internal padding for bubble content
        .background(
            RoundedRectangle(cornerRadius: 15) // Rounded bubble effect
                .fill(Color(UIColor.secondarySystemBackground)) // Subtle background color
        )
        .shadow(radius: 3, x: 0, y: 2) // Floating effect for the bubble
    }


    // MARK: - Fetch Discussions
    private func fetchUserDiscussions() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let session = try await AuthService.shared.supabaseClient.auth.session
                let user = session.user
                discussions = try await DiscussionService.shared.fetchUserDiscussions(userId: user.id)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}

// MARK: - Date Utilities
func parseISODate(_ isoString: String) -> Date? {
    let formatter = ISO8601DateFormatter()
    return formatter.date(from: isoString)
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
}
