//
//  AudioPlayerService.swift
//  radiotube
//
//  Created by Roxy  on 29/10/24.
//

import Foundation
import AVFoundation
import Combine

class AudioPlayerService: ObservableObject {
    static let shared = AudioPlayerService()
    private var player: AVPlayer?
    @Published var isPlaying: Bool = false

    private init() {
        let url = URL(string: Constants.stationURL)!
        player = AVPlayer(url: url)
    }

    func play() {
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }
}
