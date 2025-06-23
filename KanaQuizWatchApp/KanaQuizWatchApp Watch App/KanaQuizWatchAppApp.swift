//
//  KanaQuizWatchAppApp.swift
//  KanaQuizWatchApp Watch App
//
//  Created by Abby Thompson on 23.06.2025.
//

import SwiftUI
import UserNotifications

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
        // Handle granted or error if needed
    }
}

func scheduleRandomQuizNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Kana Quiz Time!"
    content.body = "Tap to test your kana knowledge."
    content.sound = .default

    // Schedule for a random time in the next 12 hours (for example)
    let randomMinutes = Int.random(in: 1...60*12)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(randomMinutes * 60), repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
}

@main
struct KanaQuizWatchApp_Watch_AppApp: App {
    @Environment(\.scenePhase) var scenePhase

    init() {
        requestNotificationPermission()
        scheduleRandomQuizNotification()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Optional: Schedule more notifications here if needed
                }
        }
        .onChange(of:scenePhase) { phase in
            if phase == .active {
                // App has become active, maybe show quiz
            }
        }
    }
}
