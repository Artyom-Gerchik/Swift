//
//  main.swift
//  TiVP-LAB1-TASK1
//
//  Created by Artyom on 15.09.23.
//

import Foundation

//public func task1ForTest() -> [String]{
//    var outArray = [String]()
//    var stringForExclamanationPoints = ""
//
//    outArray.append("Hello, World!")
//    outArray.append("Andhiagain!")
//
//    let numberOfExclamanationPoints = Int.random(in: 6...49)
//
//    for _ in 0...numberOfExclamanationPoints{
//        stringForExclamanationPoints += "!"
//    }
//
//    outArray.append(stringForExclamanationPoints)
//
//    return outArray
//}

func task1(){
    print("Hello, World!")
    print("Andhiagain!")

    let numberOfExclamanationPoints = Int.random(in: 4...49)

    for _ in 0...numberOfExclamanationPoints{
        print("!", terminator: "")
    }
    print("")
}

task1()
