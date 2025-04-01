//
//  ContentView.swift
//  CatchTheKenny
//
//  Created by Harshali Chaudhari on 11/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var score: Int = 0
    @State var timeLeft: Double = 10.0
    @State var chosenX: CGFloat = 200
    @State var chosenY: CGFloat = 200
    @State var showAlert: Bool = false
    @State var gameTimer: Timer?
    @State var counterTimer: Timer?
    
    // Position Tuples
    let positions = [(60,60), (70,240), (180,180), (180,300), (300,120), (340,80), (120,180), (170,240), (240,120), (300,240), (340,130), (180,180)]
    
    func startTimers() {
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
        VStack {
            
            Spacer().frame(height: 120)
            
            
            Text("Catch the Kenny")
                .font(.title).bold()
            
            Spacer().frame(height: 80)
            
            Text("Time Left: \(String(self.timeLeft))")
                .font(.title2)
            
            Text("Score: \(self.score)")
                .font(.title3)
            
            Spacer()
            
            Image("kenny")
                .resizable()
                .frame(width: 180,height: 100)
                .position(x: self.chosenX, y: self.chosenY)
                .onTapGesture(count: 1, perform: {
                    //Increase score when tapped on Kenny
                    self.score += 1
                })
                .onAppear {
                    //Initiate Timers
                    startTimers()
                }
            
            Spacer()
        }.alert(isPresented: $showAlert) {
            //Show Alert when time is over
            return Alert(title: Text("Oops..Time Over!!"), message: Text("Your score is: \(self.score)\n Want to Play Again?"),
                         primaryButton: Alert.Button.default(Text("Ok"), action: {
                //OK Button Action
                self.score = 0
                self.timeLeft = 10.0
                self.showAlert = false
                startTimers()
            }),  secondaryButton: .cancel(Text("Cancel"), action: {
                gameTimer?.invalidate()
                counterTimer?.invalidate()
            }))
        }
        
    }
}

#Preview {
    ContentView()
}
