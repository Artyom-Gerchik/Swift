//
//  FooterView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct FooterView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @ObservedObject var vm: ViewModel
    @State var isExpanded: Bool = false
    @State private var sizeForSpacer: Int = 0
    @State var isMainMenuActive : Bool = false
    
    var body: some View {
        HStack{
            if(vm.state == ViewModel.State.mainPage){
                //HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.timerPage
                            vm.isPaused = false
                        }
                    }, label: {
                        Text("START")
                            .font(.system(size:vm.fontSize, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.black : Color.white)
                    }).accentColor(Color.primary)
                        .buttonStyle(.borderedProminent)
                    Spacer()
                //}
                
                
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            isMainMenuActive.toggle()
                            isExpanded.toggle()
                        }
                        
                    }, label: {
                        Image(systemName: isMainMenuActive == true ? "xmark.circle" : "plus.circle")
                        //Image(systemName: "plus.circle")
                            .font(.system(size:vm.fontSize, weight: .regular))
                    }).accentColor(Color.primary)
                    
                    .overlay(self.isExpanded ? VStack{
                        HStack{
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.25)) {
                                    vm.addActionToMainPage(actionName: "Chill", actionDescription: "", actionDuration: 10, actionImageName: "sofa")
                                }
                            }, label: {
                                Image(systemName: "sofa")
                                    .font(.system(size:vm.fontSize, weight: .regular))
                            }).accentColor(Color.primary).padding(.bottom, 5)
                        }
            
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.addActionToMainPage(actionName: "Prepare", actionDescription: "", actionDuration: 10, actionImageName: "figure.walk.circle")
                            }
                        }, label: {
                            Image(systemName: "figure.walk.circle")
                                .font(.system(size:vm.fontSize, weight: .regular))
                        }).accentColor(Color.primary).padding(.bottom, 5)
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.addActionToMainPage(actionName: "Workout", actionDescription: "", actionDuration: 10, actionImageName: "dumbbell")
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

                
//                //VStack {
//                    Button(action: {
//                        print("Expandable button tapped!!!")
//                        isExpanded.toggle()
//
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .resizable()
//                            .frame(width: 75, height: 75)
//                            .foregroundColor(.green)
//                    }
//
//
//                //}
//                //.animation(.spring())
                
            }
        }
        .padding()
        
        
//                        Button(action: {
//                            vm.addAction()
//                        }, label: {
//                            Image(systemName: "plus.circle")
//                                .font(.system(size:vm.fontSize, weight: .regular))
//                        }).accentColor(Color.primary)
        
        
        //            else if(vm.state == ViewModel.State.secondPage){
        //
        //                Spacer()
        //                Button(action: {
        //                    //
        //                }, label: {
        //                    Text("START")
        //                        .font(.system(size:vm.fontSize, weight: .regular))
        //                        .foregroundColor(isDarkMode ? Color.black : Color.white)
        //                }).accentColor(isDarkMode ? Color.black : Color.white)
        //                    .buttonStyle(.borderedProminent)
        //                Spacer()
        //
        //                Button(action: {
        //                    vm.addAction()
        //                }, label: {
        //                    Image(systemName: "plus.circle")
        //                        .font(.system(size:vm.fontSize, weight: .regular))
        //                }).accentColor(Color.primary)
        //            }
        //}
        // .padding()
        
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(vm: ViewModel(state: ViewModel.State.mainPage,fontSize: 24, actionsOnMainPage: []))
    }
}
