//
//  ContentView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var plusLink = false
    @State private var minusLink = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Button(action: {
                        self.plusLink = true
                    }) {
                        Text("たしざん")
                            .font(.system(size: 32, weight: .semibold))
                    }
                    NavigationLink(destination: plusView(), isActive: $plusLink) {
                        Color.clear.frame(height: 0)
                    }
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.minusLink = true
                    }) {
                        Text("ひきざん")
                            .font(.system(size: 32, weight: .semibold))
                    }
                    NavigationLink(destination: minusView(), isActive: $minusLink) {
                        Color.clear.frame(height: 0)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Version: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) (\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String))")
                        .font(.system(size: 12))
                    Spacer()
                }
            }
            .navigationBarTitle(Text("けいさんカード"))
        }
    }
    
    func plusView() -> GameView {
        let game = Game()
        game.setupPlus()
        return GameView(game: game, formula: game.pop(), time: nil)
    }

    func minusView() -> GameView {
        let game = Game()
        game.setupMinus()
        return GameView(game: game, formula: game.pop(), time: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
