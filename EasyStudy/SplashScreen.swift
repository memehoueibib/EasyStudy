import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.3.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()

            Text("Easy Study")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Connect to Learn, Share, and Succeed!")
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: {
                // Navigation to Login Screen
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
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
