import SwiftUI // Importation du framework SwiftUI

// Vue pour l'écran d'accueil
struct HomeScreen: View {
    var onChat: () -> Void // Closure pour naviguer vers l'écran Chat
    var onProfile: () -> Void // Closure pour naviguer vers l'écran Profil

    var body: some View {
        VStack { // Conteneur vertical pour organiser les éléments
            // Liste des questions et catégories
            List {
                Section(header: Text("Recent Questions")) {
                    Text("How to use React Hooks?") // Question 1
                    Text("What is the difference between Python and Swift?") // Question 2
                }

                Section(header: Text("Categories")) {
                    Text("AI Robotics") // Catégorie 1
                    Text("PHP") // Catégorie 2
                    Text("Python") // Catégorie 3
                    Text("SwiftUI") // Catégorie 4
                }
            }

            // Boutons pour accéder aux différentes sections
            HStack {
                // Bouton pour aller à l'écran Chat
                Button(action: {
                    onChat() // Appelle la closure pour aller à ChatScreen
                }) {
                    Image(systemName: "message.fill") // Icône pour le Chat
                        .padding()
                        .background(Color.blue) // Fond bleu
                        .foregroundColor(.white) // Texte blanc
                        .cornerRadius(10) // Coins arrondis
                }

                // Bouton pour aller à l'écran Profil
                Button(action: {
                    onProfile() // Appelle la closure pour aller à ProfileScreen
                }) {
                    Image(systemName: "person.fill") // Icône pour le Profil
                        .padding()
                        .background(Color.green) // Fond vert
                        .foregroundColor(.white) // Texte blanc
                        .cornerRadius(10) // Coins arrondis
                }
            }
            .padding() // Ajoute de l'espace autour des boutons
        }
        .navigationTitle("Easy Study") // Définit le titre dans la barre de navigation
    }
}

// Aperçu pour Xcode
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Exemple avec des closures fictives pour prévisualiser la vue
        HomeScreen(onChat: {}, onProfile: {})
    }
}
