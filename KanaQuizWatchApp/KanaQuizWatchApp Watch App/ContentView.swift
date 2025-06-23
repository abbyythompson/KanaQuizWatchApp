//
//  ContentView.swift
//  KanaQuizWatchApp Watch App
//
//  Created by Abby Thompson on 23.06.2025.
//

import SwiftUI


struct ContentView: View {
    @State private var showAnswer = false
    @State private var currentKana = kanaList.randomElement()!
    
    var body: some View {
        VStack {
            Text(showAnswer ? currentKana.romaji : currentKana.character)
                .font(.system(size: 48))
                .padding()
            
            if !showAnswer {
                Text("What is this \(currentKana.type)?")
            } else {
                Text("It's \"\(currentKana.romaji)\" (\(currentKana.type))")
            }
            
            Button(showAnswer ? "Next" : "Show Answer") {
                if showAnswer {
                    // Next question
                    currentKana = kanaList.randomElement()!
                    showAnswer = false
                } else {
                    showAnswer = true
                }
            }
            .padding()
        }
    }
    
    
}


#Preview {
    ContentView()
}
