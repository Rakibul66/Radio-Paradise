import SwiftUI

struct TimerView: View {
    @State private var selectedMinutes: Int = 5
    @State private var countdown: Int = 0
    @State private var timerActive: Bool = false
    @State private var timer: Timer? = nil

    // UserDefaults keys
    private let timerEndKey = "timerEndTime"
    private let timerActiveKey = "timerActive"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set Timer to Stop Radio")
                .font(.title2)
                .bold()
                .padding()

            // Time Picker
            Picker("Minutes", selection: $selectedMinutes) {
                ForEach(1...60, id: \.self) { minute in
                    Text("\(minute) min").tag(minute)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: .infinity, maxHeight: 200)

            Button(action: startOrCancelTimer) {
                Text(timerActive ? "Cancel Timer" : "Start Timer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(timerActive ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            if timerActive {
                Text("Time Remaining: \(countdown) seconds")
                    .font(.body)
            }
            
            Spacer()
        }
        .padding()
        .onAppear(perform: loadSavedTimer) // Load timer when view appears
        .onDisappear { saveCountdownState() } // Save state on leaving screen
    }

    // Start or Cancel the Timer
    private func startOrCancelTimer() {
        if timerActive {
            cancelTimer()
        } else {
            startTimer()
        }
    }
    
    // Start the timer and save end time
    private func startTimer() {
        countdown = selectedMinutes * 60
        let endTime = Date().addingTimeInterval(TimeInterval(countdown))
        
        // Save end time and active status
        UserDefaults.standard.set(endTime, forKey: timerEndKey)
        UserDefaults.standard.set(true, forKey: timerActiveKey)
        
        timerActive = true
        startCountdownTimer()
    }
    
    // Resume countdown if timer is active and update countdown every second
    private func startCountdownTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateCountdown()
        }
    }

    // Update countdown and stop when time expires
    private func updateCountdown() {
        let endTime = UserDefaults.standard.object(forKey: timerEndKey) as? Date ?? Date()
        countdown = Int(endTime.timeIntervalSinceNow)
        
        if countdown <= 0 {
            stopRadio()
            cancelTimer()
        }
    }

    // Stop the timer and reset the values
    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
        timerActive = false
        countdown = 0
        
        // Clear saved timer data
        UserDefaults.standard.removeObject(forKey: timerEndKey)
        UserDefaults.standard.set(false, forKey: timerActiveKey)
    }

    // Load the timer if it was active before
    private func loadSavedTimer() {
        let savedEndTime = UserDefaults.standard.object(forKey: timerEndKey) as? Date ?? Date()
        let savedActive = UserDefaults.standard.bool(forKey: timerActiveKey)
        
        if savedActive && savedEndTime > Date() {
            countdown = Int(savedEndTime.timeIntervalSinceNow)
            timerActive = true
            startCountdownTimer()
        }
    }
    
    // Save the countdown state in UserDefaults on screen exit
    private func saveCountdownState() {
        if timerActive {
            UserDefaults.standard.set(true, forKey: timerActiveKey)
        }
    }

    // Function to stop or pause the radio playback
    private func stopRadio() {
        // Add code to stop or pause the radio here
        print("Radio stopped after \(selectedMinutes) minutes.")
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
