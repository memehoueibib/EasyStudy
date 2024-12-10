import SwiftUI

struct ProfileScreen: View {
    var onLogout: () -> Void // Closure pour déconnecter l'utilisateur

    var body: some View {
        NavigationView { // Ajout d'un NavigationView pour la navigation
            VStack(alignment: .leading, spacing: 20) {
                // Liste des options
                List {
                    Section(header: Text("Account Settings")) { // Section pour les paramètres du compte
                        NavigationLink(destination: Text("Edit Profile")) {
                            Label("Edit Profile", systemImage: "person.fill")
                        }
                        NavigationLink(destination: Text("Change Password")) {
                            Label("Security", systemImage: "lock.fill")
                        }
                    }

                    Section(header: Text("Notifications")) { // Section pour les notifications
                        NavigationLink(destination: Text("Manage Notifications")) {
                            Label("Notifications", systemImage: "bell.fill")
                        }
                    }

                    Section(header: Text("Support")) { // Section pour l'assistance
                        NavigationLink(destination: Text("Help Center")) {
                            Label("Help Center", systemImage: "questionmark.circle.fill")
                        }
                        NavigationLink(destination: Text("Report a Problem")) {
                            Label("Report a Problem", systemImage: "exclamationmark.triangle.fill")
                        }
                    }

                    Section { // Section pour la déconnexion
                        Button(action: {
                            onLogout() // Appelle la fonction de déconnexion
                        }) {
                            Label("Log Out", systemImage: "arrow.backward.square.fill")
                                .foregroundColor(.red) // Texte en rouge
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle()) // Style de liste moderne
            }
            .navigationTitle("Settings") // Titre unique pour la vue
        }
    }
}

// Aperçu
struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(onLogout: {})
    }
}
