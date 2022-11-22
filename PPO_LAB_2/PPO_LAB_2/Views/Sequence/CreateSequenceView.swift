//
//  SequenceView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 31.10.22.
//

import SwiftUI

struct CreateSequenceView{
    @ObservedObject var vm: ViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var locale = false
    
    @State var isExpanded: Bool = false
    @State var isMainMenuActive : Bool = false
    @State var bgColor: Color = Color.green
    @State var newSequence: Sequence = Sequence(name: "", actions: [], bgColor: "")
    
    func move(from source: IndexSet, to destination: Int) {
        vm.sequenceOnCreatePhase.actions.move(fromOffsets: source, toOffset: destination)
    }
}


extension CreateSequenceView: View {
    var body: some View {
        VStack{
            ZStack{
                if(vm.sequenceOnCreatePhase.name.isEmpty){
                    Text((locale ? "Погоняло" : "Name Of Sequence"))
                        .foregroundColor(isDarkMode ? Color.white.opacity(0.4) : Color.black.opacity(0.4))
                }
                TextField(
                    "",
                    text: $vm.sequenceOnCreatePhase.name
                )
                .multilineTextAlignment(.center)
                .foregroundColor(isDarkMode ? Color.white : Color.black)
            }.padding()
            Spacer()
            HStack{
                ColorPicker("", selection: $bgColor)
                    .labelsHidden()
                    .scaleEffect((CGSize(width: 1.5, height: 1.5)))
            }
            Spacer()
            List{
                ForEach(vm.sequenceOnCreatePhase.actions, id: \.self){
                    action in
                    ActionCardView(vm: vm, actionId: action.id, actionName: action.name, actionDescription: action.description, actionDuration: action.duration, actionImageName: action.imageName)
                    
                }.onMove(perform: move)
            }
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.easeIn(duration: 0.25)) {
                        newSequence.name = vm.sequenceOnCreatePhase.name
                        newSequence.actions = vm.sequenceOnCreatePhase.actions
                        newSequence.bgColor = vm.sequenceOnCreatePhase.bgColor
                        
                        vm.addSequence(sequenceName: newSequence.name, sequenceActions: newSequence.actions, bgColor: bgColor.toHex()!)
                        vm.state = ViewModel.State.secondPage
                        
                        vm.sequenceOnCreatePhase = Sequence(name: "", actions: [], bgColor: "''")
                        
                        print(bgColor.toHex())
                        
                    }
                }, label: {
                    Text((locale ? "ДОБРО" : "OK"))
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
                                    vm.sequenceOnCreatePhase.actions.append(Action(name:(locale ? "Перекур" : "Chill"),
                                                                                   description: "",
                                                                                   duration: 10,
                                                                                   imageName: "sofa",
                                                                                   sequenceId: newSequence.id))
                                }
                            }, label: {
                                Image(systemName: "sofa")
                                    .font(.system(size:vm.fontSize, weight: .regular))
                            }).accentColor(Color.primary).padding(.bottom, 5)
                        }
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.sequenceOnCreatePhase.actions.append(Action(name: (locale ? "Готовсь" : "Prepare"),
                                                                               description: "",
                                                                               duration: 10,
                                                                               imageName: "figure.wave",
                                                                               sequenceId: newSequence.id))
                            }
                        }, label: {
                            Image(systemName: "figure.wave")
                                .font(.system(size:vm.fontSize, weight: .regular))
                        }).accentColor(Color.primary).padding(.bottom, 5)
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.sequenceOnCreatePhase.actions.append(Action(name: (locale ? "Качалка" : "Workout"),
                                                                               description: "",
                                                                               duration: 10,
                                                                               imageName: "dumbbell",
                                                                               sequenceId: newSequence.id))
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
            }.padding()
        }
    }
}
