import SwiftUI

struct TimerView: View {
    @State private var selectedMinutes: Int = 5
    @StateObject private var timerViewModel = TimerViewModel()
    @ObservedObject var radioViewModel: RadioViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set Timer to Stop Radio")
                .font(.title2)
                .bold()
                .padding()

            Picker("Minutes", selection: $selectedMinutes) {
                ForEach(1...60, id: \.self) { minute in
                    Text("\(minute) min").tag(minute)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: .infinity, maxHeight: 200)

            Button(action: startOrCancelTimer) {
                Text(timerViewModel.timerActive ? "Cancel Timer" : "Start Timer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(timerViewModel.timerActive ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            if timerViewModel.timerActive {
                Text("Time Remaining: \(timerViewModel.countdown) seconds")
                    .font(.body)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            timerViewModel.loadSavedTimer()
        }
    }

    private func startOrCancelTimer() {
        if timerViewModel.timerActive {
            timerViewModel.cancelTimer()
        } else {
            timerViewModel.startTimer(minutes: selectedMinutes)
        }
    }
}
