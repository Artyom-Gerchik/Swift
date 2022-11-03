//
//  Sequence.swift
//  PPO_LAB_2
//
//  Created by Artyom on 31.10.22.
//

import Foundation

struct Sequence: Hashable{
    var id: UUID = UUID()
    var name: String = ""
    var actions: [Action] = []
    var bgColor: String = ""
    
    init(name: String, actions: [Action], bgColor: String) {
        self.name = name
        self.actions = actions
        self.bgColor = bgColor
    }
}
