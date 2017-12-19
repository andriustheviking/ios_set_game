//
//  SetGameModel.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import Foundation

class SetGame {
    
    var deck = [Card]()
    
    init() {
        
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
            deck[randomIndex] = deck[ randomRange ]
            deck[ randomRange ] = tempCard
        }
        
    }

    
    func selectCard(_ card: Card){
        
    }

}
