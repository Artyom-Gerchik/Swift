//
//  HeaderView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct HeaderView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
}

extension HeaderView: View {
    var body: some View {
        if(vm.state == ViewModel.State.mainPage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.settingsPage
                    }
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.mainPage
                    }
                }, label: {
                    Image(systemName: "list.bullet")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                    .animation(.easeInOut, value: 1)
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Image(systemName: "rectangle.on.rectangle")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
                Button(action: {
                    vm.deleteAllActionsOnMainPage()
                }, label: {
                    Image(systemName: "trash")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
            }.padding()
        }else if(vm.state == ViewModel.State.secondPage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.settingsPage
                    }
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.mainPage
                    }
                }, label: {
                    Image(systemName: "list.bullet")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                    .animation(.easeInOut, value: 1)
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Image(systemName: "rectangle.on.rectangle")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.sequencesUnionPage
                    }
                }, label: {
                    Image(systemName: "link.badge.plus")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
            }.padding()
        }else if(vm.state == ViewModel.State.settingsPage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.mainPage
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.mainPage
                    }
                }, label: {
                    Text("Settings")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                    .animation(.easeInOut, value: 1)
                
                Spacer()
                
                Button(action: {
                    //
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(isDarkMode ? Color.black : Color.white)
            }.padding()
        }else if (vm.state == ViewModel.State.mainTimerPage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.mainPage
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.isPaused.toggle()
                    }
                }, label: {
                    Image(systemName: vm.isPaused == true ? "play" : "pause")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
            }.padding()
        }else if(vm.state == ViewModel.State.secondTimerPage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.isPaused.toggle()
                    }
                }, label: {
                    Image(systemName: vm.isPaused == true ? "play" : "pause")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
            }.padding()
        }else if (vm.state == ViewModel.State.createSequencePage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
            }.padding()
        }else if(vm.state == ViewModel.State.sequencesUnionPage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
            }.padding()
        }else if(vm.state == ViewModel.State.editSequencePage){
            HStack{
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.secondPage
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                Spacer()
                
            }.padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(vm: ViewModel(state: ViewModel.State.mainTimerPage, fontSize: 24, actionsOnMainPage: [], sequences: []))
    }
}
