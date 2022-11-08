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
    @AppStorage("locale") private var locale = false
    
    @State var test: Double!
    @State private var showingAlert: Bool = false
}

extension SettingsView: View {
    var body: some View {
        VStack{
            List{
                HStack{
                    Text((locale ? "Шрифт" : "Font Size"))
                        .font(.system(size:vm.fontSize, weight: .regular))
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            test = vm.fontSize
                            showingAlert = true
                        }
                    }, label: {
                        Image(systemName: "gearshape.2")
                            .font(.system(size:vm.fontSize, weight: .regular))
                        
                    })
                    .accentColor(Color.primary)
                    .alert((locale ? "Шрифт" : "Font Size"), isPresented: $showingAlert) {
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.changeFontSize(newFontSize: 36)
                                DB_Manager().updateViewModel(fontSizeToFind: test, fontSizeValue: vm.fontSize)
                            }
                        }, label: {
                            Text((locale ? "Толстый" : "Big"))
                                .font(.system(size:36, weight: .regular))
                            
                        })
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.changeFontSize(newFontSize: 24)
                                DB_Manager().updateViewModel(fontSizeToFind: test, fontSizeValue: vm.fontSize)
                            }
                        }, label: {
                            Text((locale ? "Середняк" : "Medium"))
                                .font(.system(size:24, weight: .regular))
                        })
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.changeFontSize(newFontSize: 12)
                                DB_Manager().updateViewModel(fontSizeToFind: test, fontSizeValue: vm.fontSize)
                            }
                        }, label: {
                            Text((locale ? "Тонкий" : "Small"))
                                .font(.system(size:12, weight: .regular))
                            
                        })
                        Button((locale ? "Откат" : "Cancel"), role: .cancel) { }
                    }
                }
                HStack{
                    Toggle((locale ? "Негр" : "Dark Mode"), isOn: $isDarkMode.animation())
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .tint(Color.gray)
                }
                HStack{
                    Toggle((locale ? "Русиш" : "English"), isOn: $locale.animation())
                        .font(.system(size:vm.fontSize, weight: .regular))
                        .tint(Color.gray)
                }
                HStack{
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            DB_Manager().cleanUpMemory()
                            vm.cleanUpMemory()
                            isDarkMode = false
                            locale = false
                        }
                    }, label: {
                        Text((locale ? "Вынести Мусор" : "Clean Up Memory"))
                            .font(.system(size:vm.fontSize, weight: .regular))
                            .foregroundColor(isDarkMode ? Color.white : Color.black)
                    })
                }
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
        }
    }
}
