import SwiftUI // Importation du framework SwiftUI

struct ChatScreen: View {
    var onBack: () -> Void // Closure pour revenir à l'écran précédent
    @State private var message: String = "" // Variable pour stocker le texte du message saisi

    var body: some View {
        NavigationView { // Ajout d'un conteneur NavigationView
            VStack { // Conteneur vertical
                // Bouton "Retour" en haut de l'écran
                HStack {
                    Button(action: {
                        onBack() // Appelle la closure pour revenir à l'écran précédent
                    }) {
                        Image(systemName: "arrow.backward") // Icône pour "Retour"
                            .foregroundColor(.blue) // Couleur bleue pour le bouton
                            .padding()
                    }
                    Spacer() // Pousse le reste du contenu à droite
                }

                ScrollView { // Zone défilable pour afficher les messages
                    VStack(alignment: .leading, spacing: 10) { // Organise les messages verticalement
                        // Exemple de message reçu
                        Text("How hooks work?")
                            .font(.body) // Taille de police par défaut
                            .padding() // Ajoute de l'espace intérieur
                            .background(Color.blue.opacity(0.2)) // Fond bleu clair
                            .cornerRadius(10) // Coins arrondis

                        // Exemple de message envoyé
                        Text("Let's call, I'll show you.")
                            .font(.body) // Taille de police par défaut
                            .padding() // Ajoute de l'espace intérieur
                            .background(Color.gray.opacity(0.2)) // Fond gris clair
                            .cornerRadius(10) // Coins arrondis
                    }
                    .padding() // Ajoute de l'espace autour des messages
                }

                // Zone de saisie pour écrire un message
                HStack {
                    TextField("Type here...", text: $message) // Champ de saisie pour le texte
                        .padding() // Ajoute de l'espace intérieur
                        .background(Color.gray.opacity(0.2)) // Fond gris clair
                        .cornerRadius(10) // Coins arrondis

                    // Bouton pour envoyer un message
                    Button(action: {
                        // Action pour envoyer un message
                    }) {
                        Image(systemName: "paperplane.fill") // Icône pour l'envoi
                            .foregroundColor(.blue) // Couleur bleue pour l'icône
                            .padding() // Ajoute de l'espace autour de l'icône
                    }
                }
                .padding() // Ajoute de l'espace autour de la zone de saisie
            }
        }
    }
}

// Aperçu de la vue ChatScreen
struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(onBack: {}) // Aperçu avec une closure fictive
    }
}
