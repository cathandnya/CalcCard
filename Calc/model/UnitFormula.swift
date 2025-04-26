//
//  UnitFormula.swift
//  Calc
//
//  Created by nya on 2024/08/01.
//  Copyright © 2024 CatHand.org. All rights reserved.
//

import Foundation

protocol UnitProtocol {
    
    var multiplyer: Double { get }
    var label: String { get }
}

extension UnitProtocol {
    
    func convert(value: Double, to: UnitProtocol) -> Double {
        value * multiplyer / to.multiplyer
    }
}

enum DistanceUnit: UnitProtocol, CaseIterable {
    case milliMeter
    case centiMeter
    case meter
    case kiroMeter
    
    var multiplyer: Double {
        switch self {
        case .milliMeter:
            return 1
        case .centiMeter:
            return 10
        case .meter:
            return 1000
        case .kiroMeter:
            return 1000000
        }
    }
    
    var label: String {
        switch self {
        case .milliMeter:
            return "mm"
        case .centiMeter:
            return "cm"
        case .meter:
            return "m"
        case .kiroMeter:
            return "km"
        }
    }
    
    static func random() -> DistanceUnit {
        DistanceUnit.allCases.randomElement()!
    }
    
    func next() -> DistanceUnit {
        switch self {
        case .milliMeter:
            return [.centiMeter, .meter].randomElement()!
        case .centiMeter:
            return [.milliMeter, .meter].randomElement()!
        case .meter:
            return [.milliMeter, .centiMeter, .kiroMeter].randomElement()!
        case .kiroMeter:
            return [.centiMeter, .meter].randomElement()!
        }
    }
}

enum AreaUnit: UnitProtocol, CaseIterable {
    case centiMeterSquare
    case meterSquare
    case kiroMeterSquare
    case are
    case hectare
    
    var multiplyer: Double {
        switch self {
        case .centiMeterSquare:
            return 0.0001
        case .meterSquare:
            return 1
        case .kiroMeterSquare:
            return 1000000
        case .are:
            return 100
        case .hectare:
            return 10000
        }
    }
    
    var label: String {
        switch self {
        case .centiMeterSquare:
            return "cm²"
        case .meterSquare:
            return "m²"
        case .kiroMeterSquare:
            return "km²"
        case .are:
            return "a"
        case .hectare:
            return "ha"
        }
    }
    
    static func random() -> AreaUnit {
        AreaUnit.allCases.randomElement()!
    }
    
    func next() -> AreaUnit {
        switch self {
        case .centiMeterSquare:
            return [.meterSquare].randomElement()!
        case .meterSquare:
            return [.centiMeterSquare, .kiroMeterSquare, .are].randomElement()!
        case .kiroMeterSquare:
            return [.meterSquare, .hectare].randomElement()!
        case .are:
            return [.meterSquare, .hectare].randomElement()!
        case .hectare:
            return [.kiroMeterSquare, .are].randomElement()!
        }
    }
}

enum VolumeUnit: UnitProtocol, CaseIterable {
    case centiMeterCube
    case meterCube
    case cc
    case milliLiter
    case deciLiter
    case liter
    
    var multiplyer: Double {
        switch self {
        case .centiMeterCube:
            return 1
        case .meterCube:
            return 1000000
        case .cc:
            return 1
        case .milliLiter:
            return 1
        case .deciLiter:
            return 100
        case .liter:
            return 1000
        }
    }
    
    var label: String {
        switch self {
        case .centiMeterCube:
            return "cm³"
        case .meterCube:
            return "m³"
        case .cc:
            return "cc"
        case .milliLiter:
            return "mL"
        case .deciLiter:
            return "dL"
        case .liter:
            return "L"
        }
    }
    
    static func random() -> VolumeUnit {
        VolumeUnit.allCases.randomElement()!
    }
    
    func next() -> VolumeUnit {
        switch self {
        case .centiMeterCube, .cc, .milliLiter:
            return [.deciLiter, .liter].randomElement()!
        case .meterCube:
            return [.liter].randomElement()!
        case .deciLiter:
            return [.centiMeterCube, .cc, .milliLiter, .liter].randomElement()!
        case .liter:
            return [.centiMeterCube, .cc, .milliLiter, .deciLiter].randomElement()!
        }
    }
}

enum TimeUnit: UnitProtocol, CaseIterable {
    case second
    case minute
    case hour
    case day
    
    var multiplyer: Double {
        switch self {
        case .second:
            return 1
        case .minute:
            return 60
        case .hour:
            return 3600
        case .day:
            return 24 * 3600
        }
    }
    
    var label: String {
        switch self {
        case .second:
            return "秒"
        case .minute:
            return "分"
        case .hour:
            return "時間"
        case .day:
            return "日"
        }
    }
    
    static func random() -> TimeUnit {
        TimeUnit.allCases.filter({ $0 != .day }).randomElement()!
    }
    
    func next() -> TimeUnit {
        switch self {
        case .second:
            return [.minute].randomElement()!
        case .minute:
            return [.hour].randomElement()!
        case .hour:
            return [.day].randomElement()!
        case .day:
            return [.day].randomElement()!
        }
    }
}

enum SpeedUnit: UnitProtocol, CaseIterable {
    case meterPerSecond
    case meterPerMinute
    case kiroMeterPerHour
    
    var multiplyer: Double {
        switch self {
        case .meterPerSecond:
            return 1
        case .meterPerMinute:
            return 60
        case .kiroMeterPerHour:
            return 3600000
        }
    }
    
    var label: String {
        switch self {
        case .meterPerSecond:
            return "m/秒"
        case .meterPerMinute:
            return "m/分"
        case .kiroMeterPerHour:
            return "km/時"
        }
    }
    
    static func random() -> SpeedUnit {
        SpeedUnit.allCases.randomElement()!
    }
    
    func next() -> SpeedUnit {
        switch self {
        case .meterPerSecond:
            return [.meterPerMinute].randomElement()!
        case .meterPerMinute:
            return [.meterPerSecond, .kiroMeterPerHour].randomElement()!
        case .kiroMeterPerHour:
            return [.meterPerMinute].randomElement()!
        }
    }
}

struct UnitFormula: FormulaProtocol {
    
    let value: Double
    let sourceUnit: UnitProtocol
    let destinationUnit: UnitProtocol
    
    var text: String {
        String(format: "%d", Int(value)) + sourceUnit.label + "=⬜︎" + destinationUnit.label
    }
    var correctAnswer: String {
        sourceUnit.convert(value: value, to: destinationUnit).formattedText
    }
    var mode: NumbersView.Mode {
        .fraction
    }
    
    var correctAnswerText: String {
        "答えは\(correctAnswer)です。"
    }
}
