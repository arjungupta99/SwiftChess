//
//  Piece.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation
import UIKit

class Piece:ColorProtocol {
    
    var view:UIImageView?
    var colorIsWhite:Bool!
    var position:(Int,Int)!
    var board:Board!
    
    init (colorIsWhite:Bool, board:Board?) {
        self.colorIsWhite   = colorIsWhite
        if (board != nil) {
            self.board = board
        }
        
        //Piece View
        var str = (self.colorIsWhite == true) ? "w_" : "b_"
        str += self.name()
        let imageView = UIImageView(image: UIImage(named: str))
        self.view = imageView
        self.view!.frame = CGRectMake(5, 5, imageView.frame.size.width - 10, imageView.frame.size.height - 10)
    }
    
    func name() -> String {
        
        preconditionFailure("This method must be overridden")
    }
    
    func canMove(end end:(Int, Int), endPiece:Piece? = nil, registeredMove:Bool = true) -> Bool {
        
        preconditionFailure("This method must be overridden")
    }
    
    func didMove() {
        
        preconditionFailure("This method must be overridden")
    }
    
    //Used during checkmate detection
    func getMovementPath(end:(Int, Int)) -> [Square]? {
        
        preconditionFailure("This method must be overridden")
    }
    
}