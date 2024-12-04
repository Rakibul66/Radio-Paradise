import SwiftUI

struct MoreItemRow: View {
    var title: String
    var icon: String
    var action: () -> Void // Action closure that does not return anything

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.purple)
                .font(.title2) // Slightly smaller for better proportion
            Text(title)
                .foregroundColor(.white)
                .font(.headline) // Consistent font style
                .padding(.leading, 8) // Add space between icon and text
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.3))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // Enhanced shadow for depth
        )
        .onTapGesture {
            withAnimation {
                action() // Call the action with animation
            }
        }
        .accessibilityLabel(title) // Add accessibility label
        .scaleEffect(1.0) // Default scale effect
        .onTapGesture {
            withAnimation(.spring()) {
                // Animation for tap feedback
                scaleEffect(0.95)
            }
        }
        .onAppear {
            scaleEffect(1.0)
        }
    }
}
