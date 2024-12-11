import SwiftUI

struct ChatScreen: View {
    @State private var discussions: [Discussion] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                        Text("My Discussions")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 20)
                    
                    if isLoading {
                        ProgressView("Loading discussions...")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else if discussions.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "bubble.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray)
                            Text("No discussions yet")
                                .foregroundColor(.gray)
                        }
                        .padding()
                    } else {
                        List(discussions) { discussion in
                            NavigationLink(destination: DiscussionView(discussion: discussion)) {
                                HStack {
                                    Image(systemName: "text.bubble")
                                        .foregroundColor(.blue)
                                        .padding(.trailing, 8)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(discussion.title)
                                            .font(.headline)
                                        if let createdAt = discussion.created_at,
                                           let date = parseISODate(createdAt) {
                                            Text(formatDate(date))
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .onAppear {
                    fetchUserDiscussions()
                }
                .navigationBarHidden(true)
            }
        }
    }

    private func fetchUserDiscussions() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let session = try await AuthService.shared.supabaseClient.auth.session
                let user = session.user
                discussions = try await AuthService.shared.fetchUserDiscussions(userId: user.id)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}

// Fonctions utilitaires pour gérer les dates ISO8601
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
