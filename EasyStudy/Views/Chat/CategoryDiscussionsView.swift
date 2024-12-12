import SwiftUI

struct CategoryDiscussionsView: View {
    let category: Category
    @State private var discussions: [Discussion] = []
    @State private var showAddDiscussionModal = false
    @State private var errorMessage: String? = nil
    @State private var isLoading = true

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all) // Background color

            VStack(spacing: 20) {
                headerView

                contentView
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                addDiscussionButton
            }
            .sheet(isPresented: $showAddDiscussionModal) {
                AddDiscussionModal(categoryId: category.id) { discussion in
                    discussions.append(discussion)
                }
            }
            .onAppear {
                fetchDiscussions()
            }
        }
    }

    // MARK: - Header View
    private var headerView: some View {
        VStack {
            Text(category.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text("Discussions in \(category.name)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
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
                    .multilineTextAlignment(.center)
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
            Image(systemName: "text.bubble")
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
            .padding(.vertical)
        }
    }

    // MARK: - Discussion Row
    private func discussionRow(for discussion: Discussion) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(discussion.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                if let dateString = discussion.created_at,
                   let date = parseISODate(dateString) {
                    Text(formatDate(date))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .shadow(radius: 3, x: 0, y: 2) // Slight shadow for depth
        .padding(.horizontal) // Extra horizontal padding
    }

    // MARK: - Add Discussion Button
    private var addDiscussionButton: some View {
        Button(action: {
            showAddDiscussionModal = true
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(red: 0.58, green: 0.0, blue: 0.83))
            .cornerRadius(8)
            .shadow(radius: 4)
        }
    }

    // MARK: - Fetch Discussions
    private func fetchDiscussions() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                discussions = try await DiscussionService.shared.fetchDiscussions(for: category.id)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

    // MARK: - Date Parsing and Formatting
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
}
