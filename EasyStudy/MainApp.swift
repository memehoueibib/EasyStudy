import SwiftUI

struct MainApp: View {
    @State private var selectedTab: Int = 0 // Gère l'onglet sélectionné (index de 0 à 4)
    @State private var isLoggedIn: Bool = false // Gère l'état de connexion
    @State private var isCreatingAccount: Bool = false // Gère l'état de création de compte
    @State private var showSplash: Bool = true // Affiche la SplashScreen au début

    var body: some View {
        if showSplash { // Affiche la SplashScreen en premier
            SplashScreen(onNext: {
                showSplash = false // Masque la SplashScreen pour afficher LoginScreen
            })
        } else if isLoggedIn { // Affiche la TabView si l'utilisateur est connecté
            TabView(selection: $selectedTab) { // Création de la barre d'onglets
                // Onglet 1 : Accueil
                HomeScreen()
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house") // Icône pour Accueil
                        Text("Home")
                    }
                    .tag(0) // Index de cet onglet

                // Onglet 2 : Ajouter une catégorie
                HistoryScreen()
                    .tabItem {
                        Image(systemName: selectedTab == 1 ? "plus.square.fill" : "plus.square") // Icône pour Ajouter
                        Text("Add")
                    }
                    .tag(1) // Index de cet onglet

                // Onglet 3 : Chat
                ChatScreen()
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "bubble.left.fill" : "bubble.left") // Icône pour Chat
                        Text("Chat")
                    }
                    .tag(2) // Index de cet onglet

                // Onglet 4 : Notifications
                NotificationScreen()
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "bell.fill" : "bell") // Icône pour Notifications
                        Text("Notifications")
                    }
                    .tag(3) // Index de cet onglet

                // Onglet 5 : Paramètres
                ProfileScreen(onLogout: {
                    isLoggedIn = false // Déconnecte l'utilisateur et revient à l'écran Login
                    showSplash = true // Affiche la SplashScreen après déconnexion
                })
                    .tabItem {
                        Image(systemName: selectedTab == 4 ? "gearshape.fill" : "gearshape") // Icône pour Paramètres
                        Text("Settings")
                    }
                    .tag(4) // Index de cet onglet
            }
            .accentColor(.blue) // Couleur principale de la barre (modifiable)
        } else {
            if isCreatingAccount { // Affiche la page de création de compte si nécessaire
                SignUpScreen(onSignUpComplete: {
                    isCreatingAccount = false // Retourne à l'écran de connexion après la création de compte
                })
            } else {
                // Affiche l'écran de connexion si l'utilisateur n'est pas connecté
                LoginScreen(
                    onLogin: {
                        isLoggedIn = true // Réactive la TabView après connexion
                    },
                    onSignUp: {
                        isCreatingAccount = true // Passe à l'écran de création de compte
                    }
                )
            }
        }
    }
}

// Aperçu pour Xcode
struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp() // Aperçu de l'application avec barre de navigation
    }
}
