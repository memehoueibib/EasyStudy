import SwiftUI

struct HistoryScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("History Screen")
                    .font(.largeTitle)
                    .padding()

                // Contenu de la page "Ajouter un élément"
                Spacer()
            }
            .navigationTitle("Add Item") // Titre dans la barre de navigation
        }
    }
}

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
