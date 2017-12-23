//
//  SetGameModel.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import Foundation

class SetGame {

    private var deck = [Card]()
    
    private var table = [(card: Card, selected: Bool)]()

    var tableCount: Int {
        get {
            return table.count
        }
    }
    
    func getCard(at index: Int) -> Card? {
        return index < table.count ? table[index].card : nil
    }
    
    func isSelected(cardIndex: Int) -> Bool {
        if cardIndex < table.count {
            return table[cardIndex].selected
        }
        return false
    }
    
    func selectCard(index: Int) {
        if index < table.count {
            if table.filter({ $0.selected }).count >= 3 {
                for index in table.indices {
                    table[index].selected = false
                }
            }
            table[index].selected = true
        }
    }
    
    
    init(deal numCards: Int) {

        //initialize deck
        let cardNumbers = [Number.one, Number.two, Number.three]
        let cardSymbols = [SymbolType.A, SymbolType.B, SymbolType.C]
        let cardShades = [Shading.solid, Shading.open, Shading.striped]
        let cardColor = [Color.A, Color.B, Color.C]
        
        for number in cardNumbers {
            for symbol in cardSymbols {
                for shade in cardShades {
                    for color in cardColor {
                        deck.append(Card(number: number, symbol: symbol, shade: shade, color: color))
                    }
                }
            }
        }
        
        //shuffle deck
        var randomRange: Int
        var tempCard: Card
        var randomIndex: Int
        
        for index in deck.indices {
            
            randomRange = deck.count - index
            randomIndex = Int( arc4random_uniform( UInt32(randomRange)))
          
            tempCard = deck[randomIndex]
            deck[randomIndex] = deck[ randomRange - 1 ]
            deck[ randomRange - 1] = tempCard
        }
        
        //deal cards to table
        for _ in 0..<numCards {
            if let card = deck.popLast() {
                table.append( (card, false) )
            }
        }
    }
    
    

}
