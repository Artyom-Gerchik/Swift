//
//  MainView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import ActivityKit
import SwiftUI

struct MainView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    func move(from source: IndexSet, to destination: Int) {
        vm.actionsOnMainPage.move(fromOffsets: source, toOffset: destination)
        DB_Manager().hardUpdateActionsOnMainPage(updatedActions: vm.actionsOnMainPage)
    }
}

extension MainView: View {
    var body: some View {
        VStack {
            if(vm.state == ViewModel.State.mainPage){
                HeaderView(vm: vm)
                List{
                    ForEach(vm.actionsOnMainPage, id: \.self){
                        action in
                        ActionCardView(vm: vm,actionId: action.id, actionName: action.name, actionDescription: action.description, actionDuration: action.duration, actionImageName: action.imageName)
                        
                    }.onMove(perform: move)
                }
                .onAppear(perform: {
                    if(DB_Manager().checkIfDbEmpty()){
                        print("GETTING VIEWMODEL")
                        let tmpVM = DB_Manager().getViewModel()
                        vm.fontSize = tmpVM.fontSize
                        vm.actionsOnMainPage = tmpVM.actionsOnMainPage
                        
                    }else{
                        print("CREATING NEW VIEWMODEL")
                        DB_Manager().addViewModel(fontSizeValue: vm.fontSize)
                    }
                })
                
                FooterView(vm: vm).padding(.bottom)
            }else if(vm.state == ViewModel.State.secondPage){
                HeaderView(vm: vm)
                List{
                    ForEach(vm.sequences, id: \.self){
                        sequence in
                        SequenceCardView(vm: vm,sequenceId: sequence.id, sequenceName: sequence.name, sequenceActions: sequence.actions, bgColor: sequence.bgColor)
                        
                    }
                }
                .onAppear(perform: {
                    if(DB_Manager().checkIfDbEmpty()){
                        print("GETTING VIEWMODEL")
                        let tmpVM = DB_Manager().getViewModel()
                        vm.fontSize = tmpVM.fontSize
                        vm.actionsOnMainPage = tmpVM.actionsOnMainPage
                        vm.sequences = tmpVM.sequences
                        
                    }else{
                        print("CREATING NEW VIEWMODEL")
                        DB_Manager().addViewModel(fontSizeValue: vm.fontSize)
                    }
                })
                FooterView(vm: vm).padding(.bottom)
            }else if(vm.state == ViewModel.State.settingsPage){
                HeaderView(vm: vm)
                Spacer()
                SettingsView(vm: vm)
                Spacer()
            }else if (vm.state == ViewModel.State.mainTimerPage){
                HeaderView(vm: vm)
                Spacer()
                TimerView(vm:vm, actionsForViewTimer: vm.actionsOnMainPage, actionsForViewText: vm.actionsOnMainPage, getBackActions: [])
                Spacer()
            }
            else if (vm.state == ViewModel.State.secondTimerPage){
                HeaderView(vm: vm)
                Spacer()
                let sequence = vm.sequences.first(where: {$0.id == vm.sequenceIdForTimer})
                TimerView(vm: vm, actionsForViewTimer: sequence!.actions, actionsForViewText: sequence!.actions, getBackActions: [])
                Spacer()
            }
            else if(vm.state == ViewModel.State.createSequencePage){
                HeaderView(vm: vm)
                Spacer()
                CreateSequenceView(vm: vm)
                Spacer()
                Spacer()
            }else if(vm.state == ViewModel.State.sequencesUnionPage){
                HeaderView(vm: vm)
                SequencesUnionView(vm: vm, checks: [])
            }
            else if(vm.state == ViewModel.State.editSequencePage){
                HeaderView(vm: vm)
                EditSequenceView(vm: vm)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

//import SwiftUI
//import ActivityKit
//
//struct MainView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//
//            Button(action: {
//                start()
//            }, label: {
//                Text("Start")
//            })
//            Button(action: {
//                stop()
//            }, label: {
//                Text("Stop")
//            })
//        }
//        .padding()
//    }
//
//    func start(){
//        let attributes = PPO_LAB2_WIDGET_Attributes(name: "testName")
//        let initialContentState = PPO_LAB2_WIDGET_Attributes.ContentState(value: Date()...Date().addingTimeInterval(1 * 10))
//
//        do{
//
//            let MyActivity = try Activity<PPO_LAB2_WIDGET_Attributes>.request(attributes: attributes,
//                                                                    contentState: initialContentState)
//            print("Requested a Live Activity \(MyActivity.id)")
//
//        }catch (let error){
//            print("Error Requesting a Live Activity \(error.localizedDescription)")
//        }
//
//    }
//    func stop(){
//        Task{
//            for activity in Activity<PPO_LAB2_WIDGET_Attributes>.activities{
//                await activity.end(dismissalPolicy: .immediate)
//            }
//        }
//    }
//
//}
