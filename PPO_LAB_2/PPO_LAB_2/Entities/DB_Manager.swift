//
//  DB_Manager.swift
//  PPO_LAB_2
//
//  Created by Artyom on 26.10.22.
//

import Foundation
import SQLite

class DB_Manager{
    private var db: Connection!
    
    private var viewModels: Table!
    private var fontSize: Expression<Double>!
    
    private var actionsOnMainPage: Table!
    private var id: Expression<UUID>!
    private var name: Expression<String>!
    private var description: Expression<String>!
    private var duration: Expression<Double>!
    private var imageName : Expression<String>!
    
    private var sequences: Table!
    private var seq_id: Expression<UUID>!
    private var seq_name: Expression<String>!
    private var seq_bgColor: Expression<String>!
    
    private var seqActions: Table!
    private var seq_action_seq_id: Expression<UUID>!
    private var seq_action_id: Expression<UUID>!
    private var seq_action_name: Expression<String>!
    private var seq_action_description: Expression<String>!
    private var seq_action_duration: Expression<Double>!
    private var seq_action_imageName: Expression<String>!
    
    
    init(){
        do{
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/db1.sqlite3")
            
            viewModels = Table("view_models")
            fontSize = Expression<Double>("fontSize")
            
            actionsOnMainPage = Table("actions_on_main_page")
            id = Expression<UUID>("id")
            name = Expression<String>("name")
            description = Expression<String>("description")
            duration = Expression<Double>("duration")
            imageName = Expression<String>("imageName")
            
            sequences = Table("sequences")
            seq_id = Expression<UUID>("seq_id")
            seq_name = Expression<String>("seq_name")
            seq_bgColor = Expression<String>("seq_bgColor")
            
            seqActions = Table("seq_actions")
            seq_action_id = Expression<UUID>("seq_action_id")
            seq_action_seq_id = Expression<UUID>("seq_action_seq_id")
            seq_action_name = Expression<String>("seq_action_name")
            seq_action_description = Expression<String>("seq_action_description")
            seq_action_duration = Expression<Double>("seq_action_duration")
            seq_action_imageName = Expression<String>("seq_action_imageName")
            
            //            UserDefaults.standard.set(false, forKey: "is_db_created")
            //            try db.run(viewModels.drop())
            //            try db.run(actionsOnMainPage.drop())
            
            
            if(!UserDefaults.standard.bool(forKey: "is_db_created")){
                
                try db.run(viewModels.create{ (t) in
                    t.column(fontSize)
                })
                
                try db.run(actionsOnMainPage.create{ (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(description)
                    t.column(duration)
                    t.column(imageName)
                })
                
                try db.run(sequences.create{ (t) in
                    t.column(seq_id, primaryKey: true)
                    t.column(seq_name)
                    t.column(seq_bgColor)
                })
                
                try db.run(seqActions.create{ (t) in
                    t.column(seq_action_id, primaryKey: true)
                    t.column(seq_action_seq_id)
                    t.column(seq_action_name)
                    t.column(seq_action_description)
                    t.column(seq_action_duration)
                    t.column(seq_action_imageName)
                })
                
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
            
            
        }catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func checkIfDbEmpty() -> Bool{
        do{
            let count = try db.scalar(viewModels.count)
            
            if(count > 0){
                return true
            }else{
                return false
            }
        }catch{
            print("SHIT!")
        }
        return false
    }
    
    public func addViewModel(fontSizeValue: Double) {
        do {
            try db.run(viewModels.insert(fontSize <- fontSizeValue))
        } catch {
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func getViewModel() -> ViewModel{
        var viewModelToReturn: ViewModel!
        do {
            for viewModel in try db.prepare(viewModels) {
                let viewModel: ViewModel = ViewModel(state: ViewModel.State.mainPage, fontSize: Double(viewModel[fontSize]), actionsOnMainPage: [], sequences: [])
                viewModelToReturn = viewModel
                break
            }
        } catch {
            print(error.localizedDescription)
        }
        viewModelToReturn.actionsOnMainPage = getActionsOnMainPage()
        viewModelToReturn.sequences = getAllSequences()
        return viewModelToReturn
    }
    
    public func updateViewModel(fontSizeToFind: Double, fontSizeValue: Double) {
        do {
            let viewModelToUpdate: Table = viewModels.filter(fontSize == fontSizeToFind)
            
            try db.run(viewModelToUpdate.update(fontSize <- fontSizeValue))
        } catch {
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func addActionOnMainPage(idValue: UUID, nameValue: String, descriptionValue: String, durationValue: Double, imageNameValue: String) {
        do {
            try db.run(actionsOnMainPage.insert(id <- idValue,
                                                name <- nameValue,
                                                description <- descriptionValue,
                                                duration <- durationValue,
                                                imageName <- imageNameValue))
        } catch {
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func getActionsOnMainPage() -> [Action] {
        var actionsOnMainPageArray: [Action] = []
        do {
            for action in try db.prepare(actionsOnMainPage) {
                var actionNew: Action = Action(name: action[name],
                                               description: action[description],
                                               duration: Int(action[duration]),
                                               imageName: action[imageName],
                                               sequenceId: UUID())
                
                actionNew.id = action[id]
                actionsOnMainPageArray.append(actionNew)
            }
        } catch {
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
        return actionsOnMainPageArray
    }
    
    public func hardUpdateActionsOnMainPage(updatedActions: [Action]){
        do{
            try db.run(actionsOnMainPage.delete())
            
            for updatedAction in updatedActions {
                addActionOnMainPage(idValue: updatedAction.id,
                                    nameValue: updatedAction.name,
                                    descriptionValue: updatedAction.description,
                                    durationValue: Double(updatedAction.duration),
                                    imageNameValue: updatedAction.imageName)
            }
        }catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func hardUpdateActions(updatedActions: [Action]){
        do{
            try db.run(seqActions.delete())
            
            for action in updatedActions {
                try db.run(seqActions.insert(seq_action_id <- action.id,
                                             seq_action_seq_id <- action.sequenceId,
                                             seq_action_name <- action.name,
                                             seq_action_description <- action.description,
                                             seq_action_duration <- Double(action.duration),
                                             seq_action_imageName <- action.imageName))
            }
        }catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    
    public func deleteOneActionOnMainPage(idToDelete: UUID){
        do{
            let actionToDelete = actionsOnMainPage.filter(id == idToDelete)
            try db.run(actionToDelete.delete())
            
        }catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func updateActionDurationOnMainPage(idToUpdate: UUID, newDuration: Double){
        do{
            let actionToUpdate = actionsOnMainPage.filter(id == idToUpdate)
            try db.run(actionToUpdate.update(duration <- newDuration))
        }
        catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func updateActionDuration(idToUpdate: UUID, newDuration: Double){
        do{
            let actionToUpdate = seqActions.filter(seq_action_id == idToUpdate)
            try db.run(actionToUpdate.update(seq_action_duration <- newDuration))
        }
        catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func updateActionDescriptionOnMainPage(idToUpdate: UUID, newDesription: String){
        do{
            let actionToUpdate = actionsOnMainPage.filter(id == idToUpdate)
            try db.run(actionToUpdate.update(description <- newDesription))
        }
        catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func deleteAllActionsOnMainPage(){
        do{
            try db.run(actionsOnMainPage.delete())
        }catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func addSequence(sequenceToAdd: Sequence){
        do{
            try db.run(sequences.insert(seq_id <- sequenceToAdd.id,
                                        seq_name <- sequenceToAdd.name,
                                        seq_bgColor <- sequenceToAdd.bgColor))
            for action in sequenceToAdd.actions{
                try db.run(seqActions.insert(seq_action_id <- action.id,
                                             seq_action_seq_id <- sequenceToAdd.id,
                                             seq_action_name <- action.name,
                                             seq_action_description <- action.description,
                                             seq_action_duration <- Double(action.duration),
                                             seq_action_imageName <- action.imageName))
            }
        }catch{
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
    }
    
    public func getAllSequences() -> [Sequence]{
        
        var sequencesArr: [Sequence] = []
        
        do {
            for sequence in try db.prepare(sequences) {
                var sequenceEl = Sequence(name: sequence[seq_name],
                                          actions: [],
                                          bgColor:sequence[seq_bgColor])
                sequenceEl.id = sequence[seq_id]
                sequencesArr.append(sequenceEl)
            }
            for i in sequencesArr.indices {
                for action in try db.prepare(seqActions){
                    if(action[seq_action_seq_id] == sequencesArr[i].id){
                        var actionEl = Action(name: action[seq_action_name],
                                              description: action[seq_action_description],
                                              duration: Int(action[seq_action_duration]),
                                              imageName: action[seq_action_imageName],
                                              sequenceId: action[seq_action_seq_id])
                        actionEl.id = action[seq_action_id]
                        sequencesArr[i].actions.append(actionEl)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
            print(error)
            print(error.self)
        }
        return sequencesArr
    }
    
}
