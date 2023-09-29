//
//  utils.swift
//  TiVP-LAB1-TASK5
//
//  Created by Artyom on 29.09.23.
//

import Foundation

func task5(path: String, ext: String) -> [URL]{
    
    //var array = [String]()
    
    let path = path
    let extensionOfFile = ext
    
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
    }
    return files
}
