//
//  utils.swift
//  TiVP-LAB1-TASK4
//
//  Created by Artyom on 29.09.23.
//

import Foundation

func task4() -> [String]{
    //let fileManager = FileManager.default
    //let filePath = "/Users/lnxd/Desktop/TASK4.html"
    
    var arrToReturn = [String]()
    
    arrToReturn.append("<!DOCTYPE html> <html lang='en'> <head> <title>A simple HTML document</title> </head> <body> <table cellspacing='0' style='width: 100%; height: 100vh' >")
    
    for color in 0...255{
        arrToReturn.append("<tr><th style='background: rgb(\(255 - color), \(255 - color), \(255 - color));'></th></tr>")
    }
    
    arrToReturn.append("</table> </body> </html>")
    
    return arrToReturn
    
}
