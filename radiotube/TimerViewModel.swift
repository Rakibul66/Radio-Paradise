import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var countdown: Int = 0
    @Published var timerActive: Bool = false
    
    private var timer: DispatchSourceTimer?
    private let timerEndKey = "timerEndTime"
    private let timerActiveKey = "timerActive"
    
    func startTimer(minutes: Int) {
        countdown = minutes * 60
        let endTime = Date().addingTimeInterval(TimeInterval(countdown))
        
        UserDefaults.standard.set(endTime, forKey: timerEndKey)
        UserDefaults.standard.set(true, forKey: timerActiveKey)
        
        timerActive = true
        startCountdownTimer()
    }
    
    func cancelTimer() {
        timer?.cancel()
        timer = nil
        timerActive = false
        countdown = 0
        
        UserDefaults.standard.removeObject(forKey: timerEndKey)
        UserDefaults.standard.set(false, forKey: timerActiveKey)
    }
    
    private func startCountdownTimer() {
        timer?.cancel() // Cancel any existing timer
        let newTimer = DispatchSource.makeTimerSource()
        newTimer.schedule(deadline: .now(), repeating: 1)
        newTimer.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.updateCountdown()
            }
        }
        timer = newTimer
        newTimer.resume()
    }
    
    private func updateCountdown() {
        let endTime = UserDefaults.standard.object(forKey: timerEndKey) as? Date ?? Date()
        countdown = Int(endTime.timeIntervalSinceNow)
        
        if countdown <= 0 {
            stopTimer()
        }
    }
    
    private func stopTimer() {
        cancelTimer()
        print("Timer ended.")
    }
    
    func loadSavedTimer() {
        let savedEndTime = UserDefaults.standard.object(forKey: timerEndKey) as? Date ?? Date()
        let savedActive = UserDefaults.standard.bool(forKey: timerActiveKey)
        
        if savedActive && savedEndTime > Date() {
            countdown = Int(savedEndTime.timeIntervalSinceNow)
            timerActive = true
            startCountdownTimer()
        }
    }
}
