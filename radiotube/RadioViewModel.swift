//
//  RadioViewModel.swift
//  radiotube
//
//  Created by Roxy on 29/10/24.
//

import Foundation
import Combine

class RadioViewModel: ObservableObject {
    @Published var isPlaying = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        AudioPlayerService.shared.$isPlaying
            .receive(on: RunLoop.main)
            .assign(to: \.isPlaying, on: self)
            .store(in: &cancellables)
    }

    func togglePlayback() {
        if isPlaying {
            AudioPlayerService.shared.pause()
        } else {
            AudioPlayerService.shared.play()
        }
    }

    // Method to stop playback when the timer ends
    func stopPlayback() {
        AudioPlayerService.shared.pause()
        isPlaying = false
    }
}
