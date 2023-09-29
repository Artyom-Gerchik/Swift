//
//  utils.swift
//  TiVP-LAB1-TASK1
//
//  Created by Artyom on 29.09.23.
//

import Foundation

public func task1ForTest() -> [String]{
    var outArray = [String]()
    var stringForExclamanationPoints = ""
    
    outArray.append("Hello, World!")
    outArray.append("Andhiagain!")
    
    let numberOfExclamanationPoints = Int.random(in: 4...49)
    
    for _ in 0...numberOfExclamanationPoints{
        stringForExclamanationPoints += "!"
    }
    
    outArray.append(stringForExclamanationPoints)
    
    return outArray
}
