import SwiftUI

struct SplashScreen: View {
    var onNext: () -> Void // Closure pour naviguer vers la page suivante

    var body: some View {
        VStack(spacing: 30) {
            Image("splash_image") // Remplacez "splash_image" par votre asset d'image
                .resizable()
                .scaledToFit()
                .frame(height: 250) // Hauteur de l'image
                .padding(.top, 50)

            Text("Easy Study")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Connect to Learn, Share, and Succeed!")
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: {
                onNext()
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
        .background(Color.white) // Fond blanc
        .edgesIgnoringSafeArea(.all) // Étend le fond à toute la zone visible
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(onNext: {})
    }
}
