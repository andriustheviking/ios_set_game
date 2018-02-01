//
//  SymbolView.swift
//  
//  Set Game
//
//  Created by Andrius Kelly on 1/15/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//

import UIKit

enum Orientation { case horizontal, vertical }

/**
 Creates a single Set symbol as a UIView, according to its color, shape and shading.
 */
//@IBDesignable
class SymbolView: UIView {
    
    private struct sizes {
        static let strokePercent = 0.02
        static let numStripes = 16
        static let symbolAspectRatio = 1.55
    }
    
    
    var orientation = Orientation.vertical { didSet { setNeedsDisplay() } }
    
    var symbol = SymbolType.diamond { didSet { setNeedsDisplay() } }

    var shading = Shading.striped { didSet { setNeedsDisplay() } }

    var color = UIColor.blue { didSet { setNeedsDisplay() } }
    
    
    override func draw(_ rect: CGRect) {
        
        let width = min( bounds.width, bounds.height / CGFloat(sizes.symbolAspectRatio))
        let height = width * CGFloat(sizes.symbolAspectRatio)
        
        let stroke = height * CGFloat(sizes.strokePercent)
        let offset =  height / 28
        let path: UIBezierPath
        
        switch symbol {
            
        case .diamond:
            path = UIBezierPath()
            path.move(to: CGPoint(x: width / 2, y: offset))
            path.addLine(to: CGPoint(x: offset, y: height / 2.0 ) )
            path.addLine(to: CGPoint(x: width / 2, y: height - offset ) )
            path.addLine(to: CGPoint(x: width - offset, y: height / 2.0 ) )
            path.close()
        
        case .squiggle:
            //add curves to form squiggle shape
            path = UIBezierPath()
            let startPoint = CGPoint(x: 3 * width / 8, y: offset)
            
            path.move(to: startPoint )
            path.addCurve(to: CGPoint(x: width / 4, y: height / 6),
                          controlPoint1: CGPoint(x: 3 * width / 8, y: offset),
                          controlPoint2: CGPoint( x: 1 * width / 8, y: 1 * height / 18))
            path.addCurve(to: CGPoint(x: 5 * width / 32, y: 13 * height / 16),
                          controlPoint1: CGPoint(x: 9 * width / 16, y: 8 * height / 16),
                          controlPoint2: CGPoint(x: 3 * -width / 32, y: 7 * height / 16))
            path.addCurve(to: CGPoint(x: 5 * width / 8, y: height - offset),
                          controlPoint1: CGPoint(x: 5 * width / 16, y: 16 * height / 16),
                          controlPoint2: CGPoint(x: 10 * width / 16, y: height - offset))
            
            //append path with mirrored duplicate
            let duplicatePath = UIBezierPath()
            
            duplicatePath.append(path)
            duplicatePath.apply(CGAffineTransform(scaleX: -1, y: -1))
            
            duplicatePath.apply(CGAffineTransform(translationX: rect.origin.x + path.bounds.maxX + startPoint.x , y: rect.origin.y + path.bounds.maxY + startPoint.y * 0.93))
            
            
            path.append(duplicatePath)
            
        case .oval:
            let shapeRect = CGRect(origin: CGPoint(x: offset , y: offset),
                                   size: CGSize(width: width - 2*offset,
                                                height: height - 2*offset ) )
            path = UIBezierPath(roundedRect: shapeRect, cornerRadius: shapeRect.width )

        }
        

        
        switch orientation {
        case .vertical:             //center in view
            path.apply(CGAffineTransform(translationX: (bounds.maxX - width) / 2.0, y: (bounds.maxY - height) / 2.0 ))
        case .horizontal:           //rotate and center in view
            path.apply(CGAffineTransform(rotationAngle: CGFloat.pi / 2  ) )
            path.apply(CGAffineTransform(translationX: (height + bounds.maxX) / 2.0, y: (bounds.maxY - width) / 2.0 ))
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
            
            for _ in 1 ... sizes.numStripes {
                linePoint.x = bounds.width + offset
                stripes.addLine(to: linePoint)
                linePoint.y += height / CGFloat(sizes.numStripes)
                stripes.addLine(to: linePoint)
                linePoint.x = -offset
                stripes.addLine(to: linePoint)
                linePoint.y += height / CGFloat(sizes.numStripes)
                stripes.addLine(to: linePoint)
            }
            
            stripes.lineWidth = stroke
            stripes.stroke()
        }
    }
}
