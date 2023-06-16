//
//  ContentView.swift
//  ITIROD-LAB1
//
//  Created by Artyom on 16.02.23.
//

import SwiftUI
import Network

struct ContentView: View {
    
    @State var connection: NWConnection?
    
    var host: NWEndpoint.Host = "127.0.0.1"
    var port: NWEndpoint.Port = 1234
    
    var body: some View {
        VStack {
            Spacer()
            Button("Connect") {
                NSLog("Connect pressed")
                connect()
            }
            Spacer()
            Button("Send") {
                NSLog("Send pressed")
                send("hello".data(using: .utf8)!)
            }
            Spacer()
        }.padding()
    }
    
    func send(_ payload: Data) {
        connection!.send(content: payload, completion: .contentProcessed({ sendError in
            if let error = sendError {
                NSLog("Unable to process and send the data: \(error)")
            } else {
                NSLog("Data has been sent")
                connection!.receiveMessage { (data, context, isComplete, error) in
                    if(isComplete){
                        guard let myData = data else { return }
                        NSLog("Received message: " + String(decoding: myData, as: UTF8.self))
                    }else{
                        NSLog("XYITA")
                    }
                }
            }
        }))
    }
    
    func connect() {
        connection = NWConnection(host: host, port: port, using: .udp)
        
        connection!.stateUpdateHandler = { (newState) in
            switch (newState) {
            case .preparing:
                NSLog("Entered state: preparing")
            case .ready:
                NSLog("Entered state: ready")
            case .setup:
                NSLog("Entered state: setup")
            case .cancelled:
                NSLog("Entered state: cancelled")
            case .waiting:
                NSLog("Entered state: waiting")
            case .failed:
                NSLog("Entered state: failed")
            default:
                NSLog("Entered an unknown state")
            }
        }
        
        connection!.viabilityUpdateHandler = { (isViable) in
            if (isViable) {
                NSLog("Connection is viable")
            } else {
                NSLog("Connection is not viable")
            }
        }
        
        connection!.betterPathUpdateHandler = { (betterPathAvailable) in
            if (betterPathAvailable) {
                NSLog("A better path is availble")
            } else {
                NSLog("No better path is available")
            }
        }
        
        connection!.start(queue: .global())
    }
}
