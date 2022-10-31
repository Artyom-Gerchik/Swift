//
//  ContentView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct MainView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
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
                
                FooterView(vm: vm).padding(.bottom)
            }else if(vm.state == ViewModel.State.secondPage){
                HeaderView(vm: vm)
                List{
                    ForEach(vm.sequences, id: \.self){
                        sequence in
                        SequenceCardView( sequenceName: sequence.name, bgColor: sequence.bgColor)
                        
                    }//.onMove(perform: move)
                }
                FooterView(vm: vm).padding(.bottom)
            }else if(vm.state == ViewModel.State.settingsPage){
                HeaderView(vm: vm)
                Spacer()
                SettingsView(vm: vm)
                Spacer()
            }else if (vm.state == ViewModel.State.timerPage){
                HeaderView(vm: vm)
                Spacer()
                TimerView(vm:vm, actionsForViewTimer: vm.actionsOnMainPage, actionsForViewText: vm.actionsOnMainPage)
                Spacer()
            }
            else if(vm.state == ViewModel.State.createSequencePage){
                HeaderView(vm: vm)
                Spacer()
                CreateSequenceView(vm: vm)
                Spacer()
                Spacer()
                //FooterView(vm: vm).padding(.bottom)
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
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
            }
            )
    }
    
    func move(from source: IndexSet, to destination: Int) {
        vm.actionsOnMainPage.move(fromOffsets: source, toOffset: destination)
        DB_Manager().hardUpdateActionsOnMainPage(updatedActions: vm.actionsOnMainPage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm:ViewModel(state: ViewModel.State.createSequencePage,fontSize: 24, actionsOnMainPage: [], sequences: []))
    }
}
