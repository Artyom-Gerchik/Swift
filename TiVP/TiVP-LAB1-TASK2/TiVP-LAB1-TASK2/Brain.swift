//
//  Brain.swift
//  TiVP-LAB1-TASK2
//
//  Created by Artyom on 15.09.23.
//

import Foundation

class Brain{
    private var Humans: [Human] = []
    
    public func printHumans(){
        print("HUMANS")
        print("SURNAME NAME AGE")
        print("")
        for human in Humans{
            print(human.getSurname(), terminator: " ")
            print(human.getName(), terminator: " ")
            print(human.getAge(), terminator: "")
            print("")
        }
    }
    
    public func getHumans(){
        var boolInput = true
        
        print("Input humans as: NAME SURNAME AGE.\nType TERMINATE, to exit input\n")
        
        while boolInput{
            let userInput = readLine()
            
            if(userInput == "TERMINATE"){
                boolInput = false
                print("")
                break
            }else{
                let userInputElements = userInput?.split(separator: " ")
                
                if(userInputElements!.count < 3 || userInputElements!.count > 3){
                    print("FOLLOW THE RIGHT PATTERN!")
                    continue
                }
                else{
                    let ageAsInt = Int((userInputElements?[2])!) ?? 0
                    if(ageAsInt == 0){
                        print("FOLLOW THE RIGHT PATTERN!")
                        continue
                    }else{
                        let humanToAdd = Human(Name: String((userInputElements?[0])!), Surname: String((userInputElements?[1])!), Age: Int((userInputElements?[2])!)!)
                        self.Humans.append(humanToAdd)
                    }
                }
            }
        }
    }
    
    public func getLowestHighestAndMediumAge(){
        var ages: [Int] = []
        
        for human in Humans{
            ages.append(human.getAge())
        }
        
        print("")
        print("AGES\nMAX MIN AVG")
        print(ages.max()!, " ", ages.min()!, " ", Double(round((Double(ages.reduce(0, +)) / Double(ages.count)) * 100) / 100 ))
        
    }
}
