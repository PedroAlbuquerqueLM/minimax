//
//  CGContextExtension.swift
//  TicTacToeApp
//
//  Copyright © 2017 Pedro Albuquerque. All rights reserved.
//

import UIKit

// Utility methods that encapsulate the CoreGraphics API.
internal extension CGContext {
    func strokeLineFrom(from: CGPoint, to: CGPoint, color: UIColor, width: CGFloat, lineCap: CGLineCap) {
        CGContextSetStrokeColorWithColor(self, color.CGColor)
        CGContextSetLineWidth(self, width)
        CGContextSetLineCap(self, lineCap)
        CGContextMoveToPoint(self, from.x, from.y)
        CGContextAddLineToPoint(self, to.x, to.y)
        CGContextStrokePath(self)
    }
    
    func fillRect(rect: CGRect, color: UIColor) {
        CGContextSetFillColorWithColor(self, color.CGColor)
        CGContextFillRect(self, rect)
        CGContextStrokePath(self)
    }
    
    func strokeRect(rect: CGRect, color: UIColor, width: CGFloat) {
        CGContextSetLineWidth(self, width)
        CGContextSetStrokeColorWithColor(self, color.CGColor)
        CGContextAddRect(self, rect)
        CGContextStrokePath(self)
    }
    
    func strokeEllipseInRect(rect: CGRect, color: UIColor, width: CGFloat) {
        CGContextSetStrokeColorWithColor(self, color.CGColor)
        CGContextSetLineWidth(self, width)
        CGContextAddEllipseInRect(self, rect)
        CGContextStrokePath(self)
    }
}
