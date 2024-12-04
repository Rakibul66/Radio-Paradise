//
//  AboutUsView.swift
//  radiotube
//
//  Created by Roxy  on 29/10/24.
//


import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Logo Card
            CardView {
                Image("radio") // Replace with your image asset name
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(12)
                    .padding(16)
            }
            .padding(.horizontal, 16)

            // Description Card
            CardView {
                Text("""
                Radio Paradise is a listener-supported online radio station that brings a unique blend of music across genres, hand-picked by real humans with a deep love for music. Tune in to discover a diverse selection of tunes that go beyond the mainstream, crafted to create an immersive experience.
                
                Our mission is to provide a platform for quality music and connect listeners around the world. Thank you for being part of our community!
                """)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .padding(16)
            }
            .padding(.horizontal, 16)
            
            Spacer() // Push content upwards
        }
        .navigationTitle("About Us")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

// Reusable CardView for consistent styling
struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.8))
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 4)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutUsView()
        }
    }
}
