//
//  Answer.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation

struct Answer {
    
    let formula: FormulaProtocol
    let answer: String?
    
    var isCollect: Bool {
        guard let answer = answer else {
            return false
        }
        return formula.check(answer: answer)
    }
}
