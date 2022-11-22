//
//  Action.swift
//  PPO_LAB_2
//
//  Created by Artyom on 20.10.22.
//

import Foundation

struct Action: Hashable{
    var id: UUID = UUID()
    var sequenceId: UUID!
    var name: String = ""
    var description: String = ""
    var duration: Int = 0
    var imageName : String = ""
    
    init(name: String, description: String, duration: Int, imageName: String, sequenceId: UUID) {
        self.name = name
        self.description = description
        self.duration = duration
        self.imageName = imageName
        self.sequenceId = sequenceId
    }
}
