import SwiftUI // Importation du framework SwiftUI

struct HistoryScreen: View {
    @State private var post: String = "" // Stocke le texte de l'utilisateur

    var body: some View {
        VStack(spacing: 20) { // Conteneur vertical
            // Champ pour poser une question ou publier un post
            TextField("Ask a question or start a post", text: $post)
                .padding() // Ajoute de l'espace intérieur
                .background(Color.gray.opacity(0.2)) // Fond gris clair
                .cornerRadius(10) // Coins arrondis

            // Bouton pour sélectionner une catégorie
            Picker("Add Category", selection: .constant("AI Robotics")) {
                Text("AI Robotics").tag("AI Robotics") // Option 1
                Text("PHP").tag("PHP") // Option 2
                Text("Python").tag("Python") // Option 3
            }
            .pickerStyle(MenuPickerStyle()) // Style du menu déroulant

            // Bouton pour publier le post
            Button(action: {
                // Action pour poster
            }) {
                Text("Post")
                    .font(.headline) // Texte légèrement plus grand
                    .padding() // Ajoute de l'espace intérieur
                    .frame(maxWidth: .infinity) // Étend le bouton sur toute la largeur
                    .background(Color.blue) // Fond bleu
                    .foregroundColor(.white) // Texte blanc
                    .cornerRadius(10) // Coins arrondis
            }
        }
        .padding() // Ajoute de l'espace autour des éléments
    }
}

// Aperçu de la vue HistoryScreen
struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen() // Permet de voir la vue HistoryScreen dans Xcode
    }
}
