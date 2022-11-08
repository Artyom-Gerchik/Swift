//
//  FooterView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct FooterView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var locale = false
    
    @State var isExpanded: Bool = false
    @State private var sizeForSpacer: Int = 0
    @State var isMainMenuActive : Bool = false
}

extension FooterView: View {
    var body: some View {
        HStack{
            if(vm.state == ViewModel.State.mainPage){
                
                Spacer()
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        
                        if(DB_Manager().checkIfDbEmpty()){
                            print("GETTING VIEWMODEL")
                            let tmpVM = DB_Manager().getViewModel()
                            vm.fontSize = tmpVM.fontSize
                            vm.actionsOnMainPage = tmpVM.actionsOnMainPage
                            
                        }else{
                            print("CREATING NEW VIEWMODEL")
                            DB_Manager().addViewModel(fontSizeValue: vm.fontSize)
                        }
                        
                        vm.state = ViewModel.State.mainTimerPage
                        vm.isPaused = false
                        
                    }
                }, label: {
                    Text((locale ? "СТАРТ" : "START"))
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }).accentColor(Color.primary)
                    .buttonStyle(.borderedProminent)
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        isMainMenuActive.toggle()
                        isExpanded.toggle()
                    }
                    
                }, label: {
                    Image(systemName: isMainMenuActive == true ? "xmark.circle" : "plus.circle")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
                
                    .overlay(self.isExpanded ? VStack{
                        HStack{
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.25)) {
                                    vm.addActionToMainPage(actionName: (locale ? "Перекур" : "Chill"), actionDescription: "", actionDuration: 10, actionImageName: "sofa")
                                }
                            }, label: {
                                Image(systemName: "sofa")
                                    .font(.system(size:vm.fontSize, weight: .regular))
                            }).accentColor(Color.primary).padding(.bottom, 5)
                        }
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.addActionToMainPage(actionName: (locale ? "Готовсь" : "Prepare"), actionDescription: "", actionDuration: 10, actionImageName: "figure.wave")
                            }
                        }, label: {
                            Image(systemName: "figure.wave")
                                .font(.system(size:vm.fontSize, weight: .regular))
                        }).accentColor(Color.primary).padding(.bottom, 5)
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.addActionToMainPage(actionName: (locale ? "Качалка" : "Workout"), actionDescription: "", actionDuration: 10, actionImageName: "dumbbell")
                            }
                        }, label: {
                            Image(systemName: "dumbbell")
                                .font(.system(size:vm.fontSize, weight: .regular))
                        }).accentColor(Color.primary).padding(.bottom, 5)
                        
                        if(vm.fontSize == 36){
                            Spacer(minLength: 180)
                        }else if(vm.fontSize == 24){
                            Spacer(minLength: 130)
                        }else if(vm.fontSize == 12){
                            Spacer(minLength: 70)
                        }
                    }: nil)
            }else if(vm.state == ViewModel.State.secondPage){
                
                Spacer()
                Button(action: {
                    //
                }, label: {
                    Text((locale ? "СТАРТ" : "START"))
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }).accentColor(isDarkMode ? Color.black : Color.white)
                    .buttonStyle(.borderedProminent)
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        vm.state = ViewModel.State.createSequencePage
                        
                    }
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size:vm.fontSize, weight: .regular))
                }).accentColor(Color.primary)
            }
        }
        .padding()
    }
}
