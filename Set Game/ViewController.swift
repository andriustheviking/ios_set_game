//
//  ViewController.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startDeal = 24
    var symbolColors = [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
    let selectColor = UIColor.lightGray
    
    var timer = Timer()
    var time = 0
    var game = SetGame(deal: 0)
    
    
    var numCols: Int {
        if game.tableCount <= 12 { return 3 }
        else if game.tableCount <= 28 { return 4 }
        else { return 6 }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = SetGame(deal: startDeal)
        updateUI()
        
        //initilize timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerAction), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        updateUI()
        
    }
    
    
    func timerAction() {
        scoreUI.text = String(time)
        time += 1
    }
    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var scoreUI: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var tableView: UIStackView!
    
    @IBAction func playAgain(_ sender: UIButton) {
        game = SetGame(deal: startDeal)
        time = 0
        updateUI()
    }
    
    @IBAction func drawCards(_ sender: UIButton) {
        game.drawThreeCards()
        updateUI()
    }

    func updateUI(){
        updateTableView()
    }

    
    
    func updateTableView() {
        //clear out tableView
        for view in tableView.subviews {
            view.removeFromSuperview()
        }
        
        var row: UIStackView
        
        tableView.axis = tableView.bounds.height > tableView.bounds.width ? .vertical : .horizontal
        
        for i in 0..<game.tableCount {

            if let card = game.getCard(at: i) {
                
                if i % numCols == 0 {
                    row = addTableRow()
                    
                    tableView.addArrangedSubview(row)
                }
                else {
                    row = tableView.subviews.last! as! UIStackView
                }
                
                row.addArrangedSubview(createCardView(card: card, index: i))

            }
        }
        tableView.setNeedsDisplay()
        tableView.setNeedsLayout()
    }
    
    @objc func tapCard(sender: UITapGestureRecognizer){
        if let cardView = sender.view {
            game.selectCard(index: cardView.tag)
            updateUI()
        }
    }
    
    
    func createCardView(card: Card, index: Int) -> UIView {

        let cardFace = CardFaceView()
        cardFace.colors = symbolColors
        cardFace.tag = index
        
        //add tap gesture
        let cardTap = UITapGestureRecognizer(target: self, action: #selector(self.tapCard(sender:)))
        cardFace.addGestureRecognizer(cardTap)
        
        //calc orientation
        let orientation: Orientation = tableView.bounds.height > tableView.bounds.width ? .vertical : .horizontal
        
        //calc cardsize
        var cardSize: CGFloat

        if orientation == .vertical {
            cardSize = tableView.bounds.width  / CGFloat( numCols) - 5
        }
        else {
            //int division rounded up to find rows
            cardSize = tableView.bounds.height  / CGFloat( numCols) - 5
        }
        
        //create cardface
        cardFace.createFace(for: card, size: cardSize, orientation: orientation)
        
        //color selected card
        if game.cardIsSelected(at: index) {
            for view in cardFace.subviews {
                view.backgroundColor = selectColor
            }
        }
        return cardFace
    }
    
    
    func addTableRow() -> UIStackView {
        let row = UIStackView()
        row.distribution = .fillEqually
        
        if tableView.bounds.height > tableView.bounds.width{
            row.axis =  .horizontal
            row.widthAnchor.constraint(equalToConstant: tableView.bounds.width ).isActive = true
        }
        else {
            row.axis = .vertical
            row.heightAnchor.constraint(equalToConstant: tableView.bounds.height ).isActive = true
        }
        
    
        

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
