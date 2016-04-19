//
//  Game.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation
import UIKit

class Game:BoardDelegate {
    
    var turnIsWhite:Bool = true
    
    var board:Board!
    let playerWhite = Player(colorIsWhite: true)
    let playerBlack = Player(colorIsWhite: false)
    
    var startSquare:Square?
    var endSquare:Square?
    
    
    init(boardWidth:CGFloat) {
        self.board  = Board(boardWidth: boardWidth)
        self.board.delegate = self
        placePieces(self.playerWhite)
        placePieces(self.playerBlack)
    }
    
    
    
    //MARK:- Board Setup
    
    
    //Placing pieces such that the horizontal axis goes from A - H and the vertical goes from 0 - 7
    func placePieces(player:Player) {
        
        let colorIsWhite = player.colorIsWhite
        
        func makePiece(i:Int, j:Int) {
            
            let square = self.board.squares[j][i]
            var piece:Piece?
            
            if (j == 0 || j == 7) {
                switch i {
                case 0 : piece = Rook   (colorIsWhite: colorIsWhite, board: self.board)
                case 1 : piece = Knight (colorIsWhite: colorIsWhite, board: self.board)
                case 2 : piece = Bishop (colorIsWhite: colorIsWhite, board: self.board)
                case 3 : piece = Queen  (colorIsWhite: colorIsWhite, board: self.board)
                case 4 : piece = King   (colorIsWhite: colorIsWhite, board: self.board); player.kingPiece = piece as! King
                case 5 : piece = Bishop (colorIsWhite: colorIsWhite, board: self.board)
                case 6 : piece = Knight (colorIsWhite: colorIsWhite, board: self.board)
                case 7 : piece = Rook   (colorIsWhite: colorIsWhite, board: self.board)
                default: piece = nil
                }
            }
            else if (j == 1 || j == 6){
                piece = Pawn(colorIsWhite: colorIsWhite, board: self.board)
            }
            else {
                piece = nil
            }
            
            if (piece != nil) {
                square.occupyingPiece = piece!
                player.availablePieces.append(piece!)
                piece!.position = (i, j)
            }
            //DebugLog("\(i):\(j) :: \(square.occupyingPiece)")
        }
        
        if (colorIsWhite == true) {
            
            for i in 0..<8 {
                for j in 0...1 {
                    makePiece(i, j: j)
                }
            }
        }
        else {
            for i in 0..<8 {
                for j in (6...7).reverse() {
                    makePiece(i, j: j)
                }
            }
        }
    }
    
    
    
    //MARK:- Game Delegate
    
    
    
    func squarePressed(square:Square, position:(Int, Int)) {
        
        //DebugLog("square : \(square.position)")
        
        if (self.startSquare == square) { return }
        
        if (self.startSquare == nil && self.endSquare == nil && square.occupyingPiece != nil) {
            
            if (square.occupyingPiece!.colorIsWhite != self.turnIsWhite) {
                let colorStr = self.turnIsWhite ? "White" : "Black"
                DebugLog("!!!!! It's \(colorStr)'s turn")
                return
            }
            
            self.startSquare = square
            self.startSquare!.changeActiveState(true)
        }
        else if (self.startSquare != nil && self.endSquare == nil){
            self.endSquare = square
            self.move(start: self.startSquare!.position, end: self.endSquare!.position)
            self.startSquare!.changeActiveState(false)
            self.startSquare = nil
            self.endSquare = nil
            
            
            self.detectCheckMate()
        }
    }
    
    //Used when a piece is captured by a player
    func removePieceFromPlayer(piece:Piece, position:(Int,Int)) {
        
        let thePlayer:Player = (piece.colorIsWhite == true) ? self.playerWhite : self.playerBlack
        
        var removeIndex:Int?
        var theIndex:Int = 0
        for aPiece in thePlayer.availablePieces {
            if (aPiece.name() == piece.name() && aPiece.position == position) {
                removeIndex = theIndex
            }
            theIndex += 1
        }
        if (removeIndex != nil) {
            thePlayer.availablePieces.removeAtIndex(removeIndex!)
        }
    }
    
    //Used during undo operations and Pawn promotion
    func addPieceForPlayer(piece:Piece, detectCheckMate:Bool) {
        
        let player = (piece.colorIsWhite == true) ? self.playerWhite : self.playerBlack
        player.availablePieces.append(piece)
        
        if (detectCheckMate == true) {
            self.detectCheckMate()
        }
    }
    
    
    
    //MARK:- Move Methods
    
    
    //This method is used in moving a piece and checking its legality
    //registerMove comes into play when we are iterating the pieces for king check. (checking legality without a move)
    
    func move(start start:(Alpha, Int), end:(Alpha, Int), registerMove:Bool = true) -> (canMove:Bool, checkingPieces:[Piece]?) {
        
        let startXIndex = start.0.rawValue
        let startYIndex = start.1
        let endXIndex   = end.0.rawValue
        let endYIndex   = end.1
        
        let startSquare = self.board.squares[startYIndex][startXIndex]
        let endSquare   = self.board.squares[endYIndex][endXIndex]
        
        guard let startPiece    = startSquare.occupyingPiece else { DebugLog("!!!!! Start in nil"); return (false, nil) }
        let endPiece            = endSquare.occupyingPiece
        
        //Start and end are same player pieces
        
        if (endPiece != nil) {
            if (startPiece.colorIsWhite == endPiece!.colorIsWhite) { //Occupied by same piece. Ignore
                return (false, nil)
            }
        }
        
        var legal = false
        if (startPiece.colorIsWhite == self.turnIsWhite) {
            
            legal = startPiece.canMove(end: (endXIndex, endYIndex), endPiece: endPiece)
            if (legal) {
                
                self.board.moveOccupyingPieceFromSquare(startSquare, endSquare: endSquare)
                
                let checkingPieces = self.canMoveWithoutKingCheck(startPiece)
                if (checkingPieces != nil) {
                    
                    self.board.undoLastMove()
                    let colorStr = self.turnIsWhite ? "White" : "Black"
                    DebugLog("\(colorStr) King will be on check! Not Legal!")

                    return (false, checkingPieces)
                }
                else {
                    
                    if (registerMove == true) {
                        self.turnIsWhite = !self.turnIsWhite
                        startPiece.didMove()
                    }
                    else {
                        self.board.undoLastMove() //Since we are not registering this move
                    }
                    
                    return (true, nil)
                }
            }
        }
        else {
            let colorStr = self.turnIsWhite ? "Black" : "White"
            DebugLog("!!!!! Not your turn \(colorStr)")
        }
        
        //DebugLog("Start : \(startSquare.occupyingPiece) , End : \(endSquare.occupyingPiece) : \(legal)")
        
        return (false, nil)
    }
    
    
    
    //MARK: Post Movement check detection
    
    
    
    func canMoveWithoutKingCheck(excludePiece:Piece) -> [Piece]? { //return checking piece
        
        let opponentPlayer:Player   = self.turnIsWhite ? self.playerBlack : self.playerWhite
        let currentPlayer:Player    = self.turnIsWhite ? self.playerWhite : self.playerBlack
        
        var checkingPieces = [Piece]()
        for piece in opponentPlayer.availablePieces {
            let legal = piece.canMove(end: currentPlayer.kingPiece.position, endPiece: currentPlayer.kingPiece, registeredMove: false)
            
            //DebugLog("\(piece) \(piece.colorIsWhite) : legal : \(legal)")
            
            //Legal means check
            if (legal == true) {
                checkingPieces.append(piece)
            }
            
            //DebugLog("piece : \(piece) :: Position : \(piece.position) :: legal :: \(legal)")
        }
        if (checkingPieces.count == 0) { return nil }
        
        return checkingPieces
    }
    
    
    
    //MARK: Checkmate detection
    
    
    
    func detectCheckMate() {
        
        let currentPlayer:Player    = self.turnIsWhite ? self.playerWhite : self.playerBlack
        var checkingPieces:[Piece]?
        
        var checkDetected               = false
        var canMovetoSafety             = false
        var checkerCanBeKilled          = false
        var checkingPathCanBeBlocked    = false
        
        let kingPosition = currentPlayer.kingPiece.position
        
        
        //Detect Check
        
        for i in max(0,kingPosition.0 - 1)...min(7,kingPosition.0 + 1) {
            
            for j in max(0,kingPosition.1 - 1)...min(7,kingPosition.1 + 1) {
                
                let pos = (i,j)
                
                if (kingPosition == pos) {
                    
                    let kingSq = self.board.squares[kingPosition.1][kingPosition.0]
                    
                    checkingPieces = self.canMoveWithoutKingCheck(kingSq.occupyingPiece!)
                    
                    let checkPlayerColor = self.turnIsWhite ? "Black" : "White"
                    if (checkingPieces?.count > 0) {
                        DebugLog("Check!!! from : \(checkPlayerColor) \(checkingPieces)")
                        checkDetected = true
                    }
                    break
                }
            }
        }
        
        currentPlayer.kingPiece.hasCheck = checkDetected
        
        
        //MARK: 1. Check possible move to safety
        
        if (checkDetected == true) {
            
            for i in max(0,kingPosition.0 - 1)...min(7,kingPosition.0 + 1) {
                
                for j in max(0,kingPosition.1 - 1)...min(7,kingPosition.1 + 1) {
                    
                    let pos = (i,j)
                    
                    if (kingPosition == pos) { continue }
                    
                    let safeToMove = self.checkSquareSafetyForKing(pos)
                    //DebugLog("safe : \(safeToMove) pos checked : \((i,j))")
                    
                    if (safeToMove == true) {
                        canMovetoSafety = true
                    }
                }
            }
        }
        
        
        //MARK: 2. Check if the checker can be killed
        
        if (checkDetected == true) {
            
            if let theCheckingPieces = checkingPieces {
                for checkingPiece in theCheckingPieces {
                    
                    
                    let checkedPlayer = self.turnIsWhite ? self.playerWhite : self.playerBlack
                    
                    for checkedPlayerPiece in checkedPlayer.availablePieces {
                        
                        let legal = self.move(start: (Alpha(rawValue: checkedPlayerPiece.position.0)!,checkedPlayerPiece.position.1), end: (Alpha(rawValue: checkingPiece.position.0)!,checkingPiece.position.1), registerMove: false)
                        if (legal.canMove == true) {
                            //DebugLog("\(checkingPiece) can be killed by \(checkedPlayerPiece)")
                            checkerCanBeKilled = true
                        }
                    }
                }
            }
        }
        
        
        //MARK: 3. Check if checker path can be blocked
        
        if (checkDetected == true) {
            
            let checkedPlayer = self.turnIsWhite ? self.playerWhite : self.playerBlack
            
            if let theCheckingPieces = checkingPieces {
                for checkingPiece in theCheckingPieces {
                    
                    if let pathSquares = checkingPiece.getMovementPath(currentPlayer.kingPiece.position) {
                        
                        for square in pathSquares {
                            
                            for checkedPlayerPiece in checkedPlayer.availablePieces {
                                
                                if let _ = checkedPlayerPiece as? King { continue }
                                
                                let sqPosition = (square.position.0.rawValue, square.position.1)
                                let legal = checkedPlayerPiece.canMove(end: sqPosition)
                                if (legal == true) {
                                    checkingPathCanBeBlocked = true
                                    //DebugLog("Check from \(checkingPiece) can be blocked by \(checkedPlayerPiece)")
                                }
                            }
                        }
                        
                    }
                    
                }
            }
        }
        
        if (currentPlayer.kingPiece.hasCheck == true) {
            
            if (canMovetoSafety == false &&
                checkerCanBeKilled == false &&
                checkingPathCanBeBlocked == false) {
                
                DebugLog("CHECKMATE!!")
                
                self.board.openWinView(!currentPlayer.kingPiece.colorIsWhite)
            }
            else {
                DebugLog("canMovetoSafety : \(canMovetoSafety) , checkerCanBeKilled : \(checkerCanBeKilled) , checkingPathCanBeBlocked : \(checkingPathCanBeBlocked)")
            }
        }
        
    }
    
    
    //MARK: Square Safety
    
    
    func checkSquareSafetyForKing(pos:(Int, Int)) -> Bool {
        
        let opponentPlayer:Player   = self.turnIsWhite ? self.playerBlack : self.playerWhite
        let currentPlayer:Player    = self.turnIsWhite ? self.playerWhite : self.playerBlack
        
        var checkingPieces = [Piece]()
        
        var notLegal = false
        
        let square = self.board.squares[pos.1][pos.0]
        
        if let thePiece = square.occupyingPiece {
            
            if (thePiece.colorIsWhite == currentPlayer.colorIsWhite) {
                notLegal = true //Square occupied by same color
            }
            else {
                let startPos = (Alpha(rawValue: currentPlayer.kingPiece.position.0)!, currentPlayer.kingPiece.position.1)
                let endPos = square.position
                
                
                let legal = self.move(start: startPos, end: endPos, registerMove: false)
                if (legal.canMove == true) {
                    DebugLog("Can kill checker : \(square.occupyingPiece)")
                }
                else {
                    DebugLog("\(thePiece) protected by \(legal.checkingPieces)")
                }
                notLegal = !legal.canMove
            }
        }
        else {
            
            var notLegalCheck = false
            for piece in opponentPlayer.availablePieces {
                let aNotLegalCheck = piece.canMove(end: pos, endPiece: currentPlayer.kingPiece, registeredMove: false)
                if (aNotLegalCheck == true) {
                    notLegalCheck = true
                    checkingPieces.append(piece)
                }
            }
            
            notLegal = notLegalCheck
        }
        
        return !notLegal
    }
    
}
