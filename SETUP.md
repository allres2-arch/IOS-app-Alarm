# How to Create and Run the App (Step by Step)

## What You Have
You have the **source code** for the app. Now you need to create an Xcode project to package it into an iOS app.

## Step 1: Download and Open Xcode
1. Open **App Store** on your Mac
2. Search for **Xcode**
3. Click Install (it's large, ~15GB)
4. Wait for it to finish

## Step 2: Create a New Project in Xcode

1. Open **Xcode**
2. Click **File** → **New** → **Project**
3. Select **iOS** tab at the top
4. Select **App** template
5. Click **Next**

## Step 3: Configure Your Project

Fill in these values:

| Field | Value |
|-------|-------|
| Product Name | `QRAlarmApp` |
| Team | *(Select your Apple ID)* |
| Organization Identifier | `com.yourname` |
| Bundle Identifier | *(Auto-fills)* |
| Interface | **SwiftUI** |
| Language | **Swift** |
| Project Template | **None** |

Click **Next** → Choose where to save → Click **Create**

## Step 4: Delete the Default Code

Xcode creates a default "Hello World" file. We need to delete it:

1. In the left sidebar, find `ContentView.swift`
2. Right-click it → **Delete** → **Remove Reference**
3. Repeat for any other `.swift` files Xcode created

## Step 5: Copy Your Code Files

Now copy the code files from this folder into your Xcode project:

1. **Open Finder**
2. Navigate to `/home/user/IOS-app-Alarm/QRAlarmApp`
3. Select all folders: `Models`, `Managers`, `Views`, and `QRAlarmApp.swift`
4. **Copy** them (Cmd+C)

5. **Go back to Xcode**
6. In the left sidebar, right-click your project name → **Add Files to...**
7. Select the folder you just copied
8. Make sure **Copy items if needed** is checked
9. Click **Add**

## Step 6: Set Up Permissions

The app needs permission to use your camera. Set this up:

1. In Xcode, click your project in the left sidebar
2. Select **QRAlarmApp** target
3. Click **Info** tab
4. Look for **Camera Usage Description** 
5. If not there, click the **+** button at the bottom and add:
   - Key: `NSCameraUsageDescription`
   - Value: `This app needs camera access to scan QR codes to dismiss alarms.`

## Step 7: Run the App

1. At the top of Xcode, make sure you see **QRAlarmApp** and **iPhone 15 Pro** (or another device)
2. Press the **Play button** (▶️) or **Cmd+R**
3. Wait for the app to build and install on the simulator

## Troubleshooting

**"File not found" errors?**
- Make sure all the files were copied into the Xcode project

**"Camera permission" errors?**
- Check that you added the NSCameraUsageDescription in Info.plist

**Build fails?**
- Click **Product** → **Clean Build Folder** (Shift+Cmd+K)
- Then try running again

## Testing the App

Once it opens:

1. **Create an alarm:**
   - Tap the **+** button
   - Choose a time (set it 1 minute from now for quick testing)
   - Tap **Save**

2. **Wait for it to ring:**
   - The alarm will appear at that time
   - A notification will show

3. **Dismiss it:**
   - Point your camera at any QR code
   - The app detects it and dismisses the alarm

4. **Success!** 🎉

## What Happens Next

Once this is running:
- You can test adding multiple alarms
- Toggle them on/off
- The app saves alarms even if you close it

## Questions?

If something doesn't work, let me know the error message and I can help fix it!
