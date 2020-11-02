//
//  Game.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation

class Game {
    
    var stages: [Formula] = []
    var answerRange: Range<Int> = Range(1 ... 10)

    func setupPlus() {
        stages = []
        answerRange = Range(11 ... 20)
        
        for left in 5 ..< 9 {
            for right in 2 ..< 9 {
                let formula = Formula(left: left, right: right, operator: .plus)
                if answerRange.contains(formula.result) {
                    stages.append(formula)
                }
            }
        }
    }

    func setupMinus() {
        stages = []
        answerRange = Range(1 ... 10)

        for left in 11 ..< 16 {
            for right in 0 ..< 10 {
                let formula = Formula(left: left, right: right, operator: .minus)
                if Range(1 ... 9).contains(formula.result) {
                    stages.append(formula)
                }
            }
        }
    }

    func pop() -> Formula {
        stages.remove(at: Int(arc4random_uniform(UInt32(stages.count))))
    }
    
    var isEmpty: Bool {
        //stages.count < 40
        stages.isEmpty
    }
}

class PlusGame: Game {
    
    override init() {
        super.init()
        setupPlus()
    }
}
