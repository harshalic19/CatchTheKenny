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
    
    //Position Tuples
    let x1 = (60,60)
    let x2 = (120,120)
    let x3 = (180,180)
    let x4 = (180,300)
    let x5 = (300,300)
    let x6 = (340,340)
    let x7 = (120,180)
    let x8 = (240,240)
    let x9 = (240,120)
    let x10 = (300,240)
    let x11 = (340,300)
    let x12 = (340,60)
    
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
                .onAppear {
                    _ = self.timer
                }
            
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
