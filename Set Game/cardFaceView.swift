//
//  cardFaceView.swift
//  Set Game
//
//  Created by Andrius Kelly on 1/5/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//

import UIKit

//@IBDesignable
class CardFaceView: UIView {

    private struct sizing {
        static let ratio = CGFloat( 0.25 )
    }
    
    @IBInspectable
    var number = 1
    @IBInspectable
    var symbol = SymbolType.diamond
    @IBInspectable
    var shading = Shading.solid
    @IBInspectable
    var color = UIColor.blue
    
    
    
    init(frame: CGRect, num: Int, sym: SymbolType, shade: Shading, color: UIColor) {

        number = num
        symbol = sym
        shading = shade
        self.color = color
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        let ratio = sizing.ratio

        let symbolOrigin = CGPoint(x: bounds.midX * (1.0 - ratio), y: bounds.midY * (1.0 - ratio))
        
        
        
        let rect = CGRect(origin: symbolOrigin, size: CGSize(width: bounds.width * ratio, height: bounds.height * ratio ) )
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.width )
        
        path.lineWidth = 5.0
        color.setStroke()
        path.stroke()
        
    }


}

