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
                let viewModel: ViewModel = ViewModel(state: ViewModel.State.mainPage, fontSize: Double(viewModel[fontSize]), actionsOnMainPage: [])
                viewModelToReturn = viewModel
                break
            }
        } catch {
            print(error.localizedDescription)
        }
        viewModelToReturn.actionsOnMainPage = getActionsOnMainPage()
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
                                               imageName: action[imageName])
                
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
    
}
