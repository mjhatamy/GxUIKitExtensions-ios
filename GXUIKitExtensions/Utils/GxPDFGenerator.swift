//
//  GxPDFGenerator.swift
//  GXUIKitExtensions
//
//  Created by Majid Hatami Aghdam on 8/5/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

import UIKit
import WebKit

public final class GxPDFGenerator {
    public init() {
    }
    
    public func printToPDF(_ webview: WKWebView, _ pageSize:CGSize = CGSize(width: 2480, height: 3504) ) -> NSData? {
        return self.__printToPDF(webview.viewPrintFormatter(), pageSize)
    }
    
    private func __printToPDF(_ view:UIViewPrintFormatter, _ pageSize:CGSize) -> NSData? {
        let A4Size = pageSize //CGSize(width: 2480, height: 3504) // A4 in pixels at 300dpi
        let renderer = PRV300dpiPrintRenderer()
        let formatter = view
        formatter.perPageContentInsets = .zero
        renderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        let topPadding: CGFloat = 115.0
        let bottomPadding: CGFloat = 117.0
        let leftPadding: CGFloat = 100.0
        let rightPadding: CGFloat = 100.0
        let printableRect = CGRect(x: leftPadding, y:topPadding, width: A4Size.width - leftPadding - rightPadding, height: A4Size.height - topPadding - bottomPadding)
        let A4Rect = CGRect( x:0, y:0, width: A4Size.width, height: A4Size.height)
        renderer.setValue(A4Rect, forKey: "paperRect")
        renderer.setValue(printableRect, forKey: "printableRect")
        return renderer.pdfData
    }
}

private class PRV300dpiPrintRenderer : UIPrintPageRenderer {
    public var pdfData : NSData? {
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, self.paperRect, nil)
        UIColor.white.set();
        guard let pdfContext = UIGraphicsGetCurrentContext() else {
            return nil;
        }
        pdfContext.saveGState()
        pdfContext.concatenate(CGAffineTransform(scaleX: 72/300, y: 72/300)) // scale down to improve dpi from screen 72dpi to printable 300dpi
        self.prepare(forDrawingPages: NSRange.init(0...self.numberOfPages))
        let bounds = UIGraphicsGetPDFContextBounds()
        for i in 0..<self.numberOfPages {
            UIGraphicsBeginPDFPage();
            self.drawPage(at: i, in: bounds)
        }
        pdfContext.restoreGState()
        UIGraphicsEndPDFContext();
        return data
    }
}

/*
extension WKWebView {
    public func printablePdfData(_ pageSize:CGSize = CGSize(width: 2480, height: 3504) ) -> NSData? {
        let A4Size = CGSize(width: 2480, height: 3504) // A4 in pixels at 300dpi
        let renderer = PRV300dpiPrintRenderer()
        let formatter = self.viewPrintFormatter()
        formatter.perPageContentInsets = .zero
        renderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        let topPadding: CGFloat = 115.0
        let bottomPadding: CGFloat = 117.0
        let leftPadding: CGFloat = 100.0
        let rightPadding: CGFloat = 100.0
        let printableRect = CGRect(x: leftPadding, y:topPadding, width: A4Size.width - leftPadding - rightPadding, height: A4Size.height - topPadding - bottomPadding)
        let A4Rect = CGRect( x:0, y:0, width: A4Size.width, height: A4Size.height)
        renderer.setValue(A4Rect, forKey: "paperRect")
        renderer.setValue(printableRect, forKey: "printableRect")
        return renderer.pdfData
    }
}
*/
