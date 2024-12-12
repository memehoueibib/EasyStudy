import SwiftUI

struct NotificationScreen: View {
    @State private var notifications: [NotificationItem] = []
    @State private var isLoading = true
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all)
                
                VStack {
                    if isLoading {
                        ProgressView("Loading notifications...")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else if notifications.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "bell.slash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray)
                            Text("No notifications available")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    } else {
                        List(notifications) { notification in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83))
                                    .font(.title2)
                                    .padding(.top, 4)

                                VStack(alignment: .leading, spacing: 5) {
                                    Text(notification.message)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    
                                    if let createdAt = notification.created_at,
                                       let date = parseISODate(createdAt) {
                                        Text(formatDate(date))
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                }
                .navigationTitle("Notifications")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    fetchUserNotifications()
                }
            }
        }
    }

    private func fetchUserNotifications() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let session = try await AuthService.shared.supabaseClient.auth.session
                let user = session.user
                notifications = try await DiscussionService.shared.fetchNotifications(for: user.id)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
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
