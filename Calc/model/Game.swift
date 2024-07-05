//
//  Game.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation
import GameplayKit

class Game: ObservableObject {
    
    enum Mode {
        case plus
        case minus
        case pi
        case square
    }
    
    let mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
        reset()
    }
    
    var stages: [FormulaProtocol] = []
    static let randomSource = GKRandomSource.sharedRandom()

    @Published var currentFomula: FormulaProtocol!

    func reset() {
        switch mode {
        case .plus:
            setupPlus()
        case .minus:
            setupMinus()
        case .pi:
            setupPi()
        case .square:
            setupSquare()
        }
        currentFomula = stages[0]
    }
    
    private func setupPlus() {
        stages = []
        
        for _ in 0 ..< 20 {
            let left = Game.randomSource.nextInt(upperBound: 100)
            let right = Game.randomSource.nextInt(upperBound: 100)
            stages.append(Formula(left: left, right: right, operator: .plus))
        }
    }

    private func setupMinus() {
        stages = []

        for _ in 0 ..< 20 {
            let left = Game.randomSource.nextInt(upperBound: 50) + 50
            let right = Game.randomSource.nextInt(upperBound: left)
            stages.append(Formula(left: left, right: right, operator: .minus))
        }
    }
    
    private func setupPi() {
        stages = []
        
        for value in 1 ..< 10 {
            stages.append(PiFormula(value: value))
        }
        for value in 12 ..< 17 {
            stages.append(PiFormula(value: value))
        }
        stages.append(PiFormula(value: 18))
        stages.append(PiFormula(value: 24))
        stages.append(PiFormula(value: 25))
        stages.append(PiFormula(value: 36))
    }

    private func setupSquare() {
        stages = []
        
        for value in 11 ..< 30 {
            stages.append(SquareFormula(value: value))
        }
    }

    func next() {
        let randomNumber = Game.randomSource.nextInt(upperBound: stages.count)
        currentFomula = stages.remove(at: randomNumber)
    }
    
    var isEmpty: Bool {
        //stages.count < 40
        stages.isEmpty
    }
}
