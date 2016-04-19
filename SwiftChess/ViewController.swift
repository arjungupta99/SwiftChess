//
//  ViewController.swift
//  SwiftChess
//
//  Created by Arjun Gupta on 2/28/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pieceDict   = [String:UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boardWidth  = UIApplication.sharedApplication().delegate!.window!!.bounds.size.width - 50
        let boardHeight = UIApplication.sharedApplication().delegate!.window!!.bounds.size.height - 50
        let game        = Game(boardWidth: min(boardWidth, boardHeight))
        
        game.board!.view!.center = self.view.center
        game.board!.view!.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin]
        self.view.addSubview(game.board!.view!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

