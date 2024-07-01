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

extension PiFormula {
    
    static var items: [FormulaProtocol] {
        [
            PiFormula(answer: "3.14", text: "3.14 x 1"),
            PiFormula(answer: "6.28", text: "3.14 x 2"),
            PiFormula(answer: "9.42", text: "3.14 x 3"),
            PiFormula(answer: "12.56", text: "3.14 x 4"),
            PiFormula(answer: "15.7", text: "3.14 x 5"),
            PiFormula(answer: "18.84", text: "3.14 x 6"),
            PiFormula(answer: "21.98", text: "3.14 x 7"),
            PiFormula(answer: "25.12", text: "3.14 x 8"),
            PiFormula(answer: "28.26", text: "3.14 x 9"),
        ]
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
