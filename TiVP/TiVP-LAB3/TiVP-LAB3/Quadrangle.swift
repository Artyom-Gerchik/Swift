//
//  Quadrangle.swift
//  TiVP-LAB3
//
//  Created by Artyom on 13.10.23.
//

import Foundation

class Quadrangle{
    public enum QuadrangleType{
        case Quadrangle
        case Deltoid
        case Parallelogram
        case Trapezoid
        case Rhombus
        case Rectangle
        case Square
    }
    
    private var sides = [Double]()
    private var angles = [Double]()
    
    init(sides: [Double], angles: [Double]) {
        self.sides = sides
        self.angles = angles
    }
    
    public func checkParams() -> Bool{
        for side in sides {
            if(side <= 0){
                return false
            }
        }
        for angle in angles {
            if(angle <= 0){
                return false
            }
        }
        return true
    }
    
    public func checkAnglesSum() -> Bool{
        return angles.reduce(0, +) == 360
    }
    
    public func checkEachAngle() -> Bool{
        for angle in angles {
            let sum = angles.reduce(0, +)
            if(angle > (sum - angle)){
                return false
            }
        }
        return true
    }
    
    public func checkEachSide() -> Bool{
        for side in sides {
            let sum = sides.reduce(0, +)
            if(side > (sum - side)){
                return false
            }
        }
        return true
    }
    
    public func checkAnglesEquality() -> Bool{
        for angle in angles {
            if(angle != 90){
                return false
            }
        }
        return true
    }
    
    public func checkSidesEquality() -> Bool{
        for side in sides {
            if(side != sides.first){
                return false
            }
        }
        return true
    }
    
    public func checkOppositeAnglesEquality() -> Bool{
        for index in 0...((angles.count / 2) - 1){
            if(angles[index] != angles[index + 2]){
                return false
            }
        }
        return true
    }
    
    public func checkOppositeSidesEquality() -> Bool{
        for index in 0...((sides.count / 2) - 1){
            if(sides[index] != sides[index + 2]){
                return false
            }
        }
        return true
    }
    
    public func checkSupplementaryAngles() -> Bool{
        return (((angles[0] + angles[1]) == 180) && ((angles[2] + angles[3]) == 180)) ||
               (((angles[0] + angles[3]) == 180) && ((angles[1] + angles[2]) == 180))
    }
    
    public func checkSupplementarySides() -> Bool{
        ((sides[0] == sides[1]) && (sides[2] == sides[3])) ||
        ((sides[0] == sides[3]) && (sides[1] == sides[2]))
    }
    
    public func checkType() -> QuadrangleType{
        if(checkAnglesEquality()){
            if(checkSidesEquality()){
                return QuadrangleType.Square
            }else if(checkOppositeSidesEquality()){
                return QuadrangleType.Rectangle
            }
        }else if(checkOppositeAnglesEquality()){
            if(checkSidesEquality()){
                return QuadrangleType.Rhombus
            }else if(checkOppositeSidesEquality()){
                return QuadrangleType.Parallelogram
            }
        }else if(checkSupplementaryAngles()){
            return QuadrangleType.Trapezoid
        }else if(checkSupplementarySides()){
            return QuadrangleType.Deltoid
        }
        return QuadrangleType.Quadrangle
    }

}
