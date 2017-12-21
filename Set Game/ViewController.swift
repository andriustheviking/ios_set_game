//
//  ViewController.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let startDeal = 12
    let gameSymbols = "▲●■"
    let gameColors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
    
    
    var game = SetGame(startDeal: 12)
    
    
    @IBOutlet var buttons: [UIButton]!

    
    @IBAction func touchCard(_ sender: UIButton) {
        selectCard(on: sender)
    }

    
    
    func selectCard(on button: UIButton){
        let tableIndex = buttons.index(of: button)!
        if (tableIndex < game.table.count)  {
            drawCardFace(for: game.table[tableIndex] , on: button)
        }
    }
    
    
    
    private func drawCardFace(for card: Card, on button: UIButton){
        
        var symbolIndex = gameSymbols.startIndex
        
        //get the specific symbol of the face card
        switch card.symbol{
            case .A:
                break
            case .B:
                symbolIndex = gameSymbols.index(after: symbolIndex)
            case .C:
                symbolIndex = gameSymbols.index(symbolIndex, offsetBy: 2)
        }
        
        var cardFaceString = String()
        
        //add number of symbols to cardString
        for _ in 0 ..< card.number.rawValue {
            cardFaceString.append( gameSymbols[symbolIndex] )
            cardFaceString.append(" ")
        }

        //set color
        let cardColor = UIColor(cgColor: gameColors[card.color.rawValue].cgColor)
        
        //set shade and outline if necessary
        var strokeWidth = NSNumber(value: 0.0)
        var fontAlpha = CGFloat(1.0)
        
        switch card.shade {
            case .solid:
                break
            case .striped:
                fontAlpha = 0.15
            case .open:
                fontAlpha = 0.0
                strokeWidth = NSNumber(floatLiteral: 6.0)
        }
        
        let attributes = [
            NSForegroundColorAttributeName : cardColor.withAlphaComponent(fontAlpha),
            NSStrokeColorAttributeName : cardColor,
            NSStrokeWidthAttributeName : strokeWidth
        ] as [String : Any]
        
        let cardFace = NSAttributedString(string: cardFaceString, attributes: attributes)
        
        button.setAttributedTitle(cardFace, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    }
}

