import SwiftUI

struct LoginScreen: View {
    var onLogin: () -> Void
    var onSignUp: () -> Void
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            HStack{
                // Welcome Text
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome Back")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Log in to start your Easy Study journey!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Illustration
                Image("Dayflow Sitting") // Vous pouvez remplacer par une vraie image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
            }
            .padding(.vertical)
            // Input Fields
            VStack(spacing: 20) {
                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .textInputAutocapitalization(.never) // Disable automatic capitalization
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
                    
                    


                    Spacer()
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
                    .background(Color(red: 0.58, green: 0.0, blue: 0.83)) // Violet color
                     .foregroundColor(.white) // White text
                    .cornerRadius(10)
            }

            .padding(.horizontal)
            VStack {
                Spacer() // Push content to the center vertically

                Button(action: {
                    onSignUp()
                }) {
                    Text("Don't have an account? Sign up")
                        .font(.footnote)
                        .foregroundColor(Color(red: 0.58, green: 0.0, blue: 0.83)) // Violet color
                        .fontWeight(.bold)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5) // Optional shadow for better visibility

                Spacer() // Push content to the center vertically
            }
            .padding() // Optional padding for additional spacing

        
        }
        .background(Color.white)
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(onLogin: {}, onSignUp: {})
    }
}
