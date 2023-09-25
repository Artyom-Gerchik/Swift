//
//  Human.swift
//  TiVP-LAB1-TASK2
//
//  Created by Artyom on 15.09.23.
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
