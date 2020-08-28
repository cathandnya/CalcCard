//
//  NumbersView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct NumbersView: View {
    
    let handler: (Int) -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(1 ..< 6) { i in
                    Button(action: {
                        self.handler(i)
                    }) {
                        Text("\(i)")
                            .font(.system(size: 36, weight: .semibold))
                            .frame(width: UIScreen.main.bounds.width / 5)
                            .frame(height: 60)
                            .border(Color.blue, width: 1)
                    }
                }
            }
            HStack(spacing: 0) {
                ForEach(6 ..< 11) { i in
                    Button(action: {
                        self.handler(i)
                    }) {
                        Text("\(i)")
                            .font(.system(size: 36, weight: .semibold))
                            .frame(width: UIScreen.main.bounds.width / 5)
                            .frame(height: 60)
                            .border(Color.blue, width: 1)
                    }
                }
            }
        }
    }
}

struct NumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView() { i in
            
        }
    }
}
