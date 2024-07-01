//
//  CalculationCardView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct CalculationCardView: View {
    
    let formula: FormulaProtocol
    
    var body: some View {
        HStack(spacing: 0) {
            Text(formula.text)
                .font(.system(size: 82, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .padding(.horizontal, 20)
    }
}

struct CalculationCardView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationCardView(formula: Formula(left: 8, right: 6, operator: .plus))
    }
}
