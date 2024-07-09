//
//  ResultsView.swift
//  Calc
//
//  Created by nya on 2024/07/09.
//  Copyright © 2024 CatHand.org. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var path: NavigationPath
    @Environment(\.presentationMode) var presentationMode

    let results: [Answer]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Color.clear.frame(height: 20)
                ForEach(results) { item in
                    Text(item.formula.text)
                    + Text(" = ")
                    + Text(item.formula.correctAnswer)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                    + Text("  ")
                    + Text(item.answer.flatMap({ "(✖️\($0))" }) ?? "(時間切れ)")
                }
                .font(.system(size: 20))
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
                Color.clear.frame(height: 20)
            }
        }
        .navigationTitle("まちがえた問題")
    }
}

#Preview {
    NavigationStack {
        ResultsView(path: .constant(.init()), results: [
            .init(formula: Formula(left: 1, right: 2, operator: .plus), answer: "4"),
            .init(formula: Formula(left: 4, right: 2, operator: .minus), answer: "4"),
            .init(formula: PiFormula(value: 12), answer: "4"),
            .init(formula: SquareFormula(value: 18), answer: "4"),
        ])
    }
}
