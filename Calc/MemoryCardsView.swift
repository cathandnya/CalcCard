//
//  MemoryCardsView.swift
//  Calc
//
//  Created by nya on 2024/08/06.
//  Copyright © 2024 CatHand.org. All rights reserved.
//

import SwiftUI

struct MemoryCardsView: View {
    
    @Binding var path: NavigationPath

    let cards: [MemoryCard]
    
    var body: some View {
        TabView {
            ForEach(cards) { card in
                MemoryCardItemView(card: card)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        }
    }
}

struct MemoryCardItemView: View {
    
    let card: MemoryCard
    
    @State private var showFlag = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: card.front)
                .resizable()
                .scaledToFit()
            GeometryReader { geo in
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: card.back)
                        .resizable()
                        .scaledToFit()
                    Color.gray
                        .frame(height: geo.size.height * 0.18)
                        .opacity(showFlag < 1 ? 1 : 0)
                    Color.gray
                        .padding(.top, geo.size.height * 0.2)
                        .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.91)
                        .opacity(showFlag < 2 ? 1 : 0)
                }
                .onTapGesture {
                    showFlag = (showFlag + 1) % 3
                }
            }
            .aspectRatio(card.back.size, contentMode: .fit)
        }
        .onAppear {
            showFlag = 0
        }
        .onDisappear {
            showFlag = 0
        }
    }
}

#Preview {
    MemoryCardsView(path: .constant(.init()), cards: MemoryCard.load(url: Bundle.main.url(forResource: "card_pdf/plants", withExtension: "pdf")!))
}
