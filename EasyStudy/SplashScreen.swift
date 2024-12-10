import SwiftUI // Importation du framework SwiftUI

// Vue de l'écran de démarrage (Splash Screen)
struct SplashScreen: View {
    var onNext: () -> Void // Closure pour passer à l'écran suivant

    var body: some View {
        VStack(spacing: 30) { // Conteneur vertical avec un espacement entre les éléments
            // Image illustrant l'écran d'accueil
            Image(systemName: "person.3.fill") // Exemple d'icône SF Symbols
                .resizable() // Rend l'image redimensionnable
                .scaledToFit() // Maintient les proportions de l'image
                .frame(height: 200) // Définit une hauteur fixe
                .foregroundColor(.blue) // Change la couleur de l'image
                .padding() // Ajoute de l'espace autour de l'image

            // Titre principal
            Text("Easy Study")
                .font(.largeTitle) // Taille de police importante
                .fontWeight(.bold) // Texte en gras
                .foregroundColor(.blue) // Texte bleu

            // Sous-titre de l'écran
            Text("Connect to Learn, Share, and Succeed!")
                .font(.title3) // Taille de police moyenne
                .foregroundColor(.gray) // Texte en gris
                .multilineTextAlignment(.center) // Centre le texte sur plusieurs lignes

            Spacer() // Ajoute un espace flexible pour pousser les éléments vers le haut

            // Bouton pour aller à l'écran suivant
            Button(action: {
                onNext() // Appelle la closure pour naviguer vers LoginScreen
            }) {
                Text("Get Started") // Texte du bouton
                    .font(.headline) // Texte légèrement plus grand
                    .padding() // Ajoute de l'espace intérieur
                    .frame(maxWidth: .infinity) // Étend le bouton sur toute la largeur disponible
                    .background(Color.blue) // Couleur de fond bleue
                    .foregroundColor(.white) // Texte en blanc
                    .cornerRadius(10) // Coins arrondis
                    .padding(.horizontal) // Ajoute de l'espace horizontal
            }

            Spacer() // Ajoute un espace flexible sous le bouton
        }
        .padding() // Ajoute de l'espace autour du conteneur
    }
}

// Aperçu pour Xcode
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(onNext: {})
    }
}
