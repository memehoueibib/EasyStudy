import SwiftUI // Importation du framework SwiftUI pour créer l'interface utilisateur

// Vue principale de l'application
struct MainApp: View {
    // Variable pour suivre l'écran actuel (exemple : SplashScreen, LoginScreen, HomeScreen)
    @State private var currentPage: String = "SplashScreen"

    // Corps de la vue principale
    var body: some View {
        VStack { // Conteneur vertical pour organiser les écrans
            // Affichage conditionnel basé sur `currentPage`
            if currentPage == "SplashScreen" { // Affiche l'écran Splash
                SplashScreen(onNext: {
                    currentPage = "LoginScreen" // Passe à l'écran de connexion
                })
            } else if currentPage == "LoginScreen" { // Affiche l'écran Login
                LoginScreen(onNext: {
                    currentPage = "HomeScreen" // Passe à l'écran d'accueil
                })
            } else if currentPage == "HomeScreen" { // Affiche l'écran Home
                HomeScreen(
                    onChat: { currentPage = "ChatScreen" }, // Passe à l'écran discussion
                    onProfile: { currentPage = "ProfileScreen" } // Passe à l'écran profil
                )
            } else if currentPage == "ChatScreen" { // Affiche l'écran Chat
                ChatScreen()
            } else if currentPage == "ProfileScreen" { // Affiche l'écran Profile
                ProfileScreen()
            }
        }
    }
}

// Aperçu pour Xcode
struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp() // Permet de prévisualiser toutes les pages
    }
}
