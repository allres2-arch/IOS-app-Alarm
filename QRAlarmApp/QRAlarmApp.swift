import SwiftUI

@main
struct QRAlarmApp: App {
    @StateObject var alarmManager = AlarmManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(alarmManager)
        }
    }
}
