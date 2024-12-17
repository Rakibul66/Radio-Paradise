import SwiftUI

struct MoreScreenView: View {
    @StateObject private var radioViewModel = RadioViewModel() // Create an instance

    var body: some View {
        NavigationView {
            ZStack {
                // Improved Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.purple.opacity(0.9)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("More Options")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    List {
                        MoreItemRow(title: "Website", icon: "globe") {
                            openWebsite()
                        }
                        
                        MoreItemRow(title: "Email", icon: "envelope") {
                            sendEmail()
                        }

                        MoreItemRow(title: "Rate Us", icon: "star") {
                            // Rate app function
                        }
                        
                        MoreItemRow(title: "Privacy Policy", icon: "lock") {
                            openPrivacyPolicy()
                        }
                        
                        MoreItemRow(title: "Share", icon: "square.and.arrow.up") {
                            shareApp()
                        }

                        // Navigation Link to TimerView
                        NavigationLink(destination: TimerView(radioViewModel: radioViewModel)) {
                            MoreItemRow(title: "Timer", icon: "timer") {
                                // No additional action needed, handled by NavigationLink
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .background(Color.clear)
                }
            }
        }
    }
    
    // Helper Functions (same as before)
    private func openWebsite() {
        if let url = URL(string: Constants.Links.websiteURL) {
            UIApplication.shared.open(url)
        }
    }
    
    private func sendEmail() {
        if let url = URL(string: "mailto:\(Constants.Links.emailAddress)") {
            UIApplication.shared.open(url)
        }
    }

    private func openPrivacyPolicy() {
        if let url = URL(string: Constants.Links.privacyPolicyURL) {
            UIApplication.shared.open(url)
        }
    }

    private func shareApp() {
        let activityVC = UIActivityViewController(activityItems: [Constants.Links.appShareMessage], applicationActivities: nil)
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.present(activityVC, animated: true, completion: nil)
        }
    }
}
