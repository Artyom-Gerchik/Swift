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
    //@Environment(\.editMode) private var editMode
}

extension MainView: View {
    var body: some View {
        VStack {
            if(vm.state == ViewModel.State.mainPage){
                HeaderView(vm: vm)//.frame(height: 60)
                    List{
                        ForEach(vm.actionsOnMainPage, id: \.self){
                            action in
                            ActionCardView(vm: vm, actionName: action.name, actionDescription: action.description, actionDuration: action.duration, actionImageName: action.imageName)
                            
                        }.onMove(perform: move)
                    }
                    
                FooterView(vm: vm).padding(.bottom)
            }else if(vm.state == ViewModel.State.secondPage){
                HeaderView(vm: vm)
                Spacer()
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
        }.preferredColorScheme(isDarkMode ? .dark : .light)
            //.environment(\.editMode, Binding.constant(EditMode.active))
    }
    
    func move(from source: IndexSet, to destination: Int) {
        vm.actionsOnMainPage.move(fromOffsets: source, toOffset: destination)
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm:ViewModel(state: ViewModel.State.mainPage,fontSize: 24, actionsOnMainPage: []))
    }
}
