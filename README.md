# QR Code Alarm App

An iOS alarm app that requires scanning a QR code to dismiss alarms.

## Project Structure

```
QRAlarmApp/
├── QRAlarmApp.swift           # App entry point
├── Models/
│   └── Alarm.swift            # Alarm data structure
├── Managers/
│   └── AlarmManager.swift      # Handles alarms & notifications
└── Views/
    ├── ContentView.swift       # Main alarm list screen
    ├── AddAlarmView.swift      # Screen to add new alarms
    ├── AlarmRingingView.swift  # Screen when alarm goes off
    └── QRScannerView.swift     # QR code scanner component
```

## What Each File Does

### QRAlarmApp.swift
- The starting point of the app
- Sets up the AlarmManager that all views can access

### Models/Alarm.swift
- Defines the `Alarm` structure: time, label, enabled status
- This is like a "blueprint" for alarm data

### Managers/AlarmManager.swift
- Stores all alarms in memory and saves them to the phone
- Requests permission to send notifications
- Schedules notifications when alarm times arrive
- Detects when an alarm goes off and shows the ringing screen

### Views/ContentView.swift
- The main screen showing all your alarms
- Has a "+" button to add new alarms
- Shows toggle switch to enable/disable alarms

### Views/AddAlarmView.swift
- The screen that opens when you tap "+"
- Lets you pick a time and name for the alarm

### Views/AlarmRingingView.swift
- Full-screen alarm that appears when alarm time arrives
- Shows the QR code scanner
- Dismisses when you scan a QR code

### Views/QRScannerView.swift
- Handles camera access
- Uses Vision framework to detect QR codes
- Sends detected codes back to the ringing screen

## How to Run This

### First Time Setup
1. Open Xcode
2. File → Open → Select the `IOS-app-Alarm` folder
3. Select "IOS-app-Alarm" project in the left sidebar
4. Set the Bundle Identifier (Team ID) under Signing & Capabilities
5. Connect an iPhone or use the simulator

### Run the App
1. Press the Play button (▶️) or Cmd+R
2. Wait for the app to build and install

### Test It
1. Create an alarm by tapping "+"
2. Set a time 1 minute from now (for quick testing)
3. Wait for the alarm to go off
4. When the alarm rings, point your phone's camera at a QR code
5. The alarm should dismiss when QR is detected

### Set a Real Alarm
1. Create an alarm and set it to your desired time
2. Turn the toggle on to enable it
3. The app will notify you at that time (even if closed)

## Important Notes

- Alarms are saved to your phone, so they persist if you close the app
- You must grant camera permission when the app first asks
- The QR scanner works with any QR code - any scan will dismiss the alarm
- In the future, we can make it check for specific QR codes at specific locations

## Next Steps

- Add support for repeating alarms (daily, weekends, etc.)
- Add custom alarm sounds
- Add location-based QR code validation
- Add alarm history/statistics
