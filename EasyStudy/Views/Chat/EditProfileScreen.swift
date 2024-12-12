import SwiftUI

struct EditProfileScreen: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var isLoading = true
    @State private var errorMessage: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            if isLoading {
                ProgressView("Loading profile...")
            } else {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $username)
                }

                Section(header: Text("Email")) {
                    Text(email)
                        .foregroundColor(.gray)
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Section {
                    Button("Save") {
                        Task {
                            do {
                                try await AuthService.shared.updateUserName(username)
                                presentationMode.wrappedValue.dismiss()
                            } catch {
                                errorMessage = error.localizedDescription
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit Profile")
        .onAppear {
            loadProfile()
        }
    }

    private func loadProfile() {
        Task {
            do {
                let profile = try await AuthService.shared.fetchUserProfile()
                username = profile.username
                email = profile.email
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
