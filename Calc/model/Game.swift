//
//  Game.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation
import GameplayKit

class Game {
    
    var stages: [FormulaProtocol] = []
    static let randomSource = GKRandomSource.sharedRandom()

    func setupPlus() {
        stages = []
        
        for left in 5 ..< 9 {
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

        for left in 5 ..< 10 {
            for right in 0 ..< 10 {
                let formula = Formula(left: left, right: right, operator: .minus)
                if formula.result > 0 {
                    stages.append(formula)
                }
            }
        }
    }
    
    func setupPi() {
        stages = PiFormula.items
    }

    func setupSquare() {
        stages = []
        
        for value in 11 ..< 20 {
            stages.append(SquareFormula(value: value))
        }
    }

    func pop() -> FormulaProtocol {
        let randomNumber = Game.randomSource.nextInt(upperBound: stages.count)
        return stages.remove(at: randomNumber)
    }
    
    var isEmpty: Bool {
        //stages.count < 40
        stages.isEmpty
    }
    
    var initial: FormulaProtocol {
        stages[0]
    }
}

class PlusGame: Game {
    
    override init() {
        super.init()
        setupPlus()
    }
}
