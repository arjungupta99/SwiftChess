//
//  Square.swift
//  SwiftChess
//
//  Created by Arjun Gupta on 3/1/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation
import UIKit

protocol SquareDelegate:class {
    
    func squarePressed(square:Square, position:(Int, Int))
}

class Square:NSObject,PositionProtocol, SquareViewDelegate {
    
    var delegate:SquareDelegate?
    var view            :SquareView?
    var position        :(Alpha, Int)!
    var occupyingPiece  :Piece? {
        didSet {
            if let pieceView = occupyingPiece?.view {
                self.view!.addSubview(pieceView)
                occupyingPiece!.view!.frame = CGRectMake(5, 5, self.view!.frame.size.width - 10, self.view!.frame.size.height - 10)
            }
        }
    }

    init(position:(Alpha, Int), sqWidth:CGFloat, delegate:SquareDelegate!) {
        super.init()
        self.delegate = delegate
        self.position = position
        self.occupyingPiece = nil
        let i = position.0.rawValue
        let j = position.1
        
        //Square View
        var isLight:Bool!
        if (i % 2 == 0) {   isLight = (j % 2 == 0) ? false : true }
        else            {   isLight = (j % 2 != 0) ? false : true }
        self.view = SquareView(frame: CGRectMake(CGFloat(i)*sqWidth,CGFloat(j)*sqWidth,sqWidth, sqWidth), isLight: isLight, delegate:self)
        self.view!.position = (i, j)
    }
    
    func squareViewPressed(position: (Int, Int)) {
        
        self.delegate?.squarePressed(self, position: position)
    }
    
    func changeActiveState(active:Bool) {
        
        self.view?.changeActiveState(active, occupyingPieceColorWhite: self.occupyingPiece?.colorIsWhite)
    }
}

protocol PositionProtocol {
    var position:(Alpha, Int)! { get }
}