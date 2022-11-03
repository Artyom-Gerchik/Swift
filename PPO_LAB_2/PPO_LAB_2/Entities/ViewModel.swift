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
        let action: Action = Action(name: actionName, description: actionDescription, duration: 10, imageName: actionImageName,sequenceId: UUID())
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
        DB_Manager().addSequence(sequenceToAdd: sequence)
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
                let newAction: Action = Action(name: action.name, description: action.description, duration: action.duration, imageName: action.imageName, sequenceId: newSequence.id)
                newSequence.actions.append(newAction)
            }
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
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

extension Color {
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
