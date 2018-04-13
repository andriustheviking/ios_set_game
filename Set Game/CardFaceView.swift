//
//  cardFaceView.swift
//  Set Game
//
//  Created by Andrius Kelly on 1/5/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//

import UIKit

//@IBDesignable
class CardFaceView: UIStackView {
    
    private let symbolColors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
    
    func createFace(for card: Card, size: CGFloat){
        
        for view in subviews {
            view.removeFromSuperview()
        }
        
        distribution = .fillEqually
        alignment = .center
        spacing = 0.0
        
        translatesAutoresizingMaskIntoConstraints = false
        
        //add symbols
        for _ in 1...card.number.rawValue {
            
            let symbolView = SymbolView()
            
            //set symbol properties
            symbolView.symbol = card.symbol
            symbolView.shading = card.shade
            symbolView.color = UIColor(cgColor: symbolColors[card.color.rawValue].cgColor)
            
            symbolView.backgroundColor = self.backgroundColor
            
            addArrangedSubview(symbolView)
            
            //if view is wider than tall, arrange symbols horizontally, sym.height = self.height, sym.width = self.width/3
            if self.bounds.maxX > self.bounds.maxY {
                axis = .horizontal
                symbolView.heightAnchor.constraint(equalToConstant: size ).isActive = true
            }
            else {
                axis = .vertical
                symbolView.orientation = .horizontal
                symbolView.widthAnchor.constraint(equalToConstant: size ).isActive = true
            }
        }

        //redraw
        setNeedsDisplay()
        setNeedsLayout()
    }
}



