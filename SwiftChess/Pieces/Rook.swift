//
//  Rook.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation

class Rook:Piece {
    
    var castlingPossible = true
    
    override func canMove(end end:(Int, Int), endPiece:Piece? = nil, registeredMove:Bool = true) -> Bool {
        
        let start = self.position
        
        if (self.board.checkClearStraightPath(start: start, end: end) == false) { return  false }
        
        return true
    }
    
    
    override func name() -> String {
        return "rook"
    }
    
    
    override func didMove() {
        self.castlingPossible = false
    }
    
    
    override func getMovementPath(end:(Int, Int)) -> [Square]? {
        
        if (self.board.checkClearStraightPath(start: self.position, end: end) == false) { return  nil }
        
        return self.board.straightPathSquares(start: self.position, end: end)
    }
}