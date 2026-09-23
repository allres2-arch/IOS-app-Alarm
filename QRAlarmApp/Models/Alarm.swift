import Foundation

struct Alarm: Identifiable, Codable {
    var id: UUID
    var time: Date
    var label: String
    var isEnabled: Bool
    var sound: AlarmSound
    var createdAt: Date

    init(time: Date, label: String = "Alarm", sound: AlarmSound = .classicAlarm) {
        self.id = UUID()
        self.time = time
        self.label = label
        self.isEnabled = true
        self.sound = sound
        self.createdAt = Date()
    }
}
