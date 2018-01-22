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
        addStackView(stackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addStackView(stackView)
    }
    

    
    
    func createFace(for card: Card){

//        
//        //add cards to stack view
//        let symbolView = SymbolView()
//        
//        symbolView.symbol = card.symbol
//        symbolView.shading = card.shade
//        symbolView.color = UIColor(cgColor: symbolColors[card.color.rawValue].cgColor)
//        
//        
//        for _ in 0..<1{
//         stackView.addSubview(symbolView)
//        }
        



        //update drawing
        stackView.setNeedsDisplay()
        stackView.setNeedsLayout()
        setNeedsDisplay()
        setNeedsLayout()
        
    }
}

extension UIView {
    
    func addStackView(_ stackView: UIStackView ){
        
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        if self.bounds.height > self.bounds.width {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
        
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let viewsDict = ["stackView": stackView]
        let constraintString = "|-[stackView]-|"
        
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:" + constraintString,  //horizontal constraint 20 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDict)
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:" + constraintString, //vertical constraint 30 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDict)
        stackView.addConstraints(stackView_H)
        stackView.addConstraints(stackView_V)
        

        
        stackView.backgroundColor = UIColor.yellow
        
        print("X: " + String(describing: stackView.frame.maxX), ", Y: " + String(describing: stackView.frame.maxY))
    }
}

