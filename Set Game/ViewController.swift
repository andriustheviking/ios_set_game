//
//  ViewController.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gameSymbols = "▲●■"
    let gameColors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
    
    var maxCards = Int()
    
//TODO: startDeal should be set based off buttons' background
    var startDeal = 12
//TODO: game should be off startDeal
    var game = SetGame(deal: 16, of: 24)
    
    @IBOutlet var buttons: [UIButton]!{
        didSet {
            maxCards = buttons.count
            drawGame()
        }
    }
    
    
    @IBOutlet weak var drawCardButton: UIButton?
    
    
    @IBAction func drawCards(_ sender: UIButton) {
        game.drawThreeCards()
        drawGame()
    }
    
    
    
    func drawGame() {
        
        var enableDrawCard = false
        
        for i in buttons.indices {
        
            let button = buttons[i]
            
            button.layer.cornerRadius = 8.0
            
            if let card = game.getCard(at: i) {
                
                drawCardFace(for: card, on: button)
                
                if game.isSelected(at: i) {
                    buttons[i].layer.borderWidth = 3.0
                    buttons[i].layer.borderColor = UIColor.blue.cgColor
                }
                else {
                    buttons[i].layer.borderWidth = 0.0
                    buttons[i].layer.borderColor = UIColor.blue.cgColor
                }
            
            } else {
                button.backgroundColor = nil
                enableDrawCard = true
            }
            
            drawCardButton?.isEnabled = enableDrawCard
            
        }
    }
    
    
    //highlights all selected cards
    @IBAction func touchCard(_ sender: UIButton) {
        
        game.selectCard(index: buttons.index(of: sender)!)

        drawGame()

    }

    
    
    
    private func drawCardFace(for card: Card, on button: UIButton){
        
        var cardFaceString = String()
        
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
                fontAlpha = 0.40
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

