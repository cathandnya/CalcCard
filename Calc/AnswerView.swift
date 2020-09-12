//
//  AnswerView.swift
//  Calc
//
//  Created by nya on 2020/09/12.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct AnswerView: View {
    
    let number: Int
    let isCollect: Bool
    
    var body: some View {
        ZStack {
            Text("\(number)")
                .font(.system(size: 110, weight: .semibold))
            if isCollect {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color(.blue))
                    .opacity(0.6)
            } else {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .foregroundColor(Color(.red))
                    .opacity(0.6)
            }
        }
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(number: 23, isCollect: true)
    }
}
