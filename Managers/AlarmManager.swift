import Foundation
import UserNotifications

class AlarmManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var alarms: [Alarm] = []
    @Published var activeAlarmID: UUID? = nil
    @Published var isAlarmRinging: Bool = false

    private let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()
        loadAlarms()
        notificationCenter.delegate = self
        requestNotificationPermission()
    }

    // MARK: - Permission
    func requestNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Alarm Management
    func addAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
        saveAlarms()
        scheduleNotification(for: alarm)
    }

    func deleteAlarm(_ alarmID: UUID) {
        alarms.removeAll { $0.id == alarmID }
        saveAlarms()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [alarmID.uuidString])
    }

    func updateAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index] = alarm
            saveAlarms()
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
            scheduleNotification(for: alarm)
        }
    }

    // MARK: - Notification Scheduling
    private func scheduleNotification(for alarm: Alarm) {
        guard alarm.isEnabled else { return }

        let content = UNMutableNotificationContent()
        content.title = "Alarm: \(alarm.label)"
        content.body = "Scan QR code to dismiss"
        content.sound = .default
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)

        let components = Calendar.current.dateComponents([.hour, .minute], from: alarm.time)
        var trigger = DateComponents()
        trigger.hour = components.hour
        trigger.minute = components.minute

        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: trigger, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: notificationTrigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Alarm Dismissal
    func dismissAlarm() {
        activeAlarmID = nil
        isAlarmRinging = false
        notificationCenter.removeAllDeliveredNotifications()
    }

    // MARK: - Persistence
    private func saveAlarms() {
        if let encoded = try? JSONEncoder().encode(alarms) {
            UserDefaults.standard.set(encoded, forKey: "alarms")
        }
    }

    private func loadAlarms() {
        if let data = UserDefaults.standard.data(forKey: "alarms"),
           let decoded = try? JSONDecoder().decode([Alarm].self, from: data) {
            self.alarms = decoded
        }
    }

    // MARK: - Notification Delegate
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        DispatchQueue.main.async {
            self.activeAlarmID = UUID(uuidString: notification.request.identifier)
            self.isAlarmRinging = true
        }
        completionHandler([.banner, .sound])
    }
}
