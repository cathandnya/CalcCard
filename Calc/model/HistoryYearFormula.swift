//
//  HistoryYearFormula.swift
//  Calc
//
//  Created by nya on 2025/04/19.
//  Copyright © 2025 CatHand.org. All rights reserved.
//

struct HistoryYearFormula: FormulaProtocol {
    
    let title: String
    let year: String
    
    var text: String { title }
    var correctAnswer: String { year }
    var mode: NumbersView.Mode { .digits }
}
