import SwiftUI

struct SignUpScreen: View {
    var onSignUpComplete: () -> Void

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

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

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button(action: {
                    Task {
                        guard password == confirmPassword else {
                            errorMessage = "Passwords do not match"
                            return
                        }

                        do {
                            let successMessage = try await AuthService.shared.signUp(email: email, password: password)
                            print(successMessage)
                            // Insertion dans la table users
                            try await AuthService.shared.insertUserEntry(name: name)
                            onSignUpComplete()
                        } catch {
                            errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
