//
//  SplashScreenView.swift
//  radiotube
//
//  Created by Roxy  on 29/10/24.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    @State private var showMainView = false
    
    var body: some View {
        if showMainView {
            // Transition to Main App View
            RadioPlayerView()
        } else {
            // Splash Screen with Animation
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // Logo Animation
                VStack {
                    Image(systemName: "music.note.house.fill") // Replace with your logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .scaleEffect(isAnimating ? 1 : 0.5)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 1.2), value: isAnimating)
                        .onAppear {
                            isAnimating = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showMainView = true
                                }
                            }
                        }
                    
                    Text("Radio Paradise")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 1.2).delay(0.5), value: isAnimating)
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
