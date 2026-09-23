import Foundation

struct Alarm: Identifiable, Codable {
    var id: UUID
    var time: Date
    var label: String
    var isEnabled: Bool
    var createdAt: Date

    init(time: Date, label: String = "Alarm") {
        self.id = UUID()
        self.time = time
        self.label = label
        self.isEnabled = true
        self.createdAt = Date()
    }
}
