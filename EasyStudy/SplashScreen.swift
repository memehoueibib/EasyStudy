import SwiftUI // Importation du framework SwiftUI pour la création de l'interface utilisateur

// Définition de la vue SplashScreen
struct SplashScreen: View {
    // Corps de la vue
    var body: some View {
        VStack(spacing: 20) { // Un conteneur vertical avec un espacement entre les éléments
            // Image représentant un groupe d'utilisateurs
            Image(systemName: "person.3.fill") // Utilisation d'une icône SF Symbols
                .resizable() // Rend l'image redimensionnable
                .scaledToFit() // Maintient les proportions de l'image
                .frame(height: 200) // Définit une hauteur fixe pour l'image
                .padding() // Ajoute de l'espace autour de l'image

            // Titre principal de l'écran
            Text("Easy Study")
                .font(.largeTitle) // Définit une grande taille de police
                .fontWeight(.bold) // Applique un style gras au texte

            // Sous-titre de l'écran
            Text("Connect to Learn, Share, and Succeed!")
                .font(.title3) // Définit une taille de police moyenne
                .foregroundColor(.gray) // Change la couleur du texte en gris
                .multilineTextAlignment(.center) // Centre le texte sur plusieurs lignes

            Spacer() // Ajoute un espace flexible pour pousser les éléments vers le haut

            // Bouton pour accéder à l'écran suivant
            Button(action: {
                // Action à exécuter lorsque le bouton est pressé
                // Par exemple : Navigation vers l'écran de connexion
            }) {
                Text("Get Started") // Texte affiché sur le bouton
                    .font(.headline) // Taille de police légèrement plus grande
                    .padding() // Ajoute de l'espace intérieur au bouton
                    .frame(maxWidth: .infinity) // Étend le bouton sur toute la largeur disponible
                    .background(Color.blue) // Ajoute un fond bleu au bouton
                    .foregroundColor(.white) // Change la couleur du texte en blanc
                    .cornerRadius(10) // Arrondit les coins du bouton
                    .padding(.horizontal) // Ajoute un espace horizontal autour du bouton
            }
        }
        .padding() // Ajoute de l'espace autour de tout le conteneur VStack
    }
}

// Aperçu de la vue SplashScreen
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen() // Permet de prévisualiser la vue dans Xcode
    }
}
