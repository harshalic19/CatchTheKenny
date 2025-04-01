//
//  ContentView.swift
//  CatchTheKenny
//
//  Created by Harshali Chaudhari on 11/03/25.
//

import SwiftUI

struct CatchKennyView: View {
    
    @State var score: Int = 0
    @State var timeLeft: Double = 10.0
    @State var chosenX: CGFloat = 200
    @State var chosenY: CGFloat = 200
    @State var showAlert: Bool = false
    @State var gameTimer: Timer?
    @State var counterTimer: Timer?
    
    // Position Tuples
    let positions = [(60,60), (70,240), (180,180), (180,300), (300,120), (340,80), (120,180), (170,240), (240,120), (300,240), (340,130), (180,180)]
    
    func startGame() {
        score = 0
        timeLeft = 10.0
        showAlert = false
        
        
        gameTimer?.invalidate()
        counterTimer?.invalidate()
        
        // Timer for moving Kenny
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let newPosition = positions.randomElement()!
            self.chosenX = CGFloat(newPosition.0)
            self.chosenY = CGFloat(newPosition.1)
        }
        
        // Timer for countdown
        counterTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeLeft <= 1 {
                timer.invalidate()
                gameTimer?.invalidate()
                self.showAlert = true
            } else {
                self.timeLeft -= 1
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Catch the Kenny!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.7))
                        .frame(width: 140, height: 50)
                        .overlay(
                            Text("Time: \(Int(timeLeft))s")
                                .foregroundColor(.white)
                                .font(.title3)
                        )
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.7))
                        .frame(width: 140, height: 50)
                        .overlay(
                            Text("Score: \(score)")
                                .foregroundColor(.white)
                                .font(.title3)
                        )
                }
                .padding(.top, 20)
                
                Spacer()
                
                Image("kenny")
                    .resizable()
                    .frame(width: 180, height: 100)
                    .position(x: chosenX, y: chosenY)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.score += 1
                        }
                    }
                    .onAppear {
                        startGame()
                    }
                
                Spacer()
                
                Button(action: {
                    startGame()
                }) {
                    Text("Restart Game")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.red)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 30)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Oops.. Time Over!!"),
                message: Text("Your score is: \(score)\n Want to Play Again?"),
                primaryButton: .default(Text("Restart"), action: {
                    startGame()
                }),
                secondaryButton: .cancel {
                    gameTimer?.invalidate()
                    counterTimer?.invalidate()
                }
            )
        }
    }
}

#Preview {
    CatchKennyView()
}
