//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Игорь Верхов on 31.07.2023.
//

import SwiftUI

struct ContentView: View {
    var variants = ["🧱", "📄", "✂️"].shuffled()
    let shouldWin = ["🎉", "👎"].shuffled()

    @State private var currentVariant = Int.random(in: 0..<3)
    @State private var currentShouldWin = Int.random(in: 0..<2)
    
    @State private var score = 0
    @State private var round = 1
    
    @State private var showingEndGame = false
    @State private var gameOver = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("Title Game")
                .font(.system(size: 50))
            HStack {
                Text("Round: \(round)")
                Spacer()
                Text("Your score: \(score)")
            }
            .font(.title2 .weight(.light))
            .padding()
            Spacer()
            HStack(spacing: 40) {
                Text(variants[currentVariant])
                    .font(.system(size: 150))
                Text(shouldWin[currentShouldWin])
                    .font(.system(size: 100))
            }
            
            Spacer()
            Spacer()
            HStack(spacing: 20) {
                ForEach(variants.shuffled(), id: \.self) { variant in
                    Button {
                        checkAnswer(variant)
                    } label: {
                        Text(variant)
                            .font(.system(size: 80))
                    }
                }
            }
            Spacer()
        }
        .alert("Game is ended", isPresented: $showingEndGame) {
            Button("New game", action: reset)
            Button("OK") { }
        } message: {
            Text("You score: \(score)")
        }
        .padding()
        
    }
    
    
    func checkAnswer(_ variant: String) {
        
        guard round <= 3 else {
            showingEndGame = true
            return
        }
        
        let currentLocalVariant = variants[currentVariant]
        let currentLocalShouldWin = shouldWin[currentShouldWin]
        
        switch (currentLocalVariant, currentLocalShouldWin, variant) {
        case    ("🧱", "🎉", "✂️"),
                ("🧱", "👎", "📄"),
                ("✂️", "🎉", "📄"),
                ("✂️", "👎", "🧱"),
                ("📄", "🎉", "🧱"),
                ("📄", "👎", "✂️"):
                    if round <= 3 && !gameOver {
                        score += 1
                    }
        
        default: break
        }
        if round < 3 {
            round += 1
        }
        else {
            gameOver = true
            showingEndGame = true
        }
        currentVariant = Int.random(in: 0..<3)
        currentShouldWin = Int.random(in: 0..<2)
    }
    
    func reset() {
        score = 0
        round = 1
        gameOver = false
    }
    
}

#Preview {
    ContentView()
}
