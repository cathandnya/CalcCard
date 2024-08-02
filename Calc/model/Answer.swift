//
//  Answer.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation

struct Answer: Identifiable, Hashable {
    
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: String = NSUUID().uuidString
    let formula: FormulaProtocol
    let answer: String?
    
    var isCollect: Bool {
        guard let answer = answer else {
            return false
        }
        return formula.check(answer: answer)
    }
}

extension Double {
    
    var formattedText: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 16
        return formatter.string(from: .init(floatLiteral: self))!
    }
}
