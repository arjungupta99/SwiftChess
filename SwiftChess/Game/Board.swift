//
//  Board.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation
import UIKit

protocol BoardDelegate:class {
    
    func squarePressed(square:Square, position:(Int, Int))
    func removePieceFromPlayer(piece:Piece, position:(Int,Int))
    func addPieceForPlayer(piece:Piece, detectCheckMate:Bool)
}

class Board:SquareDelegate, PawnPromotionViewDelegate, WinnerViewDelegate {
    
    var delegate:BoardDelegate?
    var view    :UIView?
    var squares = [[Square]]()
    var lastMove:(piece:Piece, start:(Int,Int), end:(Int,Int))?
    
    var previousStartSquare :Square?
    var previousEndSquare   :Square?
    var lastRemovedPiece    :Piece?
    
    
    init(boardWidth:CGFloat) {
        
        //Board View
        self.view   = UIView(frame: CGRectMake(0, 0, boardWidth, boardWidth))
        let sqWidth = boardWidth/8
        
        var iCount = -1
        var jCount = -1
        
        for j in 7.stride(through: 0, by: -1) {
            
            iCount += 1
            jCount = -1
            var row = [Square]()
            
            for i in 0..<8 {
                
                jCount += 1
                
                //Square View
                let square = Square(position:(Alpha(rawValue: jCount)!, iCount), sqWidth: sqWidth, delegate:self)
                square.view!.frame = CGRectMake(CGFloat(i)*sqWidth,CGFloat(j)*sqWidth,sqWidth, sqWidth)
                self.view!.addSubview(square.view!)
                
                row.append(square)
            }
            self.squares.append(row)
        }
    }
    
    
    func squarePressed(square:Square, position:(Int, Int)) {
        
        self.delegate?.squarePressed(square, position: position)
    }
    
    
    func removePieceAtSquare(square:Square, fromPlayer:Bool = true) -> Piece {
        
        if (fromPlayer == true) {
            //DebugLog("Removing piece : \(square.occupyingPiece)")
            self.delegate?.removePieceFromPlayer(square.occupyingPiece!, position:(square.position.0.rawValue, square.position.1))
        }
        
        square.occupyingPiece?.view?.removeFromSuperview()
        
        let returnPiece = square.occupyingPiece
        
        square.occupyingPiece = nil
        
        return returnPiece!
    }
    
    
    
    //MARK:- Path check
    
    
    
    func checkClearStraightPath(start start:(Int, Int), end:(Int, Int)) -> Bool {
        
        let squares = self.straightPathSquares(start: start, end: end)
        return self.checkClearPath(squares)
    }
    
    
    func checkClearDiagonalPath(start start:(Int, Int), end:(Int, Int)) -> Bool {
        
        let squares = self.diagonalPathSquares(start: start, end: end)
        return self.checkClearPath(squares)
    }
    
    
    private func checkClearPath(squares:[Square]?) -> Bool {
        
        guard let theSquares = squares else { return false }
        
        let pathSquares = theSquares
        
        if (pathSquares.count > 0) {
            for aSquare in pathSquares {
                if (aSquare.occupyingPiece != nil) {
                    return false
                }
            }
        }
        else { return true }
        
        return true
    }
    
    
    
    //MARK:- Path Squares
    
    
    
    func straightPathSquares(start start:(Int, Int), end:(Int, Int)) -> [Square]? {
        
        let aX = start.0
        let bX = end.0
        let aY = start.1
        let bY = end.1
        
        if (aX != bX && aY != bY) {
            //DebugLog("!!!!! Not a straight path)")
            return nil
        }
        
        var theSquares = [Square]()
        
        let dist = max(abs(aX - bX), abs(aY - bY))
        for count in 1.stride(to: dist, by: 1) {
            
            var i:Int {
                if (aX == bX) {
                    return aX
                }
                if (aX < bX) {
                    return aX + count
                }
                return aX - count
            }
            var j:Int {
                if (aY == bY) {
                    return aY
                }
                if (aY < bY) {
                    return aY + count
                }
                return aY - count
            }
            
            let sq = self.squares[j][i]
            theSquares.append(sq)
        }
        return theSquares
    }
    
    
    func diagonalPathSquares(start start:(Int, Int), end:(Int, Int)) -> [Square]? {
        
        let aX = start.0
        let bX = end.0
        let aY = start.1
        let bY = end.1
        
        if (abs(bX - aX) != abs(bY - aY)) {
            //DebugLog("!!!!! Not a diagonal path")
            return nil
        }
        
        var theSquares = [Square]()
        
        let dist = abs(aX - bX)
        for count in 1.stride(to: dist, by: 1) {
            
            var i:Int {
                if (aX < bX) {
                    return aX + count
                }
                return aX - count
            }
            var j:Int {
                if (aY < bY) {
                    return aY + count
                }
                return aY - count
            }
            
            let sq = self.squares[j][i]
            theSquares.append(sq)
        }
        
        return theSquares
    }
    
    
    
    //MARK:-
    
    
    
    func getSquareAtPosition(pos:(Int, Int)) -> Square {
        
        return self.squares[pos.1][pos.0]
    }
    
    
    func moveOccupyingPieceFromSquare(startSquare:Square!, endSquare:Square!) {
        
        self.lastRemovedPiece = nil
        if (endSquare.occupyingPiece != nil) {
            self.lastRemovedPiece = self.removePieceAtSquare(endSquare)
        }
        
        endSquare.occupyingPiece = self.removePieceAtSquare(startSquare, fromPlayer: false)
        
        endSquare.occupyingPiece!.position = (endSquare.position.0.rawValue, endSquare.position.1)
        
        self.previousStartSquare    = startSquare
        self.previousEndSquare      = endSquare
        
        self.lastMove = (piece:endSquare.occupyingPiece!, start: (startSquare.position.0.rawValue, startSquare.position.1), end: (endSquare.position.0.rawValue, endSquare.position.1))
    }
    
    
    
    //MARK:- Undo Move
    
    
    
    func undoLastMove() {
        
        self.previousStartSquare?.occupyingPiece  = self.previousEndSquare?.occupyingPiece
        self.previousEndSquare?.occupyingPiece    = self.lastRemovedPiece
        
        if let theRemovedPiece = self.previousEndSquare?.occupyingPiece {
            self.delegate!.addPieceForPlayer(theRemovedPiece, detectCheckMate:false)
        }
        
        self.previousStartSquare?.occupyingPiece?.position  = (self.previousStartSquare!.position.0.rawValue, self.previousStartSquare!.position.1)
        self.previousEndSquare?.occupyingPiece?.position    = (self.previousEndSquare!.position.0.rawValue, self.previousEndSquare!.position.1)
        
        self.previousStartSquare    = nil
        self.previousEndSquare      = nil
        self.lastRemovedPiece       = nil
    }
    
    
    
    //MARK:- Promote pawn
    
    
    
    func openPawnPromotionView(pawnPiece:Pawn) {
        
        let pawnPromotionView = PawnPromotionView(boardFrame: self.view!.frame, pawnPiece:pawnPiece, colorIsWhite: pawnPiece.colorIsWhite, delegate: self)
        self.view!.addSubview(pawnPromotionView)
    }
    
    func addPromotedPawnPiece(piece:Piece!) {
        
        piece.board = self
        
        let square = self.squares[piece.position.1][piece.position.0]
        self.removePieceAtSquare(square)
        
        square.occupyingPiece = piece
        self.delegate?.addPieceForPlayer(piece, detectCheckMate:true)
    }
    
    
    
    //MARK:- Win View
    
    
    
    func openWinView(colorIsWhite:Bool) {
        
        let winView = WinnerView(boardFrame: self.view!.frame, colorIsWhite:colorIsWhite, delegate:self)
        self.view!.addSubview(winView)
    }
    
    func winViewDismiss() {
        
        //TODO: Reset game here
        
        DebugLog("Win View dismissed")
    }
    
}



enum Alpha:Int {
    case A = 0
    case B = 1
    case C = 2
    case D = 3
    case E = 4
    case F = 5
    case G = 6
    case H = 7
}
