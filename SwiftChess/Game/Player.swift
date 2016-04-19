//
//  Player.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation

class Player:ColorProtocol {
    
    var colorIsWhite:Bool!
    var availablePieces = [Piece]()
    var capturedPieces  = [Piece]()
    var kingPiece:King!
    
    init (colorIsWhite:Bool) {
        self.colorIsWhite = colorIsWhite
    }
}

protocol ColorProtocol {
    var colorIsWhite:Bool! { get }
}