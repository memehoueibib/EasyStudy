import SwiftUI

struct SplashScreen: View {
    var onNext: () -> Void // Closure pour passer à l'écran suivant

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                Image("splash_image") // Remplacez par votre asset d'image
                    .resizable()
                    .scaledToFit()
                    .frame(height: geometry.size.height * 0.3) // Hauteur adaptée à l'écran

                Text("Easy Study")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Connect to Learn, Share, and Succeed!")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                Spacer()

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
