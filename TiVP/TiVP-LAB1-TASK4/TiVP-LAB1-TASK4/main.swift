//
//  main.swift
//  TiVP-LAB1-TASK4
//
//  Created by Artyom on 15.09.23.
//

import Foundation

let fileManager = FileManager.default
let filePath = "/Users/lnxd/Desktop/TASK4.html"
var fileContent = "<!DOCTYPE html> <html lang='en'> <head> <title>A simple HTML document</title> </head> <body> <table cellspacing='0' style='width: 100%; height: 100vh' >"

for color in 0...255{
    fileContent += "<tr><th style='background: rgb(\(255 - color), \(255 - color), \(255 - color));'></th></tr>"
}

fileContent += "</table> </body> </html>"


if let data = fileContent.data(using: .utf8) {
    let success = fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
    if success {
        print("File created and data written successfully.")
    } else {
        print("Failed to create file.")
    }
} else {
    print("Failed to convert string to data.")
}
