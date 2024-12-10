import SwiftUI // Importation du framework SwiftUI

struct ProfileScreen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) { // Organise les éléments verticalement
            // Titre principal de l'écran
            Text("Settings")
                .font(.largeTitle) // Police large
                .fontWeight(.bold) // Texte en gras

            // Liste des options du profil
            List {
                Section {
                    // Options principales
                    NavigationLink(destination: Text("Edit Profile")) { // Lien vers l'écran de modification du profil
                        Label("Edit profile", systemImage: "person.fill") // Texte avec une icône
                    }
                    NavigationLink(destination: Text("Security Settings")) {
                        Label("Security", systemImage: "lock.fill")
                    }
                    NavigationLink(destination: Text("Notifications Settings")) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                    NavigationLink(destination: Text("Privacy Settings")) {
                        Label("Privacy", systemImage: "shield.fill")
                    }
                }

                Section {
                    // Options secondaires
                    NavigationLink(destination: Text("Report a Problem")) {
                        Label("Report a problem", systemImage: "exclamationmark.triangle.fill")
                    }
                    NavigationLink(destination: Text("Add Account")) {
                        Label("Add account", systemImage: "person.badge.plus.fill")
                    }
                }

                // Bouton de déconnexion
                Section {
                    Button(action: {
                        // Action pour se déconnecter
                    }) {
                        Label("Log out", systemImage: "arrow.backward.square.fill")
                            .foregroundColor(.red) // Met le bouton en rouge
                    }
                }
            }
        }
        .padding() // Ajoute de l'espace autour des éléments
    }
}

// Aperçu de la vue ProfileScreen
struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen() // Permet de voir la vue ProfileScreen dans Xcode
    }
}
