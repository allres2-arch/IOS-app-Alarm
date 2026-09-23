import SwiftUI

struct AddAlarmView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @Binding var isPresented: Bool

    @State private var selectedTime = Date()
    @State private var label = "Alarm"
    @State private var selectedSound: AlarmSound = .classicAlarm

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Time")) {
                    DatePicker(
                        "Select Time",
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                }

                Section(header: Text("Label")) {
                    TextField("Alarm name", text: $label)
                }

                Section(header: Text("Sound")) {
                    Picker("Alarm Sound", selection: $selectedSound) {
                        ForEach(AlarmSound.allCases, id: \.self) { sound in
                            Text(sound.displayName).tag(sound)
                        }
                    }
                }
            }
            .navigationTitle("New Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        var newAlarm = Alarm(time: selectedTime, label: label, sound: selectedSound)
                        alarmManager.addAlarm(newAlarm)
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    AddAlarmView(isPresented: .constant(true))
        .environmentObject(AlarmManager())
}
