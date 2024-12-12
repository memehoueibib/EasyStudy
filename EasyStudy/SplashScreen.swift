import SwiftUI

struct SplashScreen: View {
    var onNext: () -> Void // Closure pour passer à l'écran suivant

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() // Espace pour centrer le contenu verticalement
                
                VStack(spacing: 15) {
                    // Titre principal
                    Text("Easy Study")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Sous-titre
                    Text("Connect to learn, share, and succeed")
                        .font(.body)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                // Image
                Image("Dayflow Best Friends")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width * 0.8) // Limiter la taille de l'image
                    .padding(.vertical, 10)
                    .padding(.top, 50)
                
                // Barre horizontale et trois points
                HStack {
                    Spacer()
                    Image("barre-verticale")
                        .resizable()
                        .rotationEffect(.degrees(90))
                        .frame(width: 30, height: 30)
                    
                    Image("trois-points")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Spacer()
                }
                .padding(.vertical, 10)
                
                Spacer() // Ajoute un espace pour pousser le bouton vers le bas

                // Bouton "Get Started"
                Button(action: {
                    onNext() // Navigue vers LoginScreen
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height) // Ajuste à l'écran
            .background(Color.white) // Fond blanc
            .edgesIgnoringSafeArea(.all) // Étend le fond à toute la zone visible
        }
    }
}
