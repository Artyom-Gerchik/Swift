//
//  main.swift
//  TiVP-LAB1-TASK5
//
//  Created by Artyom on 28.09.23.
//

import Foundation

let path = "/Users/lnxd/Desktop/MZI" //CommandLine.arguments[1]
let extensionOfFile = "pdf" // CommandLine.arguments[2]

let url = URL(fileURLWithPath: path)
var files = [URL]()
if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
    for case var fileURL as URL in enumerator {
        do {
            let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
            if fileAttributes.isRegularFile! {
                if(fileURL.absoluteString.contains("." + extensionOfFile)){
                    files.append(fileURL)
                }
            }
        } catch { print(error, fileURL) }
    }
    for item in files{
        print(item)
    }
}
