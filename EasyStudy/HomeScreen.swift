import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
                    .font(.largeTitle)
                    .padding()

                // Contenu de la page d'accueil
                Spacer()
            }
            .navigationTitle("Home") // Titre dans la barre de navigation
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
