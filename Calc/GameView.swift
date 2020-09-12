//
//  GameView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    let game: Game
    @State var formula: Formula
    let time: TimeInterval?

    @Environment(\.presentationMode) var presentationMode

    @State var showingAlert = false
    @State var answer: Answer?
    @State var results: [Answer] = []
    @State var timer: Timer?

    var body: some View {
        VStack {
            Spacer()
            CalculationCardView(formula: formula)
            Spacer()
            NumbersView() { result in
                let answer = Answer(formula: self.formula, answer: result)
                self.results.append(answer)
                
                self.timer?.invalidate()
                self.timer = nil
                
                if answer.isCollect {
                    self.next()
                } else {
                    self.answer = answer
                    self.showingAlert = true
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            if let answer = self.answer {
                return Alert(
                    title: Text(answer.answer == nil ? "時間切れ" : "まちがい！"),
                    message: Text("答えは\(answer.formula.result)です。"),
                    dismissButton: .default(Text("はい"), action: {
                        self.showingAlert = false
                        DispatchQueue.main.async {
                            self.next()
                        }
                    }))
            } else {
                return Alert(
                    title: Text("おわり"),
                    message: Text(self.resultText),
                    dismissButton: .default(Text("はい"), action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }))
            }
        }
        .onAppear {
            self.startTimer()
        }
    }
    
    func next() {
        guard !game.isEmpty else {
            self.answer = nil
            self.showingAlert = true
            return
        }
        formula = game.pop()
        
        startTimer()
    }
    
    func startTimer() {
        guard let time = time else {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (_) in
            let answer = Answer(formula: self.formula, answer: nil)
            self.results.append(answer)
            self.timer = nil
            self.answer = answer
            self.showingAlert = true
        }
    }
    
    var resultText: String {
        let failuerCount = results.filter({ !$0.isCollect }).count
        if failuerCount == 0 {
            return "全問正解です。"
        } else {
            return "\(results.count)問中\(failuerCount)個間違えました。"
        }
    }
}

struct GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        GameView(game: PlusGame(), formula: Formula(left: 8, right: 6, operator: .minus), time: nil)
    }
}
