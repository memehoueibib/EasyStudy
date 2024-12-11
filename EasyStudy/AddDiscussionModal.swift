import SwiftUI

struct AddDiscussionModal: View {
    let categoryId: UUID
    var onDiscussionAdded: (Discussion) -> Void
    @State private var discussionTitle = ""
    @State private var isSaving = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add a New Discussion")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Discussion Title", text: $discussionTitle)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }

                if isSaving {
                    ProgressView()
                } else {
                    Button("Add Discussion") {
                        addDiscussion()
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Add Discussion")
        }
    }

    private func addDiscussion() {
        guard !discussionTitle.isEmpty else {
            errorMessage = "Title cannot be empty"
            return
        }

        isSaving = true
        errorMessage = nil

        Task {
            do {
                let discussion = try await AuthService.shared.addDiscussion(title: discussionTitle, categoryId: categoryId)
                onDiscussionAdded(discussion)
                isSaving = false
            } catch {
                errorMessage = error.localizedDescription
                isSaving = false
            }
        }
    }
}
