//
//  WinView.swift
//  SwiftChess
//
//  Created by Arjun Gupta on 4/17/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation
import UIKit

protocol WinnerViewDelegate:class {
    
    func winViewDismiss()
}

class WinnerView:UIView, SquareDelegate {
    
    weak var delegate:WinnerViewDelegate?
    
    convenience init(boardFrame: CGRect, colorIsWhite:Bool, delegate:WinnerViewDelegate) {
        
        self.init(frame: CGRectMake(0, 0, boardFrame.size.width, boardFrame.size.height))
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        let f   = boardFrame
        let h   = f.size.height/2
        let vf  = CGRectMake(f.size.width/2 - h/2, f.size.height/2 - h/2, h, h)
        
        self.delegate = delegate
        
        let containerView = UIView(frame: vf)
        self.addSubview(containerView)
        
        let kingPiece = King(colorIsWhite: colorIsWhite, board: nil)
        
        let sq = Square(position: (Alpha(rawValue: 0)!,0), sqWidth: h, delegate: self)
        containerView.addSubview(sq.view!)
        sq.occupyingPiece = kingPiece
        
        containerView.alpha = 0;
        containerView.transform = CGAffineTransformMakeScale(0.90, 0.90)
        UIView.animateWithDuration(0.5, animations: {
            self.alpha = 1.0
        }) { (true) in
            UIView.animateWithDuration(0.5, animations: {
                containerView.alpha = 1.0
                containerView.transform = CGAffineTransformIdentity
            })
        }
    }
    
    
    func squarePressed(square:Square, position:(Int, Int)) {
        
        UIView.animateWithDuration(0.3, animations: {  self.alpha = 0 }) { (true) in
            self.delegate?.winViewDismiss()
            self.removeFromSuperview() 
        }
    }
}