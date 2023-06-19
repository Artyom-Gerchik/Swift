//
//  ViewModel.swift
//  777Wrapper
//
//  Created by Artyom on 16.06.23.
//

import Foundation
import SwiftSoup

class ViewModel: ObservableObject{
    enum State{
        case mainPage
        case secondPage
    }
    
    @Published var state: State
    
    init(state: State){
        self.state = state
    }
    
    func fetchAPI() -> String{
        let url = URL(string: "http://vezu-expres.by/site/times/1/19-06-2023")!
        
        var htmlResponse: String = ""
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared
        task.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            htmlResponse = String(data: data, encoding: .utf8)!
            semaphore.signal();
        }.resume()
        
        semaphore.wait()
        
        return htmlResponse
    }
    
    func parseHTML(){
        
        let htmlResponse = fetchAPI()
        
        
        //print(htmlResponse)
        
        print("##########")
        do {
            let doc: Document = try SwiftSoup.parse(htmlResponse)
            //print(try doc.text())
            let departureTimes : Element = try doc.select("select").first()!
            let departureTimesAsArray : Elements = try departureTimes.select("option")
            
            for singleOption: Element in departureTimesAsArray.array(){
                print(try singleOption.text())
            }
            
            
            print("##########")

            
            let departurePlaces : Element = try doc.select("select").last()!
            let departurePlacesAsArray : Elements = try departurePlaces.select("option")
            
            for singleOption: Element in departurePlacesAsArray.array(){
                print(try singleOption.text())
            }
            
            
            
            //            var departureTimes: String = try doc.select("select").first()!.text()
            //            var departurePlaces: String = try doc.select("select").last()!.text()
            //
            //            print("_______")
            //            print("\n")
            //            print(departureTimes)
            //            print("\n")
            //            print(departurePlaces)
            //            print("\n")
            //            print("_______")
            
            
            
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
        print("##########")
        
    }
}
