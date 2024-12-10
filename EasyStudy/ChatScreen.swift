import SwiftUI

struct ChatScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Notifications")
                    .font(.largeTitle)
                    .padding()

                // Contenu des notifications ou messages
                Spacer()
            }
            .navigationTitle("Notifications") // Titre dans la barre de navigation
        }
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
