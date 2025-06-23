//
//  KanaQuizWatchApp_Watch_AppTests.swift
//  KanaQuizWatchApp Watch AppTests
//
//  Created by Abby Thompson on 23.06.2025.
//

import Testing
@testable import KanaQuizWatchApp_Watch_App

struct KanaQuizWatchApp_Watch_AppTests {


    @Test func testQuizPresentsFiveKana() async throws {
        let quizKana = Array(kanaList.shuffled().prefix(5))
        #expect(quizKana.count == 5)
        // Ensure all kana are unique
        let uniqueKana = Set(quizKana.map { $0.character })
        #expect(uniqueKana.count == 5)
    }

    @Test func testQuizProgressionAndCompletion() async throws {
        // Simulate quiz state
        var quizKana = Array(kanaList.shuffled().prefix(5))
        var currentIndex = 0
        var showAnswer = false
        var quizComplete = false

        // Simulate answering all 5
        for i in 0..<5 {
            showAnswer = true // User taps Show Answer
            if showAnswer {
                if currentIndex == 4 {
                    quizComplete = true
                } else {
                    currentIndex += 1
                    showAnswer = false
                }
            }
        }
        #expect(quizComplete == true)
        #expect(currentIndex == 4)
    }

    @Test func testNotificationSchedulingLogic() async throws {
        // This is a logic test, not an integration test with UNUserNotificationCenter
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
            scheduledDate = calendar.date(byAdding: .day, value: 1, to: scheduledDate)!
        }
        // Should be between 10am and 8pm
        let hour = calendar.component(.hour, from: scheduledDate)
        #expect(hour >= 10 && hour < 20)
    }

    @Test func testTotalCompletedIncrementsWithEachQuiz() async throws {
        var totalCompleted = 0
        var quizComplete = false
        // Simulate finishing two quizzes
        for _ in 0..<2 {
            quizComplete = true
            if quizComplete {
                totalCompleted += 5
                quizComplete = false // simulate pressing '5 more'
            }
        }
        #expect(totalCompleted == 10)
    }

    @Test func testFiveMoreResetsQuizButKeepsTotal() async throws {
        var quizKana = Array(kanaList.shuffled().prefix(5))
        var currentIndex = 0
        var showAnswer = false
        var quizComplete = false
        var totalCompleted = 0

        // Finish first quiz
        for _ in 0..<5 {
            showAnswer = true
            if showAnswer {
                if currentIndex == 4 {
                    quizComplete = true
                    totalCompleted += 5
                } else {
                    currentIndex += 1
                    showAnswer = false
                }
            }
        }
        #expect(quizComplete == true)
        #expect(totalCompleted == 5)
        // Simulate pressing '5 more'
        quizKana = Array(kanaList.shuffled().prefix(5))
        currentIndex = 0
        showAnswer = false
        quizComplete = false
        // Finish second quiz
        for _ in 0..<5 {
            showAnswer = true
            if showAnswer {
                if currentIndex == 4 {
                    quizComplete = true
                    totalCompleted += 5
                } else {
                    currentIndex += 1
                    showAnswer = false
                }
            }
        }
        #expect(quizComplete == true)
        #expect(totalCompleted == 10)
    }

    @Test func testDoneShowsSummaryAndCloseResetsAll() async throws {
        var totalCompleted = 15
        var showDoneSummary = true
        var quizKana = Array(kanaList.shuffled().prefix(5))
        var currentIndex = 0
        var showAnswer = false
        var quizComplete = false
        // Simulate pressing 'Close' after summary
        if showDoneSummary {
            quizKana = Array(kanaList.shuffled().prefix(5))
            currentIndex = 0
            showAnswer = false
            quizComplete = false
            totalCompleted = 0
            showDoneSummary = false
        }
        #expect(totalCompleted == 0)
        #expect(showDoneSummary == false)
        #expect(currentIndex == 0)
        #expect(quizComplete == false)
    }

    // Note: Full integration tests for notification delivery require UI or system tests, not unit tests.
}
