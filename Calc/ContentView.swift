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
    @State private var piLink = false
    @State private var squareLink = false
    
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
                    NavigationLink(destination: gameView(mode: .plus), isActive: $plusLink) {
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
                    NavigationLink(destination: gameView(mode: .minus), isActive: $minusLink) {
                        Color.clear.frame(height: 0)
                    }
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.piLink = true
                    }) {
                        Text("円周率")
                            .font(.system(size: 32, weight: .semibold))
                    }
                    NavigationLink(destination: gameView(mode: .pi), isActive: $piLink) {
                        Color.clear.frame(height: 0)
                    }
                }
                Spacer()
                VStack {
                    Button(action: {
                        self.squareLink = true
                    }) {
                        Text("平方数")
                            .font(.system(size: 32, weight: .semibold))
                    }
                    NavigationLink(destination: gameView(mode: .square), isActive: $squareLink) {
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
    
    func gameView(mode: Game.Mode) -> GameView {
        GameView(game: .init(mode: mode), time: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
