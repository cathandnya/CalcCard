//
//  CalculationCardView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct CalculationCardView: View {
    
    let formula: Formula
    
    var body: some View {
        HStack(spacing: 30) {
            Text("\(formula.left)")
                .font(.system(size: 82, weight: .bold))
            Text(formula.operator.label)
                .font(.system(size: 82, weight: .bold))
            Text("\(formula.right)")
                .font(.system(size: 82, weight: .bold))
        }
    }
}

struct CalculationCardView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationCardView(formula: Formula(left: 8, right: 6, operator: .plus))
    }
}
