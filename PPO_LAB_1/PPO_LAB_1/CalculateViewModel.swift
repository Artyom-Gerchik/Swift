//
//  CategoryCalculateViewModel.swift
//  PPO_LAB_1
//
//  Created by Artyom on 5.09.22.
//

import SwiftUI

class CalculateViewModel: ObservableObject{
    
    let coefficient: Double
    let type1: String
    let type2: String
    let pasteboard = UIPasteboard.general
    
    @Published var directConversion: Bool = true {
        didSet{
            input = input
            currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
//            if(currentCursorPosition == -1){
//                currentCursorPosition = 0
//            }
        }
    }
    
    @Published var input: String = "|" {
        didSet {
            var inputMirror = input
            let cursorIndex = inputMirror.firstIndex(of: "|")
            inputMirror.remove(at: cursorIndex!)
            
            guard let inputMirrorAsDouble = Double(inputMirror) else {
                output = "jopa"
                //currentCursorPosition -= 1
                currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
                return
            }
            if (input.count > 17){
                input = oldValue
                output = "jopa"
                //currentCursorPosition -= 1
                currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
            }else{
                output = String((inputMirrorAsDouble / properCoefficent))
            }
        }
    }
    @Published var output: String = ""
    @Published var currentCursorPosition = 0
    
    
    var properCoefficent: Double{
        if directConversion{
            return coefficient
        }
        else{
            return 1 / coefficient
        }
    }
    
    init(coefficient: Double, type1: String, type2: String){
        self.coefficient = coefficient
        self.type1 = type1
        self.type2 = type2
    }
    
    var readColor: Color{
        guard let giveMe = Bundle.main.infoDictionary?["COLOR"] as? String else {
            return .red
            
        }
        let coler: Color
        switch giveMe {
        case "red":
            coler = Color.red
        case "black":
            coler = Color.black
        default:
            coler = Color.purple
        }
        return coler
    }
    
    
    var isPremium: Bool{
        guard let giveMe = Bundle.main.infoDictionary?["PREMIUM"] as? String else{
            return false
        }
        let isPremium: Bool
        switch giveMe {
        case "true":
            isPremium = true
        case "false":
            isPremium = false
        default:
            isPremium = false
        }
        return isPremium
        
    }
    
    func swapCharacters(input: String, index1: Int, index2: Int) -> String {
        var characters = Array(input)
        characters.swapAt(index1, index2)
        
        return String(characters)
    }
    
    func insertSymbol(inputVar: Character){
        if(input.count == 2 && input[input.index(input.startIndex, offsetBy: 0)] == "0"){
            if(inputVar != "."){
                input = replaceChar(myString: input, 0, inputVar)
                return
            }
        }
        if(input.count == 16 && inputVar == "."){
            return
        }
        
        input.insert(inputVar, at: input.index(input.startIndex, offsetBy: currentCursorPosition))
        currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
        
//        if(currentCursorPosition == -1){
//            currentCursorPosition = 0
//        }
//        currentCursorPosition += 1
    }
    
    func removeSymbol(){
//        if((input.firstIndex(of: ".")?.utf16Offset(in: input))! == 0){
//            input.remove(at: input.index(input.startIndex, offsetBy: currentCursorPosition))
//            input.insert("|", at: input.index(input.startIndex, offsetBy: input.count - 1))
//        }
        input.remove(at: input.index(input.startIndex, offsetBy: currentCursorPosition - 1))
        currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
    }
    
    func moveCursorLeft(){
        input = swapCharacters(input: input, index1: currentCursorPosition, index2: currentCursorPosition - 1)
        currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
    }
    
    func moveCursorRight(){
        input = swapCharacters(input: input, index1: currentCursorPosition, index2: currentCursorPosition + 1)
        currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
    }
    
    func copyToPasteBoard(){
        var tmp = input
        tmp.remove(at: tmp.index(tmp.startIndex, offsetBy: currentCursorPosition))
        pasteboard.string = tmp
    }
    
    func insertPasteBoard() -> Bool{
        if pasteboard.hasStrings {
            if(input.count + pasteboard.string!.count < 18){
                
                var punctuationCounter = 0
                
                for symbol in pasteboard.string!{
                    if(symbol.isLetter){
                        return false
                    }
                    else if(symbol.isPunctuation){
                        if(symbol == "."){
                            punctuationCounter += 1
                        }
                        else{
                            return false
                        }
                    }
                }
                
                if(punctuationCounter > 1){
                    return false
                }else if(punctuationCounter == 1){
                    for symbolInInput in input{
                        if symbolInInput.isPunctuation{
                            return false
                        }
                    }
                }
                
                let tmp: String = pasteboard.string!
                input.insert(contentsOf: tmp, at: input.index(input.startIndex, offsetBy: currentCursorPosition))
//                if(currentCursorPosition == -1){
//                    currentCursorPosition = 0
//                }
//                currentCursorPosition += tmp.count
                currentCursorPosition = (input.firstIndex(of: "|")?.utf16Offset(in: input))!
                return true
            }
        }
        return false
    }
    
    func checkLeftPartForZeroInsert() -> Bool{
        
        var zerosCounter = 0
        var symbolsCounter = 0
        
        for symbol in input{
            if (symbol == "|"){
                break
            }
            else if (symbol == "0"){
                zerosCounter += 1
                symbolsCounter -= 1
            }
            symbolsCounter += 1
        }
        if (zerosCounter != 0 && symbolsCounter == 0){
            return false
        }
        else if (zerosCounter == 0 && symbolsCounter == 0){
            if(input.count == 1){
                return true
            }
            else{
                return false
            }
        }
        return true
    }
}

func replaceChar(myString: String, _ index: Int, _ newChar: Character) -> String {
    var chars = Array(myString)     // gets an array of characters
    chars[index] = newChar
    let modifiedString = String(chars)
    return modifiedString
}
