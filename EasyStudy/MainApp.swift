import SwiftUI

struct MainApp: View {
    @State private var selectedTab: Int = 0
    @State private var isLoggedIn: Bool = false
    @State private var isCreatingAccount: Bool = false
    @State private var showSplash: Bool = true

    var body: some View {
        if showSplash {
            SplashScreen(onNext: {
                showSplash = false
            })
        } else if isLoggedIn {
            TabView(selection: $selectedTab) {
                // Home Tab
                HomeScreen()
                    .tabItem {
                        CustomTabItem(icon: "house", text: "Home", isSelected: selectedTab == 0)
                    }
                    .tag(0)

                // Chat Tab
                ChatScreen()
                    .tabItem {
                        CustomTabItem(icon: "bubble.left", text: "Chat", isSelected: selectedTab == 2)
                    }
                    .tag(2)

                // Notifications Tab
                NotificationScreen()
                    .tabItem {
                        CustomTabItem(icon: "bell", text: "Notifications", isSelected: selectedTab == 3)
                    }
                    .tag(3)

                // Profile Tab
                ProfileScreen(onLogout: {
                    isLoggedIn = false
                    showSplash = true
                })
                    .tabItem {
                        CustomTabItem(icon: "gearshape", text: "Settings", isSelected: selectedTab == 4)
                    }
                    .tag(4)
            }
            .accentColor(Color(red: 0.58, green: 0.0, blue: 0.83)) // Accent color for selected TabItem
        } else {
            if isCreatingAccount {
                SignUpScreen(onSignUpComplete: {
                    isCreatingAccount = false
                }, onRetour: {
                    isCreatingAccount = false
                })
            } else {
                LoginScreen(
                    onLogin: {
                        isLoggedIn = true
                    },
                    onSignUp: {
                        isCreatingAccount = true
                    }
                )
            }
        }
    }
}

// Custom Tab Item
struct CustomTabItem: View {
    let icon: String
    let text: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Image(systemName: isSelected ? "\(icon).fill" : icon)
                .font(.title2)
                .foregroundColor(isSelected ? Color(red: 0.58, green: 0.0, blue: 0.83) : .gray)

            Text(text)
                .font(.caption)
                .foregroundColor(isSelected ? Color(red: 0.58, green: 0.0, blue: 0.83) : .gray)
        }
    }
}

struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp()
    }
}
