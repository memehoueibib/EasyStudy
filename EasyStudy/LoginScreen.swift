import SwiftUI // Importation du framework SwiftUI

struct LoginScreen: View {
    // Variables pour stocker l'email et le mot de passe saisis
    @State private var email: String = "" // Champ de texte pour l'adresse e-mail
    @State private var password: String = "" // Champ sécurisé pour le mot de passe

    var body: some View {
        VStack(spacing: 20) { // Conteneur vertical avec un espacement fixe
            // Titre principal
            Text("Hello, Welcome Back")
                .font(.title) // Taille de police importante
                .fontWeight(.bold) // Texte en gras

            // Sous-titre
            Text("Log in to start your Easy Study journey!")
                .font(.subheadline) // Taille de police plus petite
                .foregroundColor(.gray) // Couleur grise pour le sous-titre

            // Champ pour saisir l'email
            TextField("Email Address", text: $email) // Associe le champ au state `email`
                .padding() // Ajoute de l'espace intérieur
                .background(Color.gray.opacity(0.2)) // Fond gris clair
                .cornerRadius(10) // Coins arrondis
                .autocapitalization(.none) // Désactive la capitalisation automatique

            // Champ pour saisir le mot de passe
            SecureField("Password", text: $password) // Champ sécurisé pour masquer le texte saisi
                .padding() // Ajoute de l'espace intérieur
                .background(Color.gray.opacity(0.2)) // Fond gris clair
                .cornerRadius(10) // Coins arrondis

            // Bouton pour réinitialiser le mot de passe
            Button(action: {
                // Action pour "Mot de passe oublié"
            }) {
                Text("Forgot Password?") // Texte du bouton
                    .font(.footnote) // Taille de texte petite
                    .foregroundColor(.blue) // Texte bleu pour indiquer une action
            }

            // Bouton pour se connecter
            Button(action: {
                // Action de connexion
            }) {
                Text("Login") // Texte du bouton
                    .font(.headline) // Texte légèrement plus grand
                    .padding() // Ajoute de l'espace intérieur
                    .frame(maxWidth: .infinity) // Étend le bouton sur toute la largeur
                    .background(Color.blue) // Fond bleu
                    .foregroundColor(.white) // Texte blanc
                    .cornerRadius(10) // Coins arrondis
            }

            Spacer() // Ajoute de l'espace pour pousser les éléments vers le haut

            // Section pour la connexion via d'autres moyens
            HStack {
                Text("Or Login with") // Texte explicatif
                    .font(.footnote) // Taille de texte petite
                Spacer()
                HStack(spacing: 20) { // Regroupe les icônes des services
                    Image(systemName: "globe") // Icône représentant Google (exemple)
                    Image(systemName: "applelogo") // Icône pour Apple
                    Image(systemName: "facebook") // Icône pour Facebook
                }
            }
            .padding(.top, 20) // Ajoute un espace en haut
        }
        .padding() // Ajoute de l'espace autour de tout le conteneur
    }
}

// Aperçu de l'écran
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen() // Permet de prévisualiser l'écran
    }
}
