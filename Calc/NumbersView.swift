//
//  NumbersView.swift
//  Calc
//
//  Created by nya on 2020/08/28.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import SwiftUI

struct NumbersView: View {
    
    let ranges: [Range<Int>]
    let handler: (Int) -> Void
    
    init(range: Range<Int>, handler: @escaping (Int) -> Void) {
        self.ranges = [
            range.lowerBound ..< range.lowerBound + range.count / 2,
            range.lowerBound + range.count / 2 ..< range.upperBound,
        ]
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            ForEach(0 ..< ranges.count) { i in
                HStack(spacing: 0) {
                    ForEach(ranges[i]) { i in
                        Button(action: {
                            self.handler(i)
                        }) {
                            Text("\(i)")
                                .font(.system(size: 36, weight: .semibold))
                                .frame(width: UIScreen.main.bounds.width / 5)
                                .frame(height: 80)
                                .border(Color.blue, width: 1)
                        }
                    }
                }
            }
        }
    }
}

struct NumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView(range: Range(11 ... 20)) { i in
            
        }
    }
}
