//
//  SequenceView.swift
//  PPO_LAB_2
//
//  Created by Artyom on 31.10.22.
//

import SwiftUI

struct CreateSequenceView{
    @AppStorage("isDarkMode") private var isDarkMode = false
    @ObservedObject var vm: ViewModel
    
    @State var isExpanded: Bool = false
    @State var isMainMenuActive : Bool = false
    @State var bgColor: Color = Color.green
    @State var newSequence: Sequence = Sequence(name: "", actions: [], bgColor: "")
    
    func move(from source: IndexSet, to destination: Int) {
        vm.sequenceOnCreatePhase.actions.move(fromOffsets: source, toOffset: destination)
        //DB_Manager().hardUpdateActionsOnMainPage(updatedActions: vm.actionsOnMainPage)
    }
}


extension CreateSequenceView: View {
    var body: some View {
        VStack{
            ZStack{
                if(vm.sequenceOnCreatePhase.name.isEmpty){
                    Text("Name Of Sequence")
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
                        newSequence = vm.sequenceOnCreatePhase
                        
                        vm.addSequence(sequenceName: newSequence.name, sequenceActions: newSequence.actions, bgColor: bgColor.toHex()!)
                        //newSequence.bgColor = bgColor.toHex()!
                        //vm.sequences.append(newSequence)
                        vm.state = ViewModel.State.secondPage
                        
                        vm.sequenceOnCreatePhase = Sequence(name: "", actions: [], bgColor: "''")
                        
                    }
                }, label: {
                    Text("OK")
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
                                    vm.sequenceOnCreatePhase.actions.append(Action(name:"Chill",
                                                                                   description: "",
                                                                                   duration: 10,
                                                                                   imageName: "sofa"))
                                }
                            }, label: {
                                Image(systemName: "sofa")
                                    .font(.system(size:vm.fontSize, weight: .regular))
                            }).accentColor(Color.primary).padding(.bottom, 5)
                        }
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.sequenceOnCreatePhase.actions.append(Action(name: "Prepare",
                                                                               description: "",
                                                                               duration: 10,
                                                                               imageName: "figure.wave"))
                            }
                        }, label: {
                            Image(systemName: "figure.wave")
                                .font(.system(size:vm.fontSize, weight: .regular))
                        }).accentColor(Color.primary).padding(.bottom, 5)
                        
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.25)) {
                                vm.sequenceOnCreatePhase.actions.append(Action(name: "Workout",
                                                                               description: "",
                                                                               duration: 10,
                                                                               imageName: "dumbbell"))
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

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

extension Color {
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}


struct CreateSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSequenceView(vm: ViewModel(state: ViewModel.State.createSequencePage,fontSize: 24, actionsOnMainPage: [], sequences: []))
    }
}
