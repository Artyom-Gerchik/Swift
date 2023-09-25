//
//  MainView.swift
//  MMOD-LAB1
//
//  Created by Artyom on 18.09.23.
//

import SwiftUI
import Combine

struct MainView{
    @ObservedObject var vm: ViewModel
    @State var tasks: [Int] = [1,2,3,4]
    
    @State private var probabilityTask1: String = ""
    @State private var probabilityTask2: String = ""
    @State private var probabilityTask3: String = ""
    @State private var probabilityTask4: String = ""

    
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        } else {
            return Color(.systemGray6)
        }
    }
    
    func limitText(_ upper: Int) {
        if probabilityTask1.count > upper {
            probabilityTask1 = String(probabilityTask1.prefix(upper))
        }
    }
}

extension MainView: View {
    var body: some View {
        VStack {
            if(vm.state == ViewModel.State.mainPage){
                VStack{
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.firstTaskPage
                        }
                    }, label: {
                        Text("Task 1")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.secondTaskPage
                        }
                    }, label: {
                        Text("Task 2")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.thirdTaskPage
                        }
                    }, label: {
                        Text("Task 3")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.fourthTaskPage
                        }
                    }, label: {
                        Text("Task 4")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                }
            }else if(vm.state == ViewModel.State.firstTaskPage){
                
                Spacer()
                
                TextField("", text: $probabilityTask1)
                    .keyboardType(.decimalPad)
                    .placeholder(when: probabilityTask1.isEmpty) {
                        Text("Probability %")
                            .foregroundColor(.secondary)
                    }
                    .onReceive(Just(probabilityTask1)) { _ in
                        limitText(3)
                    }
                
                    .padding(10)
                    .frame(minWidth: 80, minHeight: 47)
                    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                Text(vm.stringForTask1)
                    .font(.system(size:24, weight: .regular))
                    .padding()
                
                Spacer()
                HStack{
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.mainPage
                        }
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size:24, weight: .regular))
                    }).accentColor(Color.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            if(probabilityTask1 != ""){
                                if(Int(probabilityTask1)! < 101 && Int(probabilityTask1)! > 0){
                                    vm.firstTask(probability: Int(probabilityTask1)!)
                                }else{
                                    probabilityTask1 = "0"
                                }
                            }
                        }
                    }, label: {
                        Text("Generate")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                }
            }else if(vm.state == ViewModel.State.secondTaskPage){
                
                Spacer()
                
                TextField("", text: $probabilityTask2)
                    .keyboardType(.decimalPad)
                    .placeholder(when: probabilityTask2.isEmpty) {
                        Text("Probability %")
                            .foregroundColor(.secondary)
                    }
                    .padding(10)
                    .frame(minWidth: 80, minHeight: 47)
                    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                Text(vm.stringForTask2)
                    .font(.system(size:24, weight: .regular))
                    .padding()
                
                Spacer()
                HStack{
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.mainPage
                        }
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size:24, weight: .regular))
                    }).accentColor(Color.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.secondTask(probability: probabilityTask2)
                        }
                    }, label: {
                        Text("Generate")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                }
            }else if(vm.state == ViewModel.State.thirdTaskPage){
                
                Spacer()
                
                TextField("", text: $probabilityTask3)
                    .keyboardType(.decimalPad)
                    .placeholder(when: probabilityTask3.isEmpty) {
                        Text("Probability %")
                            .foregroundColor(.secondary)
                    }
                    .padding(10)
                    .frame(minWidth: 80, minHeight: 47)
                    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                Text(vm.stringForTask3)
                    .font(.system(size:24, weight: .regular))
                    .padding()
                
                Spacer()
                HStack{
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.mainPage
                        }
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size:24, weight: .regular))
                    }).accentColor(Color.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.thirdTask(probability: probabilityTask3)
                        }
                    }, label: {
                        Text("Generate")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                }
            }else if(vm.state == ViewModel.State.fourthTaskPage){
                
                Spacer()
                
                TextField("", text: $probabilityTask4)
                    .keyboardType(.decimalPad)
                    .placeholder(when: probabilityTask4.isEmpty) {
                        Text("Probability %")
                            .foregroundColor(.secondary)
                    }
                    .padding(10)
                    .frame(minWidth: 80, minHeight: 47)
                    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                Text(vm.stringForTask4)
                    .font(.system(size:24, weight: .regular))
                    .padding()
                
                Spacer()
                HStack{
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.state = ViewModel.State.mainPage
                        }
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size:24, weight: .regular))
                    }).accentColor(Color.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.25)) {
                            vm.fourthTask(probability: probabilityTask4)
                        }
                    }, label: {
                        Text("Generate")
                            .font(.system(size:24, weight: .regular))
                    })
                    .buttonStyle(.borderedProminent)
                    .accentColor(colorScheme == .dark ? Color.gray : Color.black)
                    
                    Spacer()
                    
                }
            }
        }
        
        .onTapGesture {
            hideKeyboard()
        }
        .padding()
    }
}


//    struct MainView_Previews: PreviewProvider {
//        static var previews: some View {
//            MainView(vm: ViewModel(state: ViewModel.State.firstTaskPage, stringForTask1: "", stringForTask2: ""))
//        }
//    }
