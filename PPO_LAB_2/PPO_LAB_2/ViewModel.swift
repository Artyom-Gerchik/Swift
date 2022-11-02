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
        case mainTimerPage
        case secondTimerPage
        case createSequencePage
        case sequencesUnionPage
        case editSequencePage
    }
    
    @Published var state: State
    @Published var fontSize: Double
    @Published var actionsOnMainPage: [Action]
    @Published var sequenceOnCreatePhase: Sequence = Sequence(name: "", actions: [], bgColor: "")
    @Published var sequences: [Sequence]
    @Published var isPaused: Bool = false
    @Published var sequenceIdForTimer: UUID!
    @Published var sequenceIdToEdit: UUID!
    
    init(state: State, fontSize: Double, actionsOnMainPage: [Action], sequences: [Sequence]) {
        self.state = state
        self.fontSize = fontSize
        self.actionsOnMainPage = actionsOnMainPage
        self.sequences = sequences
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
    
    func removeActionFromSequenceCreatePage(idToRemove: UUID){
        var index: Int = 0
        for action in sequenceOnCreatePhase.actions{
            if (action.id == idToRemove){
                sequenceOnCreatePhase.actions.remove(at: index)
            }
            index += 1
        }
    }
    
    func deleteAllActionsOnMainPage(){
        actionsOnMainPage.removeAll()
        DB_Manager().deleteAllActionsOnMainPage()
    }
    
    func addSequence(sequenceName: String, sequenceActions: [Action], bgColor: String){
        let sequence: Sequence = Sequence(name: sequenceName, actions: sequenceActions, bgColor: bgColor)
        sequences.append(sequence)
    }
    
    func unionSequences(sequencesIds: [UUID], bgColor: String){
        var newUnion: [Sequence] = []
        var newSequence: Sequence = Sequence(name: "", actions: [], bgColor: "")
        
        for id in sequencesIds {
            for sequence in sequences {
                if(sequence.id == id){
                    newUnion.append(sequence)
                }
            }
        }
        
        for sequence in newUnion {
            newSequence.name.append(sequence.name)
            newSequence.name.append(" + ")
            for action in sequence.actions{
                let newAction: Action = Action(name: action.name, description: action.description, duration: action.duration, imageName: action.imageName)
                newSequence.actions.append(newAction)
            }
            //newSequence.actions += sequence.actions
        }
        addSequence(sequenceName: newSequence.name, sequenceActions: newSequence.actions, bgColor: bgColor)
    }
    
    func getSequenceForEdit(sequenceID: UUID) -> Sequence{
        for sequence in sequences {
            if(sequence.id == sequenceID){
                return sequence
            }
        }
        return Sequence(name: "", actions: [], bgColor: "")
    }
    
    func updateSequence(updatedSequence: Sequence){
        
        for i in sequences.indices {
            if sequences[i].id == updatedSequence.id {
                sequences[i] = updatedSequence
            }
        }
        
        //var sequenceForUpdate: Sequence
        
        //        sequences.first(where: {$0.id == sequenceIdToEdit})?.name = updatedSequence.name
        //        sequences.filter({$0.id == sequenceIdToEdit}).first?.actions = updatedSequence.actions
        //        //sequences.filter({$0.id == sequenceIdToEdit}).first?.name = updatedSequence.name
        
        
        //        for sequence in sequences {
        //            if(sequence.id == updatedSequence.id){
        //                sequence.name = updatedSequence.name
        //
        //                            }
        //        }
        
        //sequenceForUpdate = updatedSequence
    }
    
}
