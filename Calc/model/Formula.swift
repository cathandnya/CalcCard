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
        
        var label: String {
            switch self {
            case .plus:
                return "+"
            case .minus:
                return "-"
            }
        }
        
        var name: String {
            switch self {
            case .plus:
                return "たしざん"
            case .minus:
                return "ひきざん"
            }
        }
    }
    
    let left: Int
    let right: Int
    let `operator`: Operator
    
    var result: Int {
        switch self.operator {
        case .plus:
            return left + right
        case .minus:
            return left - right
        }
    }
    
    //
    
    var text: String {
        switch self.operator {
        case .plus:
            return "\(left) + \(right)"
        case .minus:
            return "\(left) - \(right)"
        }
    }
    
    var correctAnswer: String {
        "\(result)"
    }
    
    var mode: NumbersView.Mode {
        .oneDigit
    }
}
