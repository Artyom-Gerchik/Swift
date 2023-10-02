//
//  ViewModel.swift
//  MMOD-LAB2
//
//  Created by Artyom on 1.10.23.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    enum State{
        case mainPage
        case firstTaskPage
        case secondTaskPage
    }
    
    @Published var state: State
    
    init(state: State) {
        self.state = state
    }
    
    private var IKSI = [Int]()
    
    public func firstTaskInitialChart(leftBorder: Int, rightBorder: Int) -> [Double] {
        let countOfAttempts: Int = 100000
        var resultArray = [Double]()
        
        
        for _ in 0...countOfAttempts{
            let value: Double = Double(rightBorder - leftBorder) * Double.random(in: 0.0 ..< 1.0) + Double(leftBorder)
            
            resultArray.append(value)
        }
        
        return resultArray
    }
    
    public func secondTaskInitialChart(leftBorder: Int, rightBorder: Int) -> [Double] {
        let countOfAttempts: Int = 100000
        var resultArray = [Double]()
        
        
        for _ in 0...countOfAttempts{
            var x = Double(Int.random(in: leftBorder ..< (leftBorder + rightBorder - 1)))
            IKSI.append(Int(x))
            
            var a = Double(leftBorder)
            var b = Double(rightBorder)
            
            
            let value: Double = (x - a + 1) / b
            resultArray.append(value)
        }
        
        return resultArray
    }
    
    public func calcM(leftBorder: Int, rightBorder: Int) -> Double{
        let leftDouble = Double(leftBorder)
        let rightDouble = Double(rightBorder)
        
        return (leftDouble + rightDouble) / 2
    }
    
    public func calcMTask2(leftBorder: Int, rightBorder: Int) -> Double{
        let leftDouble = Double(leftBorder)
        let rightDouble = Double(rightBorder)
        
        return leftDouble + ((rightDouble - 1) / 2)
    }
    
    public func calcDTask2(leftBorder: Int, rightBorder: Int) -> Double{
        let leftDouble = Double(leftBorder)
        let rightDouble = Double(rightBorder)
        
        return ((rightDouble * rightDouble) - 1) / 12
    }
    
    public func calcD(leftBorder: Int, rightBorder: Int) -> Double{
        let leftDouble = Double(leftBorder)
        let rightDouble = Double(rightBorder)
        
        return ((rightDouble - leftDouble) * (rightDouble - leftDouble)) / 12
    }
    
    public func calcSC(leftBorder: Int, rightBorder: Int) -> Double{
        let leftDouble = Double(leftBorder)
        let rightDouble = Double(rightBorder)
        
        return (rightDouble - leftDouble) / (2 * sqrt(3))
    }
    
    
    public func pointsEstimate(resArray: [Double]) -> [Double]{
        var returnArray = [Double]()
        
        var MToReturn: Double = 0
        var DToReturn: Double = 0
        var SCToReturn: Double = 0
        var leftToReturn: Double = 0
        var rightToReturn: Double = 0
        
        for item in resArray{
            MToReturn = MToReturn + item
        }
        MToReturn = MToReturn / 100000
        
        for item in resArray{
            DToReturn = DToReturn + ((item - MToReturn) * (item - MToReturn))
        }
        DToReturn = DToReturn / 100000
        
        
        SCToReturn = sqrt(DToReturn)
        
        leftToReturn = MToReturn - sqrt(3) * SCToReturn
        rightToReturn = MToReturn + sqrt(3) * SCToReturn
        
        let confidenceValue: Double = 0.90
        let confidenceIntervalLeft: Double = MToReturn - (confidenceValue*(SCToReturn/sqrt(100000)))
        let confidenceIntervalRight: Double = MToReturn + (confidenceValue*(SCToReturn/sqrt(100000)))
        
        
        let density: Double = 1 / (rightToReturn - leftToReturn)
        var xhi_emperical: Double = 0
        
        var resArraySorted = resArray
        resArraySorted.sort()
        
        
        for(index, element) in resArraySorted.enumerated(){
            if(index + 1 >= resArraySorted.count){
                break
            }else{
                let n_i = 100000 * density * (resArraySorted[index + 1] - resArraySorted[index])
                xhi_emperical = xhi_emperical + ((n_i - round(n_i)) * (n_i - round(n_i))) / n_i
            }
        }
        
        returnArray.append(MToReturn)
        returnArray.append(DToReturn)
        returnArray.append(SCToReturn)
        returnArray.append(leftToReturn)
        returnArray.append(rightToReturn)
        returnArray.append(confidenceIntervalLeft)
        returnArray.append(confidenceIntervalRight)
        returnArray.append(xhi_emperical)
        
        
        return returnArray
    }
    
    
    public func pointsEstimateTask2() -> [Double]{
        var returnArray = [Double]()
        
        var MToReturn: Double = 0
        var DToReturn: Double = 0
        var SCToReturn: Double = 0
        var leftToReturn: Double = 0
        var rightToReturn: Double = 0
        
        for item in IKSI{
            MToReturn = MToReturn + Double(item)
        }
        MToReturn = MToReturn / 100000
        
        for item in IKSI{
            DToReturn = DToReturn + ((Double(item) - MToReturn) * (Double(item) - MToReturn))
        }
        DToReturn = DToReturn / 100000
        
        
        SCToReturn = sqrt(DToReturn)
        
        leftToReturn = MToReturn - sqrt(3) * SCToReturn
        rightToReturn = MToReturn + sqrt(3) * SCToReturn
        
        let confidenceValue: Double = 0.90
        let confidenceIntervalLeft: Double = MToReturn - (confidenceValue*(SCToReturn/sqrt(100000)))
        let confidenceIntervalRight: Double = MToReturn + (confidenceValue*(SCToReturn/sqrt(100000)))
        
        
        var density: Double = 1 / (rightToReturn - leftToReturn)
        var xhi_emperical: Double = 0
        
        IKSI.sort()
        var unique = Array(Set(IKSI))
        unique.sort()
        var tmp = unique.count
        density = density * Double(tmp)
        
        for(index, element) in unique.enumerated(){
            if(index + 1 >= unique.count){
                break
            }else{
                let n_i = density * (Double(unique[index + 1]) - Double(unique[index]))
                xhi_emperical = xhi_emperical + ((n_i - round(n_i)) * (n_i - round(n_i)))
            }
        }
        
        
        returnArray.append(MToReturn)
        returnArray.append(DToReturn)
        returnArray.append(SCToReturn)
        returnArray.append(leftToReturn)
        returnArray.append(rightToReturn)
        returnArray.append(confidenceIntervalLeft)
        returnArray.append(confidenceIntervalRight)
        returnArray.append(xhi_emperical)
        
        
        return returnArray
    }
    
    
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
