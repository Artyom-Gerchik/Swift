//
//  utils.swift
//  TiVP-LAB1-TASK3
//
//  Created by Artyom on 29.09.23.
//

import Foundation

func testMain(a: Int, b: Int) -> String{
    if(a == 0 || b == 0 || a < 0 || b < 0){
        return "FOLLOW THE PATTERN"
    }
    return String(a * b)
}
