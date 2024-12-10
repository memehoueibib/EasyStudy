import SwiftUI

struct ChatScreen: View {
    @State private var reply: String = "" // Réponse de l'utilisateur
    @State private var messages: [String] = ["How does SwiftUI work?", "Can you explain @State and @Binding?"] // Messages existants

    var body: some View {
        VStack {
            Text("Chat")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Liste des messages existants
            List(messages, id: \.self) { message in
                VStack(alignment: .leading, spacing: 10) {
                    Text("Message:")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Text(message)
                        .font(.body)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding(.vertical, 5)
            }

            Spacer()

            // Zone pour répondre à un message
            HStack {
                TextField("Type your reply...", text: $reply)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                Button(action: {
                    if !reply.isEmpty {
                        messages.append(reply) // Ajoute la réponse comme nouveau message
                        reply = "" // Réinitialise le champ texte
                    }
                }) {
                    Image(systemName: "paperplane.fill") // Icône pour envoyer
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
