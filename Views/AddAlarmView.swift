import SwiftUI

struct AddAlarmView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @Binding var isPresented: Bool

    @State private var selectedTime = Date()
    @State private var label = "Alarm"

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
                        var newAlarm = Alarm(time: selectedTime, label: label)
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
