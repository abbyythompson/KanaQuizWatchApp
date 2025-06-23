//
//  KanaQuizWatchAppApp.swift
//  KanaQuizWatchApp Watch App
//
//  Created by Abby Thompson on 23.06.2025.
//

import SwiftUI
import UserNotifications

// Request notification permissions from the user
func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
        if let error = error {
            print("Notification permission error: \(error.localizedDescription)")
        } else {
            print("Notification permission granted: \(granted)")
        }
    }
}

// Check if a quiz notification is already scheduled
func isQuizNotificationScheduled(completion: @escaping (Bool) -> Void) {
    UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
        let exists = requests.contains { $0.content.title == "Kana Quiz Time!" }
        completion(exists)
    }
}

// Schedule a notification for a random time between 10am and 8pm
func scheduleRandomQuizNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Kana Quiz Time!"
    content.body = "Can you recall the meaning of 5 random kana? Tap to take the quiz!"
    content.sound = .default

    // Calculate a random time between 10am and 8pm today (or tomorrow if past 8pm)
    let calendar = Calendar.current
    let now = Date()
    var components = calendar.dateComponents([.year, .month, .day], from: now)
    let startHour = 10
    let endHour = 20
    let randomHour = Int.random(in: startHour..<endHour)
    let randomMinute = Int.random(in: 0..<60)
    components.hour = randomHour
    components.minute = randomMinute
    components.second = 0
    var scheduledDate = calendar.date(from: components)!
    if scheduledDate < now {
        // If the random time is earlier than now, schedule for tomorrow
        scheduledDate = calendar.date(byAdding: .day, value: 1, to: scheduledDate)!
    }
    let triggerDate = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: scheduledDate)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Failed to schedule notification: \(error.localizedDescription)")
        } else {
            print("Quiz notification scheduled for \(scheduledDate)")
        }
    }
}

@main
struct KanaQuizWatchApp_Watch_AppApp: App {
    @Environment(\.scenePhase) var scenePhase

    init() {
        // Request notification permissions on app launch
        requestNotificationPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Only schedule a quiz notification if one isn't already pending
                    isQuizNotificationScheduled { exists in
                        if !exists {
                            scheduleRandomQuizNotification()
                        } else {
                            print("Quiz notification already scheduled.")
                        }
                    }
                }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                // App became active; add logic here if you want to refresh state or reschedule notifications
            }
        }
    }
}
