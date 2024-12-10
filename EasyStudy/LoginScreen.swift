import SwiftUI

struct LoginScreen: View {
    var onLogin: () -> Void // Closure pour gérer la connexion
    var onSignUp: () -> Void // Closure pour naviguer vers la page de création de compte

    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // Bouton retour
            HStack {
                Button(action: {
                    // Ajoutez une action ici si nécessaire
                }) {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }

            Spacer()

            Text("Hello, Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Log in to start your Easy Study journey!")
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

                Button(action: {
                    // Action pour mot de passe oublié
                }) {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                Button(action: {
                    onLogin() // Appelle la closure pour naviguer
                }) {
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()

            HStack {
                Text("Or Login with")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }

            HStack(spacing: 20) {
                Image(systemName: "globe") // Icône pour Google
                    .resizable()
                    .frame(width: 40, height: 40)

                Image(systemName: "applelogo") // Icône pour Apple
                    .resizable()
                    .frame(width: 40, height: 40)

                Image(systemName: "facebook") // Icône pour Facebook
                    .resizable()
                    .frame(width: 40, height: 40)
            }

            Spacer()

            Button(action: {
                onSignUp() // Navigue vers la page de création de compte
            }) {
                Text("Don't have an account? Sign up")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(onLogin: {}, onSignUp: {})
    }
}
