//
//  ActionCardView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 24.10.22.
//

import SwiftUI

struct ActionCardView: View {
    @ObservedObject var vm: ViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var actionName: String = ""
    @State var actionDescription: String = ""
    @State var actionDuration: Int = 0
    @State var actionImageName : String = ""
    
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
                if(vm.fontSize == 12){
                    Divider()
                        .frame(height: 80)
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }else{
                    Divider()
                        .frame(height: 100)
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                }
                
                Spacer()
                HStack{
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
                                Text("Description")
                                    .foregroundColor(isDarkMode ? Color.black.opacity(0.4) : Color.white.opacity(0.4))
                            }
                            TextField(
                                "",
                                text: $actionDescription
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(isDarkMode ? Color.black : Color.white)
                        }
                        //.foregroundColor(isDarkMode ? Color.black : Color.white)
                        
                        //.font(.system(size:vm.fontSize, weight: .regular))
                        
                        
                        HStack{
                            Button(action: {
                                actionDuration -= 1
                            }, label: {
                                if(vm.fontSize == 36){
                                    Image(systemName: "minus")
                                        .font(.system(size: 24, weight: .regular))
                                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                                }else{
                                    Image(systemName: "minus")
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
                                actionDuration += 1
                            }, label: {
                                if(vm.fontSize == 36){
                                    Image(systemName: "plus")
                                        .font(.system(size: 24, weight: .regular))
                                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                                }else{
                                    Image(systemName: "plus")
                                        .font(.system(size: vm.fontSize, weight: .regular))
                                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                                }
                            })
                            .accentColor(Color.black)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                    Image(systemName: "arrow.up.and.down")
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .foregroundColor(isDarkMode ? Color.black : Color.white)
                        .padding()
                }
            }
        }.padding()
    }
}

struct ActionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActionCardView(vm:ViewModel(state: ViewModel.State.mainPage,fontSize: 24, actionsOnMainPage: []))
    }
}
