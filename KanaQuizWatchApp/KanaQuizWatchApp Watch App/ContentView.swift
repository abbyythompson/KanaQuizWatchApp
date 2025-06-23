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
    
    var body: some View {
        VStack {
            if quizComplete {
                Text("Quiz Complete!")
                    .font(.title2)
                    .padding()
                Button("Done") {
                    // Reset quiz for next time
                    quizKana = Array(kanaList.shuffled().prefix(5))
                    currentIndex = 0
                    showAnswer = false
                    quizComplete = false
                }
                .padding()
            } else {
                Text(showAnswer ? quizKana[currentIndex].romaji : quizKana[currentIndex].character)
                    .font(.system(size: 48))
                    .padding()
                
                if !showAnswer {
                    Text("What is this \(quizKana[currentIndex].type)?")
                } else {
                    Text("It's \"\(quizKana[currentIndex].romaji)\" (\(quizKana[currentIndex].type))")
                }
                
                Button(showAnswer ? (currentIndex == 4 ? "Finish" : "Next") : "Show Answer") {
                    if showAnswer {
                        if currentIndex == 4 {
                            quizComplete = true
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
