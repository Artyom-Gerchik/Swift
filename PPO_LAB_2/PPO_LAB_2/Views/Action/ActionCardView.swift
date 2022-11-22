//
//  ActionCardView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 24.10.22.
//

import SwiftUI

struct ActionCardView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var locale = false
    
    @State var actionId: UUID
    @State var actionName: String = ""
    @State var actionDescription: String = ""
    @State var actionDuration: Int{
        didSet{
            
            let startNumber = 0
            let endNumber = 61
            let numberRange = startNumber...endNumber
            
            if (numberRange.contains(actionDuration + 1) && numberRange.contains(actionDuration - 1)) {
                // actionDuration = 1
            }else{
                actionDuration = oldValue
                if(vm.state == ViewModel.State.mainPage){
                    DB_Manager().updateActionDurationOnMainPage(idToUpdate: actionId, newDuration: Double(actionDuration))
                }else if(vm.state == ViewModel.State.editSequencePage){
                    DB_Manager().updateActionDuration(idToUpdate: actionId, newDuration: Double(actionDuration))
                }
            }
        }
    }
    @State var actionImageName : String = ""
}

extension ActionCardView: View {
    var body: some View {
        ZStack{
            if(vm.fontSize == 12){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(isDarkMode ? Color.white : Color.black)
                    .frame(height: 80)
            }else if(vm.fontSize == 24){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(isDarkMode ? Color.white : Color.black)
                    .frame(height: 110)
            }else if(vm.fontSize == 36){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(isDarkMode ? Color.white : Color.black)
                    .frame(height: 120)
            }
            
            HStack{
                Image(systemName: actionImageName)
                    .padding()
                    .font(.system(size:vm.fontSize, weight: .regular))
                    .foregroundColor(isDarkMode ? Color.black : Color.white)
                    .frame(width: 50)
                if(vm.fontSize == 12){
                    Divider()
                        .frame(height: 80)
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .overlay(isDarkMode ? Color.black : Color.white)
                }else{
                    Divider()
                        .frame(height: 100)
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .overlay(isDarkMode ? Color.black : Color.white)
                }
                
                
                HStack{
                    Spacer()
                    VStack{
                        if(vm.fontSize == 36){
                            Text(actionName)
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(isDarkMode ? Color.black : Color.white)
                        }else{
                            Text(actionName)
                                .font(.system(size:vm.fontSize, weight: .regular))
                                .foregroundColor(isDarkMode ? Color.black : Color.white)
                        }
                        ZStack{
                            if(actionDescription.isEmpty){
                                Text((locale ? "Малява" : "Description"))
                                    .foregroundColor(isDarkMode ? Color.black.opacity(0.4) : Color.white.opacity(0.4))
                            }
                            TextField(
                                "",
                                text: $actionDescription
                            )
                            .onSubmit {
                                if(vm.state == ViewModel.State.mainPage){
                                    DB_Manager().updateActionDescriptionOnMainPage(idToUpdate: actionId, newDesription: actionDescription)
                                }else if(vm.state == ViewModel.State.editSequencePage){
                                    DB_Manager().updateActionDescription(idToUpdate: actionId, newDesription: actionDescription)
                                }else if(vm.state == ViewModel.State.createSequencePage){
                                    for index in vm.sequenceOnCreatePhase.actions.indices{
                                        if(vm.sequenceOnCreatePhase.actions[index].id == actionId){
                                            vm.sequenceOnCreatePhase.actions[index].description = actionDescription
                                        }
                                    }
                                }
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(isDarkMode ? Color.black : Color.white)
                        }
                        
                        HStack{
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.25)) {
                                    actionDuration -= 1
                                    if(vm.state == ViewModel.State.mainPage){
                                        DB_Manager().updateActionDurationOnMainPage(idToUpdate: actionId, newDuration: Double(actionDuration))
                                    }else if(vm.state == ViewModel.State.editSequencePage){
                                        DB_Manager().updateActionDuration(idToUpdate: actionId, newDuration: Double(actionDuration))
                                    }else if(vm.state == ViewModel.State.createSequencePage){
                                        for index in vm.sequenceOnCreatePhase.actions.indices{
                                            if(vm.sequenceOnCreatePhase.actions[index].id == actionId){
                                                vm.sequenceOnCreatePhase.actions[index].duration = actionDuration
                                            }
                                        }
                                    }
                                }
                            }, label: {
                                if(vm.fontSize == 36){
                                    Image(systemName: "minus.square")
                                        .font(.system(size: 24, weight: .regular))
                                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                                }else{
                                    Image(systemName: "minus.square")
                                        .font(.system(size: vm.fontSize, weight: .regular))
                                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                                }
                                
                            })
                            .accentColor(Color.black)
                            .buttonStyle(PlainButtonStyle())
                            
                            if(vm.fontSize == 36){
                                Text(String(actionDuration))
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(isDarkMode ? Color.black : Color.white)
                            }else{
                                Text(String(actionDuration))
                                    .font(.system(size:vm.fontSize, weight: .regular))
                                    .foregroundColor(isDarkMode ? Color.black : Color.white)
                            }
                            
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.25)) {
                                    actionDuration += 1
                                    if(vm.state == ViewModel.State.mainPage){
                                        DB_Manager().updateActionDurationOnMainPage(idToUpdate: actionId, newDuration: Double(actionDuration))
                                    }else if(vm.state == ViewModel.State.editSequencePage){
                                        DB_Manager().updateActionDuration(idToUpdate: actionId, newDuration: Double(actionDuration))
                                    }else if(vm.state == ViewModel.State.createSequencePage){
                                        for index in vm.sequenceOnCreatePhase.actions.indices{
                                            if(vm.sequenceOnCreatePhase.actions[index].id == actionId){
                                                vm.sequenceOnCreatePhase.actions[index].duration = actionDuration
                                            }
                                        }
                                    }
                                    
                                }
                            }, label: {
                                if(vm.fontSize == 36){
                                    Image(systemName: "plus.square")
                                        .font(.system(size: 24, weight: .regular))
                                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                                }else{
                                    Image(systemName: "plus.square")
                                        .font(.system(size: vm.fontSize, weight: .regular))
                                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                                }
                            })
                            .accentColor(Color.black)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Spacer()
                    VStack{
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                if(vm.state == ViewModel.State.mainPage){
                                    vm.removeActionFromMainPage(idToRemove: actionId)
                                }else if(vm.state == ViewModel.State.createSequencePage){
                                    vm.removeActionFromSequenceCreatePage(idToRemove: actionId)
                                }else if(vm.state == ViewModel.State.editSequencePage){
                                    vm.removeActionFromSequence(idToRemove: actionId)
                                }
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.system(size:vm.fontSize, weight: .regular))
                                .foregroundColor(isDarkMode ? Color.black : Color.white)
                                .padding()
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                        Image(systemName: "arrow.up.and.down")
                            .font(.system(size:vm.fontSize, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.black : Color.white)
                            .padding()
                    }
                }
            }
        }.padding()
            .onTapGesture {
                hideKeyboard()
                if(vm.state == ViewModel.State.mainPage){
                    DB_Manager().updateActionDescriptionOnMainPage(idToUpdate: actionId, newDesription: actionDescription)
                }else if(vm.state == ViewModel.State.editSequencePage){
                    DB_Manager().updateActionDescription(idToUpdate: actionId, newDesription: actionDescription)
                }else if(vm.state == ViewModel.State.createSequencePage){
                    for index in vm.sequenceOnCreatePhase.actions.indices{
                        if(vm.sequenceOnCreatePhase.actions[index].id == actionId){
                            vm.sequenceOnCreatePhase.actions[index].description = actionDescription
                        }
                    }
                }
            }
    }
}
