//
//  ContentView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                ForEach(Game.Mode.allCases, id: \.self) { mode in
                    NavigationLink(mode.title, value: mode)
                        .font(.system(size: 32, weight: .semibold))
                        .padding(.vertical, 20)
                }
                NavigationLink("植物カード", value: MemoryCards(cards: MemoryCard.load(url: Bundle.main.url(forResource: "card_pdf/plants", withExtension: "pdf")!)))
                    .font(.system(size: 32, weight: .semibold))
                    .padding(.vertical, 20)
                Spacer()
                HStack {
                    Spacer()
                    Text("Version: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String) (\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String))")
                        .font(.system(size: 12))
                    Spacer()
                }
            }
            .navigationBarTitle(Text("けいさんカード"))
            .navigationDestination(for: Game.Mode.self) { mode in
                GameView(path: $path, time: nil)
                    .environmentObject(Game(mode: mode))
            }
            .navigationDestination(for: GameResult.self) { value in
                ResultsView(path: $path, results: value.results)
            }
            .navigationDestination(for: MemoryCards.self) { value in
                MemoryCardsView(path: $path, cards: value.cards)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
