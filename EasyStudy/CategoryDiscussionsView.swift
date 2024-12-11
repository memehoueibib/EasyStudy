import SwiftUI

struct CategoryDiscussionsView: View {
    let category: Category
    @State private var discussions: [Discussion] = []
    @State private var showAddDiscussionModal = false
    @State private var errorMessage: String? = nil
    @State private var isLoading = true

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all)

            VStack {
                if isLoading {
                    ProgressView("Loading discussions...")
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if discussions.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "text.bubble")
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
                                    if let dateString = discussion.created_at,
                                       let date = parseISODate(dateString) {
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
            }
            .navigationTitle(category.name)
            .toolbar {
                Button(action: {
                    showAddDiscussionModal = true
                }) {
                    Label("Add Discussion", systemImage: "plus.circle.fill")
                }
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
