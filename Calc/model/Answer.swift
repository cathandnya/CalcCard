//
//  Answer.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation

struct Answer {
    
    let formula: Formula
    let answer: Int
    
    var isCollect: Bool {
        answer == formula.result
    }
}
