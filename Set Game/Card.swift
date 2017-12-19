//
//  Card.swift
//  Set Game
//
//  Created by Andrius Kelly on 12/19/17.
//  Copyright © 2017 Andrius Kelly. All rights reserved.
//

import Foundation

enum Number: Int {
    case one = 1
    case two
    case three
}

enum SymbolType {
    case A, B, C
}

enum Shading {
    case solid, striped, open
}

enum Color {
    case A, B, C
}

struct Card {

    let number: Number
    
    let symbol: SymbolType
    
    let shade: Shading
    
    let color: Color
    
}
