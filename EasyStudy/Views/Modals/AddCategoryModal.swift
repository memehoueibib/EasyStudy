import SwiftUI

struct AddCategoryModal: View {
    @Environment(\.presentationMode) var presentationMode // To handle modal dismissal
    @State private var categoryName: String = ""
    @State private var isSaving: Bool = false
    @State private var errorMessage: String? = nil

    var onCategoryAdded: (Category) -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Enter a unique and descriptive name for the new category. This will help you organize your items more effectively.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                TextField("Category Name", text: $categoryName)
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
                    Button(action: {
                        saveCategoryToSupabase(categoryName: categoryName)
                    }) {
                        Text("Create Category")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.58, green: 0.0, blue: 0.83))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Create new Category")
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

    private func saveCategoryToSupabase(categoryName: String) {
        guard !categoryName.isEmpty else {
            errorMessage = "Please provide a category name."
            return
        }

        isSaving = true
        errorMessage = nil

        Task {
            do {
                let newCategory = try await CategoryService.shared.addCategory(name: categoryName)
                onCategoryAdded(newCategory)
                isSaving = false
                dismissModal()
            } catch {
                errorMessage = "Failed to save category. Please try again."
                isSaving = false
            }
        }
    }

    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
}
