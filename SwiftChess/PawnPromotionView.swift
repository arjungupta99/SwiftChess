//
//  PawnPromotionView.swift
//  SwiftChess
//
//  Created by Arjun Gupta on 4/9/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation
import UIKit

protocol PawnPromotionViewDelegate:class {
    
    func addPromotedPawnPiece(piece:Piece!)
}

class PawnPromotionView:UIView, SquareDelegate {
    
    weak var delegate:PawnPromotionViewDelegate?
    var pawnPieceRef:Piece?
    
    convenience init(boardFrame: CGRect, pawnPiece:Piece, colorIsWhite:Bool, delegate:PawnPromotionViewDelegate) {
        
        self.init(frame: CGRectMake(0, 0, boardFrame.size.width, boardFrame.size.height))
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        self.pawnPieceRef = pawnPiece
        
        let f   = boardFrame
        let h   = f.size.height/4
        let vf  = CGRectMake(0, f.size.height/2 - h/2, f.size.width, h)
        
        self.delegate = delegate
        
        let containerView = UIView(frame: vf)
        self.addSubview(containerView)
        
        var pieces  = [Piece]()
        pieces.append(Queen (colorIsWhite:colorIsWhite, board: nil))
        pieces.append(Rook  (colorIsWhite:colorIsWhite, board: nil))
        pieces.append(Knight(colorIsWhite:colorIsWhite, board: nil))
        pieces.append(Bishop(colorIsWhite:colorIsWhite, board: nil))
        
        var count   = 0
        for piece in pieces {
            
            let sq = Square(position: (Alpha(rawValue: count)!,0), sqWidth: h, delegate: self)
            containerView.addSubview(sq.view!)
            sq.occupyingPiece = piece
            
            count += 1
        }
        
        self.alpha = 0
        
        self.performSelector(#selector(makeAppear), withObject: nil, afterDelay: 0.1)
    }
    
    func makeAppear() {
        
        let finalPoint = (self.pawnPieceRef!.colorIsWhite == true) ? 7 : 0
        if (self.pawnPieceRef?.position.1 == finalPoint) {
            UIView.animateWithDuration(0.3) {  self.alpha = 1.0 }
        }
        else {
            //This will happen for the case where the king is under check
            self.removeFromSuperview()
        }
    }
    
    func squarePressed(square:Square, position:(Int, Int)) {
        
        square.occupyingPiece?.position = self.pawnPieceRef?.position
        self.delegate?.addPromotedPawnPiece(square.occupyingPiece)
        
        UIView.animateWithDuration(0.3, animations: {  self.alpha = 0 }) { (true) in self.removeFromSuperview() }
    }
    
}
