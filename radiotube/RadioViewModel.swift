import Foundation
import Combine
import SwiftUI

class RadioViewModel: ObservableObject {
    @Published var isPlaying = false
    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable? // Holds the timer subscription

    init() {
        AudioPlayerService.shared.$isPlaying
            .receive(on: RunLoop.main)
            .assign(to: \.isPlaying, on: self)
            .store(in: &cancellables)
    }

    // Start playback with a timer
    func playWithTimer(duration: TimeInterval) {
        togglePlayback() // Start playback

        // Schedule a timer to stop playback after the duration
        timer = Timer.publish(every: duration, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.stopPlayback()
                self?.timer?.cancel() // Cancel the timer after stopping playback
            }
    }

    func stopPlayback() {
        AudioPlayerService.shared.pause()
        isPlaying = false
        timer?.cancel() // Cancel the timer when stopping playback manually
    }

    func togglePlayback() {
        if isPlaying {
            stopPlayback()
        } else {
            AudioPlayerService.shared.play()
        }
    }
}
