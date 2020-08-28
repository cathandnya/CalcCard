//
//  Game.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation

class Game: ObservableObject {
    
    var stages: [Formula] = []

    func setupPlus() {
        stages = []
        
        for left in 0 ..< 9 {
            for right in 0 ..< 9 {
                let formula = Formula(left: left, right: right, operator: .plus)
                let result = formula.result
                if result > 0 && result <= 10 {
                    stages.append(formula)
                }
            }
        }
    }

    func setupMinus() {
        stages = []

        for left in 1 ..< 10 {
            for right in 0 ..< 10 {
                let formula = Formula(left: left, right: right, operator: .minus)
                if formula.result > 0 {
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
