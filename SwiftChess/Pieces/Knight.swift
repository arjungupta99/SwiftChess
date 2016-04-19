//
//  Knight.swift
//  Chess
//
//  Created by Arjun Gupta on 2/24/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import Foundation

class Knight:Piece {
    
    override func canMove(end end:(Int, Int), endPiece:Piece? = nil, registeredMove:Bool = true) -> Bool {
        
        let start = self.position
        
        if (abs(end.0 - start.0) == 1 && abs(end.1 - start.1) == 2) { return true }
        
        if (abs(end.1 - start.1) == 1 && abs(end.0 - start.0) == 2) { return true }
        
        return false
    }
    
    
    override func name() -> String {
        return "knight"
    }
    
    
    override func didMove() {
        
    }
    
    
    override func getMovementPath(end:(Int, Int)) -> [Square]? {
        
        return nil
    }
}