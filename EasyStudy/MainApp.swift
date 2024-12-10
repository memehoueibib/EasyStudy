import SwiftUI // Importation du framework SwiftUI pour créer l'interface utilisateur

struct MainApp: View {
    // Variable pour suivre l'écran actuel (exemple : SplashScreen, LoginScreen, HomeScreen)
    @State private var currentPage: String = "SplashScreen"

    // Corps de la vue principale
    var body: some View {
        VStack { // Conteneur vertical pour organiser les écrans
            // Affichage conditionnel basé sur `currentPage`
            if currentPage == "SplashScreen" { // Affiche l'écran Splash
                SplashScreen(onNext: {
                    currentPage = "LoginScreen"
                })
            } else if currentPage == "LoginScreen" { // Affiche l'écran Login
                LoginScreen(onNext: {
                    currentPage = "HomeScreen"
                })
            } else if currentPage == "HomeScreen" { // Affiche l'écran Home
                HomeScreen(
                    onChat: { currentPage = "ChatScreen" }, // Passe à l'écran Chat
                    onProfile: { currentPage = "ProfileScreen" } // Passe à l'écran Profil
                )
            } else if currentPage == "ChatScreen" { // Affiche l'écran Chat
                ChatScreen(onBack: {
                    currentPage = "HomeScreen" // Retourne à l'écran Home
                })
            } else if currentPage == "ProfileScreen" { // Affiche l'écran Profil
                ProfileScreen(onBack: {
                    currentPage = "HomeScreen" // Retourne à l'écran Home
                })
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
