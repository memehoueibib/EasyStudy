import SwiftUI

struct SignUpScreen: View {
    var onSignUpComplete: () -> Void // Closure pour revenir à la page de connexion

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Sign up to start your Easy Study journey!")
                .font(.subheadline)
                .foregroundColor(.gray)

            VStack(spacing: 20) {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                // Action pour finaliser l'inscription
                onSignUpComplete() // Navigue vers la page de connexion
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen(onSignUpComplete: {})
    }
}
