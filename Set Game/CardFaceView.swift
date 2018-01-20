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
    
    private let symbolColors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
    
    
    func createFace(for card: Card){
        
        let symbolView = SymbolView()
        
        symbolView.symbol = card.symbol
        symbolView.shading = card.shade
        symbolView.color = UIColor(cgColor: symbolColors[card.color.rawValue].cgColor)
        
        addSubview(symbolView)
        
        
        symbolView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.layoutMarginsGuide
        symbolView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        symbolView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        symbolView.heightAnchor.constraint(equalTo: margins.heightAnchor).isActive = true
        
        
//        var stackSymbols = [SymbolView]()
//        
//        for _ in 0..<card.number.rawValue {
//            stackSymbols.append(symbolView)
//        }
//        
//        let stackView = UIStackView(arrangedSubviews: stackSymbols)
//        
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.alignment = .fill
//
//        self.addSubview( stackView )

        
        setNeedsDisplay()
        setNeedsLayout()
        
    }
}

