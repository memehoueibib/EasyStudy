import SwiftUI

struct LoginScreen: View {
    var onLogin: () -> Void
    var onSignUp: () -> Void

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 30) {
            // Back button
//            HStack {
//                Button(action: {
//                    // Action pour revenir en arrière
//                }) {
//                    Image(systemName: "arrow.left")
//                        .font(.title2)
//                        .foregroundColor(.black)
//                }
//                Spacer()
//            }
//            .padding()
            
            Spacer()
            
            HStack{
                // Welcome Text
                VStack(alignment: .leading, spacing: 5) {
                    Text("Hello, Welcome Back")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Log in to start your Easy Study journey!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Illustration
                Image("Dayflow Sitting") // Vous pouvez remplacer par une vraie image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }

                    // Input Fields
                    VStack(spacing: 20) {
                        TextField("Email Address", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )

                        Button(action: {
                            // Forgot Password Action
                        }) {
                            Text("Forgot Password")
                                .font(.footnote)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal)

                    // Login Button
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
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
            }
        }

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(onLogin: {}, onSignUp: {})
    }
}
