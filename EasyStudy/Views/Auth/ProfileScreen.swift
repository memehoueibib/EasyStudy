import SwiftUI

struct ProfileScreen: View {
    var onLogout: () -> Void

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account Settings")) {
                    NavigationLink(destination: EditProfileScreen()) {
                        Label("Edit Profile", systemImage: "person.fill")
                    }
                    NavigationLink(destination: Text("Change Password")) {
                        Label("Security", systemImage: "lock.fill")
                    }
                }

                Section(header: Text("Notifications")) {
                    NavigationLink(destination: Text("Manage Notifications")) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                }

                Section(header: Text("Support")) {
                    NavigationLink(destination: Text("Help Center")) {
                        Label("Help Center", systemImage: "questionmark.circle.fill")
                    }
                    NavigationLink(destination: Text("Report a Problem")) {
                        Label("Report a Problem", systemImage: "exclamationmark.triangle.fill")
                    }
                }

                Section {
                    Button(action: {
                        Task {
                            do {
                                let _ = try await AuthService.shared.signOut()
                                onLogout()
                            } catch {
                                print("Error logging out: \(error)")
                            }
                        }
                    }) {
                        Label("Log Out", systemImage: "arrow.backward.square.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Settings")
        }
    }
}
