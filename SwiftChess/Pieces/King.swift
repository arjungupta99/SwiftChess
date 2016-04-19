//
//  King.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation

class King:Piece {
    
    var hasCheck            = false
    var castlingPossible    = true
    
    override func canMove(end end:(Int, Int), endPiece:Piece? = nil, registeredMove:Bool = true) -> Bool {
        
        let start = self.position
        
        //Castling
        if (self.castlingPossible == true && endPiece == nil && self.hasCheck == false) {
            
            if (abs(end.0 - start.0) == 2 && self.board.checkClearStraightPath(start: start, end: end) == true) {
                
                var rookPiece:Piece?
                var rookStartSquare:Square?
                var rookEndSquare:Square?
                
                if (end.0 - start.0 == -2) {
                    //Left side
                    rookStartSquare = (self.colorIsWhite == true) ? self.board.squares[0][0] : board.squares[7][0]
                    rookEndSquare   = (self.colorIsWhite == true) ? self.board.squares[0][3] : board.squares[7][3]
                    rookPiece       = rookStartSquare!.occupyingPiece
                }
                else {
                    //Right side
                    rookStartSquare = (self.colorIsWhite == true) ? self.board.squares[0][7] : board.squares[7][7]
                    rookEndSquare   = (self.colorIsWhite == true) ? self.board.squares[0][5] : board.squares[7][5]
                    rookPiece       = rookStartSquare!.occupyingPiece
                }
                
                if let theRook  = rookPiece as? Rook {
                    if (theRook.castlingPossible == true) {
                        
                        self.board.moveOccupyingPieceFromSquare(rookStartSquare!, endSquare: rookEndSquare!)
                        
                        DebugLog("Casteling Executed")
                        return true
                    }
                }
            }
        }
        
        if (abs(end.0 - start.0) > 1 || abs(end.1 - start.1) > 1) { return false }
        
        if (abs(end.0 - start.0) == 1 || abs(end.1 - start.1) == 1) { return true }
        
        return false
    }
    
    
    override func name() -> String {
        return "king"
    }
    
    
    override func didMove() {
        self.castlingPossible = false
    }
    
    
    override func getMovementPath(end:(Int, Int)) -> [Square]? {
        
        return nil
    }
}