//
//  DecimalFormula.swift
//  Calc
//
//  Created by nya on 2024/07/01.
//  Copyright © 2024 CatHand.org. All rights reserved.
//

import Foundation

struct PiFormula: FormulaProtocol {
    
    let value: Int

    var text: String {
        "3.14 x \(value)"
    }

    var correctAnswer: String {
        let answer = Double(314 * value) / 100
        return answer.formattedText
    }

    var mode: NumbersView.Mode {
        .fraction
    }
}

struct SquareFormula: FormulaProtocol {
    
    let value: Int

    var text: String {
        "\(value) x \(value)"
    }

    var correctAnswer: String {
        "\(value * value)"
    }
    
    var mode: NumbersView.Mode {
        .digits
    }
}
