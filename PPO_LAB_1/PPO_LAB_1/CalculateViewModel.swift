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
        }
    }
    
    @Published var input: String = "" {
        didSet {
            if input.count == 10{
                input = oldValue
            }
            guard let inputAsDouble = Double(input) else {
                output = "jopa"
                return
            }
            output = String(round((inputAsDouble / properCoefficent) * 1000) / 1000.0)
        }
    }
    @Published var output: String = ""
    
    
    var properCoefficent: Double{
        if directConversion{
            return coefficient
        }
        else{
            return 1/coefficient
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
    
}
