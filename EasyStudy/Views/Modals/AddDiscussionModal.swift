import SwiftUI

struct AddDiscussionModal: View {
    let categoryId: UUID
    var onDiscussionAdded: (Discussion) -> Void
    @Environment(\.presentationMode) var presentationMode // To handle modal dismissal
    @State private var discussionTitle = ""
    @State private var isSaving = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("Enter a descriptive title for the discussion. This will help others understand its purpose.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                TextField("Discussion Title", text: $discussionTitle)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                if isSaving {
                    ProgressView("Saving...")
                } else {
                    Button("Create Discussion") {
                        addDiscussion()
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.58, green: 0.0, blue: 0.83))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("New Discussion")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismissModal()
                    }
                    .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83))
                }
            }
        }
    }

    private func addDiscussion() {
        guard !discussionTitle.isEmpty else {
            errorMessage = "Please provide a discussion title."
            return
        }

        isSaving = true
        errorMessage = nil

        Task {
            do {
                let discussion = try await DiscussionService.shared.addDiscussion(title: discussionTitle, categoryId: categoryId)
                onDiscussionAdded(discussion)
                isSaving = false
                dismissModal()
            } catch {
                errorMessage = "Failed to save discussion. Please try again."
                isSaving = false
            }
        }
    }

    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
}
