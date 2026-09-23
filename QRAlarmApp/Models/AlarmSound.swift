import Foundation

enum AlarmSound: String, Codable, CaseIterable {
    case classicAlarm = "Classic Alarm"
    case chime = "Chime"
    case digital = "Digital"
    case echo = "Echo"
    case glass = "Glass"
    case modern = "Modern"
    case openingTheme = "Opening Theme"
    case scifi = "Sci-Fi"
    case sudden = "Sudden"
    case upUpUp = "Up Up Up"

    var systemSoundName: String {
        switch self {
        case .classicAlarm: return "alarm"
        case .chime: return "chime"
        case .digital: return "digital_alarm"
        case .echo: return "echo"
        case .glass: return "glass"
        case .modern: return "modern_alarm"
        case .openingTheme: return "opening_theme"
        case .scifi: return "sci_fi_alarm"
        case .sudden: return "sudden"
        case .upUpUp: return "up_up_up"
        }
    }

    var displayName: String {
        self.rawValue
    }
}
