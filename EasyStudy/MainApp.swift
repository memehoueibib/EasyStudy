import SwiftUI // Importation du framework SwiftUI

struct MainApp: View {
    @State private var selectedTab: Int = 0 // Gère l'onglet sélectionné (index de 0 à 3)
    @State private var isLoggedIn: Bool = true // Gère l'état de connexion

    var body: some View {
        if isLoggedIn { // Affiche la TabView si l'utilisateur est connecté
            TabView(selection: $selectedTab) { // Création de la barre d'onglets
                // Onglet 1 : Accueil
                HomeScreen()
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house") // Icône pour Accueil
                        Text("Home")
                    }
                    .tag(0) // Index de cet onglet

                // Onglet 2 : Ajouter un élément
                HistoryScreen()
                    .tabItem {
                        Image(systemName: selectedTab == 1 ? "square.and.pencil.fill" : "square.and.pencil") // Icône pour Ajouter
                        Text("Add")
                    }
                    .tag(1) // Index de cet onglet

                // Onglet 3 : Notifications
                ChatScreen()
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "bell.fill" : "bell") // Icône pour Notifications
                        Text("Notifications")
                    }
                    .tag(2) // Index de cet onglet

                // Onglet 4 : Paramètres
                ProfileScreen(onLogout: {
                    isLoggedIn = false // Déconnecte l'utilisateur et revient à l'écran Login
                })
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "gearshape.fill" : "gearshape") // Icône pour Paramètres
                        Text("Settings")
                    }
                    .tag(3) // Index de cet onglet
            }
            .accentColor(.blue) // Couleur principale de la barre (modifiable)
        } else {
            // Affiche l'écran de connexion si l'utilisateur n'est pas connecté
            LoginScreen(onNext: {
                isLoggedIn = true // Réactive la TabView après connexion
            })
        }
    }
}

// Aperçu pour Xcode
struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp() // Aperçu de l'application avec barre de navigation
    }
}
