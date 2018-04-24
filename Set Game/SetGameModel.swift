//
//  SetGameModel.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import Foundation



extension Array  {
    
    func isValidSet (_ fn: (Element, Element) -> Bool ) -> Bool {
       
        var same = true
        var diff = true
        
        for i in self.indices {
            for j in self.indices {
                if j != i {
                    same = same && fn( self[i], self[j] )
                    diff = diff && !fn( self[i], self[j] )
                }
            }
        }
        return same || diff
    }
}


class SetGame {
    
    private var deck = [Card]()
    
    private var table = [ (card: Card, selected: Bool)? ]()
    
    private var score = 0
    
    var playerScore: Int { get { return score }    }
    
    var tableCount: Int {
        get {
            for i in 0..<table.count {
                if table[i] == nil {
                    return i + 1
                }
            }
            return table.count
        }   }
    
    var isOver: Bool { get { return deck.isEmpty && table.isEmpty } }
    
    func getCard(at index: Int) -> Card? {
        return index < table.count ? table[index]?.card : nil
    }
    
    func cardIsSelected(at index: Int) -> Bool {
        if let position = table[index] {
            return position.selected
        }
        return false
    }

    
    func selectCard(index: Int) {
        
        if let space = table[index] {
            
            table[index]?.selected = !space.selected
            
            let cards = table.filter({ $0?.selected ?? false}).map({$0!.card})
            
            if cards.count == 3 {
                
                //check if valid set
                let isValid = cards.isValidSet { $0.color == $1.color }  &&
                    cards.isValidSet { $0.number == $1.number } &&
                    cards.isValidSet { $0.shade == $1.shade } &&
                    cards.isValidSet { $0.symbol == $1.symbol }

                //remove cards from table and draw three more
                if isValid {
                    for _ in 0..<3 {
                        for i in table.indices {
                            if table[i]?.selected == true {
                                table.remove(at: i)
                                break
                            }
                        }
                    }
                    score += 1
                    drawThreeCards()
                } else {
                    score -= 1
                }
                
                for i in table.indices {
                        table[i]?.selected = false
                }
            }
        }
    }
    
    
    func drawThreeCards() {
        for _ in 0..<3 {
            drawCard()
        }
    }

    func drawCard(){
        if let card = deck.popLast() {
            table.append( (card, false) )
        }
    }
    
    init(deal numCards: Int) {

        //initialize deck
        let cardNumbers = [Number.one, Number.two, Number.three]
        let cardSymbols = [SymbolType.diamond , SymbolType.oval, SymbolType.squiggle]
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
            drawCard()
        }
    }
}
