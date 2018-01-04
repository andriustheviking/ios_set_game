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
    
    var startDeal = 12
    
    override func viewDidLoad() {
        updateUI()
    }

    var game = SetGame(deal: 16, of: 24) {
        didSet{
            updateUI()
        }
    }
    
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var scoreUI: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBAction func playAgain(_ sender: UIButton) {
        game = SetGame(deal: 16, of: buttons.count)
    }
    
    @IBAction func drawCards(_ sender: UIButton) {
        game.drawThreeCards()
        updateUI()
    }
    
  
    @IBAction func touchCard(_ sender: UIButton) {
        game.selectCard(index: buttons.index(of: sender)!)
        updateUI()
    }

    
    func updateUI() {
        
        var enableDrawCard = false
        
        for i in buttons.indices {
            
            let button = buttons[i]
            
            //draw empty button
            button.layer.cornerRadius = 8.0
            button.layer.borderWidth = 0.0
            button.backgroundColor = nil
            button.setAttributedTitle(nil, for: UIControlState.normal)
            
            if let card = game.getCard(at: i) {
                
                drawCardFace(for: card, on: button)
                
                if game.isSelected(at: i) {
                    buttons[i].layer.borderWidth = 3.0
                    buttons[i].layer.borderColor = UIColor.blue.cgColor
                }
                
            } else {
                enableDrawCard = true
            }
        }
        
        drawCardButton.isEnabled = enableDrawCard
        scoreUI.text = "Score: " + String(game.playerScore)
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

