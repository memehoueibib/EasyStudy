import SwiftUI

struct NotificationScreen: View {
    @State private var notifications: [String] = [
        "Your profile was updated successfully.",
        "You have a new message from John.",
        "Don't forget to complete your profile.",
        "A new category was added by the admin."
    ] // Liste de notifications fictives

    var body: some View {
        NavigationView {
            VStack {
                if notifications.isEmpty {
                    Text("No notifications available")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(notifications, id: \.self) { notification in
                        HStack {
                            Image(systemName: "bell")
                                .foregroundColor(.blue) // Icône de notification
                                .padding(.trailing, 10)

                            Text(notification)
                                .font(.body)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline) // Titre compact
        }
    }
}

struct NotificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationScreen()
    }
}
