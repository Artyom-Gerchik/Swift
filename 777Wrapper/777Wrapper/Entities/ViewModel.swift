//
//  ViewModel.swift
//  777Wrapper
//
//  Created by Artyom on 16.06.23.
//

import Foundation

class ViewModel: ObservableObject{
    enum State{
        case mainPage
        case secondPage
    }
    
    @Published var state: State
    
    init(state: State){
        self.state = state
    }
}
