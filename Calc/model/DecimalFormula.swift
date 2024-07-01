//
//  DecimalFormula.swift
//  Calc
//
//  Created by nya on 2024/07/01.
//  Copyright © 2024 CatHand.org. All rights reserved.
//

import Foundation

struct PiFormula: FormulaProtocol {
    
    let answer: String
    let text: String

    var correctAnswer: String {
        answer
    }
    
    var mode: NumbersView.Mode {
        .decimal
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
