//
//  SwiftChessTests.swift
//  SwiftChessTests
//
//  Created by Arjun Gupta on 2/28/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import XCTest
@testable import SwiftChess

class SwiftChessTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1_checkmate() {
        
        let game        = Game(boardWidth: 300)
        
        let pawnWhite0 = game.move(start:(Alpha.E, 1), end: (Alpha.E, 2)).canMove
        XCTAssertTrue(pawnWhite0)
        
        let pawnBlack0 = game.move(start:(Alpha.F, 6), end: (Alpha.F, 5)).canMove
        XCTAssertTrue(pawnBlack0)
        
        let queenWhite0 = game.move(start:(Alpha.D, 0), end: (Alpha.H, 4)).canMove
        XCTAssertTrue(queenWhite0)
        
        let pawnBlack1 = game.move(start:(Alpha.G, 6), end: (Alpha.G, 4)).canMove
        XCTAssertFalse(pawnBlack1)
        
        let pawnBlack2 = game.move(start:(Alpha.G, 6), end: (Alpha.G, 5)).canMove
        XCTAssertTrue(pawnBlack2)
        
        let bishopWhite0 = game.move(start:(Alpha.F, 0), end: (Alpha.B, 4)).canMove
        XCTAssertTrue(bishopWhite0)
        
        let pawnBlack3 = game.move(start:(Alpha.H, 6), end: (Alpha.H, 5)).canMove
        XCTAssertTrue(pawnBlack3)
        
        let queenWhite1 = game.move(start:(Alpha.H, 4), end: (Alpha.G, 5)).canMove
        XCTAssertTrue(queenWhite1) //Checkmate!
    }
    
    
    
}
