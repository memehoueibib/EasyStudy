import SwiftUI

struct LoginScreen: View {
    var onLogin: () -> Void
    var onSignUp: () -> Void

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email Address", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button(action: {
                Task {
                    do {
                        let successMessage = try await AuthService.shared.signIn(email: email, password: password)
                        print(successMessage)
                        onLogin()
                    } catch {
                        errorMessage = error.localizedDescription
                    }
                }
            }) {
                Text("Login")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                onSignUp()
            }) {
                Text("Don't have an account? Sign up")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(onLogin: {}, onSignUp: {})
    }
}
