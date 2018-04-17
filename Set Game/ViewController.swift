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
    let numCols = 4
    
    var game = SetGame(deal: 1, of: 24)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.distribution = .fillEqually
        tableView.alignment = .leading
        tableView.spacing = 5.0
        updateTableView()
    }
    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var scoreUI: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var tableView: UIStackView!
    
    @IBAction func playAgain(_ sender: UIButton) {
        game = SetGame(deal: 1, of: 24)
        updateTableView()
    }
    
    @IBAction func drawCards(_ sender: UIButton) {
        game.drawCard()
        updateTableView()
    }


    func updateTableView() {
        
        for view in tableView.subviews {
            view.removeFromSuperview()
        }
        
        var row: UIStackView

        for i in 0..<game.tableCount {

            if let card = game.getCard(at: i) {

                if i % numCols == 0 {
                    row = addTableRow()
                    tableView.addArrangedSubview(row)
                }
                else {
                    row = tableView.subviews.last! as! UIStackView
                }

                let cardFace = CardFaceView()
                row.addArrangedSubview(cardFace)
                let cardSize = tableView.bounds.width / CGFloat( numCols + 1)
                cardFace.createFace(for: card, size: cardSize)
            }
            tableView.setNeedsDisplay()
            tableView.setNeedsLayout()
        }
    }
    
    
    func addTableRow() -> UIStackView {
        
        let row = UIStackView()
        
        row.distribution = .fillEqually
//        row.alignment = .center
        
        row.widthAnchor.constraint(equalToConstant: tableView.bounds.width ).isActive = true
        
        return row
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
