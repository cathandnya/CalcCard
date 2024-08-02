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
    
    enum Mode: String, CaseIterable {
        case basic
        case pi
        case square
        case unit
        
        var title: String {
            switch self {
            case .basic:
                return "四則演算"
            case .pi:
                return "円周率"
            case .square:
                return "平方数"
            case .unit:
                return "単位"
            }
        }
    }
    
    let mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
        reset()
    }
    
    var stages: [FormulaProtocol] = []
    static let randomSource = GKRandomSource.sharedRandom()

    @Published var currentFomula: FormulaProtocol!
    
    var time: TimeInterval = 0

    func reset() {
        switch mode {
        case .basic:
            setupBasic()
        case .pi:
            setupPi()
        case .square:
            setupSquare()
        case .unit:
            setupUnit()
        }
        currentFomula = stages[0]
    }
    
    private func setupBasic() {
        stages = []
        
        for _ in 0 ..< 4 {
            let left = Game.randomSource.nextInt(upperBound: 120)
            let right = Game.randomSource.nextInt(upperBound: 120)
            stages.append(Formula(left: Double(left), right: Double(right), operator: .plus))
        }

        for _ in 0 ..< 4 {
            let left = Game.randomSource.nextInt(upperBound: 70) + 50
            let right = Game.randomSource.nextInt(upperBound: left)
            stages.append(Formula(left: Double(left), right: Double(right), operator: .minus))
        }

        for _ in 0 ..< 4 {
            let left = Game.randomSource.nextInt(upperBound: 120)
            let right = Game.randomSource.nextInt(upperBound: 8) + 2
            stages.append(Formula(left: Double(left), right: Double(right), operator: .multiply))
        }

        for _ in 0 ..< 4 {
            let right = Game.randomSource.nextInt(upperBound: 8) + 2
            let left = Game.randomSource.nextInt(upperBound: 100) * right
            stages.append(Formula(left: Double(left), right: Double(right), operator: .divide))
        }
    }
    
    private func setupPi() {
        stages = []
        
        for value in 2 ..< 10 {
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
        
        for value in 11 ..< 20 {
            stages.append(SquareFormula(value: value))
        }
        for value in 21 ..< 30 {
            stages.append(SquareFormula(value: value))
        }
    }

    private func setupUnit() {
        stages = []
        
        for _ in 0 ..< 3 {
            let value = Game.randomSource.nextInt(upperBound: 99) + 1
            let source = DistanceUnit.random()
            stages.append(UnitFormula(value: Double(value), sourceUnit: source, destinationUnit: source.next()))
        }
        
        for _ in 0 ..< 3 {
            let value = Game.randomSource.nextInt(upperBound: 99) + 1
            let source = AreaUnit.random()
            stages.append(UnitFormula(value: Double(value), sourceUnit: source, destinationUnit: source.next()))
        }

        for _ in 0 ..< 3 {
            let value = Game.randomSource.nextInt(upperBound: 99) + 1
            let source = VolumeUnit.random()
            stages.append(UnitFormula(value: Double(value), sourceUnit: source, destinationUnit: source.next()))
        }

        for _ in 0 ..< 3 {
            let source = TimeUnit.random()
            let dest = source.next()
            let value = (Game.randomSource.nextInt(upperBound: 9) + 1) * 36
            stages.append(UnitFormula(value: Double(value), sourceUnit: source, destinationUnit: dest))
        }

        /*
        for _ in 0 ..< 3 {
            let value = Game.randomSource.nextInt(upperBound: 20) * 60
            let source = SpeedUnit.random()
            stages.append(UnitFormula(value: Double(value), sourceUnit: source, destinationUnit: source.next()))
        }*/
    }

    func next() {
        let randomNumber = Game.randomSource.nextInt(upperBound: stages.count)
        currentFomula = stages.remove(at: randomNumber)
    }
    
    var isEmpty: Bool {
        //stages.count < 40
        stages.isEmpty
    }
    
    private var baseDate: Date?
    
    func resume() {
        baseDate = Date()
    }
    
    func pause() {
        guard let baseDate = baseDate else {
            return
        }
        let now = Date()
        time += now.timeIntervalSince(baseDate)
        self.baseDate = nil
    }
}
