import SwiftUI

struct HomeScreen: View {
    @State private var searchText: String = "" // Texte de la barre de recherche
    @State private var selectedCategory: Int = 0 // Gère l'onglet sélectionné dans les catégories

    // Exemple de données pour les discussions récentes
    let discussions = [
        ("Robert Fox (JS)", "Hey, let’s talk about react", "15.43"),
        ("Esther Howard (PHP)", "Hey, let’s talk about Symphony", "15.29"),
        ("Jacob Jones (HTML)", "Hey, let’s talk about html", "14.53"),
        ("Bessie Cooper (CSS)", "Hey, let’s talk about SCSS", "12.27"),
        ("Albert Flores (Python)", "Hey, let’s talk about Django", "12.20"),
        ("Floyd Miles (SQL)", "Hey, let’s talk about SQL", "11.40")
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Barre de recherche
                HStack {
                    TextField("Search Topics or Questions", text: $searchText)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        )

                    Button(action: {
                        // Action pour scanner ou ajouter une fonctionnalité
                    }) {
                        Image(systemName: "viewfinder")
                            .foregroundColor(.blue)
                            .font(.title2)
                            .padding()
                    }
                }
                .padding(.horizontal)

                // Onglets des catégories
                HStack(spacing: 30) {
                    Button(action: {
                        selectedCategory = 0
                    }) {
                        VStack {
                            Text("Recent Questions")
                                .font(.headline)
                                .foregroundColor(selectedCategory == 0 ? .blue : .gray)
                            if selectedCategory == 0 {
                                Capsule()
                                    .fill(Color.blue)
                                    .frame(width: 100, height: 3)
                            }
                        }
                    }

                    Button(action: {
                        selectedCategory = 1
                    }) {
                        VStack {
                            Text("My Discussions")
                                .font(.headline)
                                .foregroundColor(selectedCategory == 1 ? .blue : .gray)
                            if selectedCategory == 1 {
                                Capsule()
                                    .fill(Color.blue)
                                    .frame(width: 100, height: 3)
                            }
                        }
                    }

                    Button(action: {
                        selectedCategory = 2
                    }) {
                        VStack {
                            Text("Categories")
                                .font(.headline)
                                .foregroundColor(selectedCategory == 2 ? .blue : .gray)
                            if selectedCategory == 2 {
                                Capsule()
                                    .fill(Color.blue)
                                    .frame(width: 80, height: 3)
                            }
                        }
                    }
                }

                // Liste des discussions récentes
                List(discussions, id: \.0) { discussion in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(discussion.0)
                                .font(.headline)
                                .fontWeight(.bold)

                            Text(discussion.1)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Text(discussion.2)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
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
