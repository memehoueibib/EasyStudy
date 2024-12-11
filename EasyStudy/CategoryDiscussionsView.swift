import SwiftUI

struct CategoryDiscussionsView: View {
    let category: Category
    @State private var discussions: [Discussion] = []
    @State private var showAddDiscussionModal = false
    @State private var errorMessage: String? = nil
    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading discussions...")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if discussions.isEmpty {
                Text("No discussions yet")
            } else {
                List(discussions) { discussion in
                    NavigationLink(destination: DiscussionView(discussion: discussion)) {
                        HStack {
                            Text(discussion.title)
                            Spacer()
                            if let createdAt = discussion.created_at {
                                Text(createdAt)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(category.name)
        .onAppear {
            fetchDiscussions()
        }
        .toolbar {
            Button("Add") {
                showAddDiscussionModal = true
            }
        }
        .sheet(isPresented: $showAddDiscussionModal) {
            AddDiscussionModal(categoryId: category.id) { discussion in
                discussions.append(discussion)
            }
        }
    }

    private func fetchDiscussions() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                discussions = try await AuthService.shared.fetchDiscussions(for: category.id)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
