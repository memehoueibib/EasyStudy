import SwiftUI

struct AddCategoryModal: View {
    @Environment(\.presentationMode) var presentationMode // Add this to handle modal dismissal
    @State private var categoryName: String = ""
    @State private var isSaving: Bool = false
    @State private var errorMessage: String? = nil

    var onCategoryAdded: (Category) -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add a New Category")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Category Name", text: $categoryName)
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
                    Button(action: {
                        saveCategoryToSupabase(categoryName: categoryName)
                    }) {
                        Text("Add Category")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Add Category")
            .toolbar { // Add a cancel button to the navigation bar
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismissModal()
                    }
                }
            }
        }
    }

    private func saveCategoryToSupabase(categoryName: String) {
        guard !categoryName.isEmpty else {
            errorMessage = "Category name cannot be empty"
            return
        }

        isSaving = true
        errorMessage = nil

        Task {
            do {
                let newCategory = try await AuthService.shared.addCategory(name: categoryName)
                onCategoryAdded(newCategory)
                isSaving = false
                dismissModal() // Dismiss the modal after successfully saving
            } catch {
                errorMessage = error.localizedDescription
                isSaving = false
            }
        }
    }

    private func dismissModal() {
        presentationMode.wrappedValue.dismiss() // Dismiss the modal
    }
}
