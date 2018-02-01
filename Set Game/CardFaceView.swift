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
    
    //add stackview
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    

    
    
    func createFace(for card: Card){
        
        for view in stackView.subviews {
            view.removeFromSuperview()
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = false

        stackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor ).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor ).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor ).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 0.0
        
        
        //add symbols
        for _ in 1...card.number.rawValue {
            
            let symbolView = SymbolView()
            
            //set symbol properties
            symbolView.symbol = card.symbol
            symbolView.shading = card.shade
            symbolView.color = UIColor(cgColor: symbolColors[card.color.rawValue].cgColor)
            
            symbolView.translatesAutoresizingMaskIntoConstraints = false

//TODO: manually space symbols and add all three.
            
//            symbolView.backgroundColor = self.backgroundColor
            
            stackView.addArrangedSubview(symbolView)
            
            //if view is wider than tall, arrange symbols horizontally, sym.height = self.height, sym.width = self.width/3
            if self.bounds.maxX > self.bounds.maxY {
                stackView.axis = UILayoutConstraintAxis.horizontal
                symbolView.heightAnchor.constraint(equalToConstant: stackView.bounds.height ).isActive = true
            }
            else {
                stackView.axis = UILayoutConstraintAxis.vertical
                symbolView.widthAnchor.constraint(equalToConstant: stackView.bounds.height / 4.0 ).isActive = true
                symbolView.orientation = .horizontal
            }            
        }
        
        stackView.setNeedsDisplay()
        stackView.setNeedsLayout()
        setNeedsDisplay()
        setNeedsLayout()
    }
    
}

extension UIView {
    
    func addStackView(_ stackView: UIStackView ){
        
        // TODO: https://stackoverflow.com/questions/30728062/add-views-in-uistackview-programmatically
        
        print("X: " + String(describing: stackView.frame.maxX), ", Y: " + String(describing: stackView.frame.maxY))
    }
}

