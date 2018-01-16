//
//  SymbolView.swift
//  
//  Set Game
//
//  Created by Andrius Kelly on 1/15/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//

import UIKit


/**
 Creates a single Set symbol as a UIView, according to its color, shape and shading.
 */
@IBDesignable
class SymbolView: UIView {
    private struct sizes {
        static let strokePercent = 0.02
        static let numStripes = 16
       
    }
    
    @IBInspectable
    var symbol = SymbolType.squiggle
    @IBInspectable
    var shading = Shading.striped
    @IBInspectable
    var color = UIColor.blue
    
    
    override func draw(_ rect: CGRect) {
        
        let stroke = bounds.height * CGFloat(sizes.strokePercent)
        let offset = stroke
        let path: UIBezierPath
        
        switch symbol {
            
        case .diamond:
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.midX, y: offset))
            path.addLine(to: CGPoint(x: offset, y: bounds.midY ) )
            path.addLine(to: CGPoint(x: bounds.midX, y: bounds.height - offset ) )
            path.addLine(to: CGPoint(x: bounds.width - offset, y: bounds.midY ) )
            path.close()
        
        case .squiggle:
            //add curves to form squiggle shape
            path = UIBezierPath()
            path.move(to: CGPoint(x: 3 * bounds.width / 8, y: 2 * offset) )
            path.addCurve(to: CGPoint(x: bounds.width / 4, y: bounds.height / 6),
                          controlPoint1: CGPoint(x: 3 * bounds.width / 8, y: 2 * offset),
                          controlPoint2: CGPoint( x: 1 * bounds.width / 8, y: 1 * bounds.height / 18))
            path.addCurve(to: CGPoint(x: 5 * bounds.width / 32, y: 13 * bounds.height / 16),
                          controlPoint1: CGPoint(x: 9 * bounds.width / 16, y: 8 * bounds.height / 16),
                          controlPoint2: CGPoint(x: 3 * -bounds.width / 32, y: 7 * bounds.height / 16))
            path.addCurve(to: CGPoint(x: 5 * bounds.width / 8, y: bounds.height - 2 * offset),
                          controlPoint1: CGPoint(x: 5 * bounds.width / 16, y: 16 * bounds.height / 16),
                          controlPoint2: CGPoint(x: 10 * bounds.width / 16, y: bounds.height - 2 * offset))
            //append path with mirrored duplicate
            let duplicatePath = UIBezierPath()
            duplicatePath.append(path)
            duplicatePath.apply(CGAffineTransform(translationX: -rect.origin.x, y: -rect.origin.y))
            duplicatePath.apply(CGAffineTransform(scaleX: -1, y: -1))
            duplicatePath.apply(CGAffineTransform(translationX: rect.origin.x + rect.width, y: rect.origin.y + rect.height))
            path.append(duplicatePath)
            
        case .oval:
            let shapeRect = CGRect(origin: CGPoint(x: offset , y: offset),
                                   size: CGSize(width: bounds.width - 2*offset,
                                                height: bounds.height - 2*offset ) )
            path = UIBezierPath(roundedRect: shapeRect, cornerRadius: shapeRect.width )

        }
        
        
        
        switch shading
        {
        case .solid:
            color.setFill()
            path.fill()
        
        case .open:
            color.setStroke()
            
            path.lineWidth = stroke
            path.stroke()
        
        case .striped:
            color.setStroke()

            path.lineWidth = stroke
            path.stroke()
            
            let clipPath = UIBezierPath()
            clipPath.append(path)
            clipPath.addClip()
            
            //draw stripes
            let stripes = UIBezierPath()
            var linePoint = CGPoint(x: -offset, y: bounds.height / CGFloat(2*sizes.numStripes) )
            stripes.move(to: linePoint )
            
            for _ in 1 ... sizes.numStripes / 2 {
                linePoint.x = bounds.width + offset
                stripes.addLine(to: linePoint)
                linePoint.y += bounds.height / CGFloat(sizes.numStripes)
                stripes.addLine(to: linePoint)
                linePoint.x = -offset
                stripes.addLine(to: linePoint)
                linePoint.y += bounds.height / CGFloat(sizes.numStripes)
                stripes.addLine(to: linePoint)
            }
            
            stripes.lineWidth = stroke
            stripes.stroke()
        }
        
    }

}
