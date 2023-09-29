//
//  utils.swift
//  TiVP-LAB1-TASK2
//
//  Created by Artyom on 29.09.23.
//

import Foundation

class Human{
    private var Name: String
    private var Surname: String
    private var Age: Int
    
    init(Name: String, Surname: String, Age: Int) {
        self.Name = Name
        self.Surname = Surname
        self.Age = Age
    }
    
    public func getName() -> String{
        return self.Name
    }
    
    public func getSurname() -> String{
        return self.Surname
    }
    
    public func getAge() -> Int{
        return self.Age
    }
}

class Brain{
    private var Humans: [Human] = []
    
    public func printHumans() -> [String]{
        var arrToReturn = [String]()
        for human in Humans{
            var humanAsString: String = ""
            humanAsString += human.getSurname()
            humanAsString += " "
            humanAsString += human.getName()
            humanAsString += " "
            humanAsString += String(human.getAge())
            arrToReturn.append(humanAsString)
        }
        return arrToReturn
    }
    
    public func getHumans(humans: [Human]) -> Bool{
        
        for human in humans {
            self.Humans.append(human)
        }
        return true
    }
    
    public func getLowestHighestAndMediumAge() -> [Double]{
        
        var ages: [Double] = []
        
        for human in Humans{
            ages.append(Double(human.getAge()))
        }
        var arrToReturn = [Double]()
        
        arrToReturn.append(ages.max()!)
        arrToReturn.append(ages.min()!)
        arrToReturn.append(Double(round((Double(ages.reduce(0, +)) / Double(ages.count)) * 100) / 100 ))
        
        return arrToReturn
        
    }
}
