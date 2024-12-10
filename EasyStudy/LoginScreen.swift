import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, Welcome Back")
                .font(.title)
                .fontWeight(.bold)

            Text("Log in to start your Easy Study journey!")
                .font(.subheadline)
                .foregroundColor(.gray)

            TextField("Email Address", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            Button(action: {
                // Forgot Password Action
            }) {
                Text("Forgot Password?")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }

            Button(action: {
                // Login Action
            }) {
                Text("Login")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()

            HStack {
                Text("Or Login with")
                    .font(.footnote)
                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: "globe") // Replace with Google icon
                    Image(systemName: "applelogo") // Replace with Apple icon
                    Image(systemName: "facebook") // Replace with Facebook icon
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
