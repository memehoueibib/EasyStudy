import SwiftUI // Importation du framework SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView { // Ajoute une barre de navigation
            VStack { // Conteneur vertical pour organiser les éléments
                // Barre de recherche
                HStack {
                    // Champ de recherche
                    TextField("Search Topics or Questions", text: .constant("")) // Champ de saisie avec un texte par défaut
                        .padding() // Ajoute de l'espace intérieur
                        .background(Color.gray.opacity(0.2)) // Fond gris clair
                        .cornerRadius(10) // Coins arrondis
                        .padding(.horizontal) // Ajoute un espace horizontal

                    // Bouton pour effectuer la recherche
                    Button(action: {
                        // Action de recherche
                    }) {
                        Image(systemName: "magnifyingglass") // Icône pour la recherche
                            .foregroundColor(.gray) // Couleur grise pour l'icône
                            .padding() // Ajoute de l'espace autour de l'icône
                    }
                }

                // Liste des questions et catégories
                List {
                    // Section pour les questions récentes
                    Section(header: Text("Recent Questions")) {
                        Text("How to use React Hooks?") // Question 1
                        Text("What is the difference between Python and Swift?") // Question 2
                    }

                    // Section pour les catégories
                    Section(header: Text("Categories")) {
                        Text("AI Robotics") // Catégorie 1
                        Text("PHP") // Catégorie 2
                        Text("Python") // Catégorie 3
                        Text("SwiftUI") // Catégorie 4
                    }
                }
            }
            .navigationTitle("Easy Study") // Titre affiché dans la barre de navigation
        }
    }
}

// Aperçu de la vue HomeScreen
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen() // Permet de voir la vue HomeScreen dans Xcode
    }
}
