//
//  SettingsView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showingAlert: Bool = false
    var body: some View {
        
        VStack{
            List{
                HStack{
                    Text("Font Size")
                        .font(.system(size:vm.fontSize, weight: .regular))
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            showingAlert = true
                        }
                    }, label: {
                        Image(systemName: "gearshape.2")
                            .font(.system(size:vm.fontSize, weight: .regular))
                        
                    })
                    .accentColor(Color.primary)
                    //.buttonStyle(.borderedProminent)
                    .alert("Font Size", isPresented: $showingAlert) {
                        Button(action: {
                            vm.changeFontSize(newFontSize: 36)
                        }, label: {
                            Text("Big")
                                .font(.system(size:36, weight: .regular))
                            
                        })
                        Button(action: {
                            vm.changeFontSize(newFontSize: 24)
                        }, label: {
                            Text("Medium")
                                .font(.system(size:24, weight: .regular))
                            
                        })
                        Button(action: {
                            vm.changeFontSize(newFontSize: 12)
                        }, label: {
                            Text("Small")
                                .font(.system(size:12, weight: .regular))
                            
                        })
                        Button("Cancel") { }
                    }
                }
                HStack{
                    Toggle("Dark Mode", isOn: $isDarkMode.animation())
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .tint(Color.gray)
                }
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(vm: ViewModel(state: ViewModel.State.settingsPage, fontSize: 24))
//    }
//}
