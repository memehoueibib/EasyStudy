import SwiftUI

struct SignUpScreen: View {
    var onSignUpComplete: () -> Void
    var onRetour: () -> Void // Callback for Retour button action

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Fill in the form below to create your account. Make sure all fields are correctly filled.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    // Name Field
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    // Email Field
                    TextField("Email Address", text: $email)
                        .padding()
                        .textInputAutocapitalization(.never) // Disable automatic capitalization
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    // Password Field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    // Confirm Password Field
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    // Error Message
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }

                    // Sign Up Button
                    Button(action: {
                        Task {
                            guard password == confirmPassword else {
                                errorMessage = "Passwords do not match"
                                return
                            }

                            do {
                                let successMessage = try await AuthService.shared.signUp(email: email, password: password)
                                print(successMessage)
                                try await AuthService.shared.insertUserEntry(name: name)
                                
                                showAlert = true // Show the alert
                            } catch {
                                errorMessage = error.localizedDescription
                            }
                        }
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.58, green: 0.0, blue: 0.83))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .alert("Account Created", isPresented: $showAlert) {
                        Button("OK") {
                            onSignUpComplete() // Redirect only after user acknowledges the alert
                        }
                    } message: {
                        Text("Your account was created successfully!")
                    }

                    Spacer()

                    // Retour Button
                    Button(action: {
                        onRetour() // Go back to the previous screen
                    }) {
                        Text("Retour")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Sign Up", displayMode: .inline)
        }
    }
}
