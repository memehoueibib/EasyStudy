import SwiftUI

struct HistoryScreen: View {
    @State private var categoryName: String = "" // Nom de la nouvelle catégorie
    @State private var categories: [String] = ["SwiftUI", "iOS Development", "UI Design"] // Liste des catégories existantes

    var body: some View {
        VStack(spacing: 20) {
            Text("Add Category")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Champ pour saisir une nouvelle catégorie
            TextField("Enter category name", text: $categoryName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            // Bouton pour ajouter la catégorie
            Button(action: {
                if !categoryName.isEmpty {
                    categories.append(categoryName) // Ajoute la catégorie
                    categoryName = "" // Réinitialise le champ texte
                }
            }) {
                Text("Add Category")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // Liste des catégories existantes
            List(categories, id: \.self) { category in
                Text(category)
            }
        }
        .padding()
    }
}

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
