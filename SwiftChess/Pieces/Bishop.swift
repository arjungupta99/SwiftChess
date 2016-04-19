//
//  Bishop.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation

class Bishop:Piece {
    
    override func canMove(end end:(Int, Int), endPiece:Piece? = nil, registeredMove:Bool = true) -> Bool {
        
        let start = self.position
        
        if (self.board.checkClearDiagonalPath(start: start, end: end) == false) { return  false }
        
        return true
    }
    
    
    override func name() -> String {
        return "bishop"
    }
    
    
    override func didMove() {
        
    }
    
    
    override func getMovementPath(end:(Int, Int)) -> [Square]? {
        
        if (board.checkClearDiagonalPath(start: self.position, end: end) == false) { return  nil }
        
        return board.diagonalPathSquares(start: self.position, end: end)
    }
}