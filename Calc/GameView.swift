//
//  GameView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI
import AudioToolbox
import SystemSound

struct GameResult: Hashable {
    
    let results: [Answer]
}

struct GameView: View {
    
    @Binding var path: NavigationPath

    @EnvironmentObject var game: Game
    var formula: FormulaProtocol {
        game.currentFomula
    }
    var time: TimeInterval?

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase

    @State private var alert: AlertItem?
    @State var results: [Answer] = []
    @State var timer: Timer?

    var body: some View {
        VStack {
            Text("\(results.count + 1) / \(results.count + game.stages.count + 1)")
            Spacer()
            CalculationCardView(formula: formula)
            Spacer()
            NumbersView(formula: formula) { result in
                self.answer(answer: result)
            }
        }
        .alert(item: $alert, content: { $0.alert })
        .onAppear {
            print("onAppear")
            game.reset()
            results.removeAll()
            self.next()
            self.startTimer()
            game.resume()
        }
        .onDisappear {
            print("onDisappear")
            game.pause()
        }
        .onChange(of: scenePhase) { _, phase in
            switch phase {
            case .background:
                print("background")
                break
            case .inactive:
                print("inactive")
                game.pause()
                break
            case .active:
                print("active")
                game.resume()
                break
            @unknown default:
                print("default")
                break
            }
        }
    }
        
    func answer(answer: String) {
        let answer = Answer(formula: formula, answer: answer)
        self.results.append(answer)
        
        self.timer?.invalidate()
        self.timer = nil
        
        if answer.isCollect {
            self.next()
            AudioServicesPlaySystemSound(.tweetSent)
        } else {
            self.alert = .init(alert: Alert(
                title: Text(answer.answer == nil ? "時間切れ" : "まちがい！"),
                message: Text("答えは\(answer.formula.correctAnswer)です。"),
                dismissButton: .default(Text("はい"), action: {
                    next()
                })))
            AudioServicesPlaySystemSound(.sIMToolkitNegativeACK)
        }
    }
    
    func next() {
        guard !game.isEmpty else {
            game.pause()
            self.alert = .init(alert: Alert(
                title: Text("おわり"),
                message: Text(self.resultText ),
                dismissButton: .default(Text("はい"), action: {
                    let failuerCount = results.filter({ !$0.isCollect }).count
                    if failuerCount == 0 {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        path.removeLast()
                        path.append(GameResult(results: results))
                    }
                })))
            AudioServicesPlaySystemSound(.fanfare)
            return
        }
        game.next()
        
        startTimer()
    }
    
    func startTimer() {
        guard let time = time else {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { (_) in
            let answer = Answer(formula: formula, answer: nil)
            self.results.append(answer)
            self.timer = nil
            self.alert = .init(alert: Alert(
                title: Text(answer.answer == nil ? "時間切れ" : "まちがい！"),
                message: Text("答えは\(answer.formula.correctAnswer)です。"),
                dismissButton: .default(Text("はい"), action: {
                    next()
                })))
        }
    }
    
    var resultText: String {
        let sec = Int(game.time)
        
        let failuerCount = results.filter({ !$0.isCollect }).count
        if failuerCount == 0 {
            return "全問正解です。\nタイム: \(sec)秒"
        } else {
            return "\(results.count)問中\(failuerCount)個間違えました。\nタイム: \(sec)秒"
        }
    }
}

struct GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        GameView(path: .constant(.init()))
            .environmentObject(Game(mode: .plus))
    }
}
