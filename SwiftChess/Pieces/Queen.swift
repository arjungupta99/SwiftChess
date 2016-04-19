//
//  Queen.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation

class Queen:Piece {
    
    override func canMove(end end:(Int, Int), endPiece:Piece? = nil, registeredMove:Bool = true) -> Bool {
        
        let start = self.position
        
        let straightCheck = self.board.checkClearStraightPath(start: start, end: end)
        
        let diagonalCheck = self.board.checkClearDiagonalPath(start: start, end: end)
        
        if (straightCheck == false && diagonalCheck == false) { return false }
        
        return true
    }
    
    
    override func name() -> String {
        return "queen"
    }
    
    
    override func didMove() {
        
    }
    
    
    override func getMovementPath(end:(Int, Int)) -> [Square]? {
        
        let isStraightPath = self.board.checkClearStraightPath(start: self.position, end: end)
        let isDiagonalPath = self.board.checkClearDiagonalPath(start: self.position, end: end)
        
        if (isStraightPath == false && isDiagonalPath == false) { return nil }
        
        if (isStraightPath) {
            return self.board.straightPathSquares(start: self.position, end: end)
        }
        
        if (isDiagonalPath) {
            return self.board.diagonalPathSquares(start: self.position, end: end)
        }
        
        return nil
    }
}