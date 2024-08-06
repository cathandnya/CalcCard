//
//  MemoryCard.swift
//  Calc
//
//  Created by nya on 2024/08/06.
//  Copyright © 2024 CatHand.org. All rights reserved.
//

import Foundation
import UIKit

struct MemoryCards: Hashable {
    
    let cards: [MemoryCard]
}

struct MemoryCard: Identifiable, Hashable {
    
    static func == (lhs: MemoryCard, rhs: MemoryCard) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: String = NSUUID().uuidString
    let front: UIImage
    let back: UIImage
    
    static func load(url: URL) -> [MemoryCard] {
        var results = [MemoryCard]()
        guard let pdf = UIImage.loadPdf(url: url) else {
            return results
        }
        var images = [UIImage]()
        for page in 1 ... pdf.numberOfPages {
            guard let image = UIImage.fromPdf(doc: pdf, page: page, scale: 1) else {
                return results
            }
            images.append(image)
        }
        let pageSize = images[0].size
        let leftMargin: CGFloat = pageSize.width * 140 / 3093
        let cardSize = CGSize(width: (pageSize.width - leftMargin) / 4, height: pageSize.height / 4)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 3
        for page in stride(from: 0, to: images.count, by: 2) {
            let front = images[page]
            let back = images[page + 1]
            for i in 0 ..< 4 {
                let frontX = CGFloat(i)
                let backX = CGFloat(3 - i)
                for j in 0 ..< 4 {
                    let y = CGFloat(j)
                    let frontFrame: CGRect = .init(origin: .init(x: leftMargin + frontX * cardSize.width, y: y * cardSize.height), size: cardSize)
                    let backFrame: CGRect = .init(origin: .init(x: leftMargin + backX * cardSize.width, y: y * cardSize.height), size: cardSize)
                    let frontImage = UIGraphicsImageRenderer(size: cardSize, format: format).image { context in
                        front.draw(at: .init(x: -frontFrame.origin.x, y: -frontFrame.origin.y))
                    }
                    let backImage = UIGraphicsImageRenderer(size: cardSize, format: format).image { context in
                        back.draw(at: .init(x: -backFrame.origin.x, y: -backFrame.origin.y))
                    }
                    results.append(.init(front: frontImage, back: backImage))
                }
            }
        }
        
        results.removeLast(8)
        return results
    }
}
