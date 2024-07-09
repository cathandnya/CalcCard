//
//  ContentView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ForEach(Game.Mode.allCases, id: \.self) { mode in
                    NavigationLink(mode.title, value: mode)
                        .font(.system(size: 32, weight: .semibold))
                        .padding(.vertical, 30)
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
            .navigationDestination(for: Game.Mode.self) { mode in
                GameView(game: .init(mode: mode), time: nil)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
