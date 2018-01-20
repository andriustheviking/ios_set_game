//
//  ViewController.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startDeal = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    var game = SetGame(deal: 16, of: 24)
    

    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var scoreUI: UILabel!
    @IBOutlet weak var playBtn: UIButton!

    
    @IBAction func playAgain(_ sender: UIButton) {
        game = SetGame(deal: 16, of: 24)
    }
    
    
    
    @IBAction func drawCards(_ sender: UIButton) {
//        game.drawThreeCards()

        if let card = game.getCard(at: game.tableCount.arc4random ) {
            cardFace.createFace(for: card)
        }
        
    }
    
    //temp cardface
    @IBOutlet weak var cardFace: CardFaceView!
    

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int( arc4random_uniform( UInt32(self) ))
        }
        else if self < 0 {
            return -Int( arc4random_uniform( UInt32(self) ))
        }
        else {
            return 0
        }
    }
}
