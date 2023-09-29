//
//  main.swift
//  TiVP-LAB1-TASK6
//
//  Created by Artyom on 28.09.23.
//

import Foundation

func loadFileSync(url: URL, destinationUrl1: URL)
{
    let destinationUrl = destinationUrl1.appendingPathComponent(url.lastPathComponent)
    
    if FileManager().fileExists(atPath: destinationUrl.path)
    {
        print("File already exists [\(destinationUrl.path)]")
    }
    else if let dataFromURL = NSData(contentsOf: url)
    {
        if dataFromURL.write(to: destinationUrl, atomically: true)
        {
            print("\(destinationUrl.path)")
        }
        else
        {
            print("error saving file")
            _ = NSError(domain:"Error saving file", code:1001, userInfo:nil)
        }
    }
    else
    {
        _ = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
    }
}

let url = CommandLine.arguments[1] // "https://www.africau.edu/images/default/sample.pdf" //
var destinationUrl = CommandLine.arguments[2] // "/Users/lnxd/Desktop/folder_for_task6" //

destinationUrl = "file://" + destinationUrl;

loadFileSync(url: URL(string: url)!, destinationUrl1: URL(string: destinationUrl)!)
