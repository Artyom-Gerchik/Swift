//
//  ViewModel.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    
    enum State{
        case mainPage
        case secondPage
        case settingsPage
        case timerPage
    }
    
    @Published var state: State
    @Published var fontSize: Double
    @Published var actionsOnMainPage: [Action]
    @Published var isPaused: Bool = false
    
    init(state: State, fontSize: Double, actionsOnMainPage: [Action]) {
        self.state = state
        self.fontSize = fontSize
        self.actionsOnMainPage = actionsOnMainPage
    }
    
    func changeFontSize(newFontSize: Double){
        fontSize = newFontSize
    }
    
    func addActionToMainPage(actionName: String, actionDescription: String, actionDuration: Int, actionImageName: String){
        let action: Action = Action(name: actionName, description: actionDescription, duration: 10, imageName: actionImageName)
        actionsOnMainPage.append(action)
        
        DB_Manager().addActionOnMainPage(idValue: action.id,
                                         nameValue: action.name,
                                         descriptionValue: action.description,
                                         durationValue: Double(action.duration),
                                         imageNameValue: action.imageName)
    }
    
    func removeActionFromMainPage(idToRemove: UUID){
        var index: Int = 0
        for action in actionsOnMainPage{
            if (action.id == idToRemove){
                actionsOnMainPage.remove(at: index)
                DB_Manager().deleteOneActionOnMainPage(idToDelete: idToRemove)
            }
            index += 1
        }
    }
    
    func deleteAllActionsOnMainPage(){
        actionsOnMainPage.removeAll()
        DB_Manager().deleteAllActionsOnMainPage()
    }
    
}
