import SwiftUI

struct ContentView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @State private var showAddAlarmSheet = false

    var body: some View {
        ZStack {
            if alarmManager.isAlarmRinging {
                AlarmRingingView()
                    .transition(.move(edge: .up))
            } else {
                NavigationView {
                    List {
                        ForEach(alarmManager.alarms) { alarm in
                            AlarmRow(alarm: alarm)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    // Edit alarm
                                }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                alarmManager.deleteAlarm(alarmManager.alarms[index].id)
                            }
                        }
                    }
                    .navigationTitle("Alarms")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { showAddAlarmSheet = true }) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .sheet(isPresented: $showAddAlarmSheet) {
                        AddAlarmView(isPresented: $showAddAlarmSheet)
                    }
                }
            }
        }
        .animation(.easeInOut, value: alarmManager.isAlarmRinging)
    }
}

struct AlarmRow: View {
    @EnvironmentObject var alarmManager: AlarmManager
    let alarm: Alarm
    @State private var isOn = true

    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: alarm.time)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(timeString)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(alarm.label)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(alarm.sound.displayName)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .onChange(of: isOn) { newValue in
                    var updatedAlarm = alarm
                    updatedAlarm.isEnabled = newValue
                    alarmManager.updateAlarm(updatedAlarm)
                }
        }
        .onAppear {
            isOn = alarm.isEnabled
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AlarmManager())
}
