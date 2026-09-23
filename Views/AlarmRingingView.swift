import SwiftUI

struct AlarmRingingView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @State private var scanningStarted = false
    @State private var statusMessage = "Point camera at QR code"

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    Text("ALARM")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.red)

                    if let alarmID = alarmManager.activeAlarmID,
                       let alarm = alarmManager.alarms.first(where: { $0.id == alarmID }) {
                        Text(alarm.label)
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding()

                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                        .cornerRadius(16)

                    QRScannerView { qrCode in
                        handleQRCode(qrCode)
                    }
                    .frame(height: 300)
                    .cornerRadius(16)

                    VStack {
                        HStack {
                            Rectangle().fill(Color.red).frame(width: 2)
                            Spacer()
                            Rectangle().fill(Color.red).frame(width: 2)
                        }
                        Spacer()
                        HStack {
                            Rectangle().fill(Color.red).frame(width: 2)
                            Spacer()
                            Rectangle().fill(Color.red).frame(width: 2)
                        }
                    }
                    .padding(20)
                }

                Text(statusMessage)
                    .font(.body)
                    .foregroundColor(.white)

                Spacer()

                Button(action: {
                    alarmManager.dismissAlarm()
                }) {
                    Text("Dismiss")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()
            }
            .padding()
        }
    }

    private func handleQRCode(_ code: String) {
        statusMessage = "QR Detected: \(code)"
        alarmManager.dismissAlarm()
    }
}

#Preview {
    AlarmRingingView()
        .environmentObject({
            let manager = AlarmManager()
            manager.isAlarmRinging = true
            manager.activeAlarmID = UUID()
            manager.alarms = [Alarm(time: Date(), label: "Wake Up")]
            return manager
        }())
}
