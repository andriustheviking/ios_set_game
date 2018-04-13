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
    
    var game = SetGame(deal: 16, of: 24)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableView()

    }

    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var scoreUI: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var tableView: UIStackView!
    @IBOutlet weak var tempCard: CardFaceView!


    
    @IBAction func playAgain(_ sender: UIButton) {
        game = SetGame(deal: 16, of: 24)
    }
    
    @IBAction func drawCards(_ sender: UIButton) {
//        game.drawThreeCards()
        updateTableView()
    }


    func updateTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        if let card = game.getCard(at: game.tableCount.arc4random ) {

            tempCard.createFace(for: card)
            
            let cardView = CardFaceView()
            
            tableView.addArrangedSubview(cardView)
            
            cardView.backgroundColor = UIColor.yellow
            
            cardView.createFace(for: card)
        }
    }
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
