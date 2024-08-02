//
//  Formula.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation

protocol FormulaProtocol {
 
    var text: String { get }
    var correctAnswer: String { get }
    var mode: NumbersView.Mode { get }
}

extension FormulaProtocol {
    
    func check(answer: String) -> Bool {
        correctAnswer == answer
    }
}

struct Formula: FormulaProtocol {
    
    enum Operator {
        
        case plus
        case minus
        case multiply
        case divide
        
        var label: String {
            switch self {
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .multiply:
                return "×"
            case .divide:
                return "÷"
            }
        }
    }
    
    let left: Double
    let right: Double
    let `operator`: Operator
    
    var result: Double {
        switch self.operator {
        case .plus:
            return left + right
        case .minus:
            return left - right
        case .multiply:
            return left * right
        case .divide:
            return left / right
        }
    }
    
    //
    
    var text: String {
        "\(left.formattedText) \(self.operator.label) \(right.formattedText)"
    }
    
    var correctAnswer: String {
        result.formattedText
    }
    
    var mode: NumbersView.Mode {
        .digits
    }
}
