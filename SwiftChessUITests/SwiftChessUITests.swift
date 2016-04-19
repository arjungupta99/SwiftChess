//
//  SwiftChessUITests.swift
//  SwiftChessUITests
//
//  Created by Arjun Gupta on 2/28/16.
//  Copyright © 2016 ArjunGupta. All rights reserved.
//

import XCTest

class SwiftChessUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1_UI_checkmate() {
        
        let element = XCUIApplication().childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1)
        element.childrenMatchingType(.Other).elementBoundByIndex(52).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(44).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(13).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(21).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(59).childrenMatchingType(.Button).element.tap()
        
        let button = element.childrenMatchingType(.Other).elementBoundByIndex(31).childrenMatchingType(.Button).element
        button.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(14).childrenMatchingType(.Button).element.tap()
        
        let button2 = element.childrenMatchingType(.Other).elementBoundByIndex(22).childrenMatchingType(.Button).element
        button2.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(61).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(25).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(15).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(23).childrenMatchingType(.Button).element.tap()
        button.tap()
        button2.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Button).element.tap()
    }
    
    
    func test2_UI_checkmate() {
        
        
        let element = XCUIApplication().childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1)
        element.childrenMatchingType(.Other).elementBoundByIndex(52).childrenMatchingType(.Button).element.tap()
        
        let button = element.childrenMatchingType(.Other).elementBoundByIndex(44).childrenMatchingType(.Button).element
        button.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(9).childrenMatchingType(.Button).element.tap()
        
        let button2 = element.childrenMatchingType(.Other).elementBoundByIndex(17).childrenMatchingType(.Button).element
        button2.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(61).childrenMatchingType(.Button).element.tap()
        
        let button3 = element.childrenMatchingType(.Other).elementBoundByIndex(25).childrenMatchingType(.Button).element
        button3.tap()
        
        let button4 = element.childrenMatchingType(.Other).elementBoundByIndex(10).childrenMatchingType(.Button).element
        button4.tap()
        
        let button5 = element.childrenMatchingType(.Other).elementBoundByIndex(8).childrenMatchingType(.Button).element
        button5.tap()
        button5.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(16).childrenMatchingType(.Button).element.tap()
        button3.tap()
        
        let button6 = element.childrenMatchingType(.Other).elementBoundByIndex(34).childrenMatchingType(.Button).element
        button6.tap()
        button2.tap()
        button3.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(48).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(32).childrenMatchingType(.Button).element.tap()
        button3.tap()
        button6.tap()
        
        let button7 = element.childrenMatchingType(.Other).elementBoundByIndex(49).childrenMatchingType(.Button).element
        button7.tap()
        
        let button8 = element.childrenMatchingType(.Other).elementBoundByIndex(41).childrenMatchingType(.Button).element
        button8.tap()
        button6.tap()
        button8.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(50).childrenMatchingType(.Button).element.tap()
        button8.tap()
        
        let element2 = element.childrenMatchingType(.Other).elementBoundByIndex(1)
        element2.childrenMatchingType(.Button).element.tap()
        
        let button9 = element.childrenMatchingType(.Other).elementBoundByIndex(18).childrenMatchingType(.Button).element
        button9.tap()
        
        let button10 = element.childrenMatchingType(.Other).elementBoundByIndex(62).childrenMatchingType(.Button).element
        button10.tap()
        
        let button11 = element.childrenMatchingType(.Other).elementBoundByIndex(45).childrenMatchingType(.Button).element
        button11.tap()
        button9.tap()
        
        let button12 = element.childrenMatchingType(.Other).elementBoundByIndex(27).childrenMatchingType(.Button).element
        button12.tap()
        button9.tap()
        
        let button13 = element.childrenMatchingType(.Other).elementBoundByIndex(26).childrenMatchingType(.Button).element
        button13.tap()
        button9.tap()
        
        let button14 = element.childrenMatchingType(.Other).elementBoundByIndex(28).childrenMatchingType(.Button).element
        button14.tap()
        button11.tap()
        button14.tap()
        
        let button15 = element.childrenMatchingType(.Other).elementBoundByIndex(12).childrenMatchingType(.Button).element
        button15.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(20).childrenMatchingType(.Button).element.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(59).childrenMatchingType(.Button).element.tap()
        
        let button16 = element.childrenMatchingType(.Other).elementBoundByIndex(31).childrenMatchingType(.Button).element
        button16.tap()
        button16.tap()
        button16.tap()
        button8.tap()
        button4.tap()
        button13.tap()
        button8.tap()
        
        let button17 = element.childrenMatchingType(.Other).elementBoundByIndex(33).childrenMatchingType(.Button).element
        button17.tap()
        button13.tap()
        button17.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(58).childrenMatchingType(.Button).element.tap()
        
        let button18 = element.childrenMatchingType(.Other).elementBoundByIndex(40).childrenMatchingType(.Button).element
        button18.tap()
        button17.tap()
        button8.tap()
        button18.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(5).childrenMatchingType(.Button).element.tap()
        
        let button19 = element.childrenMatchingType(.Other).elementBoundByIndex(60).childrenMatchingType(.Button).element
        button19.tap()
        button8.tap()
        button7.tap()
        button19.tap()
        button10.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(57).childrenMatchingType(.Button).element.tap()
        
        let button20 = element.childrenMatchingType(.Other).elementBoundByIndex(56).childrenMatchingType(.Button).element
        button20.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(11).childrenMatchingType(.Button).element.tap()
        
        let button21 = element.childrenMatchingType(.Other).elementBoundByIndex(19).childrenMatchingType(.Button).element
        button21.tap()
        button14.tap()
        button9.tap()
        button7.tap()
        button20.tap()
        
        let element3 = element2.childrenMatchingType(.Other).element
        element3.childrenMatchingType(.Other).elementBoundByIndex(0).childrenMatchingType(.Button).element.tap()
        button9.tap()
        
        let button22 = element.childrenMatchingType(.Other).elementBoundByIndex(3).childrenMatchingType(.Button).element
        button22.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(4).childrenMatchingType(.Button).element.tap()
        button22.tap()
        button16.tap()
        
        let button23 = element.childrenMatchingType(.Other).elementBoundByIndex(13).childrenMatchingType(.Button).element
        button23.tap()
        button20.tap()
        
        let button24 = element.childrenMatchingType(.Other).elementBoundByIndex(35).childrenMatchingType(.Button).element
        button24.tap()
        
        let button25 = element.childrenMatchingType(.Other).elementBoundByIndex(6).childrenMatchingType(.Button).element
        button25.tap()
        button24.tap()
        button.tap()
        button24.tap()
        button25.tap()
        element.childrenMatchingType(.Other).elementBoundByIndex(23).childrenMatchingType(.Button).element.tap()
        button23.tap()
        button15.tap()
        
        let button26 = element3.childrenMatchingType(.Other).element.childrenMatchingType(.Button).element
        button26.tap()
        button21.tap()
        button12.tap()
        button26.tap()
        
    }
    
}
