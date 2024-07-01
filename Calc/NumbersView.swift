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
                    .disabled(value.isEmpty)
                    Spacer()
                    Text(value)
                        .font(.system(size: 28))
                    Spacer()
                    Button {
                        handler(value)
                        value = ""
                    } label: {
                        Image(systemName: "arrowshape.right.circle.fill")
                            .font(.system(size: 30))
                    }
                    .disabled(value.isEmpty)
                }
                .frame(height: 30)
                .padding(.horizontal, 10)
            }
            VStack(spacing: -1) {
                HStack(spacing: -1) {
                    ForEach(1 ..< 6) { i in
                        Button(action: {
                            digit(num: i)
                        }) {
                            Text("\(i)")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: UIScreen.main.bounds.width / 5)
                                .frame(height: 60)
                                .border(Color.blue, width: 1)
                        }
                    }
                }
                HStack(spacing: -1) {
                    ForEach(6 ..< 11) { i in
                        Button(action: {
                            if i == 10 && mode != .oneDigit {
                                digit(num: 0)
                            } else {
                                digit(num: i)
                            }
                        }) {
                            if i == 10 && mode != .oneDigit {
                                Text("\(0)")
                                    .font(.system(size: 36, weight: .semibold))
                                    .frame(width: UIScreen.main.bounds.width / 5)
                                    .frame(height: 60)
                                    .border(Color.blue, width: 1)
                            } else {
                                Text("\(i)")
                                    .font(.system(size: 36, weight: .semibold))
                                    .frame(width: UIScreen.main.bounds.width / 5)
                                    .frame(height: 60)
                                    .border(Color.blue, width: 1)
                            }
                        }
                    }
                }
                if mode == .decimal {
                    HStack(spacing: -1) {
                        ForEach(1 ..< 6) { i in
                            if i < 5 {
                                Color.clear
                                    .frame(width: UIScreen.main.bounds.width / 5)
                                    .frame(height: 60)
                            } else {
                                Button(action: {
                                    dot()
                                }) {
                                    Text(".")
                                        .font(.system(size: 36, weight: .semibold))
                                        .frame(width: UIScreen.main.bounds.width / 5)
                                        .frame(height: 60)
                                        .border(Color.blue, width: 1)
                                }
                                .disabled(value.isEmpty || value.last == ".")
                            }
                        }
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
}

struct NumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView(formula: Formula(left: 8, right: 6, operator: .plus)) { i in
            
        }
    }
}
