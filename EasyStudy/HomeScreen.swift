import SwiftUI

struct HomeScreen: View {
    @State private var searchText: String = ""
    @State private var showAddCategoryModal: Bool = false
    @State private var categories: [Category] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Barre de recherche et bouton d'ajout
                HStack {
                    TextField("Search Categories", text: $searchText)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        )

                    Button(action: {
                        showAddCategoryModal = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                            .padding()
                    }
                }
                .padding(.horizontal)

                if isLoading {
                    ProgressView("Loading categories...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(filteredCategories(), id: \.id) { category in
                        NavigationLink(destination: CategoryDiscussionsView(category: category)) {
                            HStack {
                                Text(category.name)
                                    .font(.headline)
                                Spacer()
                                if let createdAt = category.created_at {
                                    Text(createdAt)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Home")
            .onAppear {
                fetchCategories()
            }
            .sheet(isPresented: $showAddCategoryModal) {
                AddCategoryModal(onCategoryAdded: { newCategory in
                    categories.append(newCategory)
                })
            }
        }
    }

    private func filteredCategories() -> [Category] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    private func fetchCategories() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                categories = try await AuthService.shared.fetchCategories()
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
