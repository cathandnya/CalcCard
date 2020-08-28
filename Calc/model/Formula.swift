//
//  Formula.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation

struct Formula {
    
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
}
