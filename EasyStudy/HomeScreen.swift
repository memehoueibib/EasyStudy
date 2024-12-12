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
                searchBarAndAddButton
                
                contentView
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                fetchCategories()
            }
            .sheet(isPresented: $showAddCategoryModal) {
                AddCategoryModal(onCategoryAdded: { newCategory in
                    categories.append(newCategory)
                })
            }
            .padding()
        }
    }

    // MARK: - Search Bar and Add Button
    private var searchBarAndAddButton: some View {
        HStack {
            // Search Bar
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
            
            // Add Category Button
            Button(action: {
                showAddCategoryModal = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83))
                    .font(.title2)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 4)
            }
        }
    }

    // MARK: - Content View
    private var contentView: some View {
        Group {
            if isLoading {
                ProgressView("Loading categories...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                categoryList
            }
        }
    }

    // MARK: - Category List
    private var categoryList: some View {
        List(filteredCategories(), id: \.id) { category in
            NavigationLink(destination: CategoryDiscussionsView(category: category)) {
                categoryRow(for: category)
            }
        }
        .listStyle(PlainListStyle())
    }

    // MARK: - Category Row
    private func categoryRow(for category: Category) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                
                if let createdAt = category.created_at {
                    Text(formatDate(createdAt))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }

    // MARK: - Helper Methods
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
                categories = try await CategoryService.shared.fetchCategories()
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

    private func formatDate(_ date: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .medium
        outputFormatter.timeStyle = .none
        
        if let dateObject = inputFormatter.date(from: date) {
            return outputFormatter.string(from: dateObject)
        } else {
            return date
        }
    }
}
