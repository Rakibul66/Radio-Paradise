import AVFoundation
import Combine

class AudioPlayerService: NSObject, ObservableObject {
    static let shared = AudioPlayerService()
    private var player: AVPlayer?
    @Published var isPlaying: Bool = false
    @Published var errorMessage: String? // Publish error messages

    private override init() {
        super.init()
        let url = URL(string: Constants.stationURL)!
        player = AVPlayer(url: url)

        // Observe the player's status
        player?.addObserver(self, forKeyPath: "status", options: [.new, .initial], context: nil)
    }

    func play() {
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    deinit {
        player?.removeObserver(self, forKeyPath: "status")
    }

    // Handle AVPlayer status changes
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status", let player = object as? AVPlayer {
            switch player.status {
            case .failed:
                errorMessage = player.error?.localizedDescription ?? "Unknown playback error"
                isPlaying = false
            case .readyToPlay:
                errorMessage = nil // Reset error when ready to play
            default:
                break
            }
        }
    }
}
