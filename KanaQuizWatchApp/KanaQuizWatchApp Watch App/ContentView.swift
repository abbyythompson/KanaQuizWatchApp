//
//  ContentView.swift
//  KanaQuizWatchApp Watch App
//
//  Created by Abby Thompson on 23.06.2025.
//

import SwiftUI


struct ContentView: View {
    @State private var showAnswer = false
    @State private var quizKana: [Kana] = Array(kanaList.shuffled().prefix(5))
    @State private var currentIndex = 0
    @State private var quizComplete = false
    @State private var totalCompleted = 0
    @State private var showDoneSummary = false
    
    var body: some View {
        VStack {
            if quizComplete {
                if showDoneSummary {
                    Text("You completed \(totalCompleted) kana today!")
                        .font(.title3)
                        .padding()
                    Button("Close") {
                        // Reset everything for a new session
                        quizKana = Array(kanaList.shuffled().prefix(5))
                        currentIndex = 0
                        showAnswer = false
                        quizComplete = false
                        totalCompleted = 0
                        showDoneSummary = false
                    }
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .padding(.horizontal)
                } else {
                    Text("Quiz Complete!")
                        .font(.title3)
                        .padding()
                    VStack {
                        Button("Do 5 more") {
                            quizKana = Array(kanaList.shuffled().prefix(5))
                            currentIndex = 0
                            showAnswer = false
                            quizComplete = false
                        }
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .padding(.horizontal)
                        Button("Done") {
                            showDoneSummary = true
                        }
                        .buttonStyle(.borderless)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .padding(.horizontal)
                    }
                }
            } else {
                Text(showAnswer ? quizKana[currentIndex].romaji : quizKana[currentIndex].character)
                    .font(.system(size: 48))
                    .padding()
                
                if !showAnswer {
                    Text("What is this?")
                        .foregroundColor(.secondary)
                } else {
                    Text("It's \"\(quizKana[currentIndex].romaji)\" (\(quizKana[currentIndex].type))").foregroundColor(.secondary)
                }
                
                Button(showAnswer ? (currentIndex == 4 ? "Finish" : "Next") : "Show Answer") {
                    if showAnswer {
                        if currentIndex == 4 {
                            quizComplete = true
                            totalCompleted += 5
                        } else {
                            currentIndex += 1
                            showAnswer = false
                        }
                    } else {
                        showAnswer = true
                    }
                }
                .padding()
            }
        }
    }
    
    
}


#Preview {
    ContentView()
}
