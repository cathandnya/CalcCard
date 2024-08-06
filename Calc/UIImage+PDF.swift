//
//  UIImage+PDF.swift
//  TraceNote
//
//  Created by nya on 2022/01/19.
//

import UIKit

extension UIImage {
    
    static func loadPdf(url: URL) -> CGPDFDocument? {
        do {
            let pdfdata = try NSData(contentsOf: url, options: NSData.ReadingOptions.init(rawValue: 0))
            let pdfData = pdfdata as CFData
            guard let provider:CGDataProvider = CGDataProvider(data: pdfData),
                  let pdfDoc:CGPDFDocument = CGPDFDocument(provider) else {
                      return nil
            }
            return pdfDoc
        } catch {
            return nil
        }
    }
    
    static func fromPdf(doc: CGPDFDocument, page: Int = 1, scale: CGFloat = 3) -> UIImage? {
        guard let pdfPage: CGPDFPage = doc.page(at: page) else {
            return nil
        }
        var pageRect:CGRect = pdfPage.getBoxRect(.mediaBox)
        pageRect.size = CGSize(width:pageRect.size.width * scale, height:pageRect.size.height * scale)
        let pdfImage = UIGraphicsImageRenderer(size: pageRect.size).image { ctx in
            let context = ctx.cgContext
            context.saveGState()
            context.translateBy(x: 0.0, y: pageRect.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.concatenate(pdfPage.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))
            context.drawPDFPage(pdfPage)
            context.restoreGState()
        }
        guard let cgImage = pdfImage.cgImage else {
            return nil
        }
        return UIImage(cgImage: cgImage, scale: 1, orientation: .up)
    }

}
