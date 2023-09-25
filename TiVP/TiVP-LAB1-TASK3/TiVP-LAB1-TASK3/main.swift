//
//  main.swift
//  TiVP-LAB1-TASK3
//
//  Created by Artyom on 15.09.23.
//

import Foundation

class Main{
    public func main(){
        print("Insert a b: ", terminator: "")
        let userInput = readLine()
        print("")

        let values = userInput?.split(separator: " ")

        if(values!.count < 2 || values!.count > 2){
            print("FOLLOW THE PATTERN")
            return
        }else{
            let a = Double(values![0]) ?? 0
            let b = Double(values![1]) ?? 0
            
            if(a == 0 || b == 0 || a < 0 || b < 0){
                print("FOLLOW THE PATTERN")
                return
            }else{
                print("Square is: ", terminator: "")
                print(a * b)
            }
        }

    }
}

Main().main()
