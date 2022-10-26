//
//  HeaderView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct HeaderView: View {
    
    @ObservedObject var vm: ViewModel
    
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
                    //
                }, label: {
                    Image(systemName: "plus")
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
                    //
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.white)
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
                }).accentColor(Color.white)
            }.padding()
        }else if (vm.state == ViewModel.State.timerPage){
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
        }
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(vm: ViewModel(state: ViewModel.State.timerPage, fontSize: 24, actionsOnMainPage: []))
    }
}
