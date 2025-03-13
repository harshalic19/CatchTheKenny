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
    
    //Position Tuples
    let x1 = (60,60)
    let x2 = (70,240)
    let x3 = (180,180)
    let x4 = (180,300)
    let x5 = (300,120)
    let x6 = (340,80)
    let x7 = (120,180)
    let x8 = (170,240)
    let x9 = (240,120)
    let x10 = (300,240)
    let x11 = (340,130)
    let x12 = (180,180)
    
    //Timer for Time Left
    var counterTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeLeft < 0.5 {
                self.chosenX = 200
                self.chosenY = 200
                self.showAlert = true
            } else {
                self.timeLeft -= 1
            }
        }
    }
    
    //Timer for changing Kenny's positions
    var timer: Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            let positionArr = [x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12]
            
            var previousnum: Int?
            
            func randomNumber() -> Int {
                var randomNumber: Int
                repeat {
                    randomNumber = Int.random(in: 0..<positionArr.count)
                } while previousnum == randomNumber
                previousnum = randomNumber
                return randomNumber
            }
            
            self.chosenX = CGFloat(positionArr[randomNumber()].0)
            self.chosenY = CGFloat(positionArr[randomNumber()].1)
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
                    _ = self.timer
                    _ = self.counterTimer
                }
            
            Spacer()
        }.alert(isPresented: $showAlert) {
            //Show Alert when time is over
            return Alert(title: Text("Oops..Time Over!!"), message: Text("Your score is: \(self.score)\n Want to Play Again?"),
                primaryButton: Alert.Button.default(Text("Ok"), action: {
                //OK Button Action
                self.score = 0
                self.timeLeft = 10.0
            }), secondaryButton: Alert.Button.cancel())
        }
        
    }
}

#Preview {
    ContentView()
}
