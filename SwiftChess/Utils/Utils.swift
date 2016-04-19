//
//  Constants.swift
//  MusicInImages
//
//  Created by Arjun Gupta on 6/10/15.
//  Copyright © 2015 ArjunGupta. All rights reserved.
//

import Foundation

func DebugLog(logMessage: String, className: String = #file, lineNumber: NSInteger = #line) {
    let tempArr = className.componentsSeparatedByString("/")
    let last = tempArr[tempArr.count-1]
    print("\(last) ... Line: \(lineNumber) ... \(logMessage)", terminator: "\n")
}

func DebugLogS(logMessage: String, className: String = #file, lineNumber: NSInteger = #line) {
    let tempArr = className.componentsSeparatedByString("/")
    let last = tempArr[tempArr.count-1]
    print("\(last) ... Line: \(lineNumber) ... \(logMessage)", terminator: "")
}



class Constants:NSObject {
    
    
    
}