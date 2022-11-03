//
//  SettingsView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 19.10.22.
//

import SwiftUI

struct SettingsView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var test: Double!
    
    @State private var showingAlert: Bool = false
}

extension SettingsView: View {
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
                    .onAppear(perform: {
                        test = vm.fontSize
                    })
                    .onDisappear(perform: {
                        DB_Manager().updateViewModel(fontSizeToFind: test, fontSizeValue: vm.fontSize)
                    })
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