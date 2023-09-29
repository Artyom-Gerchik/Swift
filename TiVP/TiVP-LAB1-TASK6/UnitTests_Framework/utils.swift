//
//  utils.swift
//  TiVP-LAB1-TASK6
//
//  Created by Artyom on 29.09.23.
//

import Foundation


func loadFileSync(url: URL, destinationUrl1: URL) -> String
{
    let destinationUrl = destinationUrl1.appendingPathComponent(url.lastPathComponent)
    
    if FileManager().fileExists(atPath: destinationUrl.path)
    {
        return "FILE EXISTS"
        //print("File already exists [\(destinationUrl.path)]")
    }
    else if let dataFromURL = NSData(contentsOf: url)
    {
        if dataFromURL.write(to: destinationUrl, atomically: true)
        {
            return "FILE SAVED"
            //print("\(destinationUrl.path)")
        }
        else
        {
            return "ERROR"
            //print("error saving file")
            //_ = NSError(domain:"Error saving file", code:1001, userInfo:nil)
        }
    }
    else
    {
        return "ERROR"
        //_ = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
    }
    
    return ""
}
