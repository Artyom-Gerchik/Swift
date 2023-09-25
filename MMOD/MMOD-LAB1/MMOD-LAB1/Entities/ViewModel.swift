//
//  ViewModel.swift
//  MMOD-LAB1
//
//  Created by Artyom on 18.09.23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    enum State{
        case mainPage
        case firstTaskPage
        case secondTaskPage
        case thirdTaskPage
        case fourthTaskPage
    }
    
    @Published var state: State
    @Published var stringForTask1: String
    @Published var stringForTask2: String
    @Published var stringForTask3: String
    @Published var stringForTask4: String
    
    private var trueCounter: Int = 0
    private var falseCounter: Int = 0
    
    private var oneCounter: Int = 0
    private var twoCounter: Int = 0
    private var threeCounter: Int = 0
    private var fourCounter: Int = 0
    
    
    init(state: State, stringForTask1: String, stringForTask2: String, stringForTask3: String, stringForTask4: String) {
        self.state = state
        self.stringForTask1 = stringForTask1
        self.stringForTask2 = stringForTask2
        self.stringForTask3 = stringForTask3
        self.stringForTask4 = stringForTask4
    }
    
    public func firstTask(probability: Int){
        for _ in 0...1000000{
            let tmp = weightedRandom(weightedValues: (value: "true", weight: Double(probability)), (value: "false", weight: Double(100 - probability)))
            
            if(tmp == "true"){
                trueCounter += 1
            }else if(tmp == "false"){
                falseCounter += 1
            }
        }
        
        stringForTask1 = ""
        
        stringForTask1 += "True: "
        stringForTask1 += String(trueCounter)
        stringForTask1 += " "
        let percent = (Double(trueCounter) / 1000000) * 100
        let percentNorm = Double(round(1000 * percent) / 1000)
        stringForTask1 += String(percentNorm)
        stringForTask1 += "%\n"
        
        stringForTask1 += "False: "
        stringForTask1 += String(falseCounter)
        stringForTask1 += " "
        let percent1 = (Double(falseCounter) / 1000000) * 100
        let percentNorm1 = Double(round(1000 * percent1) / 1000)
        stringForTask1 += String(percentNorm1)
        stringForTask1 += "%\n"
        
        trueCounter = 0
        falseCounter = 0
        
    }
    
    public func secondTask(probability: String){
        var probArray = probability.split(separator: ",")
        
        for prob in probArray {
            if(Int(prob)! < 0 || Int(prob)! > 100 ){
                stringForTask2 = "REDNECK"
                return
            }
        }
        stringForTask2 = ""
        
        for prob in probArray {
            for _ in 0...1000000{
                let tmp = weightedRandom(weightedValues: (value: "true", weight: Double(Int(prob)!)), (value: "false", weight: Double(100 - Int(prob)!)))
                
                if(tmp == "true"){
                    trueCounter += 1
                }else if(tmp == "false"){
                    falseCounter += 1
                }
            }
            stringForTask2 += "True: "
            stringForTask2 += String(trueCounter)
            stringForTask2 += " "
            let percent = (Double(trueCounter) / 1000000) * 100
            let percentNorm = Double(round(1000 * percent) / 1000)
            stringForTask2 += String(percentNorm)
            stringForTask2 += "%\n"
            
            stringForTask2 += "False: "
            stringForTask2 += String(falseCounter)
            stringForTask2 += " "
            let percent1 = (Double(falseCounter) / 1000000) * 100
            let percentNorm1 = Double(round(1000 * percent1) / 1000)
            stringForTask2 += String(percentNorm1)
            stringForTask2 += "%\n\n"
            
            trueCounter = 0
            falseCounter = 0
            
        }
    }
    
    public func thirdTask(probability: String){
        var probArray = probability.split(separator: ",")
        
        for prob in probArray {
            if(prob.count < 3 && prob.count > 0){
                if(Int(prob)! < 0 || Int(prob)! > 100 ){
                    stringForTask3 = "REDNECK"
                    return
                }
            }else{
                return
            }
        }
        stringForTask3 = ""
        
        var a: Double = Double(Int(probArray[0])!)/100
        var b: Double = Double(Int(probArray[1])!)/100
        
        var ab = a * b
        var aNotB = a * (1-b)
        var notAB = (1-a) * (1-b)
        var notANotB = 1 - ab - aNotB - notAB
        
    
        
        for _ in 0...1000000{
            let tmp = weightedRandom(weightedValues:
                                        (value: "1", weight: Double(ab) * 100),
                                     (value: "2", weight: Double(aNotB) * 100),
                                     (value: "3", weight: Double(notAB) * 100),
                                     (value: "4", weight: Double(notANotB) * 100))
            
            if(tmp == "1"){
                oneCounter += 1
            }else if(tmp == "2"){
                twoCounter += 1
            }else if(tmp == "3"){
                threeCounter += 1
            }else if(tmp == "4"){
                fourCounter += 1
            }
        }
        
        stringForTask3 += "1: "
        stringForTask3 += String(oneCounter)
        stringForTask3 += " "
        var percent = (Double(oneCounter) / 1000000) * 100
        var percentNorm = Double(round(1000 * percent) / 1000)
        stringForTask3 += String(percentNorm)
        stringForTask3 += "%\n"
        
        stringForTask3 += "2: "
        stringForTask3 += String(twoCounter)
        stringForTask3 += " "
        percent = (Double(twoCounter) / 1000000) * 100
        percentNorm = Double(round(1000 * percent) / 1000)
        stringForTask3 += String(percentNorm)
        stringForTask3 += "%\n"
        
        stringForTask3 += "3: "
        stringForTask3 += String(threeCounter)
        stringForTask3 += " "
        percent = (Double(threeCounter) / 1000000) * 100
        percentNorm = Double(round(1000 * percent) / 1000)
        stringForTask3 += String(percentNorm)
        stringForTask3 += "%\n"
        
        stringForTask3 += "4: "
        stringForTask3 += String(fourCounter)
        stringForTask3 += " "
        percent = (Double(fourCounter) / 1000000) * 100
        percentNorm = Double(round(1000 * percent) / 1000)
        stringForTask3 += String(percentNorm)
        stringForTask3 += "%\n"
        
        oneCounter = 0
        twoCounter = 0
        threeCounter = 0
        fourCounter = 0
        
        
    }
    
    public func fourthTask(probability: String){
        
        var probArray = probability.split(separator: ",")
        var tmp = 0
        
        for prob in probArray {
            tmp += Int(prob)!
            if(tmp > 100){
                stringForTask4 = "REDNECK"
                return
            }
            if(Int(prob)! < 0 || Int(prob)! > 100 ){
                stringForTask4 = "REDNECK"
                return
            }
        }
        
        var arrayTask4: [Task4Class] = []
        
        var tmpCounter = 1
        for prob in probArray {
            arrayTask4.append(Task4Class(text: "\(tmpCounter)", probability: Double(Int(prob)!), counter: 0))
            tmpCounter += 1
        }
        
        stringForTask4 = ""
        var megaArray: [Any] = []
        
        for elem in arrayTask4{
            var elemForProb = (value: "\(elem.text)", weight: elem.probability)
            megaArray.append(elemForProb)
        }
        
        
        for _ in 0...1000000{
            let tmp = funcForTask4(array: arrayTask4)
            
            let i = arrayTask4.firstIndex(where: { $0.text == tmp })
            arrayTask4[i!].counter += 1
            
            
//            stringForTask4 += "\(arrayTask4[i!].text)"
//            stringForTask4 += "\(arrayTask4[i!].counter)"
//            stringForTask4 += " "
//            var percent = (Double(arrayTask4[i!].counter) / 1000000) * 100
//            var percentNorm = Double(round(1000 * percent) / 1000)
//            stringForTask4 += String(percentNorm)
//            stringForTask4 += "%\n"
        }
        
        for elem in arrayTask4{
            stringForTask4 += "\(elem.text)"
            stringForTask4 += "\(elem.counter)"
            stringForTask4 += " "
            var percent = (Double(elem.counter) / 1000000) * 100
            var percentNorm = Double(round(1000 * percent) / 1000)
            stringForTask4 += String(percentNorm)
            stringForTask4 += "%\n"
        }
        
    }
    
    func weightedRandom<Value>(weightedValues: (value: Value, weight: Double)...) -> Value {
        let rnd = Double.random(in: 0.0...100.0)
        var accWeight = 0.0
        
        for (value, weight) in weightedValues {
            accWeight += weight
            if rnd <= accWeight {
                return value
            }
        }
        //If the sum of weights is less the 100%, the last value is returned
        return weightedValues.last!.value
    }
    
    func funcForTask4(array:[Task4Class]) -> String {
        let rnd = Double.random(in: 0.0...100.0)
        var accWeight = 0.0
        
        for elem in array {
            
            accWeight += elem.probability
            if rnd <= accWeight {
                return elem.text
            }
        }
        //If the sum of weights is less the 100%, the last value is returned
        return array.last!.text
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
