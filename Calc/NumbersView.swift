//
//  NumbersView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct NumbersView: View {

    enum Mode {
        case oneDigit
        case digits
        case decimal
    }
    
    let formula: FormulaProtocol
    let handler: (String) -> Void
    
    @State var value: String = ""
    
    var mode: Mode {
        formula.mode
    }
    
    var body: some View {
        VStack {
            if mode != .oneDigit {
                HStack {
                    Button {
                        value = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                    }
                    .frame(width: 40)
                    .disabled(value.isEmpty)
                    Spacer()
                    Text(value)
                        .font(.system(size: 28))
                    Spacer()
                    Color.clear
                        .frame(width: 40)
                }
                .frame(height: 30)
                .padding(.horizontal, 10)
            }
            VStack(spacing: -1) {
                HStack(spacing: -1) {
                    ForEach(1 ..< 4) { i in
                        Button(action: {
                            digit(num: i)
                        }) {
                            Text("\(i)")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: 80, height: 80)
                                .border(Color.blue, width: 1)
                        }
                    }
                }
                HStack(spacing: -1) {
                    ForEach(4 ..< 7) { i in
                        Button(action: {
                            digit(num: i)
                        }) {
                            Text("\(i)")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: 80, height: 80)
                                .border(Color.blue, width: 1)
                        }
                    }
                }
                HStack(spacing: -1) {
                    ForEach(7 ..< 10) { i in
                        Button(action: {
                            digit(num: i)
                        }) {
                            Text("\(i)")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: 80, height: 80)
                                .border(Color.blue, width: 1)
                        }
                    }
                }
                HStack(spacing: -1) {
                    if mode == .oneDigit {
                        Button(action: {
                            digit(num: 10)
                        }) {
                            Text("\(10)")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: 80, height: 80)
                                .border(Color.blue, width: 1)
                        }
                    } else {
                        Button(action: {
                            digit(num: 0)
                        }) {
                            Text("\(0)")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: 80, height: 80)
                                .border(Color.blue, width: 1)
                        }
                        .disabled(value.isEmpty)
                    }
                    if mode == .decimal {
                        Button(action: {
                            dot()
                        }) {
                            Text(".")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: 80, height: 80)
                                .border(Color.blue, width: 1)
                        }
                        .disabled(value.isEmpty || value.last == ".")
                    } else {
                        Color.clear
                            .frame(width: 80, height: 80)
                            .border(Color.blue, width: 1)
                    }
                    if mode == .oneDigit {
                        Color.clear
                            .frame(width: 80, height: 80)
                            .border(Color.blue, width: 1)
                    } else {
                        Button(action: {
                            next()
                        }) {
                            Image(systemName: "arrowshape.right.fill")
                                .font(.system(size: 36))
                                .frame(width: 80, height: 80)
                                .border(Color.blue, width: 1)
                        }
                        .disabled(value.isEmpty)
                    }
                }
            }
        }
    }
    
    func digit(num: Int) {
        switch mode {
        case .oneDigit:
            handler("\(num)")
        case .digits, .decimal:
            value += "\(num)"
        }
    }
    
    func dot() {
        value += "."
    }
    
    func next() {
        handler(value)
        value = ""
    }
}

struct NumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView(formula: Formula(left: 8, right: 6, operator: .plus)) { _ in }
        NumbersView(formula: Game(mode: .square).currentFomula) { _ in }
        NumbersView(formula: Game(mode: .pi).currentFomula) { _ in }
    }
}
