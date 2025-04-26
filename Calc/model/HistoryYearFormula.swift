//
//  HistoryYearFormula.swift
//  Calc
//
//  Created by nya on 2025/04/19.
//  Copyright © 2025 CatHand.org. All rights reserved.
//

import Foundation
import CSV

struct HistoryYearFormula: FormulaProtocol {
    
    let title: String
    let year: String
    
    var text: String { title }
    var correctAnswer: String { year }
    var mode: NumbersView.Mode { .digits }
    
    var correctAnswerText: String {
        let goroawase = Goroawase.shared.items[year]
        let message = "答えは\(correctAnswer)年です。"
        if let goroawase = goroawase {
            return "\(message)\n\(goroawase)"
        } else {
            return message
        }
    }
}

class Goroawase {
    
    static let shared = Goroawase()
    lazy var items: [String: String] = {
        load() ?? [:]
    }()
    
    func load() -> [String: String]? {
        let fileName = "語呂合わせ-1"
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") else { return nil }
        guard let stream = InputStream(fileAtPath: filePath) else { return nil }
        guard let csv = try? CSVReader(stream: stream) else { return nil }
        csv.next() // skip header

        var items: [String: String] = [:]
        while let row = csv.next() {
            guard row.count == 2 else { continue }
            items[row[0]] = row[1]
        }
        return items
    }
}
