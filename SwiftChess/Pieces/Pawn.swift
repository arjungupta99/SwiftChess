//
//  Pawn.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation

class Pawn:Piece {
    
    private var twoStepStartTaken:Bool = false //For En Passant pawn capture
    
    override func canMove(end end:(Int, Int), endPiece:Piece? = nil, registeredMove:Bool = true) -> Bool {
        
        let start = self.position
        
        func checkEnPassant() -> Bool {
            
            if (registeredMove == false) { return false }
            let lastMove = self.board.lastMove
            if (lastMove != nil) {
                if let lastMovePiece = lastMove!.piece as? Pawn {
                    if (lastMovePiece.twoStepStartTaken == true) {
                        if (end.0 == lastMove!.end.0) {
                            var comparePos:Int {
                                if (self.colorIsWhite == true) {
                                    return lastMove!.end.1 + 1
                                }
                                return lastMove!.end.1 - 1
                            }
                            if (end.1 == comparePos) {
                                let square = self.board.squares[lastMove!.end.1][lastMove!.end.0]
                                self.board.removePieceAtSquare(square)
                                DebugLog("En Passant!")
                                return true
                            }
                        }
                    }
                }
            }
            return false
        }
        
        
        func checkpawnPromotion() {
            
            if (registeredMove == false) { return }
            let finalPoint = (self.colorIsWhite == true) ? 7 : 0
            if (end.1 == finalPoint) {
                self.board.openPawnPromotionView(self)
            }
        }
        
        
        if (self.colorIsWhite == true) {
            
            if (start.1 > end.1) { return false }
            
            if (endPiece == nil) {
                
                if (start.0 == end.0) {
                    if (self.board.checkClearStraightPath(start: start, end: end) == false) { return  false }
                }
                
                if (start.0 != end.0) { //En Passant check
                    return checkEnPassant()
                }
                
                if (start.1 == 1) { //At start
                    if (end.1 > start.1 + 2) { return false }
                    if (end.1 == start.1 + 2) {
                        self.twoStepStartTaken = true
                    }
                }
                else {              //Not at start
                    if (end.1 > start.1 + 1) { return false }
                    self.twoStepStartTaken = false
                }
            }
            else { //End occupied
                
                if (end.1 == start.1 + 1 && (end.0 == start.0 + 1 || end.0 == start.0 - 1)) {
                    self.twoStepStartTaken = false
                    checkpawnPromotion()
                    return true
                }
                return false
            }
        }
        else {
            
            if (start.1 < end.1) { return false }
            
            if (endPiece == nil) {
                
                if (start.0 == end.0) {
                    if (self.board.checkClearStraightPath(start: start, end: end) == false) { return  false }
                }
                    
                if (start.0 != end.0) { //En Passant check
                    return checkEnPassant()
                }
                
                if (start.1 == 6) { //At start
                    if (end.1 < start.1 - 2) { return false }
                    
                    if (end.1 == start.1 - 2) {
                        self.twoStepStartTaken = true
                    }
                }
                else {              //Not at start
                    if (end.1 < start.1 - 1) { return false }
                    self.twoStepStartTaken = false
                }
            }
            else { //End occupied
                
                if (end.1 == start.1 - 1 && (end.0 == start.0 + 1 || end.0 == start.0 - 1)) {
                    self.twoStepStartTaken = false
                    checkpawnPromotion()
                    return true
                }
                return false
            }
        }
        
        checkpawnPromotion()
        return true
    }
    
    
    override func name() -> String {
        return "pawn"
    }
    
    
    override func didMove() {
        
    }
    
    override func getMovementPath(end:(Int, Int)) -> [Square]? {
        
        return nil
    }
}