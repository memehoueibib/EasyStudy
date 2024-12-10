import SwiftUI

struct ProfileScreen: View {
    // Closure pour gérer la déconnexion (navigation vers LoginScreen)
    var onLogout: () -> Void

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) { // Conteneur vertical
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                // Section pour les paramètres principaux
                List {
                    Section(header: Text("Account")) {
                        NavigationLink(destination: Text("Edit Profile")) { // Lien pour modifier le profil
                            Label("Edit Profile", systemImage: "person.fill")
                        }
                        NavigationLink(destination: Text("Privacy Settings")) { // Lien pour la confidentialité
                            Label("Privacy", systemImage: "shield.fill")
                        }
                        NavigationLink(destination: Text("Security Settings")) { // Lien pour la sécurité
                            Label("Security", systemImage: "lock.fill")
                        }
                    }

                    // Section pour la déconnexion
                    Section {
                        Button(action: {
                            // Appelle la closure pour déconnexion
                            onLogout()
                        }) {
                            Label("Log Out", systemImage: "arrow.backward.square")
                                .foregroundColor(.red) // Bouton en rouge
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle()) // Style pour la liste
                .navigationTitle("Settings") // Titre dans la barre de navigation
            }
        }
    }
}

// Aperçu de la vue ProfileScreen
struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(onLogout: {})
    }
}
