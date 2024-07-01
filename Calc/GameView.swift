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
    @State var formula: FormulaProtocol
    let time: TimeInterval?

    @Environment(\.presentationMode) var presentationMode

    @State var showingAlert = false
    @State var answer: Answer?
    @State var results: [Answer] = []
    @State var timer: Timer?
    @State var voiceRecognizer: VoiceRecognizer?

    var body: some View {
        VStack {
            Spacer()
            CalculationCardView(formula: formula)
            Spacer()
            NumbersView(formula: formula) { result in
                self.answer(answer: result)
            }
        }
        .alert(isPresented: $showingAlert) {
            if let answer = self.answer {
                return Alert(
                    title: Text(answer.answer == nil ? "時間切れ" : "まちがい！"),
                    message: Text("答えは\(answer.formula.correctAnswer)です。"),
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
            self.next()
            self.startTimer()
            VoiceRecognizer.prepare { (b) in
                if (b) {
                    self.voiceStart()
                } else {
                    
                }
            }
        }
        .onDisappear {
            self.voiceRecognizer?.stop()
        }
    }
    
    func voiceStart() {
        voiceRecognizer = VoiceRecognizer()
        _ = try? voiceRecognizer?.start {
            self.voice(result: $0)
        }
    }
    
    func voice(result: Result<Int?, Error>) {
        self.voiceRecognizer = nil
        
        switch result {
        case .success(let result):
            print("voice: \(String(describing: result))")
            guard let result = result else {
                voiceStart()
                return
            }
            answer(answer: "\(result)")
        case .failure(let error):
            print("voice error: \(error)")
        }
    }
    
    func answer(answer: String) {
        let answer = Answer(formula: formula, answer: answer)
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
    
    func next() {
        guard !game.isEmpty else {
            self.answer = nil
            self.showingAlert = true
            return
        }
        formula = game.pop()
        
        startTimer()
        voiceStart()
    }
    
    func startTimer() {
        guard let time = time else {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (_) in
            let answer = Answer(formula: formula, answer: nil)
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
