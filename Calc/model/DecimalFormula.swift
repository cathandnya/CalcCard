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
        let f1 = Int(314 * value) % 100
        let f2 = f1 % 10
        if f1 == 0 {
            return String(format: "%d", Int(answer))
        } else if f2 == 0 {
            return String(format: "%.1f", answer)
        } else {
            return String(format: "%.2f", answer)
        }
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
