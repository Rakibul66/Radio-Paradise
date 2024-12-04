import SwiftUI

struct RadioPlayerView: View {
    @ObservedObject private var viewModel = RadioViewModel()
    @State private var showMoreScreen = false

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Top-right Ball Image
            VStack {
                HStack {
                    Spacer()
                    Image("ball")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding()
                }
                Spacer()
            }
            
            // Main Content: Glassmorphic Play/Pause Button
            VStack(spacing: 20) {
                Spacer()
                Text("Live Radio Paradise")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 150, height: 150)
                        .blur(radius: 10)
                        .offset(x: -6, y: -6)
                    
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 150, height: 150)
                        .background(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.white.opacity(0.5), Color.clear]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 4
                                )
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .overlay(
                            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            viewModel.togglePlayback()
                        }
                }
                .padding()
                
                Spacer()
            }
            
            // Bottom Ice Image with "More" Button
            VStack {
                Spacer()
                Image("ice")
                    .resizable()
                    .frame(width: 130, height: 80)
                    .overlay(
                        Button(action: {
                            showMoreScreen.toggle()
                        }) {
                            Text("More")
                                .font(.headline)
                                .padding(8)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        .padding(.top, -20)
                    )
                    .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $showMoreScreen) {
            MoreScreenView()
        }
    }
}
