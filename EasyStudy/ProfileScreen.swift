import SwiftUI // Importation du framework SwiftUI

struct ProfileScreen: View {
    var onBack: () -> Void // Closure pour revenir à l'écran précédent

    var body: some View {
        NavigationView { // Ajout d'un conteneur NavigationView pour gérer la navigation
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

                Spacer() // Ajoute de l'espace flexible pour pousser les éléments vers le haut

                // Bouton "Retour"
                Button(action: {
                    onBack() // Appelle la closure pour revenir à l'écran précédent
                }) {
                    Text("Back")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity) // Étend le bouton sur toute la largeur disponible
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding() // Ajoute de l'espace autour du bouton
            }
            .padding() // Ajoute de l'espace autour des éléments principaux
        }
    }
}

// Aperçu de la vue ProfileScreen
struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen(onBack: {}) // Aperçu avec une closure fictive
    }
}
