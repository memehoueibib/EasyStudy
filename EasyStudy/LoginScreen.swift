import SwiftUI // Importation du framework SwiftUI

// Vue pour l'écran de connexion
struct LoginScreen: View {
    var onNext: () -> Void // Closure pour naviguer vers l'écran suivant

    @State private var email: String = "" // Variable pour stocker l'email de l'utilisateur
    @State private var password: String = "" // Variable pour stocker le mot de passe de l'utilisateur

    var body: some View {
        VStack(spacing: 20) { // Conteneur vertical avec un espacement
            // Titre principal
            Text("Hello, Welcome Back")
                .font(.title) // Taille de police importante
                .fontWeight(.bold) // Texte en gras

            // Sous-titre
            Text("Log in to start your Easy Study journey!")
                .font(.subheadline) // Taille de police plus petite
                .foregroundColor(.gray) // Couleur grise pour le sous-titre

            // Champ pour saisir l'email
            TextField("Email Address", text: $email) // Champ de texte lié à `email`
                .padding() // Ajoute de l'espace intérieur
                .background(Color.gray.opacity(0.2)) // Fond gris clair
                .cornerRadius(10) // Coins arrondis
                .autocapitalization(.none) // Désactive la capitalisation automatique
                .keyboardType(.emailAddress) // Définit le type de clavier pour saisir un email

            // Champ pour saisir le mot de passe
            SecureField("Password", text: $password) // Champ sécurisé lié à `password`
                .padding() // Ajoute de l'espace intérieur
                .background(Color.gray.opacity(0.2)) // Fond gris clair
                .cornerRadius(10) // Coins arrondis

            // Lien pour réinitialiser le mot de passe
            Button(action: {
                // Action pour "Mot de passe oublié"
            }) {
                Text("Forgot Password?") // Texte du bouton
                    .font(.footnote) // Taille de texte petite
                    .foregroundColor(.blue) // Texte bleu
            }

            // Bouton pour se connecter
            Button(action: {
                onNext() // Passe à l'écran suivant (HomeScreen)
            }) {
                Text("Login")
                    .font(.headline) // Texte légèrement plus grand
                    .padding() // Ajoute de l'espace intérieur
                    .frame(maxWidth: .infinity) // Étend le bouton sur toute la largeur disponible
                    .background(Color.blue) // Fond bleu
                    .foregroundColor(.white) // Texte en blanc
                    .cornerRadius(10) // Coins arrondis
            }

            Spacer() // Ajoute de l'espace flexible sous le bouton

            // Options de connexion alternatives
            HStack {
                Text("Or Login with") // Texte explicatif
                    .font(.footnote) // Taille de texte petite

                Spacer()

                // Icônes de services de connexion
                HStack(spacing: 20) {
                    Image(systemName: "globe") // Icône pour Google (exemple)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)

                    Image(systemName: "applelogo") // Icône pour Apple
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)

                    Image(systemName: "facebook") // Icône pour Facebook
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 20) // Ajoute de l'espace en haut
        }
        .padding() // Ajoute de l'espace autour du conteneur
    }
}

// Aperçu pour Xcode
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(onNext: {})
    }
}
