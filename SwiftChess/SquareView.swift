//
//  SquareView.swift
//  SwiftChess
//
//  Created by Arjun Gupta on 2/29/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation
import UIKit

protocol SquareViewDelegate:class {
    
    func squareViewPressed(position:(Int, Int))
}

class SquareView:UIView {
    
    var delegate:SquareViewDelegate?
    var position:(Int, Int)?
    var button:UIButton?
    var activeView:UIView?
    var highlight_blk   :UIImageView!
    var highlight_wht   :UIImageView!
    
    init(frame: CGRect, isLight:Bool, delegate:SquareViewDelegate!) {
        super.init(frame: frame)
        
        self.delegate = delegate
        
        self.backgroundColor = (isLight == false) ? UIColor.grayColor() : UIColor.lightGrayColor()
        
        self.button = UIButton(frame: CGRectMake(0,0,self.bounds.size.width, self.bounds.size.height))
        self.addSubview(self.button!)
        self.button!.backgroundColor = UIColor.clearColor()
        
        self.button!.addTarget(self, action: #selector(squarePressed), forControlEvents: .TouchUpInside)
        self.button!.addTarget(self, action: #selector(squareReleasedOutside), forControlEvents: .TouchDragOutside)
        self.button!.addTarget(self, action: #selector(squarePress), forControlEvents: .TouchDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func squarePress() {
        self.button!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.11)
    }
    
    func squareReleasedOutside() {
        self.button!.backgroundColor = UIColor.clearColor()
    }
    
    func squarePressed() {
        self.button!.backgroundColor = UIColor.clearColor()
        self.delegate?.squareViewPressed(self.position!)
    }
    
    func changeActiveState(active:Bool, occupyingPieceColorWhite:Bool?) {
        
        if (self.activeView == nil) {
            self.activeView = UIView(frame: CGRectMake(0,0,self.bounds.size.width,self.bounds.size.height))
            
            self.highlight_wht = UIImageView(image: UIImage(named: "pieceHighlight"))
            self.highlight_wht.frame = CGRectMake(0, 0, self.activeView!.frame.size.width, self.activeView!.frame.size.height)
            self.activeView?.addSubview(self.highlight_wht)
            self.highlight_wht.alpha = 0.85
            
            self.highlight_blk = UIImageView(image: UIImage(named: "pieceHighlight_blk"))
            self.highlight_blk.frame = CGRectMake(0, 0, self.activeView!.frame.size.width, self.activeView!.frame.size.height)
            self.activeView?.addSubview(self.highlight_blk)
            self.highlight_blk.alpha = 0.85
        }
        
        if (active == true) {
            self.addSubview(self.activeView!)
            self.sendSubviewToBack(self.activeView!)
            
            if let isWhite = occupyingPieceColorWhite {
                if (isWhite == true) {
                    self.highlight_wht.hidden = true
                    self.highlight_blk.hidden = false
                }
                else {
                    self.highlight_wht.hidden = false
                    self.highlight_blk.hidden = true
                }
            }
        }
        else {
            self.activeView?.removeFromSuperview()
        }
    }
    
}
