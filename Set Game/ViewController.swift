//
//  ViewController.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gameColors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
    
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
        game.drawThreeCards()

    }



    
    
    private func drawCardFace(for card: Card, on cardFace: UIView){

    }
}

