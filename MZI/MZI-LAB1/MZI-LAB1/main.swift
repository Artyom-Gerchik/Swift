//
//  main.swift
//  MZI-LAB1
//
//  Created by Artyom on 7.09.23.
//

import Foundation

class main{
    init(){
        let brain = Brain()
        brain.getData()
        
        let encrypted = brain.gammificationMode(plainText: brain.initialDataAsBytesArray)
        
        print("")
        print("ENCRYPTED")
        print(String(bytes: encrypted, encoding: String.Encoding(rawValue: NSASCIIStringEncoding))!, terminator: " = ")
        print(encrypted)
        print("ENCRYPTED")
        
        let decrypted = brain.gammificationMode(plainText: encrypted)
        
        print("")
        print("DECRYPTED")
        brain.finalResult = String(bytes: decrypted, encoding: String.Encoding(rawValue: NSASCIIStringEncoding))!
        print(brain.finalResult, terminator: " = ")
        print(decrypted)
        print("DECRYPTED")
        
        brain.saveData()
    }
}

main()
